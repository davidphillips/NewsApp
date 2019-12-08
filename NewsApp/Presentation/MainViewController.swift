//
//  MainViewController.swift
//  NewsApp
//
//  Created by David Phillips on 1/12/19.
//  Copyright © 2019 David Phillips. All rights reserved.
//

import UIKit
import AlamofireImage

class MainViewController: UIViewController, MainView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var presenter = MainViewPresenter()
    private let refreshControl = UIRefreshControl()
    
    let cellReuseIdentifier = "NewsCollectionViewCell"
    let openUrlViewControllerIdentifier = "OpenUrlViewController"
    var articles: [NewsArticle] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.attachView(view: self)
        getArticles()
        setUpRefreshControl()
    }
    
    // Get News Articles from the presenter
    func getArticles() {
        presenter.getArticles()
    }
    
    // MARK: - RefreshControl
    // Pull down to refresh data and display any updates
    private func setUpRefreshControl() {
        self.collectionView.refreshControl = refreshControl
        self.refreshControl.addTarget(self, action: #selector(refreshArticles(_:)), for: .valueChanged)
    }
    
    @objc private func refreshArticles(_ sender: Any) {
        // Reload articles
        presenter.getArticles()
    }
    
    

    // MARK: - MainView Delegate
    
    // Replace the list of articles with the fresh list of articles and reload collectionview
    func returnedArticles(_ articles: [NewsArticle]) {
        self.articles = articles
        self.collectionView.reloadData()
        
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: NewsCollectionViewCell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier,
        for: indexPath) as! NewsCollectionViewCell
        
        let article = articles[indexPath.item]
        
        cell.headline.text = article.headline
        cell.abstract.text = article.abstract
        cell.byLine.text = article.byLine
        if article.timeStamp != nil {
            cell.timeStamp.text = DateUtils.convertTimeStampIntToDateString(article.timeStamp!)
        }
        else {
            cell.timeStamp.text = ""
        }
        
        // If no image is found while still having a valid URL - display the default imagenotfound image
        if article.thumbnail != nil {
            cell.thumbnail.af_setImage(withURL: URL(string: article.thumbnail!)!, placeholderImage: UIImage(named: "imagenotfound"))
            cell.thumbnail.isHidden = false
        }
        else {
            cell.thumbnail.isHidden = true
        }
        
        // Some cells won't update their layout until this method is called.
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = articles[indexPath.item].url {
            openUrl(url)
        }
    }
    
    //MARK: - CollectionViewFlowLayout
    // Let the cell width be the size of the screen width, except for larger devices in which case limit to 650 points
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: min(collectionView.bounds.width, 650), height: 200)
    }
    
    //MARK: - Navigation
    
    func openUrl(_ url: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: openUrlViewControllerIdentifier) as! OpenUrlViewController
        vc.urlString = url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
