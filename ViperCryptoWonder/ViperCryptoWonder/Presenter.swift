//
//  Presenter.swift
//  ViperCryptoWonder
//
//  Created by Mac on 25.07.2022.
//

import Foundation


protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidDownloadData(result: Result<[Crypto], Error>)
}

class CryptoPresenter: AnyPresenter {
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.downloadData()
        }
    }
    
    
    var view: AnyView?
    
    func interactorDidDownloadData(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(let error):
            view?.update(with: "Hata alındı.")
        }
    }
    
}
