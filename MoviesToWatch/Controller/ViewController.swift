//
//  ViewController.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 9/12/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var movieTableView = UITableView()
    private let moviesListDataSource = MoviesListDataModel()
    private var moviesListData = [MovieModel]() {
        didSet {
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesListDataSource.delegate = self
        createMovieTableView()
    }
    //MARK: - UITableViewMovies
    func createMovieTableView() {
        self.movieTableView = UITableView(frame: view.bounds, style: .plain)
        movieTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        movieTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(movieTableView)
    }
    //MARK: - UIViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return moviesListData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = moviesListData[indexPath.row].title
        return cell!
    }
    //MARK: - UIViewDataDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesListDataSource.requestData()
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

//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return moviesList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
//        cell?.textLabel?.text = moviesList[indexPath.row].title
//        return cell!
//    }
//}
