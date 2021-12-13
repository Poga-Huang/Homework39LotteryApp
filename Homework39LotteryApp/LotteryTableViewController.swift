//
//  LotteryTableViewController.swift
//  Homework39LotteryApp
//
//  Created by 黃柏嘉 on 2021/12/13.
//

import UIKit
import GameplayKit


enum ItemMode:Int{
    case superLottery
    case lottery
}

class LotteryTableViewController: UITableViewController {
    
    //View
    @IBOutlet weak var showItemView: UIView!
    @IBOutlet var lotteryView: UIView!
    @IBOutlet var superLotteryView: UIView!
    //Label
    @IBOutlet weak var drawTimeLabel: UILabel!
    //switch
    @IBOutlet weak var serialNumberSwitch: UISwitch!
    //datePicker
    @IBOutlet weak var purchaceTimeDatePicker: UIDatePicker!
    //segmentedControl
    @IBOutlet weak var itemSegmentedControl: UISegmentedControl!
    //UIImageView
    @IBOutlet var superLotteryImageArray: [UIImageView]!
    @IBOutlet weak var superLotterySpecialNumberImageView: UIImageView!
    @IBOutlet var lotteryImageArray: [UIImageView]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showItemView.addSubview(superLotteryView)
       
    }
    //選擇投注項目
    @IBAction func selectPlayItem(_ sender: UISegmentedControl) {
        showItemView.subviews[0].removeFromSuperview()
        if sender.selectedSegmentIndex == 0{
            showItemView.addSubview(superLotteryView)
        }else{
            showItemView.addSubview(lotteryView)
        }
    }
    
    //產生
    @IBAction func generate(_ sender: UIButton) {
        generateNumber(selectIndex: itemSegmentedControl.selectedSegmentIndex)
        showDrawTime(selectIndex: itemSegmentedControl.selectedSegmentIndex)
    }
}
