//
//  VacationTableViewCell.swift
//  HRApp
//
//  Created by Semicolon on 06/11/2022.
//

import UIKit

class VacationTableViewCell: UITableViewCell {
   
    //MARK: - outlet
    //
    @IBOutlet weak var childView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    //MARK: - variable
    //
    static let Identifier = "VacationTableViewCell"
    static func Nib() -> UINib {
        return UINib(nibName: "VacationTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configration(data: VacationData) {
        let vacation = data.vacation
        nameLabel.text = vacation?.name
        let startedDate = vacation?.startVaction ?? ""
        let endDate = vacation?.endVation ?? ""
        dateLabel.text = "\(startedDate) / \(endDate)"
    }
}
