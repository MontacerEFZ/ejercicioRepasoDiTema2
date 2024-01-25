//
//  ApiConexiones.swift
//  ejercicioRepasoDiTema2
//
//  Created by Montacer El Fazazi on 25/01/2024.
//

import Foundation
import Alamofire

final class ApiConexiones{
    static let api = ApiConexiones()
    
    let BASE_URL = "https://www.themealdb.com"
    
    func getCategorias
    (success: @escaping(_ respuesta: [Category]) ->(), failure: @escaping(_ error: Error?) ->()){ //todo esto para q sea asyncrona
      let url = "\(BASE_URL)/api/json/v1/1/categories.php"
        
        AF.request(url, method: .get).validate(statusCode: 200...299).responseDecodable(of: Categories.self){ //este es el nombre del struct Categories (mayuscula)
            respuesta in
            
            if let res = respuesta.value{
                success(res.categories) //este es el atributo dentro de Categories, se llama categories (minuscula)
            }else{
                failure(respuesta.error)
            }
        }
    }
    
    func getComidas
    (categoria: String, success: @escaping(_ respuesta: [Meal]) ->(), failure: @escaping(_ error: Error?) ->()){
    let url = "\(BASE_URL)/api/json/v1/1/filter.php"
    let parameters: Parameters = ["c": categoria]
    
    AF.request(url, method: .get, parameters: parameters).validate(statusCode: 200...299).responseDecodable(of: Meals.self){
    respuesta in
    
            if let res = respuesta.value{
                success(res.meals) //este es el atributo dentro de Categories, se llama categories (minuscula)
            }else{
                failure(respuesta.error)
            }
        }
    }
}
