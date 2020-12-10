//
//  FeetBackItemViewModel.swift
//  Twich
//
//  Created by Valentin Mironov on 10.12.2020.
//

import Foundation
import RxSwift
import RxCocoa
import JXReviewController
class FeetBackItemViewModel {
    unowned let vc: UIViewController
    
    init(vc: UIViewController) {
        self.vc = vc
    }
    
    private func createJXReviewConroller() -> JXReviewController{
        let reviewController = JXReviewController()
        reviewController.image = UIImage(systemName: "app.fill")
        reviewController.title = "Enjoy it?"
        reviewController.message = "Tap a star to rate it."
        reviewController.delegate = self
        return reviewController
    }
    func presentFeetBackVC(){
        vc.present(createJXReviewConroller(), animated: true)
    }
}

extension FeetBackItemViewModel: JXReviewControllerDelegate {
    func reviewController(_ reviewController: JXReviewController, didSelectWith point: Int) {
        print("Did select with \(point) point(s).")
    }
    
    func reviewController(_ reviewController: JXReviewController, didCancelWith point: Int) {
        print("Did cancel with \(point) point(s).")
    }
    
    func reviewController(_ reviewController: JXReviewController, didSubmitWith point: Int) {
        print("Did submit with \(point) point(s).")
    }
}

extension FeetBackItemViewModel{
    func transform(input: Input) -> Output {
        return Output(event: input.tapBarButton.map{self.presentFeetBackVC()}.asDriver(onErrorJustReturn: ()))
    }
    
    struct Input {
        let tapBarButton: ControlEvent<Void>
    }
    
    struct Output {
        let event: Driver<Void>
    }
}
