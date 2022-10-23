//
//  ViewController.swift
//  StackOverFlowQuestions
//
//  Created by fyz on 9/15/22.
//

import UIKit

class QuestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var questionsViewModel = QuestionsViewModel()
    var questionsTableView = UITableView()
    var questions:[Question] = []
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Questions"
        configureTableView()
        
        questionsViewModel.fetchQuestions {[weak self] results, error in
            
            guard let self = self else {return}
            if let results = results {
                self.questions = results
            }
            
            DispatchQueue.main.async {
                self.questionsTableView.reloadData()
            }
        }
        configureRefreshControl()
    }
   //Configure tableview
    func configureTableView() {
        
        view.addSubview(questionsTableView)
        questionsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            questionsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            questionsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            questionsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        questionsTableView.delegate = self
        questionsTableView.dataSource = self
        
        questionsTableView.register(QuestionsCell.self, forCellReuseIdentifier: "QuestionsCell")
        
    }
    //Configure refresh control
    func configureRefreshControl() {
        questionsTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshQuestions), for: .valueChanged)
    }
    @objc func refreshQuestions() {
        questionsViewModel.fetchQuestions {[weak self] results, error in
            guard let self = self,
                  let results = results else {
                return
            }
            self.questions = results
            DispatchQueue.main.async {
                self.questionsTableView.reloadData()
            }
        }
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionsCell", for: indexPath) as? QuestionsCell else {return UITableViewCell()}
        cell.questionLabel.text = questions[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVc = DetailsViewController()
        detailsVc.question = questions[indexPath.row]
        navigationController?.pushViewController(detailsVc, animated: true)
    }
    //Spinner view for infinite scroll
    private func createSpinner() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    //Pagination - Infinite Scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (questionsTableView.contentSize.height - 50) - scrollView.frame.size.height {
            self.questionsTableView.tableFooterView = createSpinner()
            questionsViewModel.page += 1
            questionsViewModel.fetchQuestions { [weak self] results, error in
                DispatchQueue.main.async {
                    self?.questionsTableView.tableFooterView = nil
                }
                guard let self = self,
                      let results = results else {
                    return
                }
                self.questions.append(contentsOf: results)
                DispatchQueue.main.async {
                    self.questionsTableView.reloadData()
                }
            }
        }
    }
    
}

