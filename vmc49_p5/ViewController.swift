//
//  ViewController.swift
//  vmc49_p5
//
//  Created by Victor Chen on 3/30/19.
//  Copyright © 2019 Victor Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var filterBarCollectionView: UICollectionView!
    var restaurantDisplayCollectionView: UICollectionView!
    var filterArray: [Filter]!
    var selectedfilterArray: [Filter]!
    var restaurantArray: [Restaurant]!
    var hiddenRestaurantArray: [Restaurant]!
    var numfilters: CGFloat = 0
    
    let filterCellReuseIdentifier = "filterCellReuseIdentifier"
    let restaurantCellReuseIdentier = "restaurantCellReuseIdentier"
    let padding: CGFloat = 8
    let filterBarHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "My Restaurants"
        
        let filter1 = Filter(name: "$")
        let filter2 = Filter(name: "$$")
        let filter3 = Filter(name: "$$$")
        let filter4 = Filter(name: "American")
        let filter5 = Filter(name: "Asian")
        let filter6 = Filter(name: "Breakfast")
        let filter7 = Filter(name: "Dinner")
        let filter8 = Filter(name: "Fast Food")
        let filter9 = Filter(name: "Italian")
        let filter10 = Filter(name: "Lunch")
        
        filterArray = [filter1, filter2, filter3, filter4, filter5, filter6, filter7, filter8, filter9, filter10]
        
        let filterBarLayout = UICollectionViewFlowLayout()
        filterBarLayout.scrollDirection = .horizontal
        filterBarLayout.minimumInteritemSpacing = padding
        filterBarLayout.minimumLineSpacing = padding
        
        filterBarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterBarLayout)
        filterBarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterBarCollectionView.dataSource = self
        filterBarCollectionView.delegate = self
        filterBarCollectionView.backgroundColor = .gray
        filterBarCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterCellReuseIdentifier)
        view.addSubview(filterBarCollectionView)
        
        let restaurant1 = Restaurant(name: "Nikki Green", type: "American", time: "Lunch", cost: "$$")
        let restaurant2 = Restaurant(name: "Luna Inspired Street Food", type: "Asian", time: "Lunch", cost: "$$")
        let restaurant3 = Restaurant(name: "Burger King", type: "Fast Food", time: "Lunch", cost: "$")
        let restaurant4 = Restaurant(name: "Collegetown Bagels", type: "American", time: "Breakfast", cost:
    "$")
        let restaurant5 = Restaurant(name: "Louie's Lunch", type: "Fast Food", time: "Lunch", cost: "$")
        let restaurant6 = Restaurant(name: "Taverna Banfi", type: "Italian", time: "Dinner", cost: "$$$")
        let restaurant7 = Restaurant(name: "Sangam Indian Cuisine", type: "Asian", time: "Dinner", cost: "$$")
        let restaurant8 = Restaurant(name: "Gangnam Station", type: "Asian", time: "Dinner", cost: "$$")
        let restaurant9 = Restaurant(name: "Gola Osteria", type: "Italian", time: "Dinner", cost: "$$$")
        let restaurant10 = Restaurant(name: "Wings Over Ithaca", type: "Fast Food", time: "Lunch", cost: "$$")
        
        restaurantArray = [restaurant1, restaurant2, restaurant3, restaurant4, restaurant5, restaurant6, restaurant7, restaurant8, restaurant9, restaurant10]
        hiddenRestaurantArray = [restaurant1, restaurant2, restaurant3, restaurant4, restaurant5, restaurant6, restaurant7, restaurant8, restaurant9, restaurant10]
        selectedfilterArray = []
        
        
        let restaurantDisplayLayout = UICollectionViewFlowLayout()
        restaurantDisplayLayout.scrollDirection = .vertical
        restaurantDisplayLayout.minimumLineSpacing = padding
        restaurantDisplayLayout.minimumInteritemSpacing = padding
        
        restaurantDisplayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: restaurantDisplayLayout)
        restaurantDisplayCollectionView.translatesAutoresizingMaskIntoConstraints = false
        restaurantDisplayCollectionView.dataSource = self
        restaurantDisplayCollectionView.delegate = self
        restaurantDisplayCollectionView.backgroundColor = .gray
        restaurantDisplayCollectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: restaurantCellReuseIdentier)
        view.addSubview(restaurantDisplayCollectionView)
        
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            filterBarCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterBarCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterBarCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterBarCollectionView.heightAnchor.constraint(equalToConstant: filterBarHeight)
            ])
        
        NSLayoutConstraint.activate([
            restaurantDisplayCollectionView.topAnchor.constraint(equalTo: filterBarCollectionView.bottomAnchor),
            restaurantDisplayCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            restaurantDisplayCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            restaurantDisplayCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }

}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filterBarCollectionView{
            return filterArray.count
        }
        else{
            return restaurantArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filterBarCollectionView{
            let cell = filterBarCollectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuseIdentifier, for: indexPath) as! FilterCollectionViewCell
            let filter = filterArray[indexPath.item]
            cell.configure(for: filter)
            return cell
        }
        else {
            let cell = restaurantDisplayCollectionView.dequeueReusableCell(withReuseIdentifier: restaurantCellReuseIdentier, for: indexPath) as! RestaurantCollectionViewCell
            let restaurant = restaurantArray[indexPath.item]
            cell.configure(for: restaurant)
            return cell
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterBarCollectionView{
            let cell = filterBarCollectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
            let filter = filterArray[indexPath.item]
            cell.changeState(for: filter)
            if !filter.isSelected {
                let pos = selectedfilterArray.firstIndex(of: filter)!
                selectedfilterArray.remove(at: pos)
            }
            else {
                selectedfilterArray.append(filter)
            }
            updateRestaurantArrays()
            collectionView.reloadData()
            restaurantDisplayCollectionView.reloadData()
        }
    }
    func updateRestaurantArrays() {
        restaurantArray.removeAll()
        if selectedfilterArray.count == 0 {
            for restaurant in hiddenRestaurantArray{
                restaurantArray.append(restaurant)
            }
        }
        else {
            for filter in selectedfilterArray {
                for restaurant in hiddenRestaurantArray{
                    if filter.name == restaurant.name || filter.name == restaurant.cost || filter.name == restaurant.time || filter.name == restaurant.type {
                        restaurantArray.append(restaurant)
                    }
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filterBarCollectionView{
            let width = collectionView.frame.width/5
            let height = collectionView.frame.height-3*padding
            return CGSize(width: width, height: height)
        }
        else {
            let width = (collectionView.frame.width-2*padding)/2
            let height = collectionView.frame.height/4
            return CGSize(width: width, height: height)
        }
    }
}
