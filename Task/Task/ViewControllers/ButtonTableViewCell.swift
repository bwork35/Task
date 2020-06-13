//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Bryan Workman on 6/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit


class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    weak var delegate: ButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.buttonCellButtonTapped(self) 
    }
    
    func updateButton(_ isComplete: Bool){
        if isComplete {
            completeButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            completeButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
    }
}

extension ButtonTableViewCell {
    func update(withTask task: Task) {
        primaryLabel?.text = task.name
        updateButton(task.isComplete)
    }
}
 
protocol ButtonTableViewCellDelegate : AnyObject {
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}
