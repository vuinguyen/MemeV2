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

  override func viewDidLoad() {
    super.viewDidLoad()
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    print("Printing Memes in Collection View")
    for meme in memes {
      print("Top Text: \(String(describing: meme.topText)) , and Bottom Text: \(String(describing: meme.bottomText))")
    }
    // Register cell classes
   // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    // Do any additional setup after loading the view.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(refreshCollection),
                                           name: NSNotification.Name(rawValue: "refreshMemeData"), object: nil)
  }

  // this is really bad!
  /*
   override func viewWillDisappear(_ animated: Bool) {
   super.viewDidDisappear(animated)
   NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "refreshMemeData"), object: nil)
   }
   */

  @objc func refreshCollection() {
    self.collectionView.reloadData()
  }

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using [segue destinationViewController].
   // Pass the selected object to the new view controller.
   }
   */

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

  // MARK: UICollectionViewDelegate

  /*
   // Uncomment this method to specify if the specified item should be highlighted during tracking
   override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */

  /*
   // Uncomment this method to specify if the specified item should be selected
   override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */

  /*
   // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
   override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
   return false
   }

   override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
   return false
   }

   override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {

   }
   */

}
