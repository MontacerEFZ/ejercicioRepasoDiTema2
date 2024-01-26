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

class RecetaViewController: UIViewController {

    @IBOutlet weak var lbCategoria: UILabel!
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var lbInstrucciones: UILabel!
    @IBOutlet weak var lbArea: UILabel!
    @IBOutlet weak var imFoto: UIImageView!
    
    var id: String!
    var receta: Meal!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("gsgsdgdsgdsggsdgf \(id)")

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
            
        }else{
            
        }
    }
    

}
