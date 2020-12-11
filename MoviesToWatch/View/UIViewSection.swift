//
//  UIViewSection.swift
//  MoviesToWatch
//
//  Created by Vladyslav on 11/12/20.
//

import UIKit

class UIViewSection: UIView { //@IBDesignable UITableViewCell
    @IBOutlet var sectionContentView: UIView!
    @IBOutlet weak var lableTitle: UILabel!
    @IBOutlet weak var lableGenres: UILabel!
    @IBOutlet weak var lableDate: UILabel!
    @IBOutlet weak var lableRating: UILabel!
    @IBOutlet weak var sectionUIImageView: UIImageView!
    
    @IBInspectable var textLabelTitle: String {
        get {
            return lableTitle.text!
        }
        set(textLabelTitle) {
            lableTitle.text = textLabelTitle
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSection()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSection()
//        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSection() {
        Bundle.main.loadNibNamed("SectionView", owner: self, options: nil)
        addSubview(sectionContentView)
        //sectionContentView.frame = self.bounds
        //sectionContentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
