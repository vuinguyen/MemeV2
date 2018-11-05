//
//  MemesCollectionViewController.swift
//  MemeV2
//
//  Created by Vui Nguyen on 10/27/18.
//  Copyright © 2018 Sunfish Empire. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeCollectionViewCell"

class SentMemesCollectionVC: UICollectionViewController {

  var memes: [Meme]! {
    let object = UIApplication.shared.delegate
    let appDelegate = object as! AppDelegate
    return appDelegate.memes
  }

  // MARK: Properties
  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

  // MARK:  UICollectionViewController
  override func viewDidLoad() {
    super.viewDidLoad()

    let space:CGFloat = 3.0
    let dimension = (view.frame.size.width - (2 * space)) / 3.0

    flowLayout.minimumInteritemSpacing = space
    flowLayout.minimumLineSpacing = space
    flowLayout.itemSize = CGSize(width: dimension, height: dimension)
  }

  // Note: we cannot remove the observer (in viewWillDisappear, etc.) because then the notification won't get sent
  // during app execution (maybe has something to do with switching the views between tabs?)
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(refreshCollection),
                                           name: NSNotification.Name(rawValue: "refreshMemeData"), object: nil)
  }

  // MARK: Helper function to refresh data in collection
  @objc func refreshCollection() {
    self.collectionView.reloadData()
  }

  // MARK: UICollectionViewDataSource
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return memes.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
    let meme = self.memes[(indexPath as NSIndexPath).row]

    cell.memeImageView?.image = meme.memedImage
    // Configure the cell
    
    return cell
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {

    let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
    detailController.meme = self.memes[(indexPath as NSIndexPath).row]
    self.navigationController!.pushViewController(detailController, animated: true)
  }
}
