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
    }
    
    
    
    
}

extension CountryListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = countryCV.dequeueReusableCell(withReuseIdentifier: CountryListCell.identifier, for: indexPath) as! CountryListCell
        let country = list[indexPath.row]
        cell.config(countryname: country.name)
        
        return cell
    }
    
    
}

