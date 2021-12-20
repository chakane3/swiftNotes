//
//  NewsFeedController.swift
//  stories
//
//  Created by Chakane Shegog on 12/19/21.
//

import UIKit

enum SearchScope {
    case title
    case abstract
}

class NewsFeedController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var currentScope = SearchScope.title
    
    var searchQuery = "" {
        didSet {
            switch currentScope {
            case .title:
                headlines = HeadlinesData.getHeadlines().filter {$0.title.lowercased().contains(searchQuery.lowercased())}
            case .abstract:
                headlines = HeadlinesData.getHeadlines().filter( {$0.abstract.lowercased().contains(searchQuery.lowercased() )})
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // run this function in viewDidLoad()
    func loadData() {
        headlines = HeadlinesData.getHeadlines()
    }
    
    // when we search for something in the search bar we'll see if our targets contains anything in our searchQuery
    func filterHeadlines(for searchText: String) {
        guard !searchText.isEmpty else { return }
        
        // we get out headlines, then filter by title which we'll lowercase
        // if that title contains anything in the user searchText we will return or change our headlines data for the tableView
        headlines = HeadlinesData.getHeadlines().filter {$0.title.lowercased().contains(searchText.lowercased())}
    }
    
    // here we need to had set up NewsDetailController because were sending our headlines data to another file. 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get destination view controller
        // get the index path the user selected from the table
        guard let newsDetailController = segue.destination as? NewsDetailController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("could not retrieve instance of NDC, verify class name in the identity inspector")
        }
        let headline = headlines[indexPath.row]
        newsDetailController.newsHeadline = headline
    }
    
}
