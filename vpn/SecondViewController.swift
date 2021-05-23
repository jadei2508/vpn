//
//  SecondViewController.swift
//  vpn
//
//  Created by Roman Alikevich on 18.05.2021.
//

import UIKit

class SecondViewController: UIViewController {
    var tableView = UITableView.init(frame: CGRect.zero, style: .plain)
    var countryNameArray = ["Германия", "Польша", "США", "Беларусь", "Китай"]
    var countryIconArray = ["germany", "poland", "usa", "belarus", "china"]
    var transmissCountryValue: ((String, String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.register(CountryView.self, forCellReuseIdentifier: "countryView")
        tableView.backgroundColor = UIColor.getColorByRgb(rgbValue: 0x24d7f7)
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        view.backgroundColor = .white
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryNameArray.count - 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if let countryCell = tableView.dequeueReusableCell(withIdentifier: "countryView", for: indexPath) as? CountryView {
            print(indexPath.row)
            countryCell.backgroundColor = UIColor.white.withAlphaComponent(0.8)
            
            countryCell.setViewElements(name: countryNameArray[indexPath.row], iconUrl: countryIconArray[indexPath.row])
            cell = countryCell
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
        if let action = transmissCountryValue {
            action(countryNameArray[indexPath.row], countryIconArray[indexPath.row])
        }
    }
}
