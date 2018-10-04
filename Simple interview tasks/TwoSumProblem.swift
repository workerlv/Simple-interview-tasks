//
//  TwoSumProblem.swift
//  Simple interview tasks
//
//  Created by Arturs Vitins on 04/10/2018.
//  Copyright © 2018 Arturs Vitins. All rights reserved.
//

// Simple comparison of nested loops vs binary search vs linear search in two SUM problem

import UIKit

class TwoSumProblem: UIViewController {

    
    @IBOutlet weak var txtLblOutlet: UILabel!
    
    @IBOutlet weak var brutForceResultLblOutlet: UILabel!
    @IBOutlet weak var binarySearchResultLblOutlet: UILabel!
    @IBOutlet weak var linearSearchResultLblOutlet: UILabel!
    
    @IBOutlet weak var addNumberTxtField: UITextField!
    @IBOutlet weak var checkSumTxtField: UITextField!
    
    
    var intArray = [1, 2, 5, 9, 18]
    var currArr = "Curent array is empty"
    
    var brutalForceLoopCount = 0
    var binarySearchLoopCount = 0
    var linearSearchLoopCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtLblOutlet.text = "Current array " + "\(intArray.description)"

    }

    // Brute force - nested for loops -> easy to do, not very good solution
    
    func checkSumInNestedLoops (array: [Int], sum: Int) {
        
        for i in 0..<array.count {
            
            for j in 0..<array.count where j != i {
                brutalForceLoopCount += 1

                if array[i] + array[j] == sum {
                    brutForceResultLblOutlet.text = "Nested loop -> Two numbers = \(array[i]) and \(array[j]) (\(brutalForceLoopCount))"
                    return
                } else {
                    print("Nested loop -> Not sum = \(array[i]) and \(array[j])")
                }
            }
        }
        brutForceResultLblOutlet.text = "Nested loop -> No SUM found (\(brutalForceLoopCount))"

    }

    // Binnary search
    
    func checkSumInBinarySearch (array: [Int], sum: Int) {
    
        for i in 0..<array.count {
            
            let compliment = sum - array[i]
            
            var tempArray = array
            tempArray.remove(at: i)
            
            let hasCompliment = binarySearch(array: tempArray, key: compliment)
            print("Binary search -> Not sum = \(array[i]) and \(compliment)")
            
            if hasCompliment {
                binarySearchResultLblOutlet.text = "Binary search -> Two numbers = \(array[i]) and \(compliment) (\(binarySearchLoopCount))"
                return
            }
            
            binarySearchResultLblOutlet.text = "Binary search -> No SUM found (\(binarySearchLoopCount))"

        }
    
    }
    
    // Binary search helper method
    
    func binarySearch (array: [Int], key: Int) -> Bool {
        binarySearchLoopCount += 1

        if array.count == 0 { return false }
        
        let minIndex: Int = 0
        let maxIndex: Int = array.count - 1
        let midIndex: Int = maxIndex / 2
        
        if key > array[maxIndex] || key < array[minIndex] {
            return false
        }
        
        let midValue = array[midIndex]
        
        if key > midValue {
            let slice: [Int] = Array(array[midIndex + 1...maxIndex])
            return binarySearch(array: slice, key: key)
        }
        
        if key < midValue {
            let slice: [Int] = Array(array[minIndex...midIndex - 1])
            return binarySearch(array: slice, key: key)
        }
        
        if key == midValue {
            return true
        }
        
        return false
        
    }
    
    // Linear search
    
    func checkSumInLinearSearch (array: [Int], sum: Int) {
        
        var lowIndex = 0
        var highIndex = array.count - 1
        
        while lowIndex < highIndex {
            
            linearSearchLoopCount += 1
            
            let sumOfItems = array[lowIndex] + array[highIndex]
            
            if sumOfItems == sum {
                linearSearchResultLblOutlet.text = "Linear search -> Two numbers = \(array[lowIndex]) and \(array[highIndex]) (\(linearSearchLoopCount))"
                return
            } else if sumOfItems < sum {
                lowIndex += 1
            } else if sumOfItems > sum {
                highIndex -= 1
            }
            print("Linear search -> Not sum = \(array[lowIndex]) and \(array[highIndex])")

        }
        linearSearchResultLblOutlet.text = "Linear search -> No SUM found (\(linearSearchLoopCount))"

    }
    
    
    // MARK: - Button actions
    
    @IBAction func addNumberToArrayBtnAction(_ sender: Any) {
        
        if !(addNumberTxtField.text?.isEmpty)! {
            intArray.append(Int(addNumberTxtField.text!)!)
        }

        intArray =  intArray.sorted()
        
        txtLblOutlet.text = "Current array " + "\(intArray.description)"
        
        addNumberTxtField.text = ""
        
    }
    
    
    @IBAction func checkSumBtnAction(_ sender: Any) {
        
        brutalForceLoopCount = 0
        binarySearchLoopCount = 0
        linearSearchLoopCount = 0
        
        if !(checkSumTxtField.text?.isEmpty)! {
            
            let currSum = Int(checkSumTxtField.text!)!
            
            //Nested loops
            checkSumInNestedLoops(array: intArray, sum: currSum)
            
            // Binary search
            checkSumInBinarySearch(array: intArray, sum: currSum)
            
            // Linear search
            checkSumInLinearSearch(array: intArray, sum: currSum)
        }
        
    }
    
}




