//
//  RecetaViewController.swift
//  ejercicioRepasoDiTema2
//
//  Created by Montacer El Fazazi on 26/01/2024.
//

import UIKit
import Alamofire
import AlamofireImage
import FirebaseAuth
import FirebaseFirestore

class RecetaViewController: UIViewController {

    @IBOutlet weak var btnLogOut: UIBarButtonItem!
    @IBOutlet weak var lbCategoria: UILabel!
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var lbInstrucciones: UILabel!
    @IBOutlet weak var lbArea: UILabel!
    @IBOutlet weak var imFoto: UIImageView!
    
    var id: String!
    var receta: Meal!
    var bd: Firestore!
    var datos: ManagerUserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnLogOut.isEnabled = false
        if let user = Auth.auth().currentUser{
            self.btnLogOut.isEnabled = true
        }
        
        bd = Firestore.firestore() //equivalente al getInstance de android
        datos = ManagerUserDefaults()
        cargarReceta()
    }
    
    func cargarReceta(){
        ApiConexiones.api.getReceta(id: id){
            respuesta in
            
            self.receta = respuesta
            self.lbNombre.text = self.receta.strMeal
            self.lbCategoria.text = self.receta.strCategory
            self.lbArea.text = self.receta.strArea
            self.lbInstrucciones.text = self.receta.strInstructions
            
            AF.request(self.receta.strMealThumb).responseImage{
                imagen in
                
                if case .success(let img) = imagen.result{
                    self.imFoto.image = img
                }
            }
        }failure: {
            error in
            print(error.debugDescription)
        }
    }

    @IBAction func btnGuardar(_ sender: Any) {
        if let user = Auth.auth().currentUser { //si esta logeado
            self.btnLogOut.isEnabled = true
            
            bd.collection("recetas").document(user.uid).collection("favoritas").document(receta.idMeal).setData(["comida": receta.strMeal,
                                                                                                                    "categoria": receta.strCategory!,
                                                                                                                    "area": receta.strArea!,
                                                                                                                    "instrucciones": receta.strInstructions!]);
            
            datos.guardar(dato: receta.strMeal, clave: "RECETA")
            datos.guardar(dato: user.email!, clave: "EMAIL")
        }else{
            self.btnLogOut.isEnabled = false
            let ventana = self.storyboard?
                .instantiateViewController(identifier: "LOGIN") as! LoginViewController
            self.navigationController?.pushViewController(ventana, animated: true)
        }
    }
    
    @IBAction func btnLogOutAction(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        }catch{
            
        }
    }
        override func   viewWillAppear(_ animated: Bool){
            self.btnLogOut.isEnabled = false
            if let user = Auth.auth().currentUser{
                self.btnLogOut.isEnabled = true
            }
        }
    }

