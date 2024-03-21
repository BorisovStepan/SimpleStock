//
//  NewsController.swift
//  SimpleProject
//
//  Created by Stepan Borisov on 10.03.24.
//

import UIKit

class NewsController: UIViewController {

    @IBOutlet weak var tableNews: UITableView!
    @IBOutlet weak var xsxs: UILabel!
    private var newsModel: [NewsModel]!
    private let network = NetworkServiceNews()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        newsModel = [NewsModel]()
        load()
        tableNews.dataSource = self
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func load() {
        network.loadData() { [weak self] newPosts in
         self?.newsModel = newPosts
        }
    }

}

extension NewsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = newsModel[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsCell
        cell.configure(with: viewModel)
        return cell
    }
    
    
}
extension NewsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = newsModel[indexPath.row]
     //   newsModel.loadSelectedPost(post: post)
    }
}
