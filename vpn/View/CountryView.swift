//
//  CountryView.swift
//  vpn
//
//  Created by Roman Alikevich on 21.05.2021.
//

import UIKit
import Cartography

class CountryView: UITableViewCell {
    var name: UILabel?
    var icon: UIImageView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.name = UILabel()
        self.icon = UIImageView()
        
        initElements()
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon?.backgroundColor = .white
        icon?.layer.cornerRadius = (icon?.frame.size.width ?? 200) / 2
        self.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    func setViewElements(name: String, iconUrl: String) {
        self.name?.text = name
        self.icon?.image = UIImage(named: iconUrl)
    }
}

private extension CountryView {
    func initElements() {
        name?.textColor = .black
        name?.font = UIFont.systemFont(ofSize: 20.0)
        name?.textAlignment = NSTextAlignment.center
        
        icon?.clipsToBounds = true
        icon?.layer.borderWidth = 1.0
        icon?.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func addViews() {
        self.addSubview(name!)
        self.addSubview(icon!)
    }
    
    func setupConstraints() {
        
        constrain(icon!, self) { icon, view in
            icon.centerY == view.centerY
            icon.trailing == view.trailing
            icon.width == view.height * 0.8
            icon.width == icon.height
        }
        
        constrain(name!, icon!, self) { name, icon, view in
            name.leading == view.leading
            name.trailing == icon.trailing
            name.top == view.top
            name.bottom == view.bottom
        }
    }
}
