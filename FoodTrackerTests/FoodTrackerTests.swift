//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by XY on 2018/5/4.
//  Copyright © 2018年 zhangjingyu. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    //Meal类测试
    //当参数正确时，确认Meal类返回Meal对象
    func testMealInitializationSucceeds(){
        //评级为0时
        let zeroRatingMeal = Meal.init(name: "zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        //评级为正数时
        let positiveRatingMeal = Meal.init(name: "positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    //当参数的name为空或rating为负数时，确认返回空值
    func testMealInitializationFails(){
        //负数评级
        let negativeRatingMeal = Meal.init(name: "negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        //name为空
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
        //评级超过5
        let largeRatingMeal = Meal.init(name: "large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
    }
}
