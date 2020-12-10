//
//  GameViewModel.swift
//  Twich
//
//  Created by Valentin Mironov on 08.12.2020.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class GameViewModel {
    private static let networking: NetworkProvider = ServiceLocator.networking
    
    private let name: String
    private let channels:Int
    private let viewers: Int
    private var image: UIImage?{
        didSet{
            if let image = image{
                input?.image.onNext(image)
                input?.image.onCompleted()
            }
        }
    }
    
    init(name:String, channels: Int, viewers: Int, image: UIImage?){
        self.name = name
        self.channels = channels
        self.viewers = viewers
        self.image = image
    }
    //MARK: - Public params
    var input: Input?{
        didSet{
            input?.channels.onNext(String(channels))
            input?.channels.onCompleted()
            input?.viewers.onNext(String(viewers))
            input?.viewers.onCompleted()
            input?.name.onNext(name)
            input?.name.onCompleted()
            if(image != nil){
                input?.image.onNext(image)
                input?.image.onCompleted()
            }
        }
    }
}
extension GameViewModel{
    public static func make(topGame: TopGame) -> GameViewModel{
        let vm = GameViewModel(name: topGame.name, channels: Int(topGame.channels), viewers: Int(topGame.viewers), image: nil)
        DispatchQueue.global().async {
            if let imageData = topGame.image {
                vm.image  = UIImage(data: imageData)
            }else{
                if let imageDataWithURl = GameViewModel.networking.downloadImage(url: topGame.imageURL){
                    vm.image = UIImage(data: imageDataWithURl)
                    topGame.image = imageDataWithURl
                }
            }
        }
        return vm
    }
}

extension GameViewModel{
    struct Input {
        let name: Binder<String?>
        let viewers: Binder<String?>
        let channels: Binder<String?>
        let image: Binder<UIImage?>
        
    }
}
