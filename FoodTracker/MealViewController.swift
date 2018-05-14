//
//  MealViewController.swift
//  FoodTracker
//
//  Created by XY on 2018/5/4.
//  Copyright © 2018年 zhangjingyu. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: 属性
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 通过代理回调处理文本框
        nameTextField.delegate = self
    }
    
    //MARK: 文本框代理回調
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 隱藏鍵盤
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
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
    
}

