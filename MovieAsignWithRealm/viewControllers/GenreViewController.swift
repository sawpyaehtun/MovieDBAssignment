//
//  GenreViewController.swift
//  Movie
//
//  Created by saw pyaehtun on 26/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GenreViewController: BaseViewController {
    @IBOutlet weak var tableViewGenreList: UITableView!
    
    private let viewModel = GenreViewModel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpUIs() {
        super.setUpUIs()
        setUpTableView()
        setUpRefreshControl()
    }
    
    private func setUpTableView(){
        tableViewGenreList.registerForCell(strID: String(describing: GenreItemTableViewCell.self))
        tableViewGenreList.separatorColor = UIColor.white
        tableViewGenreList.refreshControl = refreshControl
    }
    
    override func bindData() {
        super.bindData()
        refreshControl.rx.controlEvent(.valueChanged).bind(to: viewModel.tapRefetchData).disposed(by: disposableBag)
        
        viewModel.genreList.observeOn(MainScheduler.instance)
            .do(onNext: {[weak self] _ in self?.refreshControl.endRefreshing()})
            .bind(to: tableViewGenreList.rx.items(cellIdentifier: String(describing: GenreItemTableViewCell.self), cellType: GenreItemTableViewCell.self)){ row, model, cell in
                cell.genreVO = model
        }
        .disposed(by: disposableBag)
        
    }
    
    override func bindModel() {
        super.bindModel()
        viewModel.bindViewModel(in: self)
    }
}
