//
//  ViewController.swift
//  MQAlertView
//
//  Created by 892895471@qq.com on 11/15/2017.
//  Copyright (c) 2017 892895471@qq.com. All rights reserved.
//

import UIKit
import MQAlertView

class ViewController: UIViewController {

    var dataSource: [String] = ["0","1","2","3","4"] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.frame.origin.y = 64
        view.backgroundColor = .white
        tableView.backgroundColor = .gray
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        switch indexPath.row {
        case 1:
            let al = MQAlertView(title: "title",
                                 placeholder: "placeholder",
                                 btnDoneTitle: "certain")
            al.setupViews {
                print("btnDone click")
            }
            al.show(animated: true)
        case 2:
            let al = MQAlertView(title: "title",
                                 message: "message",
                                 btnDoneTitle: "certain")
            al.appearFrom = .bottom
            al.setupViews {
                print("btnDone click")
            }
            al.show(animated: true)
        case 3:
            let al = MQAlertView(title: "title",
                                 message: "message",
                                 btnDoneTitle: "certain")
            al.clearBackground = true
            al.setupViews {
                print("btnDone click")
            }
            al.show(animated: false)
            
        case 4:
            let al = MQAlertView(title: "title",
                                 alertType: .input,
                                 message: "placeholder",
                                 btnDoneTitle: "certain")
            
            al.setupViews { [weak self] in
                print("btnDone click")
                let text = al.getTextField().text ?? ""
                self?.dataSource.append(text)
            }
            al.show(animated: false)
        default:
            let al = MQAlertView(title: "title",
                                 message: "message",
                                 btnDoneTitle: "certain")
            al.setupViews {
                print("btnDone click")
            }
            al.show(animated: true)
            break
        }
        
    }
}
