//
//  ImagesViewController.swift
//  WangCarsonHW7
//  Name: Carson Wang
//  Email: carsonw@usc.edu
//  Created by Carson Wang on 11/2/22.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"
class ImagesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    // use singleton to share data
    public static let shared = ImagesViewController()
    public var yelp = [YelpModel]()
    
    // create varible arrays
    public var storeName = [String]()
    public var storeAdd = [String]()
    public var storeUrl = [String]()
    var urls: [String] = []
    var name: [String] = []
    var price: [String] = []
    var Address: [String] = []
    var Address2: [String] = []
    var phone: [String] = []
    var type2: [String] = []
    var url2: [String] = []
    
    // set margin for collection view
    let margin: CGFloat = 5
    
    // connect outlet
    @IBOutlet var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this create margins for collectionView between each item
        guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            flowLayout.minimumInteritemSpacing = margin
            flowLayout.minimumLineSpacing = margin
            flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
        // call load image
        loadImages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // reload data
        collection.reloadData()
    }
    
    // this function change the overall look for display
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2 // # per row
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: 200)
    }
    
    // this function load data from YelpAPI
    func loadImages(){
        // calling from YelpAPI
        YelpAPI.shared.getImages{ images in
            DispatchQueue.main.async {
                YelpAPI.shared.yelp = images
                // using for loop to loop through the data
                // save the data to local varibles
                for x in 0..<YelpAPI.shared.yelp.count{
                    for i in YelpAPI.shared.yelp[x].businesses{
                        self.urls.append(i.imageURL!)
                        self.name.append(i.name!)
                        self.Address.append((i.location?.address1)!)
                        self.phone.append(i.phone!)
                        self.Address2.append((i.location?.city)!)
                        self.type2.append(i.categories![x].title!)
                        self.url2.append(i.url!)
                    }
                }
                // reload
                self.collectionView.reloadData()
            }
        }
    }

    @IBAction func refresh(_ sender: UIBarButtonItem) {
        // click on button reload
        loadImages()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.urls.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        // Configure the cell
        // get current url
        let url = URL(string: self.urls[indexPath.row])
        // use kingfisher to load image
        cell.ImageView.kf.setImage(with: url)
        // add name
        cell.name.text = name[indexPath.row]
        // add address
        cell.Address.text = Address[indexPath.row]
        return cell
    }
    
    // this function is for loading the detail store info using prepare for segue
    override func prepare(for segue: UIStoryboardSegue,
                         sender: Any?) {
      // Get selected item
        if segue.identifier == "loadImage",
           let StoreViewController = segue.destination as? StoreViewController{
            // get index path
            let indexPath = collectionView.indexPathsForSelectedItems!.first!.row
            // pass through data to another segue
            let url = URL(string: self.urls[indexPath])
            StoreViewController.url = url
            StoreViewController.name1 = self.name[indexPath]
            StoreViewController.phone1 = self.phone[indexPath]
            StoreViewController.address1 = self.Address[indexPath]
            StoreViewController.city1 = self.Address2[indexPath]
            StoreViewController.type1 = self.type2[indexPath]
            StoreViewController.url_page = self.url2[indexPath]
        }
    }
}
