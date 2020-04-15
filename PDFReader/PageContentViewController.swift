//
//  PageContentViewController.swift
//  PDFReader
//
//  Created by Hugo Flores Perez on 4/15/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit
import PDFKit

class PageContentViewController: UIViewController {
    
    public static let identifier = "PageContentViewController"
    let pageView: PDFView = {
        let pageView = PDFView()
        pageView.displayMode = .singlePage
        pageView.autoScales = true
        pageView.translatesAutoresizingMaskIntoConstraints = false
        return pageView
    }()
    var pageIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        if let path = Bundle.main.path(forResource: "Test", ofType: "pdf") {
            let url = URL(fileURLWithPath: path)
            if let pdfDocument = PDFDocument(url: url) {
                pageView.document = pdfDocument
                print("Page loaded?")
            }
        }
        */
        view.addSubview(pageView)
        
        NSLayoutConstraint.activate([
            pageView.topAnchor.constraint(equalTo: view.topAnchor),
            pageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            pageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            pageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}
