//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by XY on 2018/5/14.
//  Copyright © 2018年 zhangjingyu. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    //MARK:属性
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
