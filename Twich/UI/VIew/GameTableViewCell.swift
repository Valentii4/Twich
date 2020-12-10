//
//  GameTableViewCell.swift
//  Twich
//
//  Created by Valentin Mironov on 08.12.2020.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageGame: UIImageView!
    @IBOutlet weak var channels: UILabel!
    @IBOutlet weak var viewers: UILabel!
    
    unowned var gameViewModel: GameViewModel!{
        didSet{
            gameViewModel.input = input
        }
    }
    private lazy var input = GameViewModel.Input(name: name.rx.text, viewers: viewers.rx.text, channels: channels.rx.text, image: imageGame.rx.image)
    
}
