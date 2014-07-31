//
//  FirstViewController.swift
//  Casebook 8
//
//  Created by Marcus Bloice on 22/07/14.
//  Copyright (c) 2014 Marcus D. Bloice. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    // IB Outlets are just created here now instead of the
    @IBOutlet var txtCaseName: UITextField
    @IBOutlet var txtAccessCode: UITextField
    
    // IB Actions also appear here in Swift
    @IBAction func btnSave(){
        txtCaseName.text = "Save Button Pressed"
    }
    
    @IBAction func btnLoad(){
        txtCaseName.text = "Load Button Pressed"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

