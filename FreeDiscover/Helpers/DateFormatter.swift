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
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
