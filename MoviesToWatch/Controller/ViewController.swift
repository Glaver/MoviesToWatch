//
//  ViewController.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 9/12/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var moviesTablePicker: UISegmentedControl!
    @IBAction func segmentPickerMovies(_ sender: UISegmentedControl) {
        moviesListDataSource.requestData(from: moviesTablePicker.selectedSegmentIndex)
        moviesTableView.reloadData()
    }
    private let moviesListDataSource = MoviesListDataModel()
    private let genresDataSource = GenresDataModel()
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
        cell.sectionRating.text = String(moviesListData[indexPath.row].voteAverage)
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
