//
//  MealsViewController.swift
//  ejercicioRepasoDiTema2
//
//  Created by Montacer El Fazazi on 25/01/2024.
//

import UIKit
import Alamofire
import AlamofireImage

class MealsViewController: UIViewController, UITextViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tablaComidas: UITableView!
    
    var categoria: String!
    var listaReceta:[Meal]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listaReceta = []
        cargarRecetas()
    }
    func cargarRecetas(){
        ApiConexiones.api.getComidas(categoria: categoria){
            respuesta in
            
            self.listaReceta = respuesta
            self.tablaComidas.reloadData()
        }failure: {
            error in
            print(error.debugDescription)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listaReceta.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "CELDAMEALS") as! CeldaTableViewCell
        
        celda.lbNombre.text = listaReceta[indexPath.row].strMeal
        
        AF.request(listaReceta[indexPath.row].strMealThumb).responseImage{
            image in
            if case .success(let img) = image.result{
                celda.imFoto.image = img
            }
        }
        return celda
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RECETA"{
            let destino = segue.destination as! RecetaViewController
            let fila = tablaComidas.indexPathForSelectedRow?.row
            destino.id = listaReceta[fila!].idMeal
        }
    }

    

}
