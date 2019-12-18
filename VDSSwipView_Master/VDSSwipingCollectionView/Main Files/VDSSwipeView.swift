//
//  VDSSwipeView.swift
//  VDSSwipingCollectionView
//
//  Created by Vimal Das on 11/12/18.
//  Copyright © 2018 Vimal Das. All rights reserved.
//

import UIKit


class VDSSwipeView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let menuReuseIdentifier = "menu"
    
    private let mainReuseIdentifier = "main"
    
    private let menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    private let mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    private var isInitialLoading = false
    
    var menuItems:[String] = [] {
        didSet {
            menuCollectionView.reloadData()
            if menuItems.count != 0 {
                isInitialLoading = true
                menuCollectionView.selectItem(at: [0, 0], animated: true, scrollPosition: .centeredHorizontally)
                menuCount = menuItems.count
            }
        }
    }
        
    private var menuCount: Int = 1 {
        didSet {
            menuCollectionView.reloadData()
        }
    }
    
    var vcItems: [UIViewController] = [] {
        didSet {
            mainCollectionView.reloadData()
        }
    }
    
    var menuBarColor:UIColor = .black {
        didSet {
            menuCollectionView.reloadData()
        }
    }
    
    var menuTitleColor: UIColor = .lightGray {
        didSet {
            menuCollectionView.reloadData()
        }
    }
    
    var menuSelectedTitleColor: UIColor = .black {
        didSet {
            menuBar.backgroundColor = menuBarColor
        }
    }
    
    private let menuBar: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        return v
    }()
    
    private var widthConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initiateViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initiateViews()
    }
    
    fileprivate func initiateViews() {
        setupCollectionViews()
        setupConstraints()
    }
    
    fileprivate func setupCollectionViews() {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        menuCollectionView.backgroundColor = .white
        mainCollectionView.backgroundColor = .white
        
        menuCollectionView.register(VDSMenuCell.self, forCellWithReuseIdentifier: menuReuseIdentifier)
        mainCollectionView.register(VDSMainCell.self, forCellWithReuseIdentifier: mainReuseIdentifier)
        
        let layout1 = UICollectionViewFlowLayout()
            layout1.scrollDirection = .horizontal
            layout1.minimumLineSpacing = 0
            layout1.minimumInteritemSpacing = 0
            menuCollectionView.collectionViewLayout = layout1
        
        let layout2 = UICollectionViewFlowLayout()
            layout2.scrollDirection = .horizontal
            layout2.minimumLineSpacing = 0
            layout2.minimumInteritemSpacing = 0
            mainCollectionView.collectionViewLayout = layout2
        
        mainCollectionView.allowsSelection = true
        mainCollectionView.isPagingEnabled = true
    }
    
    fileprivate func setupConstraints() {
        self.clipsToBounds = true
        
        addSubview(menuCollectionView)
        menuCollectionView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, size: .init(width: 0, height: 60))
        
        addSubview(menuBar)
        menuBar.anchor(top: nil, leading: self.leadingAnchor, bottom: menuCollectionView.bottomAnchor, trailing: nil, size: .init(width: 0, height: 3))
        widthConstraint = menuBar.widthAnchor.constraint(equalToConstant: self.frame.width/CGFloat(menuCount))
            widthConstraint?.isActive = true
        
        addSubview(mainCollectionView)
        mainCollectionView.anchor(top: menuCollectionView.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
        
    
    func setup(in vc: UIViewController,withTitles titles:[String], ofViewControllers vcArray: [UIViewController], selectedTitleColor: UIColor = .black, titleColor: UIColor = .lightGray) {
        self.menuSelectedTitleColor = selectedTitleColor
        self.menuTitleColor = titleColor
        
        for subVC in vcArray {
            vc.addChild(subVC)
        }
        self.menuItems = titles
        self.vcItems = vcArray
    }

    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == menuCollectionView {
            return 1
        } else {
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuCollectionView {
            return menuItems.count
        } else {
            return vcItems.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == menuCollectionView {
            let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: menuReuseIdentifier, for: indexPath) as! VDSMenuCell
            cell.label.text = menuItems[indexPath.item]
            cell.menuTitleColor = menuTitleColor
            cell.menuSelectedTitleColor = menuSelectedTitleColor
            if isInitialLoading {
                if indexPath.row == 0 {
                    cell.label.textColor = menuSelectedTitleColor
                } else {
                    cell.label.textColor = menuTitleColor
                }
                if indexPath.row == menuItems.count - 1 {
                    isInitialLoading = false
                }
            }
            return cell
        } else {
            let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: mainReuseIdentifier, for: indexPath) as! VDSMainCell
            
            let vcView = vcItems[indexPath.row].view!
            cell.addSubview(vcView)
            vcView.fillSuperview()
            return cell
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.width
        if collectionView == menuCollectionView {
            let count:CGFloat = menuItems.count >= menuCount ? CGFloat(menuCount) : CGFloat(menuItems.count)
            if count != 0 {
                widthConstraint?.constant = width/count
                widthConstraint?.isActive = true
            }
            return .init(width: width / count, height: collectionView.frame.height)
        } else {
            return .init(width: width, height: collectionView.frame.height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCollectionView {
            if indexPath.row < vcItems.count {
                mainCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            } else {
                print("VDSSwpieView : doesnt have enough viewcontroller to scroll to.")
            }
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mainCollectionView {
            let x = scrollView.contentOffset.x
            let count:CGFloat = menuItems.count >= menuCount ? CGFloat(menuCount) : CGFloat(menuItems.count)
            let offset = count != 0 ? x / count : x/CGFloat(menuCount)
            menuBar.transform = CGAffineTransform(translationX: offset, y: 0)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == mainCollectionView {
            let x = targetContentOffset.pointee.x
            let item = x / self.frame.width
            let indexPath = IndexPath(item: Int(item), section: 0)
            menuCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
        
    }
    
}
fileprivate class VDSMainCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

fileprivate class VDSMenuCell: UICollectionViewCell {
    
    var menuSelectedTitleColor: UIColor = .black
    
    var menuTitleColor: UIColor = .lightGray
    
    let label: UILabel = {
        let l = UILabel()
        l.text = "Menu Item"
        l.textAlignment = .center
        return l
    }()
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? menuSelectedTitleColor : menuTitleColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
}

