//
//  timetableCollectionViewController.swift
//  morningRoutine
//
//  Created by Kate Roberts on 26/09/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class timetableCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let date = Date()
    let calendar = Calendar.current
   
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)

      //  let imageView = UIImageView(image: #imageLiteral(resourceName: "image.png")) // This would be your mapView, here I am just using a random image
        
     //   let newFrame = view.frame.
        let lineView = LineView(frame: CGRect( x: 0, y: 200, width: view.frame.size.width, height: view.frame.size.height ) )
        
//        NSLayoutConstraint.activate(
//            [
//                //lineView.centerXAnchor.constraint(equalTo: view.margins.centerXAnchor),
//             //  lineView.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 163/545),
//                lineView.topAnchor.constraint(equalTo
//            ]
//        )

        view.addSubview(lineView)
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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
        return 7
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let width = (self.view.frame.size.height) / 7//some width
        let height = (self.view.frame.size.width) / 18
               return CGSize(width: width, height: height)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> timetableCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! timetableCollectionViewCell
        cell.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        cell.label.text = " "
        
        if indexPath.section == 0{
            cell.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            //if indexPath.row == 1 {}
            switch indexPath.row {
                case 1: cell.label.text = "Mum"
                case 2: cell.label.text = "Xenia"
                case 3: cell.label.text = "Peter"
                case 4: cell.label.text = "Lenny"
                case 5: cell.label.text = "Marina"
                case 6: cell.label.text = "Cassie"
                default: cell.label.text = "Name"
            }
        }
        
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
        
        if indexPath.row == 4{
                   cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                   //if indexPath.row == 1 {}
                   switch indexPath.section {
                       case 1: cell.label.text = "Wake Up"
                       case 2: cell.label.text = "Eat"
                       case 3: cell.label.text = "Eat"
                       case 4: cell.label.text = "Dressed and Clean"
                       case 5: cell.label.text = "Packed and Ready"
                       case 6: cell.label.text = "Piano"
                       case 7: cell.label.text = "Listening Program"
                       case 8: cell.label.text = "Leave"
                       case 9: cell.label.text = " "
                       case 10: cell.label.text = " "
                       case 11: cell.label.text = " "
                       case 12: cell.label.text = " "
                       default: cell.label.text = "Lenny"
                        cell.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                   }
               }
        
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //  addToList.append(objectsArray[indexPath.row])
        let cell = collectionView.cellForItem(at: indexPath) as! timetableCollectionViewCell
        cell.layer.borderWidth = 2.0
        if cell.backgroundColor == #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        {
            cell.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        }
        else{
            if cell.backgroundColor == #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            {
                cell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
        }
        
        if cell.label.text == "Leave"
        {
            performSegue(withIdentifier: "leave", sender: self)
        }
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
            context.addLine(to: CGPoint(x: 1500.0, y: 0.0)) // This would be newX, newY
            context.strokePath()
        }
    }
}
