//
//  ViewController.swift
//  ejercicioRepasoDiTema2
//
//  Created by Montacer El Fazazi on 25/01/2024.
//

import UIKit
import Alamofire
import AlamofireImage
import Toast

class ViewController: UIViewController, UITextViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tablaCategorias: UITableView!
    
    var listaCategorias: [Category]!
    var datos: ManagerUserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datos = ManagerUserDefaults()
        let email = datos.recuperar(clave: "EMAIL")
        let receta = datos.recuperar(clave: "RECETA")
        
        if email != "" && receta != "" {
        self.view.makeToast("Email: \(email) Receta: \(receta)")
        }

        
        listaCategorias = []
        cargarCategorias()
        
        }
    
    func cargarCategorias(){
        ApiConexiones.api.getCategorias(){
            respuesta in
            
            self.listaCategorias = respuesta
            self.tablaCategorias.reloadData()
        }failure: {
            error in
            print(error.debugDescription)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
    Int {
        listaCategorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "CELDA", for: indexPath) as! CeldaTableViewCell
        
        celda.lbNombre.text = listaCategorias[indexPath.row].strCategory
        AF.request(listaCategorias[indexPath.row].strCategoryThumb).responseImage{
            imagen in
            if case .success(let img) = imagen.result{
                celda.imFoto.image = img
            }
        }
        return celda
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MEALS" {
            let destino = segue.destination as! MealsViewController
            let fila = tablaCategorias.indexPathForSelectedRow?.row
            destino.categoria = self.listaCategorias[fila!].strCategory
        }
    }

}

