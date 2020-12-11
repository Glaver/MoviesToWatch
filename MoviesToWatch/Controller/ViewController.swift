//
//  ViewController.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 9/12/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var moviesTableView: UITableView!
    private let moviesListDataSource = MoviesListDataModel()
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
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesListDataSource.requestData()
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
        cell.sectionDate.text = DateFormattingHelper.shared.printFormattedDate(moviesListData[indexPath.row].releaseDate, printFormat: "yyyy-MM-dd")
        cell.sectionRating.text = String(moviesListData[indexPath.row].voteAverage)
        cell.sectionGenres.text = "Genres"
        cell.sectionImageView.image = UIImage(named: "blur")
        return cell
    }
    //MARK: - UIViewDataDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        tableView.frame.width / 6
//        tableView.frame.height / 6
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select movie at: \(indexPath)")
    }
}

extension ViewController: MoviesListDataModelDelegate {
    func didFail(with error: APIServiceError) {
        print("\(error)")
    }
    func didRecive(data: [MovieModel]) {
        moviesListData = data
    }
}
