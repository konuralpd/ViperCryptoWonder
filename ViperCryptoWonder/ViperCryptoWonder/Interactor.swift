//
//  Interactor.swift
//  ViperCryptoWonder
//
//  Created by Mac on 25.07.2022.
//

import Foundation



protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func downloadData()
}

class CryptoInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func downloadData() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let datas = try? JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloadData(result: .success(datas!))
            } catch {
                self?.presenter?.interactorDidDownloadData(result: .failure(error))
            }
            
        }
        task.resume()
    }
    
}
