//
//  RatingControl.swift
//  FoodTracker
//
//  Created by XY on 2018/5/11.
//  Copyright © 2018年 zhangjingyu. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //MARK: 属性
    private var ratingButtons = [UIButton]()
    var rating = 0
    @IBInspectable var starSize:CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount:Int = 5 {
        didSet{
            setupButtons()
        }
    }
    //MARK: 初始化
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder:coder)
        setupButtons()
    }
    //MARK: 添加按钮动作
    @objc func ratingButtonTapped(button:UIButton)
    {
        print("button pressed 👍")
    }
    //MARK: 私有方法
    private func setupButtons()
    {
        //如果存在按钮，先清空了它
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        for _ in 0..<starCount {
            //创建按钮
            let button = UIButton()
            button.backgroundColor = UIColor.red
            //添加按钮的约束条件
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            //创建戳动作
            button.addTarget(self, action:
                #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            //把按钮填到视图
            addArrangedSubview(button)
            //把按钮填到评分列表结构中
            ratingButtons.append(button)
        }
    }
}
