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

struct FilterAlertController {
    public static func showFilters(on vc: UIViewController, inArray: [FilterTvShowAndMovies]) -> [FilterTvShowAndMovies] {
        var filteredContent = [FilterTvShowAndMovies]()
        let alertController = UIAlertController(title: "Filter", message: "Choose filter:", preferredStyle: .actionSheet)
        
        let actionDate = UIAlertAction(title: "Date",
                                              style: .default) { (action) in
                print("You selected the Destructive action")
            filteredContent = inArray.sorted { $0.releaseDate > $1.releaseDate }
        }

        let actionName = UIAlertAction(title: "Name",
                                          style: .default) { (action) in
                print("You selected the Default action")
            filteredContent = inArray.sorted { $0.title < $1.title }
        }
        let actionRating = UIAlertAction(title: "Rating",
                                          style: .default) { (action) -> Void in
                print("You selected the Default action")
            filteredContent = inArray.sorted { $0.voteAverage > $1.voteAverage }
        }
        let actionPopular = UIAlertAction(title: "Popular",
                                          style: .default) { (action) -> Void in
                print("You selected the Default action")
            filteredContent = inArray.sorted { $0.popularity > $1.popularity }
        }

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (action) -> Void in
                print("You selected the Cancel action")
        }
        
        alertController.addAction(actionDate)
        alertController.addAction(actionName)
        alertController.addAction(actionRating)
        alertController.addAction(actionPopular)
        alertController.addAction(cancelAction)
        vc.present(alertController, animated: true)
        return filteredContent
    }
}
