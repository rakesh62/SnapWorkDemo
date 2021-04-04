//
//  EventDetailsVC.swift
//  SnapMachineTask
//
//  Created by Rakesh on 4/4/21.
//  Copyright © 2021 Rakesh. All rights reserved.
//

import UIKit

class EventDetailsVC: UIViewController,UITextViewDelegate,UITextFieldDelegate{
    
    
    

    @IBOutlet weak var descriptionsTextview: UITextView!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeTextfield: UITextField!
    var selecteddt = ""
    var timeArray = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
       var SecondArray = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    weak var delegate:EventDetailDelegate?
    var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "EventDetails"
        self.dateLabel.text = selecteddt
        self.timeTextfield.text = setcurrentTime()
      titleTextfield.addTarget(self, action: #selector(editingChanged), for: UIControl.Event.editingChanged)
        descriptionsTextview.delegate = self
        titleTextfield.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapSave(_ sender: Any) {
         if delegate != nil {
            delegate?.cellTapped(datetime: "\( self.timeTextfield.text ?? "")\(selecteddt)", detailtext: descriptionsTextview.text, Index: selectedIndex)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func setcurrentTime() -> String
    {
        let now = Date()

               let formatter = DateFormatter()
               formatter.timeStyle = .short
               

               let datetime = formatter.string(from: now)
        return datetime
    }

    
    @objc func editingChanged(Textfield:UITextField) -> Void
       {
           switch Textfield.tag
           {
           case 100: // alergies_which
            titleTextfield.text = Textfield.text!
            print("title is=====>\(titleTextfield.text!)")
               break
           default:
            break
        }
        
    }
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text!)
    }
}
