//
//  ViewController.swift
//  Twich
//
//  Created by Valentin Mironov on 02.12.2020.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    

    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var enterBtn: UIButton!
    
    let bag = DisposeBag()
    let vm = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(output: vm.transform(input: input))
        
//        vm.transform(input: MainViewModel.Input(someTrigger: UITextField().rx.text))
        
    }
    
    
    lazy var input = MainViewModel.Input(password: passwordTF.rx.text, login: loginTF.rx.text, loginTriger: enterBtn.rx.tap)
    

    func bind(output: MainViewModel.Output) {
        output.login.drive(enterBtn.rx.isHidden).disposed(by: bag)
        output.isLoginButtonEnable.drive(enterBtn.rx.isEnabled).disposed(by: bag)
    }

}

