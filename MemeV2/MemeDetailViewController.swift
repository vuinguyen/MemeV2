//
//  MemeDetailViewController.swift
//  MemeV2
//
//  Created by Vui Nguyen on 10/27/18.
//  Copyright © 2018 Sunfish Empire. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

  var meme: Meme?

  // MARK: Outlets
  @IBOutlet weak var memeImageView: UIImageView!

  // MARK: UIViewController
  override func viewDidLoad() {
    super.viewDidLoad()

    if let meme = meme {
      memeImageView.image = meme.memedImage
    }
  }
}
