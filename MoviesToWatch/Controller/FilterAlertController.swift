//
//  FilterAlertController.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 20/12/20.
//

import Foundation
import UIKit

protocol FilterTvShowAndMovies {
    var releaseDate: Date { get }
    var title: String { get }
    var voteAverage: Float { get }
    var popularity: Float { get }
}
/*
struct FilterAlertController {
    public static func showFilters(on vc: UIViewController, filteredContent: inout [MovieModel]) {
        let alertController = UIAlertController(title: "Filter", message: "Choose filter:", preferredStyle: .actionSheet)
        
        let actionDate = UIAlertAction(title: "Date", style: .default) { (action) in
            FilterContent.listOfContent(&filteredContent, by: FilterContent.FilteredParameters.releaseDate)
        }
        let actionName = UIAlertAction(title: "Name", style: .default) { (action) in
            FilterContent.listOfContent(&filteredContent, by: FilterContent.FilteredParameters.title)
        }
        let actionRating = UIAlertAction(title: "Rating", style: .default) { (action) in
            FilterContent.listOfContent(&filteredContent, by: FilterContent.FilteredParameters.rating)
        }
        let actionPopular = UIAlertAction(title: "Popular",style: .default) { (action) in
            FilterContent.listOfContent(&filteredContent, by: FilterContent.FilteredParameters.popularity)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                print("You selected the Cancel action")
        }
        
        alertController.addAction(actionDate)
        alertController.addAction(actionName)
        alertController.addAction(actionRating)
        alertController.addAction(actionPopular)
        alertController.addAction(cancelAction)
        vc.present(alertController, animated: true)
    }
}
*/
class FilterContent {
    enum FilteredParameters: String {
        case popularity
        case releaseDate
        case title
        case rating
    }

    static func listOfContent(_ array: inout [MovieModel], by filteringTvShowIndex: FilteredParameters) {
        switch filteringTvShowIndex {
        case .releaseDate: array = array.sorted { $0.releaseDate > $1.releaseDate }
        case .title: array = array.sorted { $0.title < $1.title }
        case .rating: array = array.sorted { $0.voteAverage > $1.voteAverage }
        case .popularity: array = array.sorted { $0.popularity > $1.popularity }
        }
    }
}

protocol FilterViewControllerDelegate {
    func tableViewFilter(with filter: FilterContent.FilteredParameters)
}
