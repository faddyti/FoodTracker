//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by XY on 2018/5/14.
//  Copyright © 2018年 zhangjingyu. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    //MARK:属性
    var meals = [Meal]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // 加载快餐列表
        loadSampleMeals()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //单元格重用，离队标记一下
        let cellIdentifier = "MealTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else{
            fatalError("离队单元格不是MealTalbeViewCell实例")
        }
        //获取对应数据源的快餐
        let meal = meals[indexPath.row]
        cell.nameLable.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: 跳转
    // 跳转之前做点准备
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier ?? ""  {
        case "AddItem":
            os_log("add new item", log:OSLog.default, type:.debug)
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController else{
                fatalError("unexpected destination: \(segue.destination)")
            }
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("unexpected sender: \(sender)")
            }
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("the selected cell is not being displayed by the table.")
            }
            let selectMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectMeal
        default:
            fatalError("unexpeted segue identifier: \(segue.identifier)")
        }
        
    }

    //MARK:动作
    @IBAction func unwindToMealList(sender:UIStoryboardSegue){
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            //添加新项目到列表
            let newIndexPath = IndexPath(row: meals.count, section: 0)
            meals.append(meal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        }
    }
    //MARK:私有方法
    private func loadSampleMeals(){
        let photo1 = UIImage(named: "Meal1")
        let photo2 = UIImage(named: "Meal2")
        let photo3 = UIImage(named: "Meal3")
        guard let meal1 = Meal.init(name: "意大利番茄沙拉", photo: photo1, rating: 4) else{
                fatalError("无法创建实例:meal1")
        }
        guard let meal2 = Meal.init(name: "土豆鸡块", photo: photo2, rating: 5) else {
            fatalError("无法创建实例:meal2")
        }
        guard let meal3 = Meal.init(name: "意大利肉丸面", photo: photo3	, rating: 3) else {
            fatalError("无法创建实例:meal3")
        }
        meals += [meal1,meal2,meal3]
    }

}
