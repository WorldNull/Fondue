//
//  MenuViewController.swift
//  InstagramProject
//
//  Created by YouGotToFindWhatYouLove on 3/1/16.
//  Copyright © 2016 Candy. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuTableView: UITableView!
    var menuItemArray: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        menuTableView.delegate = self
        menuTableView.dataSource = self
        

        menuItemArray = ["Home", "Capture", "Profile"]
        menuTableView.frame.size.height = self.view.frame.height


        menuTableView.tableFooterView = UIView()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCellWithIdentifier(menuItemArray[indexPath.row], forIndexPath: indexPath) as! MenuCell
        cell.menuIconImageView.image = UIImage(named: "\(menuItemArray[indexPath.row])")
        cell.menuItemNameLabel.text = "\(menuItemArray[indexPath.row])"
        
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemArray.count
    }
    
}
