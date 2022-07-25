//
//  View.swift
//  ViperCryptoWonder
//
//  Created by Mac on 25.07.2022.
//

import Foundation
import UIKit



protocol AnyView {
    
    var presenter: AnyPresenter? { get set }
    
    func update(with datas: [Crypto])
    func update(with error: String)
}

class CryptoViewController: UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
   
    
    var presenter: AnyPresenter?
    
    var cryptos : [Crypto] = []
    
    private var tableView : UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let messageLabel: UILabel = {
       let label = UILabel()
        label.isHidden = false
        label.text = "İndiriliyor..."
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .green
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .opaqueSeparator
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = .green
        return cell
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width/2 - 100, y: view.frame.height/2 - 30, width: 200, height: 60)
    }
   
    
    func update(with datas: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos = datas
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.tableView.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
            
        }
    }
    
    
}
