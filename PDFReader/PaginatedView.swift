//
//  PaginatedView.swift
//  PDFReader
//
//  Created by Hugo Flores Perez on 4/15/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit
import PDFKit

class PaginatedView: UIPageViewController {
    
    var loadedPDF: PDFDocument?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        if let path = Bundle.main.path(forResource: "Test", ofType: "pdf") {
            let url = URL(fileURLWithPath: path)
            if let pdfDocument = PDFDocument(url: url) {
                loadedPDF = pdfDocument
                /*
                pdfView.displayMode = .singlePageContinuous
                pdfView.autoScales = true
                // pdfView.displayDirection = .horizontal
                pdfView.document = pdfDocument
                */
                setViewControllers([getViewControllerAtIndex(index: 0)], direction: .forward, animated: false, completion: nil)
            }
        }
    }
    
    func getViewControllerAtIndex(index: Int) -> PageContentViewController {
        let pageController = storyboard?.instantiateViewController(identifier: PageContentViewController.identifier) as! PageContentViewController
        let page: PDFDocument = PDFDocument()
        page.insert((loadedPDF?.page(at: index))!, at: 0)
        pageController.pageView.document = page
        pageController.pageIndex = index
        return pageController
    }
}

extension PaginatedView: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContent = viewController as! PageContentViewController
        var index = pageContent.pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1;
        
        return getViewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent = viewController as! PageContentViewController
        var index = pageContent.pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if (index == loadedPDF?.pageCount){
            return nil
        }
        
        return getViewControllerAtIndex(index: index)
    }
}
