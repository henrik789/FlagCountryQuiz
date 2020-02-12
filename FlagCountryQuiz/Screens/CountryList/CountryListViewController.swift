//
//  CountryListViewController.swift
//  FlagCountryQuiz
//
//  Created by Henrik on 2020-02-11.
//  Copyright © 2020 Henrik. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController {
    
    @IBOutlet weak var countryCV: UICollectionView!
    var getFlags = GetFlags()
    var list = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = getFlags.readJSONFromFile()
        self.countryCV.dataSource = self
        self.countryCV.delegate = self
        self.countryCV.register(UINib.init(nibName: CountryListCell.identifier, bundle: nil), forCellWithReuseIdentifier: CountryListCell.identifier)
        
        for i in list {
            print("Capital: \(i.capital) Land: \(i.name) Area: \(i.area) Language: \(i.language)")
        }
    }
    
    
    
    
}

extension CountryListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = countryCV.dequeueReusableCell(withReuseIdentifier: CountryListCell.identifier, for: indexPath) as! CountryListCell
        let country = list[indexPath.row]
        cell.config(countryname: country.name, capital: country.capital, region: country.region, subRegion: country.subregion, population: country.population, area: country.area, language: country.language, flagUrl: country.flagUrl, latitude: country.latitude, longitude: country.longitude, currrency: country.currency, currrencySymbol: country.currencySymbol)
        
        return cell
    }
    
    
}

