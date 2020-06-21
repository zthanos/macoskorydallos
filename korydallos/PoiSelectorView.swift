//
//  PoiSelectorView.swift
//  korydallos
//
//  Created by Korydallos on 21/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import SwiftUI
import UIKit


public class PopupMapOptions: UIView  {
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "Επιλογή"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .gray
        self.frame = UIScreen.main.bounds
        
    }
    fileprivate lazy var stack : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel])
        return stack
    }()
    
    required init?(coder aDecoder: NSCoder){
        fatalError("initcoder:) has not been implemented!")
    }
    
    
}

