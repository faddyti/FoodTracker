//
//  MealViewController.swift
//  FoodTracker
//
//  Created by XY on 2018/5/4.
//  Copyright © 2018年 zhangjingyu. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: 属性
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    /*
     meal, 由MealTableViewController的方法prepare(for:sender:)传值或新建项目时产生
     */
    var meal: Meal?
    override func viewDidLoad() {
        super.viewDidLoad()
        // 通过代理回调处理文本框
        nameTextField.delegate = self
        // 如果是编辑状态，那么把空都填上
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        // 没有有效项目名称，禁用保存按钮
        updateSaveButtonState()
    }
    
    //MARK: 文本框代理回調
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 隱藏鍵盤
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 输入状态，保存按钮不能使用
        saveButton.isEnabled = false
    }
    
    //MARK: 图片代理回调
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 关闭图片选择器
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            else{
                fatalError("Excepted a dictionary containing an image, but was provided follow info:\(info)")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    //MARK: 跳转
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // 根据进入场景的方式：模式化还是导航的push，执行两种不同取消策略
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode{
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else{
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    // 在显示目标视图前配置视图控制器
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // 当“保存”按钮按下，配置目标视图控制器
        guard let button = sender as?UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log:OSLog.default,type:.debug)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        // 设置跳转前变量meal，为跳转到目标视图做准备
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    //MARK: 动作
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // 隐藏键盘
        nameTextField.resignFirstResponder()
        // 新建选取图片控件
        let imagePickerController = UIImagePickerController()
        // 仅从照片图库里选取图片
        imagePickerController.sourceType = .photoLibrary
        // 通知视图代理
        imagePickerController.delegate = self
        present(imagePickerController,animated: true,completion: nil)
    }
    //MARK: 私有方法
    private func updateSaveButtonState() {
        // 如果输入为空，保存按钮禁用
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

