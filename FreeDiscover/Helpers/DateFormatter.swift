//
//  DateFormatter.swift
//  FreeDiscover
//
//  Created by apprenant92 on 03/11/2023.
//

import Foundation
import SwiftUI

let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter
    }()

func formatDateInFrench(_ date: Date) -> String {
       let frenchDateFormatter = DateFormatter()
       frenchDateFormatter.dateFormat = "dd MMMM yyyy"
       frenchDateFormatter.locale = Locale(identifier: "fr_FR")
       return frenchDateFormatter.string(from: date)
   }

func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        // Définissez le format de date que vous souhaitez
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
func shortDateFormatter(_ date: Date) -> String {
       let shortDateFormatter = DateFormatter()
    shortDateFormatter.dateFormat = "dd/MM/yyyy"
    shortDateFormatter.locale = Locale(identifier: "fr_FR")
       return shortDateFormatter.string(from: date)
   }
