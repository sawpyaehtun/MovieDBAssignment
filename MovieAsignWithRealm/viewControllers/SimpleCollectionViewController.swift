//
//  SimpleCollectionViewController.swift
//  CollectionView
//
//  Created by saw pyaehtun on 25/08/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import UIKit

class SimpleCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let numberOfItemsInRow : CGFloat = 3.0
    let spacing : CGFloat = 5
    let leadingSpace : CGFloat = 5
    let TrailingSpace : CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupCollerctionView()
    }
    
    private func setupCollerctionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerForCell(strID: String(describing: MoviePosetCollectionViewCell.self))
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        // calculating total padding
        let totalPadding : CGFloat = ((numberOfItemsInRow - 1) * spacing) + leadingSpace + TrailingSpace
        let itemWidth = (self.view.frame.width - totalPadding) / numberOfItemsInRow
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.45)
    }
    
}

extension SimpleCollectionViewController : UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
}

extension SimpleCollectionViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MoviePosetCollectionViewCell.self), for: indexPath) as? MoviePosetCollectionViewCell
        return item!
    }
}

