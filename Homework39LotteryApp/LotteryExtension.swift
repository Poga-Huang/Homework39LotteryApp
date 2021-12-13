//
//  LotteryExtension.swift
//  Homework39LotteryApp
//
//  Created by 黃柏嘉 on 2021/12/13.
//

import UIKit
import GameplayKit

extension LotteryTableViewController{
    //產生數字
    func generateNumber(selectIndex:Int){
       let selectItem = ItemMode(rawValue: selectIndex)
        switch selectItem {
        case .superLottery:
            generateRandomNumber(maxNumber: 38, serialNumber: serialNumberSwitch.isOn)
        case .lottery:
            generateRandomNumber(maxNumber: 49, serialNumber: serialNumberSwitch.isOn)
        default:
            return
        }
    }
    //產生隨機數
    func generateRandomNumber(maxNumber:Int,serialNumber:Bool){
        var numberArray = [Int]()
        var numberIndex = 0
        //接受連號
        if serialNumber == true{
            let GKShuffleNumber = GKShuffledDistribution(lowestValue: 1, highestValue: maxNumber)
            for _ in 0...5{
                numberArray.append(GKShuffleNumber.nextInt())
            }
        }else{
            //不接受連號
            //產生所有數字
            var serialnumberArray = [Int]()
            for i in 1...maxNumber{
                serialnumberArray.append(i)
            }
            //隨機從所有數字中取得6個數並將前後數字移除避免連號
            for _ in 0...5{
                let randomIndex = Int.random(in: 0..<serialnumberArray.count)
                numberArray.append(serialnumberArray[randomIndex])
                if randomIndex == 0{
                    serialnumberArray.remove(at: randomIndex)
                    serialnumberArray.remove(at: randomIndex+1)
                }else if randomIndex == serialnumberArray.count-1{
                    serialnumberArray.remove(at: randomIndex)
                    serialnumberArray.remove(at: randomIndex-1)
                }else{
                    serialnumberArray.remove(at: randomIndex+1)
                    serialnumberArray.remove(at: randomIndex)
                    serialnumberArray.remove(at: randomIndex-1)
                }
            }
        }
        //按照大小順序
        numberArray.sort()
        if maxNumber == 38{
            for i in superLotteryImageArray{
                i.image = UIImage(systemName: "\(numberArray[numberIndex]).circle.fill")
                i.tintColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
                numberIndex += 1
            }
            //特別號
            superLotterySpecialNumberImageView.image = UIImage(systemName: "\(Int.random(in: 1...8)).circle.fill")
            superLotterySpecialNumberImageView.tintColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        }else if maxNumber == 49{
            for i in lotteryImageArray{
                i.image = UIImage(systemName: "\(numberArray[numberIndex]).circle.fill")
                i.tintColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
                numberIndex += 1
            }
        }
    }
    //比對開獎時間
    func showDrawTime(selectIndex:Int){
        let selectItem = ItemMode(rawValue: selectIndex)
        let purchaseTime = purchaceTimeDatePicker.date
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: purchaseTime)
        let weekday = dateComponents.weekday
        //不同項目開獎時間不同
        switch selectItem {
        case .superLottery:
            if weekday == 2 || weekday == 5{
                drawTimeLabel.text = "開獎就是今天！"
            }else{
                if weekday! < 2{
                    drawTimeLabel.text = "明天開獎"
                }else if weekday! > 2 && weekday! < 5{
                    drawTimeLabel.text = "開獎還有\(5-weekday!)天"
                }else{
                    drawTimeLabel.text = "開獎還有\(7-weekday!+2)天"
                }
            }
        case .lottery:
            if weekday == 3 || weekday == 6{
                drawTimeLabel.text = "開獎就是今天！"
            }else{
                if weekday! < 3{
                    drawTimeLabel.text = "明天開獎"
                }else if weekday! > 3 && weekday! < 6{
                    drawTimeLabel.text = "開獎還有\(6-weekday!)天"
                }else{
                    drawTimeLabel.text = "開獎還有\(7-weekday!+3)天"
                }
            }
        default:
            return
        }
    }
}
