//
//  MainTableViewController.swift
//  Twich
//
//  Created by Valentin Mironov on 07.12.2020.
//

import UIKit
import Alamofire
import RxCocoa
import RxSwift

final class MainTableViewController: UITableViewController, Storyboarded {
    private let bag = DisposeBag()
    lazy var input = MainTableViewModel.Input(tableViewWillDispay: tableView.rx.willDisplayCell)
    
    weak var coordinator: MainCoordinator!
    var vm: MainTableViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let vm = vm else {
            print("Vm equal nil, mainTableViewController")
            return
        }
        
        setBarButtonFeetBack()
        bind(output: vm.transform(input: input), subject: vm.observabelTopGame)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.nubmerOfRows ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GameTableViewCell
        cell.gameViewModel = vm?.createGameViewModel(with: indexPath.row)
        
        return cell
    }
    
}

//MARK: - Create Bar Button
extension MainTableViewController{
    private func setBarButtonFeetBack(){
        let buttonVm = FeetBackItemViewModel(vc: self)
        let buttonFeetBack = UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil)
        bindButton(output: buttonVm.transform(input: FeetBackItemViewModel.Input(tapBarButton: buttonFeetBack.rx
                                                                                    .tap)))
        self.navigationItem.rightBarButtonItem = buttonFeetBack
    }
}

//MAKR: - Bind and subscribe
extension MainTableViewController{
    private func bindButton(output: FeetBackItemViewModel.Output){
        output.event.drive().disposed(by: bag)
    }
    
    
    private func bind(output: MainTableViewModel.Output, subject: PublishSubject<[TopGame]>){
        output.willDisplay.drive().disposed(by: bag)
        
        subject.subscribe { (object) in
            guard let elemets = object.element, elemets.count != 0 else{
                return
            }
            let lastRow = self.tableView.numberOfRows(inSection: 0)
            if(elemets.count > 0 && lastRow != 0){
                var indexPath: [IndexPath] = []
                for i in lastRow ... elemets.count + lastRow - 1 {
                    indexPath.append(IndexPath(row: i, section: 0))
                }
                DispatchQueue.main.async {
                    self.tableView.insertRows(at: indexPath, with: .automatic)
                }
            }else{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }.disposed(by: bag)
    }
}
