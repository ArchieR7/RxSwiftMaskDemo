//
//  MaskTableViewCell.swift
//  RxSwiftDemo
//
//  Created by Archie on 2020/5/5.
//  Copyright © 2020 Archie. All rights reserved.
//

import UIKit

class MaskTableViewCell: UITableViewCell {
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var countLabel: UILabel!
    
    var viewModel: MaskCellModel? {
        didSet {
            guard let viewModel: MaskCellModel = viewModel else { return }
            nameLabel.text = viewModel.name
            countLabel.text = viewModel.count
            if viewModel.name.isEmpty {
                nameLabel.text = "未標記縣市"
            }
        }
    }
}
