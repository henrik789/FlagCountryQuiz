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
    var flagImage = ""
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var flagView: UIView!
    @IBOutlet weak var bigFlag: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        
        self.title = "List"
    }
    
    @IBAction func mainButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func config() {
        let aSelector : Selector = #selector(CountryListViewController.removeViewFromSuperView)
        let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
        flagView.addGestureRecognizer(tapGesture)
        flagView.translatesAutoresizingMaskIntoConstraints = true
        searchBar.delegate = self
        countryCV.backgroundColor = .myWhite2
        list = getFlags.readJSONFromFile()
        self.countryCV.dataSource = self
        self.countryCV.delegate = self
        self.countryCV.register(UINib.init(nibName: CountryListCell.identifier, bundle: nil), forCellWithReuseIdentifier: CountryListCell.identifier)
        mainButton.layer.cornerRadius = mainButton.bounds.height / 2
        mainButton.backgroundColor = .myBlue
        self.countryCV.keyboardDismissMode = .onDrag
    }
    
    func showFlagView(flag: String){
        view.addSubview(flagView)
        let flagFormat = flag.replacingOccurrences(of: ".", with: "")
        bigFlag.image = UIImage(named: "\(flagFormat).png")
        flagView.isUserInteractionEnabled = true
        animate()
    }
    
    @objc func removeViewFromSuperView() {
        if let subView = self.flagView{
            subView.removeFromSuperview()
            print("tar bort")
        } else {
            print("ikke!!")
            return
        }
    }
    
    func animate() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: .curveEaseIn, animations: {
            self.flagView.alpha = 1
            self.flagView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            self.flagView.layer.cornerRadius = 20
            self.flagView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
        }) { _ in
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        showFlagView(flag: list[indexPath.row].flagUrl)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = countryCV.dequeueReusableCell(withReuseIdentifier: CountryListCell.identifier, for: indexPath) as! CountryListCell
        var country = list[indexPath.row]
        if searching {
            country = searchList[indexPath.row]
        } else {
            country = list[indexPath.row]
        }
        flagImage = list[indexPath.row].flagUrl
        cell.config(countryname: country.name, capital: country.capital, region: country.region, subRegion: country.subregion, population: country.population, area: country.area, language: country.language, flagUrl: country.flagUrl, latitude: country.latitude, longitude: country.longitude, currrency: country.currency, currrencySymbol: country.currencySymbol)
        
        return cell
    }
}

extension CountryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = list.filter({ country -> Bool in
            if searchText.isEmpty { return true }
            searching = true
            return country.name.lowercased().hasPrefix(searchText.lowercased())
        })
        countryCV.reloadData()
        print(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        countryCV.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searching = false
        self.searchBar.endEditing(true)
    }
    
}

