//
//  ViewController.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 9/12/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var searchBarMovies: UISearchBar!
    @IBOutlet weak var moviesTablePicker: UISegmentedControl!

    @IBAction func segmentPickerMovies(_ sender: UISegmentedControl) {
        moviesListDataSource.requestData(from: moviesTablePicker.selectedSegmentIndex)
        moviesTableView.reloadData()
    }
    @IBAction func filterButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Filter", message: "Choose filter:", preferredStyle: .actionSheet)
        
        let actionDate = UIAlertAction(title: "Date", style: .default) { (action) in
            FilterContent.listOfContent(&self.moviesListData, by: FilterContent.FilteredParameters.releaseDate)
        }
        let actionName = UIAlertAction(title: "Name", style: .default) { (action) in
            FilterContent.listOfContent(&self.moviesListData, by: FilterContent.FilteredParameters.title)
        }
        let actionRating = UIAlertAction(title: "Rating", style: .default) { (action) in
            FilterContent.listOfContent(&self.moviesListData, by: FilterContent.FilteredParameters.rating)
        }
        let actionPopular = UIAlertAction(title: "Popular",style: .default) { (action) in
            FilterContent.listOfContent(&self.moviesListData, by: FilterContent.FilteredParameters.popularity)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                print("You selected the Cancel action")
        }
        
        alertController.addAction(actionDate)
        alertController.addAction(actionName)
        alertController.addAction(actionRating)
        alertController.addAction(actionPopular)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    private let moviesListDataSource = MovieViewModel(networkService: NetworkService.shared)
    private let genresDataSource = GenresViewModel()
//    private var movieGenresData = [GenresDTO]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.moviesTableView.reloadData()
//                for genre in self.movieGenresData {
//                    print(String(genre.id) + " for " + genre.name)
//                }
//            }
//        }
//    }
    private var moviesListData = [MovieModel]() {
        didSet {
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesListDataSource.delegate = self
        searchBarMovies.delegate = self
//        genresDataSource.delegate = self
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesListDataSource.requestData(from: moviesTablePicker.selectedSegmentIndex)
//        genresDataSource.requestData()
    }

    //MARK: - UITableViewMovies
    private func setupTableView() {
        let nib = UINib(nibName: "ContentTableViewCell", bundle: nil)
        moviesTableView.register(nib, forCellReuseIdentifier: "sectionCellIdetifire")
    }
    //MARK: - UIViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesListData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCellIdetifire", for: indexPath) as! ContentTableViewCell
        cell.sectionTitile.text = moviesListData[indexPath.row].title
        cell.sectionDate.text = DateFormattingHelper.shared.printFormattedDate(moviesListData[indexPath.row].releaseDate, printFormat: "MMM dd,yyyy")
        cell.sectionRating.text = moviesListData[indexPath.row].voteAverage != 0.0 ? String(moviesListData[indexPath.row].voteAverage) : ""
        cell.sectionGenres.text = "Genres"//moviesListData[indexPath.row].genreIds
        cell.sectionImageView.loadThumbnail(urlSting: moviesListData[indexPath.row].posterPath ?? "")
        return cell
    }
//MARK: - UIViewDataDelegate
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select movie at: \(indexPath)")
    }
}

extension ViewController: MoviesListDataModelDelegate {
    func didFail(with error: APIServiceError) {
        print("Movies list: \(error)")
    }
    func didRecive(data: [MovieModel]) {
        moviesListData = data
    }
}

//extension ViewController: GenresDataModelDelegate {
//    func didFail(error: APIServiceError) {
//        print("Genres array: \(error)")
//    }
//    func didRecive(data: [GenresDTO]) {
//        movieGenresData = data
//    }
//}
//MARK: - Search
extension ViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    moviesListDataSource.requestDataSearch(from: searchBar.text!)
    searchBarMovies.resignFirstResponder()
    moviesTableView.reloadData()
    print("The search text is: '\(searchBar.text!)'")
  }
}
