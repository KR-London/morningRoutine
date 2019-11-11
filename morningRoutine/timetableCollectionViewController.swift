//
//  timetableCollectionViewController.swift
//  morningRoutine
//
//  Created by Kate Roberts on 26/09/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit
import CoreLocation
private let reuseIdentifier = "Cell"
import Alamofire
import SwiftyJSON

let testing = false

class timetableCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "c2b380f85b27464a398cc982d4fba1c5"
    
    //TODO: declare instance variable s
    
    let locationManger = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    var weatherManager = WeatherManager()
    
    var taskMatrix = Array(repeating: Array(repeating: (false, taskStatus.Open), count: 14), count: 13)

    var startingPoint : Date?
    
     unowned var myNav : UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // print(getDateFromHour(hour: 20))
        
        //TODO: set up location manager
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
        weatherManager.delegate = self as! WeatherManagerDelegate
        weatherManager.fetchWeather(cityName: "Watford")
        //// city ID is 2634677
      //  setUpNavigationBarItems()
        
        if testing == true{
              //startingPoint = DispatchTime.now()
            startingPoint = Date()
          }
        else{
            startingPoint = getDateFromHour(hour: 12)
        }
       // let hour = calendar.component(.hour, from: date)
       // let minutes = calendar.component(.minute, from: date)
        


        let lineView = LineView(frame: CGRect( x: 0, y: view.frame.size.height/13, width: 10, height: 10) )
       // self.view.frame.width

        //print(taskMatrix)
        view.addSubview(lineView)
        
        /// in the real thing I'd need to figure out the current time > status matrix at the point the app is launched
        if testing == true
        {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: "updateLine", userInfo: nil, repeats: true)
        }
        else{
            updateLine()
            Timer.scheduledTimer(timeInterval: 60, target: self, selector: "updateLine", userInfo: nil, repeats: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 13
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 14
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let width = (self.view.frame.size.height  ) / 15//some width
        let height = (self.view.frame.size.width -  (navigationController?.navigationBar.frame.height ?? 0 ) ) / 18
               return CGSize(width: width, height: height)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> timetableCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! timetableCollectionViewCell
        cell.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        cell.label.text = " "
        
        if indexPath.row == 0{
            cell.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            //if indexPath.row == 1 {}
            switch indexPath.section {
                case 1: cell.label.text = "6:00"
                case 2: cell.label.text = "6:15"
                case 3: cell.label.text = "6:30"
                case 4: cell.label.text = "6:45"
                case 5: cell.label.text = "7:00"
                case 6: cell.label.text = "7:15"
                case 7: cell.label.text = "7:30"
                case 8: cell.label.text = "7:45"
                case 9: cell.label.text = "8:00"
                case 10: cell.label.text = "8:15"
                case 11: cell.label.text = "8:30"
                case 12: cell.label.text = "8:45"
                default: cell.label.text = "Name"
            }
        }
        if indexPath.row == 2{
                if taskMatrix[indexPath.section][2].1 == taskStatus.Open
                {
                       cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                }
                else
                {
                        cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                }
                       //if indexPath.row == 1 {}
                       switch indexPath.section {
                           case 1: cell.label.text = "Make Porridge"
                           case 2: cell.label.text = "Feed"
                           case 3: cell.label.text = "Feed"
                           case 4: cell.label.text = "Pack"
                           case 5: cell.label.text = "Dress"
                           case 6: cell.label.text = "Drive Xen"
                           case 7: cell.label.text = "Drive Xen"
                           case 8: cell.label.text = "Support Boys"
                           case 9: cell.label.text = "End Food"
                           case 10: cell.label.text = "Dress girls"
                           case 11: cell.label.text = "Hair&Book"
                           case 12: cell.label.text = "Leave"
                           default: cell.label.text = "Adult"
                            cell.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                       }
                   }
        
        if indexPath.row == 4{
        if taskMatrix[indexPath.section][4].1 == taskStatus.Open
        {
               cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        else
        {
                cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        }
               //if indexPath.row == 1 {}
               switch indexPath.section {
                   case 1: cell.label.text = " "
                   case 2: cell.label.text = " "
                   case 3: cell.label.text = "Wake"
                   case 4: cell.label.text = "Pack"
                   case 5: cell.label.text = "Eat"
                   case 6: cell.label.text = "Leave"
                   case 7: cell.label.text = " "
                   case 8: cell.label.text = " "
                   case 9: cell.label.text = " "
                   case 10: cell.label.text = " "
                   case 11: cell.label.text = " "
                   case 12: cell.label.text = " "
                   default: cell.label.text = "Xenia"
                    cell.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
               }
           }
        
        if indexPath.row == 5{
            if taskMatrix[indexPath.section][5].1 == taskStatus.Open
            {
                   cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            else
            {
                    cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            }
                   //if indexPath.row == 1 {}
                   switch indexPath.section {
                       case 1: cell.label.text = " "
                       case 2: cell.label.text = " "
                       case 3: cell.label.text = " "
                       case 4: cell.label.text = " "
                       case 5: cell.label.text = " "
                       case 6: cell.label.text = " "
                       case 7: cell.label.text = " "
                       case 8: cell.label.text = " "
                       case 9: cell.label.text = " "
                       case 10: cell.label.text = " "
                       case 11: cell.label.text = " "
                       case 12: cell.label.text = " "
                       default: cell.label.text = "Xenia"
                        cell.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                   }
               }
            
        
        if indexPath.row == 6{
                if taskMatrix[indexPath.section][6].1 == taskStatus.Open
                {
                       cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                }
                else
                {
                        cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                }
                       //if indexPath.row == 1 {}
                       switch indexPath.section {
                           case 1: cell.label.text = "Wake Up"
                           case 2: cell.label.text = "Eat"
                           case 3: cell.label.text = "Eat"
                           case 4: cell.label.text = "Piano"
                           case 5: cell.label.text = "Piano"
                           case 6: cell.label.text = "Get Ready"
                           case 7: cell.label.text = "Breathe"
                           case 8: cell.label.text = "Leave"
                           case 9: cell.label.text = " "
                           case 10: cell.label.text = " "
                           case 11: cell.label.text = " "
                           case 12: cell.label.text = " "
                           default: cell.label.text = "Peter"
                            cell.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                       }
                   }
        
        if indexPath.row == 7{
                     if taskMatrix[indexPath.section][7].1 == taskStatus.Open
                     {
                            cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                     }
                     else
                     {
                             cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                     }
                            //if indexPath.row == 1 {}
                            switch indexPath.section {
                                case 1: cell.label.text = "Make Bed"
                                case 2: cell.label.text = "Teeth"
                                case 3: cell.label.text = "Pack Lunch"
                                case 4: cell.label.text = " "
                                case 5: cell.label.text = "Prayer"
                                case 6: cell.label.text = " "
                                case 7: cell.label.text = " "
                                case 8: cell.label.text = " "
                                case 9: cell.label.text = " "
                                case 10: cell.label.text = " "
                                case 11: cell.label.text = " "
                                case 12: cell.label.text = " "
                                default: cell.label.text = "Peter"
                                 cell.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                            }
                        }
        
        if indexPath.row == 8{
            if taskMatrix[indexPath.section][8].1 == taskStatus.Open
            {
                   cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            else
            {
                    cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            }
                   //if indexPath.row == 1 {}
                   switch indexPath.section {
                       case 1: cell.label.text = "Wake Up"
                       case 2: cell.label.text = "Eat"
                       case 3: cell.label.text = "Eat"
                       case 4: cell.label.text = "Dressed "
                       case 5: cell.label.text = "Get Ready"
                       case 6: cell.label.text = "Piano"
                       case 7: cell.label.text = "Front"
                       case 8: cell.label.text = "Leave"
                       case 9: cell.label.text = " "
                       case 10: cell.label.text = " "
                       case 11: cell.label.text = " "
                       case 12: cell.label.text = " "
                       default: cell.label.text = "Lenny"
                        cell.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                   }
               }
        
        if indexPath.row == 9{
            if taskMatrix[indexPath.section][9].1 == taskStatus.Open
            {
                   cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            else
            {
                    cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            }
                   //if indexPath.row == 1 {}
                   switch indexPath.section {
                       case 1: cell.label.text = "Make Bed"
                       case 2: cell.label.text = " "
                       case 3: cell.label.text = " "
                       case 4: cell.label.text = "Teeth & Hair"
                       case 5: cell.label.text = " "
                       case 6: cell.label.text = " "
                       case 7: cell.label.text = " "
                       case 8: cell.label.text = " "
                       case 9: cell.label.text = " "
                       case 10: cell.label.text = " "
                       case 11: cell.label.text = " "
                       case 12: cell.label.text = " "
                       default: cell.label.text = "Lenny"
                        cell.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                   }
               }
        
        if indexPath.row == 10{
            if taskMatrix[indexPath.section][10].1 == taskStatus.Open
            {
                   cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            else
            {
                    cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            }
                   //if indexPath.row == 1 {}
                   switch indexPath.section {
                       case 1: cell.label.text = " "
                       case 2: cell.label.text = " "
                       case 3: cell.label.text = " "
                       case 4: cell.label.text = " "
                       case 5: cell.label.text = " "
                       case 6: cell.label.text = "Wake Up"
                       case 7: cell.label.text = "Eat"
                       case 8: cell.label.text = " Eat"
                       case 9: cell.label.text = " Dress"
                       case 10: cell.label.text = " Reading"
                       case 11: cell.label.text = "Leave"
                       case 12: cell.label.text = " "
                       default: cell.label.text = "Marina"
                        cell.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                   }
               }
        
        
         if indexPath.row == 11{
             if taskMatrix[indexPath.section][10].1 == taskStatus.Open
             {
                    cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
             }
             else
             {
                     cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
             }
                    //if indexPath.row == 1 {}
                    switch indexPath.section {
                        case 1: cell.label.text = " "
                        case 2: cell.label.text = " "
                        case 3: cell.label.text = " "
                        case 4: cell.label.text = " "
                        case 5: cell.label.text = " "
                        case 6: cell.label.text = " "
                        case 7: cell.label.text = " "
                        case 8: cell.label.text = "Tidy Plate"
                        case 9: cell.label.text = " Teeth&Hair"
                        case 10: cell.label.text = "Tie and Jumper"
                        case 11: cell.label.text = "Socks & shoes"
                        case 12: cell.label.text = " "
                        default: cell.label.text = "Marina"
                         cell.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                    }
                }
        
        if indexPath.row == 12{
                 if taskMatrix[indexPath.section][12].1 == taskStatus.Open
                 {
                        cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                 }
                 else
                 {
                         cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                 }
                        //if indexPath.row == 1 {}
                        switch indexPath.section {
                            case 1: cell.label.text = " "
                            case 2: cell.label.text = " "
                            case 3: cell.label.text = " "
                            case 4: cell.label.text = " "
                            case 5: cell.label.text = ""
                            case 6: cell.label.text = ""
                            case 7: cell.label.text = " Hair"
                            case 8: cell.label.text = " Eat"
                            case 9: cell.label.text = " Eat"
                            case 10: cell.label.text = " Dress "
                            case 11: cell.label.text = " Read"
                            case 12: cell.label.text = " "
                            default: cell.label.text = "Cass"
                             cell.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                        }
                    }
        
        if indexPath.row == 13{
                  if taskMatrix[indexPath.section][13].1 == taskStatus.Open
                  {
                         cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                  }
                  else
                  {
                          cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                  }
                         //if indexPath.row == 1 {}
                         switch indexPath.section {
                             case 1: cell.label.text = " "
                             case 2: cell.label.text = " "
                             case 3: cell.label.text = " "
                             case 4: cell.label.text = " "
                             case 5: cell.label.text = " "
                             case 6: cell.label.text = " "
                             case 7: cell.label.text = "Wake Up"
                             case 8: cell.label.text = "Eat"
                             case 9: cell.label.text =  " Dress "
                             case 10: cell.label.text = "Socks & shoes"
                             case 11: cell.label.text =  "Leave"
                             case 12: cell.label.text = " "
                             default: cell.label.text = "Cass"
                              cell.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                         }
                     }
        
        if cell.label.text == " " {
            switch indexPath.row {
            //case 1:
           // case 2:
           // case 3:
                case 4:cell.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                           case 5: cell.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                           case 6: cell.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                case 7: cell.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                           case 8: cell.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                           case 9: cell.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                case 10:  cell.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                           case 11:  cell.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                           case 12: cell.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                case 13: cell.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            default: cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
        
        if taskMatrix[indexPath.section][indexPath.row].0 == true
        {
            if cell.backgroundColor ==  #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1){
                cell.wobble()
                //xcell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            }
            else{
                    //cell.alpha = 0.2
                  cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                }
        }
//        if taskMatrix[indexPath.section][indexPath.row].0 == true  && cell.backgroundColor ==  #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1){
//                    //cell.alpha = 0.2
//                  cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//                }
        
        
        if  taskMatrix[indexPath.section][indexPath.row].0 == true  && cell.backgroundColor ==  #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)  {
                     //cell.alpha = 0.2
        
            //cell.alpha = 0.2
          cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        
        var elapsedTime = -Int(  startingPoint!.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate)
        
        if indexPath.section < elapsedTime/(60*15) && cell.backgroundColor ==  #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        {
            cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
          
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //  addToList.append(objectsArray[indexPath.row])
        let cell = collectionView.cellForItem(at: indexPath) as! timetableCollectionViewCell
        print("selected", cell.label.text!)
        cell.layer.borderWidth = 2.0
        if cell.backgroundColor == #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        {
            if taskMatrix[indexPath.section][indexPath.row].0 == false
            {
                cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            }
            else
            {
                cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            }
            cell.stopWobble()
            taskMatrix[indexPath.section][indexPath.row].1 = taskStatus.Closed
        }
        else{
            if cell.backgroundColor ==  #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            {
                cell.backgroundColor =  #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                
                taskMatrix[indexPath.section][indexPath.row].1 = taskStatus.Open
            }
        }
        
        if cell.label.text == "Leave"
        {
            performSegue(withIdentifier: "leave", sender: self)
        }
        
        if cell.label.text == "Get Ready"
        {
            performSegue(withIdentifier: "list", sender: self)
        }
    }
    
    
    func setUpNavigationBarItems(weather: WeatherModel){
        navigationItem.title = "Nag-O-Matic"
            //weather.cityName
        //

            let navBarHeight = navigationController?.navigationBar.frame.height
           
            let weatherButton = UIButton(type: .system)
            if #available(iOS 13.0, *) {
                weatherButton.setImage( UIImage(systemName: weather.conditionName ), for: .normal)
            } else {
               navigationItem.title = weather.conditionName
            }
        
          //  let weatherIcon = UIImageView()
           // weatherIcon.image = UIImage(systemName: weather.conditionName )
            //weatherButton.setImage(UIImage(named:"sun.jpg" )?.resize(to: CGSize(width: (36/53)*0.7*(navBarHeight ?? 100),height: 0.7*(navBarHeight ?? 100) )), for: .normal)

            //shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: weatherButton)
            
    //        let statsButton = UIButton(type: .system)
    //       // statsButton.setImage(UIImage(named: "appleHistory")?.resize(to: CGSize(width: 0.55*(navBarHeight ?? 100),height: 0.55*(navBarHeight ?? 100) )), for: .normal)
    //        statsButton.addTarget(self, action: #selector(goStats), for: .touchUpInside)
    //        statsButton.titleLabel?.text = "Stats"
    //        //statsButton.titleLabel?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    //        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: statsButton)
            
        }
    
    
    //MARK: Networking
    
    func getWeatherData(url: String, parameters: [String: String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess{
               // print("Got weather data")
                
              //  let weatherJSON : JSON = response.result.value! as! JSON
                
              let weatherJSON : JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
             
               // print(weatherJSON)
                //self.parseJSON(weatherData: weatherJSON)
                
            }else{
                print(response.result.error)
            }
        }
    }
    
    //MARK: JSON parsing
    
    func updateWeatherData(json: JSON){
        let tempResult = json["main"]["temp"].double
        weatherDataModel.temperature = Int(tempResult!) - Int(273.15)
       // WeatherDataModel.c
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let iconFilename = getConditionName(weatherID: id)
            print(iconFilename)
            
            print(iconFilename)
        }
            catch{
                print(error)
            }
        }
    
    func getConditionName(weatherID: Int) -> String{
        switch weatherID{
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            //case 801...804:
              ///  return "cloud.bolt"
            default:
                return "cloud"
        }
    }
    
    // MARK: Wether location manager delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManger.stopUpdatingLocation()
            print("longitude =")
            print(location.coordinate.longitude)
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String: String] = ["lat" : latitude, "lon": longitude, "appid": APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    //Update clock every second
    @objc func updateLine() {
        // let now = Date()
      //  var elapsedTime =  Int( (DispatchTime.now().uptimeNanoseconds -  startingPoint!.uptimeNanoseconds)/1000000000 )
        
        var elapsedTime = -Int( startingPoint!.timeIntervalSince1970 - Date().timeIntervalSince1970 )
      //  print(elapsedTime)
        
        // view.subvid
        //let lineView = LineView(frame: CGRect( x: 0, y: 200, width: view.frame.size.width, height: view.frame.size.height ) )
        //view.addSubview(lineView)
        //
        if testing == true
        {
            if elapsedTime < 12
            {

                let screenHeight = view.frame.size.height
                    view.subviews[1].frame = CGRect( x: 0, y: (screenHeight * CGFloat(elapsedTime + 2) ) / 13, width: 1000, height: 10 )
                

                for itemsIndex in 0 ... 13{
                    taskMatrix[elapsedTime ][itemsIndex].0 = true
                }
                self.collectionView.reloadSections(NSIndexSet(index: elapsedTime ) as IndexSet)
            }
        }
        else{
            if elapsedTime < 3*3600
            {
              
                let screenHeight = view.frame.size.height
                    elapsedTime = elapsedTime*12/(3*3600)
                    print(elapsedTime)
                let offset = navigationController?.navigationBar.frame.height
                print(offset)
                view.subviews[1].frame = CGRect( x: 0, y: (screenHeight * CGFloat(elapsedTime + 2 )  ) / 12 + (offset ?? 0 ) - 25 , width: 1000, height: 10 )
                

                for itemsIndex in 0 ... 13{
                    taskMatrix[elapsedTime ][itemsIndex].0 = true
                }
                for x in 1 ... elapsedTime{
                     self.collectionView.reloadSections(NSIndexSet(index: elapsedTime - x ) as IndexSet)
                }
               
            }
        }
        
       // }
    }
    
    func getDateFromHour(hour: Int) -> Date {
      let date = Date()
      let calendar = Calendar.current
      let componentsCurrent = calendar.dateComponents([.year, .month, .day], from: date)

      var components = DateComponents()
      components.hour = hour
      components.minute = 0
      components.second = 0
      components.month = componentsCurrent.month
      components.day = componentsCurrent.day
      components.year = componentsCurrent.year
      return calendar.date(from: components)!
    }
    
    
    
    

}

extension timetableCollectionViewController: WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel) {
              DispatchQueue.main.async {
            //  self.temperatureLabel.text = weather.temperatureString
           //   self.conditionImageView.image = UIImage(systemName: weather.conditionName)
              ///self.cityLabel.text = weather.cityName
              //self.
              print("The icon that I would show is...")
                print(weather.conditionName)
                
                self.setUpNavigationBarItems(weather: weather)
        
          }
    }
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherDataModel) {
        DispatchQueue.main.async {
          //  self.temperatureLabel.text = weather.temperatureString
         //   self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            ///self.cityLabel.text = weather.cityName
            //self.
            print("The icon that I would show is...")
            print(weather.weatherIconName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

class LineView : UIView {

    var position = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(10)
            context.beginPath()
            context.move(to: CGPoint(x: 0.0, y: 00.0)) // This would be oldX, oldY
            context.addLine(to: CGPoint(x: 15000.0, y: 0.0)) // This would be newX, newY
            context.strokePath()
        }
    }
}
//class func pulse(view: UIView, sizeMultiplier: Float, duration: NSTimeInterval, repeatCount: Float = 1.0) {
//    let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
//    pulseAnimation.duration = duration
//    pulseAnimation.toValue = NSNumber(float: sizeMultiplier)
//    pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//    pulseAnimation.autoreverses = true
//    pulseAnimation.repeatCount = repeatCount
//    view.layer.addAnimation(pulseAnimation, forKey: nil)
//}




//import UIKit
//
//
//
//private let reuseIdentifier = "cell"
//
//
//
//class timetableCollectionViewController: UICollectionViewController {
//
////    let alarmCollectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
////    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
////
//
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
//
//
//
//        // Uncomment the following line to preserve selection between presentations
//
//        // self.clearsSelectionOnViewWillAppear = false
//
//
//        // Register cell classes
//
//       // self.collectionView.layoutIfNeeded()
//
//      self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
//
//
//        // Do any additional setup after loading the view.
//
//    }
//
//
//
//    /*
//
//    // MARK: - Navigation
//
//
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        // Get the new view controller using [segue destinationViewController].
//
//        // Pass the selected object to the new view controller.
//
//    }
//
//    */
//
//
//
//    // MARK: UICollectionViewDataSource
//
//
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//
//        // #warning Incomplete implementation, return the number of sections
//
//        return 7
//
//    }
//
//
//
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        // #warning Incomplete implementation, return the number of items
//
//        return 13
//
//    }
//
//
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//
//        cell.backgroundColor = UIColor.green
//
//        // Configure the cell
//
//
//
//        return cell
//
//    }
//
//
//
//    // MARK: UICollectionViewDelegate
//
//
//
//    /*
//
//    // Uncomment this method to specify if the specified item should be highlighted during tracking
//
//    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//
//        return true
//
//    }
//
//    */
//
//
//
//    /*
//
//    // Uncomment this method to specify if the specified item should be selected
//
//    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//
//        return true
//
//    }
//
//    */
//
//
//
//    /*
//
//    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//
//    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
//
//        return false
//
//    }
//
//
//
//    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
//
//        return false
//
//    }
//
//
//
//    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//
//
//
//    }
//
//    */
//
//
//
//}
//
