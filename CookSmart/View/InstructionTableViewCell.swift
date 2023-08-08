//
//  InstructionTableViewCell.swift
//  CookSmart
//
//  Created by Trey Eckenrod on 8/8/23.
//

import UIKit

class InstructionTableViewCell: UITableViewCell {

    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var instructionNumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
