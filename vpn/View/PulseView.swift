//
//  PulseView.swift
//  vpn
//
//  Created by Roman Alikevich on 22.05.2021.
//

import UIKit
import Cartography

class PulseView: UIView {
    private static let DEFAULT_COUNTRY_NAME = "What's country?"
    private static let DEFAULT_COUNTRY_URL = "question"
    private var name: UILabel?
    private var icon: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.name = UILabel()
        self.icon = UIImageView()
        
        initElements()
        addViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon?.layer.cornerRadius = (icon?.frame.size.width ?? 200) / 2
        icon?.backgroundColor = .clear
        self.layer.backgroundColor = UIColor.white.cgColor
    }
    
    func setViewElements(name: String = DEFAULT_COUNTRY_NAME, iconUrl: String = DEFAULT_COUNTRY_URL) {
            self.name?.text = name
            self.icon?.image = UIImage(named: iconUrl)
    }
}

private extension PulseView {
    
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
            icon.centerX == view.centerX
            icon.centerY == view.centerY
            icon.height == view.height * 0.6
            icon.width == icon.height
        }
        
        constrain(name!, icon!, self) { name, icon, view in
            name.top == icon.bottom
            name.left == view.left
            name.right == view.right
            name.height == view.height / 8
        }
    }
}
