//
//  Meal.swift
//  FoodTracker
//
//  Created by JY on 2018/5/13.
//  Copyright © 2018年 zhangjingyu. All rights reserved.
//

import UIKit

class Meal {
    //MARK:属性
    var name: String
    var photo: UIImage?
    var rating: Int
    //MARK:初始化
    init?(name: String, photo: UIImage?, rating: Int) {
        //名称不能为空
        guard  !name.isEmpty else {
            return nil
        }
        //评级为0-5
        guard (rating >= 0 && rating <= 5) else {
            return nil
        }
        //初始化属性值
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
