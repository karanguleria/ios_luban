//
//  DateTestVC.swift
//  Luban
//
//  Created by King on 8/19/20.
//

import UIKit

class DateTestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
         let startDate = "2018-03-01"
         let endDate   = "2018-03-05"
         let mydates = Date.dates(from: startDate, to: endDate)
         
         let startDatetwo = "2018-03-03"
         let endDatetwo   = "2018-03-07"
         let mydatestwo = Date.dates(from: startDatetwo, to: endDatetwo)
         
         var someHash: [String: Bool] = [:]

         mydates.forEach { someHash[$0] = true }

         var commonItems = [String]()

         mydatestwo.forEach { veg in
          if someHash[veg] ?? false {
              commonItems.append(veg)
          }
         }

       
    }
  

}
extension Date {
    static func dates(from fromDate: String, to toDate: String) -> [String] {
        var mydates : [String] = []
        var dateFrom =  Date() // First date
        var dateTo = Date()   // Last date
        // Formatter for printing the date, adjust it according to your needs:
        let fmt = DateFormatter()
        fmt.dateFormat = "yyy-MM-dd"
        dateFrom = fmt.date(from: fromDate)!
        dateTo = fmt.date(from: toDate)!
        while dateFrom <= dateTo {
            mydates.append(fmt.string(from: dateFrom))
            dateFrom = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!

        }
        return mydates
    }
}
