//
//  DetailVC.swift
//  PlaceCustomMarker
//
//  Created by Tung Xuan on 1/11/18.
//  Copyright © 2018 Tung Xuan. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var passedData = (title: "Name", img: #imageLiteral(resourceName: "Place_BoDaPagoda"), text: "Name")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupViews()
    }
    let myScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints=false
        scrollView.showsVerticalScrollIndicator=false
        scrollView.showsHorizontalScrollIndicator=false
        return scrollView
    }()
    
    let containerView: UIView = {
        let v=UIView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let imgView: UIImageView = {
        let v=UIImageView()
        v.image = #imageLiteral(resourceName: "Place_WaterfallSuoiMo")
        v.contentMode = .scaleAspectFill
        v.clipsToBounds=true
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text = "Name"
        lbl.font=UIFont.systemFont(ofSize: 28)
        lbl.textColor = UIColor.black
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()

    let lblDescription: UILabel = {
        let lbl=UILabel()
        lbl.text = "Description"
        lbl.numberOfLines = 0
        lbl.font=UIFont.systemFont(ofSize: 20)
        lbl.textColor = UIColor.gray
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    func setupViews() {
        self.view.addSubview(myScrollView)
        myScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        myScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true
        myScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
        myScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
        myScrollView.contentSize.height = 800
        
        myScrollView.addSubview(containerView)
        containerView.centerXAnchor.constraint(equalTo: myScrollView.centerXAnchor).isActive=true
        containerView.topAnchor.constraint(equalTo: myScrollView.topAnchor).isActive=true
        containerView.widthAnchor.constraint(equalTo: myScrollView.widthAnchor).isActive=true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
        
        containerView.addSubview(imgView)
        imgView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive=true
        imgView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive=true
        imgView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive=true
        imgView.heightAnchor.constraint(equalToConstant: 200).isActive=true
        imgView.image = passedData.img
        
        containerView.addSubview(lblTitle)
        lblTitle.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive=true
        lblTitle.topAnchor.constraint(equalTo: imgView.bottomAnchor).isActive=true
        lblTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive=true
        lblTitle.heightAnchor.constraint(equalToConstant: 50).isActive=true
        lblTitle.text = passedData.title

        containerView.addSubview(lblDescription)
        lblDescription.leftAnchor.constraint(equalTo: lblTitle.leftAnchor).isActive=true
        lblDescription.rightAnchor.constraint(equalTo: lblTitle.rightAnchor).isActive=true
        lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 15).isActive=true
        lblDescription.text = passedData.text
        lblDescription.sizeToFit()
}
    
}
