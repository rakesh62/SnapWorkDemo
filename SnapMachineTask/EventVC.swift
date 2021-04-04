//
//  ViewController.swift
//  SnapMachineTask
//
//  Created by Rakesh on 4/4/21.
//  Copyright © 2021 Rakesh. All rights reserved.
//

import UIKit
protocol RowDelegate:class {
    func cellTapped(value:String,isyearSelected:Bool,index:Int)
}
protocol EventDetailDelegate:class {
    func cellTapped(datetime: String, detailtext: String,Index:Int)
}

class EventVC: UIViewController,RowDelegate,EventDetailDelegate {
    func cellTapped(datetime: String, detailtext: String,Index:Int) {
        print(datetime,detailtext,Index)
        self.selectedIndex = [Index]
        dateandTime = datetime
        detailText = detailtext
        tableview.reloadData()
        
    }
    
    @IBOutlet weak var yearBtn: UIButton!
    @IBOutlet weak var monthBtn: UIButton!
    @IBOutlet weak var tableview: UITableView!
    var selectedMonth = ""
    var seletedYear = ""
    var seleteddate = ""
    var isediting = Bool()
    var dt = [Date]()
    let dateArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]
    var selectedIndex = IndexPath()
    var dateandTime = ""
    var detailText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableview.register(UINib(nibName: "DaysTableViewCell", bundle: nil), forCellReuseIdentifier: "DaysTableViewCell")
        self.title  = "Events"
        self.currentdetails()
        
    }
    func currentdetails()
    {
        if let monthInt = Calendar.current.dateComponents([.month], from: Date()).month {
            let monthStr = Calendar.current.monthSymbols[monthInt-1]
            print(monthInt) // 4
            self.monthBtn.setTitle(monthStr, for: .normal)
        }
        
        let yearInt = Calendar.current.component(.year, from: Date()) // 4
        self.yearBtn.setTitle(String(yearInt), for: .normal)
        
    }
    @IBAction func didTapYear(_ sender: Any) {
        
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "ModalPopupVC") as? ModalPopupVC
        myVC?.modalPresentationStyle = .overCurrentContext
        let navController = UINavigationController(rootViewController: myVC!)
        navController.modalPresentationStyle = .overCurrentContext
        myVC?.delegate = self
        myVC?.isyearSelected = true
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    @IBAction func didTapMonth(_ sender: Any)
    {
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "ModalPopupVC") as? ModalPopupVC
        myVC?.modalPresentationStyle = .overCurrentContext
        let navController = UINavigationController(rootViewController: myVC!)
        navController.modalPresentationStyle = .overCurrentContext
        myVC?.delegate = self
        myVC?.isyearSelected = false
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    func cellTapped(value: String,isyearSelected:Bool,index:Int) {
        if isyearSelected
        {
            self.yearBtn.setTitle(value, for: .normal)
            self.seletedYear = value
        }
        else
        {
            self.monthBtn.setTitle(value, for: .normal)
            self.selectedMonth = value
            self.tableview.reloadData()
            
        }
    }
    func getAllDates(month: Int, year: Int) -> [Date] {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        var arrDates = [Date]()
        for day in 1...numDays {
            let dateString = "\(year) \(month) \(day)"
            if let date = formatter.date(from: dateString) {
                arrDates.append(date)
            }
        }
        
        return arrDates
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EventDetailsVC {
            vc.delegate = self
            vc.selecteddt = "\(seleteddate)-\(selectedMonth)-\(seletedYear)"
            vc.selectedIndex = tableview.indexPathForSelectedRow?.row ?? 0
        }
    }
}

extension EventVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            
        case 0:
            return 120
        default:
            return 120
        }
    }
}
extension EventVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateArray.count
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DaysTableViewCell", for: indexPath) as! DaysTableViewCell
        print(selectedIndex.contains(indexPath.row))
        if selectedIndex.contains(indexPath.row)
        {
            cell.dayLabel.text = dateArray[indexPath.row]
            cell.monthLabel.text = selectedMonth
            cell.dateandTimeLabel.text = dateandTime
            cell.detailsText.text = detailText
        }
        else
        {
            cell.dayLabel.text = dateArray[indexPath.row]
            cell.monthLabel.text = selectedMonth
            cell.dateandTimeLabel.text = ""
            cell.detailsText.text = ""
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.seleteddate = dateArray[indexPath.row]
        self.performSegue(withIdentifier: "EventToEventDetails", sender: self)
    }
}
@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

