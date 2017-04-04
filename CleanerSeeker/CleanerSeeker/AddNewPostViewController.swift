//
//  AddNewPostViewController.swift
//  CleanerSeeker
//
//  Created by Arpita Patel on 2017-03-27.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class AddNewPostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var typeOfSpace: UIPickerView!
    @IBOutlet weak var noOfBedroomPicker: UIPickerView!
    @IBOutlet weak var noOfWashroomsPicker: UIPickerView!

    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var addressTxtView: UITextField!
    @IBOutlet weak var zipcodeTxtView: UITextField!
    @IBOutlet weak var hoursToClean: UITextField!

    var noOfTypes: [String] = [String]()
    var noOfBedrooms: [String] = [String]()
    var noOfWashrooms: [String] = [String]()

    var bedroomPrice = 10
    var washroomPrice = 10

    override func viewDidLoad() {
        super.viewDidLoad()

        self.typeOfSpace.delegate = self
        self.typeOfSpace.dataSource = self

        self.noOfBedroomPicker.delegate = self
        self.noOfBedroomPicker.dataSource = self

        self.noOfWashroomsPicker.delegate = self
        self.noOfWashroomsPicker.dataSource = self

        noOfTypes = ["House", "condo"]

        noOfBedrooms = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
                        "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]

        noOfWashrooms = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
                         "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if pickerView == typeOfSpace {
            return noOfTypes.count
        } else if pickerView == noOfBedroomPicker {
            return noOfBedrooms.count
        } else if pickerView == noOfWashroomsPicker {
            return noOfWashrooms.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == typeOfSpace {
            return noOfTypes[row]
        } else if pickerView == noOfBedroomPicker {
            return noOfBedrooms[row]
        } else if pickerView == noOfWashroomsPicker {
            return noOfWashrooms[row]
        }
        return nil
    }

    @IBAction func createNewPost(_ sender: UIButton) {
        //let type = noOfTypes[typeOfSpace.selectedRow(inComponent: 0)]

        print("Type of Spcae \(self.typeOfSpace)")

    }

}
