//
//  GetFavorite.swift
//  FreeDiscover
//
//  Created by apprenant58 on 24/10/2023.
//

import Foundation

//@dev : function to filter all the temporary Activities of the data base
func getFavorite() -> [FreeDiscover] {
    return FreeDiscover.allFreeDiscover.filter {
        $0.favorite == true
    }
}
