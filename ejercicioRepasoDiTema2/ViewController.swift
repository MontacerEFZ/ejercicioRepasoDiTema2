//
//  ViewController.swift
//  ejercicioRepasoDiTema2
//
//  Created by Montacer El Fazazi on 25/01/2024.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController, UITextViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tablaCategorias: UITableView!
    
    var listaCategorias: [Category]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

}

