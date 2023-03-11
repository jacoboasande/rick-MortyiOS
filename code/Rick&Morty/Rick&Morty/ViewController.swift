//
//  ViewController.swift
//  Rick&Morty
//
//  Created by Jacobo Adrián Sande Veiga on 11/3/23.
//

import Alamofire
import UIKit
import SwiftyJSON


class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    private lazy var results: [Result] = []


    private var charactersPath = "https://rickandmortyapi.com/api/character"


    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func loadData() {
        // read json from api
        self.fetchAllDatas { [weak self] (response) in
            self?.results = response ?? []
            self?.tableView.reloadData()

        }
    }

    func fetchAllDatas(response: @escaping ([Result]?) -> Void) {
        AF.request(charactersPath).responseDecodable(of: PostModel.self) { (model) in
            guard let data = model.value else {
                response(nil)
                return
            }
            response(data.results)
        }

    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("touched!")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row].name
        return cell
    }
}

