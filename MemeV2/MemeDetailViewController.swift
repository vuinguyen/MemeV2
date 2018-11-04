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

  @IBOutlet weak var memeImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    if let meme = meme {
      memeImageView.image = meme.memedImage
    }
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
