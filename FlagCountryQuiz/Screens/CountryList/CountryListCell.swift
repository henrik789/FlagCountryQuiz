//
//  CountryListCell.swift
//  FlagCountryQuiz
//
//  Created by Henrik on 2020-02-11.
//  Copyright © 2020 Henrik. All rights reserved.
//

import UIKit
import WebKit

class CountryListCell: UICollectionViewCell{

    
    @IBOutlet weak var countrynameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    

    static var identifier: String {
        return "CountryListCell"
    }

    
    func config(countryname: String, capital: String, region: String, subRegion: String, population: String, area: String, language: String, flagUrl: String, latitude: String, longitude: String, currrency: String, currrencySymbol: String){

        mainView.backgroundColor = .myBeige
        mainView.layer.cornerRadius = mainView.bounds.height * 0.05
        
        countrynameLabel.text = "Country: \(countryname)"
        capitalLabel.text = "Capital: \(capital)"
        regionLabel.text = "Region: \(region)"
        languageLabel.text = "Language: \(language)"
        currencyLabel.text = "Currency: \(currrency) (\(currrencySymbol))"
        populationLabel.text = "Population: \(population)"

        var flag = flagUrl
        flag = flag.replacingOccurrences(of: ".", with: "")
        imageView.image = UIImage(named: "\(flag).png") ?? UIImage(named: "globe_white.png")
        
    }
    
}



