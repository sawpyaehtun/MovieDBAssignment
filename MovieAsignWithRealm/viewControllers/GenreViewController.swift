//
//  GenreViewController.swift
//  Movie
//
//  Created by saw pyaehtun on 26/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

class GenreViewController: BaseViewController {
    @IBOutlet weak var tableViewGenreList: UITableView!
    
    let viewModel = GenreViewModel()
    var generList : [GenreVO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

       fetchGenres()
    }
    
    override func setUpUIs() {
        super.setUpUIs()
        setUpTableView()
    }
    
    private func setUpTableView(){
        tableViewGenreList.delegate = self
        tableViewGenreList.dataSource = self
        tableViewGenreList.registerForCell(strID: String(describing: GenreItemTableViewCell.self))
        tableViewGenreList.separatorColor = UIColor.white
    }
    
    private func fetchGenres(){
        viewModel.fetchGenre()
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.genreList.subscribe(onNext: { (genreVOs) in
            self.generList = genreVOs
            self.tableViewGenreList.reloadData()
            }).disposed(by: disposableBag)
        
    }

    override func bindModel() {
        super.bindModel()
        viewModel.bindViewModel(in: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GenreViewController : UITableViewDelegate {
    
}

extension GenreViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GenreItemTableViewCell.self), for: indexPath) as! GenreItemTableViewCell
        
        cell.genreVO = generList[indexPath.row]
        return cell
    }
    
}
