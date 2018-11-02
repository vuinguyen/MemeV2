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

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    print("Print Memes in Table View")
    for meme in memes {
      print("Top Text: \(String(describing: meme.topText)) , and Bottom Text: \(String(describing: meme.bottomText))")
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(refreshTable),
                                           name: NSNotification.Name(rawValue: "refreshMemeData"), object: nil)
  }

  // this is really bad!
  /*
  override func viewWillDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "refreshMemeData"), object: nil)
  }
 */

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
}

