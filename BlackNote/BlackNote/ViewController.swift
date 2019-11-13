//
//  ViewController.swift
//  BlackNote
//
//  Created by Alexader Malygin on 15.10.2019.
//  Copyright © 2019 Alexader Malygin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    var note: Notes?

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        titleTextField.text = note?.title
        textView.text = note?.note
    
        
        
    }
    
    
    @IBAction func saveActionButton(_ sender: Any) {
        note?.title = titleTextField.text
        note?.note = textView.text
    }
    
    


}

