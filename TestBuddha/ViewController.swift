//
//  ViewController.swift
//  TestBuddha
//
//  Created by Zhang on 11/08/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import MJExtension

let SCREENHEIGHT = UIScreen.main.bounds.size.height
let SCREENWIDTH = UIScreen.main.bounds.size.width

class ViewController: UIViewController {

    var buddhaIndexModels = [BuddhaIndexModel]()
    var label:UILabel!
    var labelDesc:UILabel!
    var labelDescc:UILabel!
    var userInfo:UserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.readTextData()
        
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: SCREENHEIGHT - 40, width: 40, height: 40)
        button.backgroundColor = UIColor.red
        button.setTitle("投掷", for: .normal)
        button.addTarget(self, action: #selector(ViewController.buttonPress), for: .touchUpInside)
        self.view.addSubview(button)
        
        
        label = UILabel.init()
        label.frame = CGRect.init(x: 40, y: SCREENHEIGHT - 40, width: SCREENWIDTH - 40, height: 40)
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        self.view.addSubview(label)
        
        labelDesc = UILabel.init()
        labelDesc.frame = CGRect.init(x: 40, y: SCREENHEIGHT - 40, width: SCREENWIDTH/2, height: 40)
        labelDesc.font = UIFont.systemFont(ofSize: 25)
        labelDesc.textAlignment = .center
        self.view.addSubview(labelDesc)
        
        labelDescc = UILabel.init()
        labelDescc.frame = CGRect.init(x: 0, y: SCREENHEIGHT/2, width: SCREENWIDTH, height: 40)
        labelDescc.font = UIFont.systemFont(ofSize: 25)
        labelDescc.textAlignment = .center
        self.view.addSubview(labelDescc)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func buttonPress(){
        let index = self.drawRandomCard()
        self.gotoLogic(index: index)
        print(userInfo.index.desc)
        switch index {
        case 0:
            label.text = "南"
        case 1:
            label.text = "无"
        case 2:
            label.text = "啊"
        case 3:
            label.text = "弥"
        case 4:
            label.text = "陀"
        default:
            label.text = "佛"
        }
        
    }

    func drawRandomCard() -> Int{
        let randomNumber : Int = Int(arc4random_uniform(6))
        return randomNumber
    }
    
    // + 表示封几
    // - 1 复位
    // - 100 不行
    // - 10 没有数据
    // - 1000 停一
    // - 1 , f 表示复位行佛
    
    func gotoLogic(index:Int?){
        if userInfo == nil {
            for model in buddhaIndexModels {
                if "\((index)!)" == model.index {
                    userInfo = UserModel.init()
                    userInfo.index = model
                    userInfo.selectArray.append(model)
                }
            }
        }else{
            //0,1,2,3,4,5
            let toIndex = self.changeIndexToKey(index: index!, buddha:userInfo.index.buddha)
            
            let strArray = toIndex?.components(separatedBy: ",")
            if strArray?.count == 1 {
                for model in buddhaIndexModels {
                    if toIndex == model.index {
                        userInfo.index = model
                        userInfo.selectArray.append(model)
                        labelDesc.text = userInfo.index.desc
                    }
                }
            }else{
                if strArray?[0] == "-" {
                    for i in 1...(strArray?.count)! - 1 {
                        if strArray?[i] == "1" {
                            print("复位")
                            userInfo.index = userInfo.selectArray[userInfo.selectArray.count - 2]
                        }else if strArray?[i] == "10" {
                            labelDesc.text = "不变"
                            print("不变")
                        }else if strArray?[i] == "100" {
                            labelDesc.text = "不行"
                            print("不行")
                        }else if strArray?[i] == "1000" {
                            labelDesc.text = "停一"
                            print("停一")
                        }else if strArray?[i] == "f" {
                            let toIndex = userInfo.index.buddha.f
                            let strArray = toIndex?.components(separatedBy: ",")
                            if strArray?.count == 1 {
                                for model in buddhaIndexModels {
                                    if toIndex == model.index {
                                        userInfo.index = model
                                        userInfo.selectArray.append(model)
                                        labelDesc.text = userInfo.index.desc
                                        print(userInfo.index.desc)
                                    }
                                }
                            }else{
                                if strArray?[0] == "-" {
                                    for i in 1...(strArray?.count)! - 1 {
                                        if strArray?[i] == "1" {
                                            print("复位")
                                            userInfo.index = userInfo.selectArray[userInfo.selectArray.count - 4]
                                        }else if strArray?[i] == "10" {
                                            labelDesc.text = "不变"
                                            print("不变")
                                        }else if strArray?[i] == "100" {
                                            labelDesc.text = "不行"
                                            print("不行")
                                        }else if strArray?[i] == "1000" {
                                            labelDesc.text = "停一"
                                            print("停一")
                                        }else if strArray?[i] == "f" {
                                            let toIndex = userInfo.index.buddha.f
                                            for model in buddhaIndexModels {
                                                if toIndex == model.index {
                                                    userInfo.index = model
                                                    userInfo.selectArray.append(model)
                                                    labelDesc.text = userInfo.index.desc
                                                    print(userInfo.index.desc)
                                                }
                                            }
                                        }else if strArray?[i] == "t" {
                                            let toIndex = userInfo.index.buddha.t
                                            for model in buddhaIndexModels {
                                                if toIndex == model.index {
                                                    userInfo.index = model
                                                    userInfo.selectArray.append(model)
                                                    labelDesc.text = userInfo.index.desc
                                                    print(userInfo.index.desc)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }else if strArray?[i] == "t" {
                            let toIndex = userInfo.index.buddha.f
                            for model in buddhaIndexModels {
                                if toIndex == model.index {
                                    userInfo.index = model
                                    userInfo.selectArray.append(model)
                                    print(userInfo.index.desc)
                                    labelDesc.text = userInfo.index.desc
                                }
                            }
                        }
                    }
                }else if strArray?[0] == "+"{
                    labelDesc.text = "封\((strArray?[1])!)"
                    print("封\((strArray?[1])!)")
                }
            }
        }
        let str = "\((userInfo.index.desc)!) \((userInfo.index.dessc)!)"
        labelDescc.text = str
        print(str)
    }
    
    func changeIndexToKey(index:Int, buddha:BuddhaModel) -> String? {
        switch index {
        case 0:
            return buddha.n
        case 1:
            return buddha.w
        case 2:
            return buddha.a
        case 3:
            return buddha.m
        case 4:
            return buddha.t
        default:
            return buddha.f
        }
    }
    
    func setData(array:NSMutableArray){
        for i in array {
            let model = BuddhaIndexModel.init()
                .mj_setKeyValues(i)
            model?.index = (i as! NSDictionary).object(forKey: "index") as! String
            model?.desc = (i as! NSDictionary).object(forKey: "desc") as! String
            model?.buddha = BuddhaModel.init(dic: (i as! NSDictionary).object(forKey: "buddha") as! NSDictionary)
            self.buddhaIndexModels.append(model!)
        }
    }
    
    func readTextData(){
        //设定路径
        let array = NSMutableArray.init()
        let data1 = NSMutableArray.mj_objectArray(withKeyValuesArray: str31)
        let data2 = NSMutableArray.mj_objectArray(withKeyValuesArray: str1)
        let data3 = NSMutableArray.mj_objectArray(withKeyValuesArray: str2)
        let data4 = NSMutableArray.mj_objectArray(withKeyValuesArray: str3)
        let data5 = NSMutableArray.mj_objectArray(withKeyValuesArray: str4)
        let data6 = NSMutableArray.mj_objectArray(withKeyValuesArray: str5)
        let data7 = NSMutableArray.mj_objectArray(withKeyValuesArray: str6)
        let data8 = NSMutableArray.mj_objectArray(withKeyValuesArray: str7)
        let data9 = NSMutableArray.mj_objectArray(withKeyValuesArray: str8)
        let data10 = NSMutableArray.mj_objectArray(withKeyValuesArray: str10)
        let data11 = NSMutableArray.mj_objectArray(withKeyValuesArray: str11)
        let data12 = NSMutableArray.mj_objectArray(withKeyValuesArray: str11)
        let data13 = NSMutableArray.mj_objectArray(withKeyValuesArray: str13)
        let data14 = NSMutableArray.mj_objectArray(withKeyValuesArray: str14)
        let data15 = NSMutableArray.mj_objectArray(withKeyValuesArray: str15)
        let data16 = NSMutableArray.mj_objectArray(withKeyValuesArray: str16)
        let data17 = NSMutableArray.mj_objectArray(withKeyValuesArray: str17)
        let data18 = NSMutableArray.mj_objectArray(withKeyValuesArray: str18)
        let data19 = NSMutableArray.mj_objectArray(withKeyValuesArray: str19)
        let data20 = NSMutableArray.mj_objectArray(withKeyValuesArray: str20)
        let data21 = NSMutableArray.mj_objectArray(withKeyValuesArray: str21)
        let data22 = NSMutableArray.mj_objectArray(withKeyValuesArray: str22)
        let data23 = NSMutableArray.mj_objectArray(withKeyValuesArray: str23)
        let data24 = NSMutableArray.mj_objectArray(withKeyValuesArray: str24)
        let data25 = NSMutableArray.mj_objectArray(withKeyValuesArray: str25)
        let data26 = NSMutableArray.mj_objectArray(withKeyValuesArray: str26)
        let data27 = NSMutableArray.mj_objectArray(withKeyValuesArray: str27)
        let data28 = NSMutableArray.mj_objectArray(withKeyValuesArray: str28)
        let data29 = NSMutableArray.mj_objectArray(withKeyValuesArray: str29)
        let data30 = NSMutableArray.mj_objectArray(withKeyValuesArray: str30)
        let data31 = NSMutableArray.mj_objectArray(withKeyValuesArray: str31)
//        array.add
        array.addObjects(from: data1 as! [Any])
        array.addObjects(from: data2 as! [Any])
        array.addObjects(from: data3 as! [Any])
        array.addObjects(from: data4 as! [Any])
        array.addObjects(from: data5 as! [Any])
        array.addObjects(from: data6 as! [Any])
        array.addObjects(from: data7 as! [Any])
        array.addObjects(from: data8 as! [Any])
        array.addObjects(from: data9 as! [Any])
        array.addObjects(from: data10 as! [Any])
        array.addObjects(from: data11 as! [Any])
        array.addObjects(from: data12 as! [Any])
        array.addObjects(from: data13 as! [Any])
        array.addObjects(from: data14 as! [Any])
        array.addObjects(from: data15 as! [Any])
        array.addObjects(from: data16 as! [Any])
        array.addObjects(from: data17 as! [Any])
        array.addObjects(from: data18 as! [Any])
        array.addObjects(from: data19 as! [Any])
        array.addObjects(from: data20 as! [Any])
        array.addObjects(from: data21 as! [Any])
        array.addObjects(from: data22 as! [Any])
        array.addObjects(from: data23 as! [Any])
        array.addObjects(from: data24 as! [Any])
        array.addObjects(from: data25 as! [Any])
        array.addObjects(from: data26 as! [Any])
        array.addObjects(from: data27 as! [Any])
        array.addObjects(from: data28 as! [Any])
        array.addObjects(from: data29 as! [Any])
        array.addObjects(from: data30 as! [Any])
        array.addObjects(from: data31 as! [Any])
        self.setData(array: array)
    }
    
    func jsonStringToDic(_ dictionary_temp:String) ->NSDictionary {
        let data = dictionary_temp.data(using: String.Encoding.utf8)! as NSData
        let dictionary_temp_temp = try? JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
        return dictionary_temp_temp as! NSDictionary
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

