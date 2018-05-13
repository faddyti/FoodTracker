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
    var rating = 0 {
        didSet{
            updateButtonSelectionStates()
        }
    }
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
        guard let index =  ratingButtons.index(of: button) else{
            fatalError("The button \(button), is not in the ratingButtons arrays: \(ratingButtons)")
        }
        //计算选中的按钮的索引值
        let selectRating = index + 1
        if selectRating == rating {
            //选中的星星索引与当前评级相同，那么置0
            rating = 0
        }
        else{
            //其他情况就是该星星的索引评级
            rating = selectRating
        }
        
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
        let bundle = Bundle(for:(type(of: self)))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        for index in 0..<starCount {
            //创建按钮
            let button = UIButton()
            button.setImage(emptyStar, for: UIControlState.normal)
            button.setImage(filledStar, for: UIControlState.selected)
            button.setImage(highlightedStar, for: UIControlState.highlighted)
            button.setImage(highlightedStar, for: [UIControlState.selected,UIControlState.highlighted])
            //添加按钮的约束条件
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            //设置无障碍标签
            button.accessibilityLabel = "Set \(index + 1) star rating"
            //创建戳动作
            button.addTarget(self, action:
                #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            //把按钮填到视图
            addArrangedSubview(button)
            //把按钮填到评分列表结构中
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    private func updateButtonSelectionStates(){
        for(index,button) in ratingButtons.enumerated(){
            button.isSelected = index < rating
            //为当前选中的星星设置提示语音字
            let hintString:String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to 0"
            }
            else{
                hintString = nil
            }
            //为当前星星设置提示值
            let valueString:String
            switch(rating){
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            //将提示音和值分配给按钮
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
