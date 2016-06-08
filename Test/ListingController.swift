//
//  ListingController.swift
//  Test
//
//  Created by Ryan Maxwell on 2016-06-08.
//  Copyright © 2016 Bceen Ventures. All rights reserved.
//

import UIKit


class ListingController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    var items: [String] = ["We", "Heart", "Swift"]
    var images: [String] = [ "oranges.jpg", "oranges-1.jpg", "oranges-2.jpg"]
    var detail: [String] = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum varius commodo mauris a feugiat. Quisque ornare elit nec sodales rutrum. Aliquam ut felis blandit, pharetra leo vestibulum, commodo felis. Duis congue vitae urna eget consequat. Vivamus a lorem tristique tellus dictum cursus at gravida dolor.","Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum varius commodo mauris a feugiat. Quisque ornare elit nec sodales rutrum. Aliquam ut felis blandit, pharetra leo vestibulum, commodo felis. Duis congue vitae urna eget consequat. Vivamus a lorem tristique tellus dictum cursus at gravida dolor.","Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum varius commodo mauris a feugiat. Quisque ornare elit nec sodales rutrum. Aliquam ut felis blandit, pharetra leo vestibulum, commodo felis. Duis congue vitae urna eget consequat. Vivamus a lorem tristique tellus dictum cursus at gravida dolor."]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        cell!.textLabel?.text = self.items[indexPath.row]
        let imagename = self.images[indexPath.row]
        cell!.imageView!.image = UIImage(named: imagename)
        cell!.detailTextLabel!.text = self.detail[indexPath.row]
        return cell!

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
       
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self


    }
    
    
    
    
}