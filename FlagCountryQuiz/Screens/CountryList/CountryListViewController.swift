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
    var searchList = [Country]()
    var searching = false
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        //        for i in list {
        //            print("Capital: \(i.capital) Land: \(i.name) Area: \(i.area) Language: \(i.language)")
        //        }
        
    }
    
    @IBAction func mainButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func config() {
        searchBar.delegate = self
        countryCV.backgroundColor = .myWhite2
        list = getFlags.readJSONFromFile()
        self.countryCV.dataSource = self
        self.countryCV.delegate = self
        self.countryCV.register(UINib.init(nibName: CountryListCell.identifier, bundle: nil), forCellWithReuseIdentifier: CountryListCell.identifier)
        mainButton.layer.cornerRadius = mainButton.bounds.height / 2
        mainButton.backgroundColor = .myBlue
    }
    
    
    
}

extension CountryListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return searchList.count
        }else {
            return list.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = countryCV.dequeueReusableCell(withReuseIdentifier: CountryListCell.identifier, for: indexPath) as! CountryListCell
        var country = list[indexPath.row]
        if searching {
            country = searchList[indexPath.row]
        } else {
            country = list[indexPath.row]
        }
        cell.config(countryname: country.name, capital: country.capital, region: country.region, subRegion: country.subregion, population: country.population, area: country.area, language: country.language, flagUrl: country.flagUrl, latitude: country.latitude, longitude: country.longitude, currrency: country.currency, currrencySymbol: country.currencySymbol)
        
        return cell
    }
    
    
}

extension CountryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = list.filter({ country -> Bool in
            if searchText.isEmpty { return true }
            searching = true
            return country.name.lowercased().contains(searchText.lowercased())
        })
        countryCV.reloadData()
        print(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
    }
    
}

