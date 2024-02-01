//
//  ManagerUserDefaults.swift
//  ejercicioRepasoDiTema2
//
//  Created by Montacer El Fazazi on 01/02/2024.
//

import Foundation

class ManagerUserDefaults{
    func guardar(dato: String, clave: String){
        UserDefaults.standard.set(dato, forKey: clave)
        UserDefaults.standard.synchronize()
    }
    
    func recuperar(clave: String) -> String{
        guard let devolver: String = UserDefaults.standard.value(forKey: clave) as? String
        else{
            return ""
        }
        
        return devolver
    }
}
