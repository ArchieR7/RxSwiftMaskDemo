//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by Archie on 2020/5/4.
//  Copyright © 2020 Archie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            let identifier: String = String(describing: MaskTableViewCell.self)
            tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
            tableViewModel.rx.cellModels.bind(to: tableView.rx.items(cellIdentifier: identifier, cellType: MaskTableViewCell.self)) { row, model, cell in
                cell.viewModel = model
            }
            .disposed(by: tableViewModel.disposeBag)
        }
    }
    
    private let tableViewModel: MaskPointTableViewModel = MaskPointTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewModel.getMaskPoints()
    }
}

