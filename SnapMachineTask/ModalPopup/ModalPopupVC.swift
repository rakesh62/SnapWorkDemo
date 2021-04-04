//
//  ModalPopupVC.swift
//  SnapMachineTask
//
//  Created by Rakesh on 4/4/21.
//  Copyright © 2021 Rakesh. All rights reserved.
//

import UIKit

class ModalPopupVC: UIViewController {
    @IBOutlet weak var bgview: UIView!
    weak var delegate:RowDelegate?
    var years = ["2016","2017","2018","2019","2020","2021","2022","2023","2024","2025"]
    var monthsArray = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    
    @IBOutlet weak var tableView: UITableView!
    var isyearSelected = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.tableView.backgroundView = blurEffectView
        self.bgview.layer.cornerRadius = 20
        self.tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        
        // Do any additional setup after loading the view.
    }
    @IBAction func dismissbutton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
extension ModalPopupVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            
        case 0:
            return 70
        default:
            return 70
        }
    }
}
extension ModalPopupVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isyearSelected
        {
            return years.count
            
        }
        else
        {
            return monthsArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as! TitleTableViewCell
        if isyearSelected
        {
            cell.titleLabel.text = years[indexPath.row]
        }
        else{
            cell.titleLabel.text = monthsArray[indexPath.row]
            
        }
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil {
            print(indexPath.item)
            if isyearSelected
            {
                delegate?.cellTapped(value:years[indexPath.row],isyearSelected:true,index:indexPath.row)
                self.dismiss(animated: true, completion: nil)
            }
            else
            {
                delegate?.cellTapped(value:monthsArray[indexPath.row],isyearSelected:false,index:indexPath.row)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
        
        
    }
}
