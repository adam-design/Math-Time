//
//  Math.swift
//  Math Time
//
//  Created by vgm on 1/14/17.
//  Copyright © 2017 vgmoose. All rights reserved.
//

import WatchKit
import Foundation

class MathInterfaceController : WKInterfaceController {

    @IBAction func answerPressed() {
        presentTextInputController(withSuggestions: [], allowedInputMode: .plain) {
            (result) -> Void in
            if (result != nil) && result!.count > 0
            {
                let response = result![0] as? String
                print(response)
            }
        }

    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
