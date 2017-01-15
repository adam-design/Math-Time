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
    
    @IBOutlet var questionLabel: WKInterfaceLabel!
    
    // the currrent question (expression) stored as a string
    var curQuestion: String
    
    // the total possible value of an operand
    let difficulty: Int = 10
    
    override init()
    {
        // initialization stuff
        curQuestion = "N/A"
        super.init()
        
        // generate the first question
        curQuestion = generateExpression()
    }
    
    func eval(_ input: String) -> Int
    {
        // setup the expression
        let expression = NSExpression(format: input)
        
        // evaluate it and return
        return expression.expressionValue(with: nil, context: nil) as! Int
    }
    
    func randOperand() -> String
    {
        // get a random number between 0 (inclusive) and difficulty (exclusive)
        return String(Int(arc4random_uniform(UInt32(difficulty))))
    }
    
    func makeExpression(_ left: String, _ operation: String, _ right: String) -> String
    {
        // compose the input Strings into one expression String
        return String("\(left) \(operation) \(right)")
    }
    
    func generateExpression() -> String
    {
        // generate two operands
        var leftOperand  = randOperand()
        var rightOperand = randOperand()
        
        // choose the operation
        var operation = ["+", "-", "*", "/"].randomElement
        
        // if it's subtraction, use the sum as the left operand
        if operation == "-"
        {
            // evaluate the expression
            leftOperand = String(eval(makeExpression(leftOperand, "+", rightOperand)))
        }
        
        // if it's division, use the product as the left operand
        if operation == "/"
        {
            // evaluate the expression
            leftOperand = String(eval(makeExpression(leftOperand, "*", rightOperand)))
        }
        
        // return the expression
        return makeExpression(leftOperand, operation, rightOperand)
    }

    @IBAction func answerPressed() {
        // answer button was pressed, prompt for input
        presentTextInputController(withSuggestions: [curQuestion], allowedInputMode: .plain) {
            (result) -> Void in
            
            // check if they didn't press cancel
            if (result != nil) && result!.count > 0
            {
                // get the response
                let response = result![0] as? String
                
                // compare it to the evaluation of the expression
                if response == String(self.eval(self.curQuestion))
                {
                    // correct!
                    print("Correct")
                }
                else
                {
                    // wrong
                    print("incorrect")
                }
                
                // generate a new expression
                self.curQuestion = self.generateExpression()
                
                // update the label
                self.updateQuestionLabel()
            }
        }

    }
    
    func updateQuestionLabel()
    {
        // update the label to the question
        questionLabel.setText(curQuestion)
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // update the question label for the first question
        updateQuestionLabel()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

private extension Array {
    var randomElement: Element {
        // return a random element form the array
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
}
