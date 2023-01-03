//
//  TaskListViewController.swift
//  GoodList
//
//  Created by Monil Gandhi on 15/01/21.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    //    private var tasks = Variable<[Task]>([])
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filterdTask = [Task]()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController,
              let addTVC = navC.viewControllers.first as? AddTaskViewController else {
            fatalError("Error")
        }
        addTVC.taskSubjectObservable
            .subscribe(onNext: { [unowned self] task in
                
                let prority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
                
                var existingTasks = self.tasks.value
                existingTasks.append(task)
                self.tasks.accept(existingTasks)
                self.filterTask(by: prority)
            }).disposed(by: disposeBag)
    }
    
    
    @IBAction func priorityValueChanged(segmentedControl: UISegmentedControl) {
        let prority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        self.filterTask(by: prority)
    }
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func filterTask(by priority: Priority?) {
        
        if priority == nil {
            self.filterdTask = self.tasks.value
            self.updateTableView()
        } else {
            self.tasks.map { tasks in
                return tasks.filter{ $0.priority == priority! }
            }.subscribe(onNext: { [weak self] tasks in
                self?.filterdTask = tasks
                self?.updateTableView() 
            }).disposed(by: disposeBag)
        }
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterdTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        cell.textLabel?.text = self.filterdTask[indexPath.row].title
        return cell
    }
}
