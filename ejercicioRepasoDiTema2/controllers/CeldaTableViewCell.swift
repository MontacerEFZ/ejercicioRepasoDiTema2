//
//  CeldaTableViewCell.swift
//  ejercicioRepasoDiTema2
//
//  Created by Montacer El Fazazi on 25/01/2024.
//

import UIKit

class CeldaTableViewCell: UITableViewCell {

    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var imFoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
