//
//  MainTableViewModel.swift
//  Twich
//
//  Created by Valentin Mironov on 08.12.2020.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
class MainTableViewModel{
    private let networking: NetworkProvider = ServiceLocator.networking
    private let db: DataBaseProvider = ServiceLocator.dataBase

    //MARK: - init
    init(){
        bind()
        getTopGamesFromApi()
    }
    //rx
    private(set) var observabelTopGame = PublishSubject<[TopGame]>()
    private let bag = DisposeBag()
  
    
    //tableview elements
    private var topGames: [TopGame] = CoreDataManager.shareInstance.getObjectsTop() ?? []
    //networking
    private let limit = 5
    var nubmerOfRows: Int {
        return topGames.count
    }

    //MARK: - TableView
    private func updateWillDisplay(with indextPathRow: Int){
        if(indextPathRow == topGames.count - 1 ){
            DispatchQueue.global().asyncAfter(deadline: .now()+2, execute: getTopGamesFromApi)
        }
    }
    
    private func getGame(with indexPathRow: Int) -> TopGame? {
        if indexPathRow<=topGames.endIndex{
            return topGames[indexPathRow]
        }else{
            return nil
        }
    }
    
    func createGameViewModel(with indexPathRow: Int) -> GameViewModel?{
        guard let game = getGame(with: indexPathRow) else{
            return nil
        }
        return GameViewModel.make(topGame: game)
    }
    
}

//MARK: - Api
extension MainTableViewModel{
    private func getTopGamesFromApi(){
        networking.createPayment(params: GameRequest(limit: limit, offset: nubmerOfRows)) { (response) in
            guard let objects = response?.tops else{
                print("response equal nil")
                return
            }
            var result: [TopGame] = []
            for  object in objects {
                unowned let gameName = self.db.getObject(withName: object.game.name)
                if gameName == nil{
                    unowned let newObject =  self.db.createObject(game: object)
                    if let tObject = newObject{
                        result.append(tObject)
                    }
                }
            }
            self.appendElementsInTopGames(games: result)
        }
    }
}

//MAKR: - RX Input and Output
extension MainTableViewModel{
    func transform(input: Input) -> Output {
        let willDisplay = input.tableViewWillDispay.map{self.updateWillDisplay(with: $0.indexPath.row)}.asDriver(onErrorJustReturn: ())
        return Output(willDisplay: willDisplay)
    }
    
    struct Input {
        let tableViewWillDispay: ControlEvent<WillDisplayCellEvent>
    }
    
    struct Output {
        let willDisplay: Driver<Void>
    }
}
//MARK: - Working with array
extension MainTableViewModel{
    private func bind (){
        observabelTopGame.subscribe { (array) in
            self.topGames += array
        } onError: { (error) in
            print(error)
        } onCompleted: {
            print("observabelTopGame comleted")
        } onDisposed: {
            print("observabelTopGame dispsed")
        }.disposed(by: bag)
    }
    
    func appendElemetnInTopGames(game: TopGame){
        observabelTopGame.onNext([game])
    }
    
    func appendElementsInTopGames(games: [TopGame]){
        observabelTopGame.onNext(games)
    }
}
