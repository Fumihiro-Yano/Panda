//
//  QuestionnaireViewController.swift
//  Panda
//
//  Created by 矢野史洋 on 2016/08/06.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import UIKit

class QuestionnaireViewController: UIViewController {
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var pushModalViewButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    //動かすために一旦仮
    var tappedImage: UIImageView?
    private var indexRow: Int?
    var indexRowAccessor: Int? {
        get {
            return self.indexRow
        }
        set(value) {
            self.indexRow = value
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftImage.image = UIImage(named: Datacontent().getImageName(self.indexRow!, imageSide: 0))
        self.rightImage.image = UIImage(named: Datacontent().getImageName(self.indexRow!, imageSide: 1))
        self.titleLabel.text = Datacontent().getTitle(self.indexRow!)
        self.descriptionTextView.text = Datacontent().getQuestionDescription(self.indexRow!)
        //xibで指定した
        //self.descriptionTextView.editable = false
        leftImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(QuestionnaireViewController.imageTapped(_:))))
        rightImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(QuestionnaireViewController.imageTapped(_:))))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        //tabbarとCollectionViewの最後がかぶらないように
        if self.respondsToSelector(Selector("edgesForExtendedLayout")) {
            self.edgesForExtendedLayout = UIRectEdge.None
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.descriptionTextView.setContentOffset(CGPointZero, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openButtonTouchUpInside(sender: AnyObject) {
        let lineupModalViewController = lineUpModalViewController()
        lineupModalViewController.modalPresentationStyle = .Custom
        lineupModalViewController.transitioningDelegate = self
        presentViewController(lineupModalViewController, animated: true, completion: nil)
    }
    
    //imageのタップイベント
    func imageTapped(sender: UITapGestureRecognizer) {
        let selectedTag: Int = sender.view!.tag
        switch selectedTag {
        case 0:
            tappedImage = leftImage
        case 1:
            tappedImage = rightImage
        default :
            tappedImage = leftImage
        }
        
        let questionSelectModalViewController = QuestionSelectModalViewController()
        questionSelectModalViewController.delegate = self
        
        questionSelectModalViewController.modalPresentationStyle = .Custom
        questionSelectModalViewController.transitioningDelegate = self
        questionSelectModalViewController.indexRowAccessor = self.indexRow
        questionSelectModalViewController.selecedImageTagAccessor = selectedTag
        presentViewController(questionSelectModalViewController, animated: true, completion: nil)
    }
}

extension QuestionnaireViewController: UIViewControllerTransitioningDelegate {
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
}

extension QuestionnaireViewController {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomAnimatedTransitioning(isPresent: true, imgView:
            tappedImage)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomAnimatedTransitioning(isPresent: false, imgView: tappedImage)
    }
}

extension QuestionnaireViewController: pushResuViewDelegate {
    func pushQuestionnaireResultViewController() {
        let baseQuestionnaireResultViewController: QuestionnaireResultViewController = QuestionnaireResultViewController()
        baseQuestionnaireResultViewController.indexRowAccessor = self.indexRow
        self.navigationController!.pushViewController(baseQuestionnaireResultViewController, animated: true)
    }
}
