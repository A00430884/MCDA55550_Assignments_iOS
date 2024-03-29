//
//  SavedWondersViewController.swift
//  MCDA5550_Assignment2
//
//  Created by MSc CDA on 2019-08-09.
//  Copyright © 2019 MSc CDA. All rights reserved.
//

import UIKit

class SavedWondersViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var savedWonders: [Wonders] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        let slides = createSlides()
        setupScrollView(slides: slides)
        
        view.bringSubviewToFront(pageControl)
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        
        // Do any additional setup after loading the view.
    }
    
    func createSlides() -> [Slide] {
        
        let slide1: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.slideLabel.text = savedWonders[0].name
        
        let slide2: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.slideLabel.text = savedWonders[1].name
        
        let slide3: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.slideLabel.text = savedWonders[2].name
        
        let slide4: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.slideLabel.text = savedWonders[3].name
        
        let slide5: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.slideLabel.text = savedWonders[4].name
        
        let slide6: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide6.slideLabel.text = savedWonders[5].name
        
        let slide7: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide7.slideLabel.text = savedWonders[6].name
        
        return [slide1, slide2, slide3, slide4, slide5, slide6, slide7]
    }
    
    func setupScrollView(slides:[Slide]){
        scrollView.frame = CGRect(x: 0,y: 0,width: view.frame.width,height:view.frame.height)
        scrollView.contentSize = CGSize(width:view.frame.width * CGFloat(slides.count),height: view.frame.height)
        
        for index in 0..<slides.count{
            slides[index].frame = CGRect(x:view.frame.width*CGFloat(index),y:0,width:view.frame.width,height:view.frame.height)
            scrollView.addSubview(slides[index])
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SavedWondersViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Check and disable vertical scrolling
        if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
        
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
