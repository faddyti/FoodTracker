//
//  Meal.swift
//  FoodTracker
//
//  Created by JY on 2018/5/13.
//  Copyright © 2018年 zhangjingyu. All rights reserved.
//

import UIKit
import os.log

class Meal:NSObject, NSCoding {
    
    //MARK:属性
    var name: String
    var photo: UIImage?
    var rating: Int
    //MARK:存放路径
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    //MARK:类型
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
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
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name,forKey:PropertyKey.name)
        aCoder.encode(photo,forKey:PropertyKey.photo)
        aCoder.encode(rating,forKey:PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        //名称必须，如果名称不能解码，此方法返回nil
        guard let name = aDecoder.decodeObject(forKey:PropertyKey.name) as? String else {
            os_log("Unable to decode a name for meal Object.",log:OSLog.default,type:.debug)
            return nil
        }
        let photo = aDecoder.decodeObject(forKey:PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey:PropertyKey.rating)
        self.init(name: name, photo: photo, rating: rating)
    }
}
