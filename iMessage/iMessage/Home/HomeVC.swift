//
//  HomeVC.swift
//  iMessage
//
//  Created by Fabio Martinez on 08/03/22.
//

import UIKit

class HomeVC: UIViewController {

    var screen: HomeScreen?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CustomColor.appLight
    }
    
    override func loadView() {
        self.screen = HomeScreen()
        self.view = self.screen
    }

}
