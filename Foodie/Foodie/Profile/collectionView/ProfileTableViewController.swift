//
//  ProfileTableViewController.swift
//  Foodie
//  Name: Carson Wang
//  Email: carsonw@usc.edu
//  Created by Carson Wang on 12/7/22.
//

import UIKit

// This UITableViewController create the table view for user to see their saved stores
// When user tap on cell, the web view shows up

class ProfileTableViewController: UITableViewController {
    // singleton - share data
    public static let shared = ProfileTableViewController()
    
    // index for cell
    public var myIndex = 0
    
    // outlet
    @IBOutlet var saved: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // relaod data everytime
    override func viewWillAppear(_ animated: Bool) {
        saved.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ImagesViewController.shared.storeName.count
    }


    // create table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        // name
        cell.textLabel!.text = "Resturant Name: " + ImagesViewController.shared.storeName[indexPath.row]
        // address
        cell.detailTextLabel!.text = "Address: " + ImagesViewController.shared.storeAdd[indexPath.row]
        return cell
    }



    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    // delete data/ store
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            // delete using remove(at:)
            ImagesViewController.shared.storeName.remove(at: indexPath.row)
            ImagesViewController.shared.storeAdd.remove(at: indexPath.row)
            ImagesViewController.shared.storeUrl.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            // No insert
        }    
    }
    
    // get current index and save it
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
    }
}
