//
//  ViewController.swift
//  CollectionView
//
//  Created by Magic on 2018/2/23.
//  Copyright © 2018年 magic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 成员变量
    
    @IBOutlet weak var titleBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleView: UIView!
    
    fileprivate var lastSelectedBtn:UIButton!
    lazy var line: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.white
        lineView.bounds = CGRect(x:0,y:0,width:UIScreen.main.bounds.size.width/4,height:2)
        return lineView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseSet()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectTypeVC(_ sender: UIButton)
    {
        if lastSelectedBtn==sender
        {
            return
        }
        if lastSelectedBtn != nil {
            lastSelectedBtn.isSelected = false
        }
        
        sender.isSelected = true
        lastSelectedBtn = sender
        let width = collectionView.bounds.size.width
        collectionView.contentOffset = CGPoint(x:CGFloat(sender.tag) * width,y:0)
        line.frame = CGRect(x:CGFloat(lastSelectedBtn.tag)*line.bounds.size.width,y:titleView.bounds.size.height-line.bounds.size.height,width:line.bounds.size.width,height:line.bounds.size.height)
    }
}

extension ViewController
{
    fileprivate func baseSet()
    {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        
        self.collectionView.register(UINib.init(nibName: "ZGCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ZGCollectionViewCell")
        
        addChildVCs()
        defaultSelectedBtn(index: 0)
        addLineView()
    }
    fileprivate func addLineView()
    {
        titleView.addSubview(line)
        titleView.bringSubview(toFront: line)
        
    }
    fileprivate func addChildVCs()
    {
        let vc1 = ZGSubVC()
        vc1.title = "第一个"
        let vc2 = ZGSubVC()
        vc2.title = "第二个"
        let vc3 = ZGSubVC()
        vc3.title = "第三个"
        let vc4 = ZGSubVC()
        vc4.title = "第四个"
        self.addChildViewController(vc1)
        self.addChildViewController(vc2)
        self.addChildViewController(vc3)
        self.addChildViewController(vc4)
    }
    fileprivate func defaultSelectedBtn(index:NSInteger)
    {
        for btn in titleView.subviews {
            if !btn.isKind(of: UIButton.self){return}
            let currentBtn = btn as! UIButton
            if currentBtn.tag==index
            {
                if lastSelectedBtn != nil
                {
                    lastSelectedBtn.isSelected = false
                }
                lastSelectedBtn = currentBtn
                lastSelectedBtn.isSelected = true
                
                line.frame = CGRect(x:CGFloat(lastSelectedBtn.tag)*line.bounds.size.width,y:titleView.bounds.size.height-line.bounds.size.height,width:line.bounds.size.width,height:line.bounds.size.height)
            }
            currentBtn.setTitleColor(.red, for: .selected)
        }
    }
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZGCollectionViewCell", for: indexPath)
        cell.backgroundColor = indexPath.row%2==0 ?.red:.yellow
        let vc = self.childViewControllers[indexPath.row] as! ZGSubVC
        vc.view.frame = collectionView.frame
        cell.contentView.addSubview(vc.view)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.bounds.size.width,height:collectionView.bounds.size.height);
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let currentIndex = offsetX/collectionView.bounds.size.width
        if NSInteger(currentIndex)==lastSelectedBtn.tag{return}
        defaultSelectedBtn(index: NSInteger(currentIndex))
    }
}

