//
//  CountryListCell.swift
//  FlagCountryQuiz
//
//  Created by Henrik on 2020-02-11.
//  Copyright © 2020 Henrik. All rights reserved.
//

import UIKit

class CountryListCell: UICollectionViewCell {

    @IBOutlet weak var countrynameLabel: UILabel!
    
    
    
    static var identifier: String {
        return "CountryListCell"
    }

    func config(countryname: String){

        
        countrynameLabel.text = "Country: " + countryname
        
    }
    
    

}
