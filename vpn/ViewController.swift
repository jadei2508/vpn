//
//  ViewController.swift
//  vpn
//
//  Created by Roman Alikevich on 18.05.2021.
//

import UIKit

class ViewController: UIViewController {
    private static let DEFAULT_COUNTRY_VALUE = ""
//    var window: UIWindow?
    var pulseView = PulseView()
    var secondView: SecondViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondView = SecondViewController(nibName: nil, bundle: nil)
        view.backgroundColor = .white

        setUpNavigationController()
        
        secondView?.transmissCountryValue = { [unowned self] (countryName, countryUrl) in
            self.view.removeFromSuperview()
            setLaunchButton(countryName: countryName, countryUrl: countryUrl)
        }
        setLaunchButton()
    }
    
    func setUpNavigationController() {
        let menu = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(moveToSecondViewController))
        self.view.backgroundColor = UIColor.getColorByRgb(rgbValue: 0x24d7f7)
        self.navigationItem.setRightBarButton(menu, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.title = "Secure VPN"
    }
    
    func setLaunchButton(countryName: String = "", countryUrl: String = "") {
        if countryName != "" {
            pulseView.setViewElements(name: countryName, iconUrl: countryUrl)
        } else {
            pulseView.setViewElements()
        }
//        pulseView.setViewElements(name: countryName, iconUrl: countryUrl)
        let subviewWidth = self.view.frame.width / 2.0
        pulseView.layer.cornerRadius = subviewWidth / 2

        self.view.addSubview(pulseView)
        pulseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pulseView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            pulseView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            pulseView.widthAnchor.constraint(equalToConstant: subviewWidth),
            pulseView.heightAnchor.constraint(equalToConstant: subviewWidth)
        ])
    }
    
    @objc func moveToSecondViewController() {
        navigationController?.pushViewController(secondView!, animated: true)
    }
}

