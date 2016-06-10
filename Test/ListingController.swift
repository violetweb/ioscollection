//
//  ListingController.swift
//  Test
//
//  Created by Ryan Maxwell on 2016-06-08.
//  Copyright © 2016 Bceen Ventures. All rights reserved.
//

import UIKit


class ListingController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
     
    var dataSourceArray = [ItemModel]()
    
    let titleKey = "title"
    let paraKey = "para"
    let buttonKey = "button"
    

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArray.count
    }
    
     
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       /* let cellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        cell!.textLabel?.text = self.items[indexPath.row]
        let imagename = self.images[indexPath.row]
        cell!.imageView!.image = UIImage(named: imagename)
        cell!.detailTextLabel!.text = self.detail[indexPath.row]
        */
        guard let cell : CustomTableCell = tableView.dequeueReusableCellWithIdentifier("CellID") as! CustomTableCell else {
            preconditionFailure("reusable cell not found")
        }
        
        let item = self.dataSourceArray[indexPath.row]
        cell.setCellContent(item, isExpanded: true)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
     }
    
    
    private func fetchDataFromJSON(){
        

            guard let filePath = NSBundle.mainBundle().pathForResource("data", ofType: "json") else {
                print("File does not exist")
                return
            }
            guard let jsonData = NSData(contentsOfFile: filePath) else  {
                print("error parsing data from file")
                return
            }
            do {
                guard let jsonArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments) as? [[String:String]] else {
                    print("json doesnot confirm to expected format")
                    return
                }
                self.dataSourceArray = jsonArray.map({ (object) -> ItemModel in
                    return ItemModel(title: object[self.titleKey]!,para:object[self.paraKey]!, button: object[self.buttonKey]!)
                    
                })
               
             }
            catch {
                print("error\(error)")
            }
             self.tableView.reloadData()

    }
    
    
    
    /*
    private func fetchDataFromAPI() {
       
        
        //GRAB FROM AN API:
        let url = NSURL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20youtube.search%20where%20query%3D%22saturday%20night%20live%22&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=")
        let params: [String: String] = ["Q": "NADA"]
        let request = NSMutableURLRequest(URL:url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Send the information in a POST and using JSON!!!! formatting.
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(rawValue:0))
        request.HTTPBody = jsonData
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {   (jsonData, response, error)-> Void in
            //NSJSONReadingOptions.MutableContainers
            do {
               let jsonArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as!
                [[String: String]]//NSDictionary
                
                //completion(data)
                self.dataSourceArray = jsonArray.map({ (object) -> ItemModel in
                  //  return ItemModel(title: object[self.questionKey]!,para:object[self.answerKey]!, button: object(self.questionKey]!)
                })
                self.tableView.reloadData()

            
            } catch let myJSONError {
               print("uh oh!")
                
                
                
            }
            
         
        })

        
        
    }
*/
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        let v = self.tableView.cellForRowAtIndexPath(indexPath)
       
    }
    
    
    
    private lazy var tableView : UITableView = {
        let tbl = UITableView(frame: CGRectMake(0,50,300,300))
        tbl.separatorColor = UIColor.lightGrayColor()
        tbl.translatesAutoresizingMaskIntoConstraints = true
        tbl.dataSource = self
        tbl.delegate = self
        tbl.registerClass(CustomTableCell.self, forCellReuseIdentifier: "CellID")
        return tbl
    } ()
    
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        fetchDataFromJSON()
        self.view.addSubview(self.tableView)
       
    }
    
    
    
    
}