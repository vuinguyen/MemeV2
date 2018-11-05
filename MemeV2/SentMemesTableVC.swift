//
//  ViewController.swift
//  MemeV2
//
//  Created by Vui Nguyen on 10/25/18.
//  Copyright © 2018 Sunfish Empire. All rights reserved.
//

import UIKit

class SentMemesTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var memes: [Meme]! {
    let object = UIApplication.shared.delegate
    let appDelegate = object as! AppDelegate
    return appDelegate.memes
  }

  private let reuseIdentifier = "MemeTableCell"

  // MARK: Properties
  @IBOutlet weak var tableView: UITableView!

  // MARK: UIViewController
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.rowHeight = 110
  }

  // Note: we cannot remove the observer (in viewWillDisappear, etc.) because then the notification won't get sent
  // during app execution (maybe has something to do with switching the views between tabs?)
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(refreshTable),
                                           name: NSNotification.Name(rawValue: "refreshMemeData"), object: nil)
  }

  // MARK: Helper function to refresh data in table
  @objc func refreshTable() {
    self.tableView.reloadData()
  }
  
  // MARK: Table View Data Source
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.memes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!
    let meme = self.memes[(indexPath as NSIndexPath).row]

    // Set the name and image
    if let topText = meme.topText, let bottomText = meme.bottomText {
      cell.textLabel?.text = topText + " " + bottomText
    }
    cell.imageView?.image = meme.memedImage

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
    detailController.meme = self.memes[(indexPath as NSIndexPath).row]
    self.navigationController!.pushViewController(detailController, animated: true)
  }
}
