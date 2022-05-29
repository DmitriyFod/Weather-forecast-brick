import Foundation
import UIKit

class LabelInfo: UILabel {
     var darkLabelInfo: UILabel = {
        let darkLabelInfo = UILabel()
        darkLabelInfo.isHidden = false
        darkLabelInfo.frame = CGRect(x: 0, y: 0, width: 277, height: 372)
        darkLabelInfo.layer.backgroundColor = UIColor(red: 0.984, green: 0.373, blue: 0.161, alpha: 1).cgColor
        darkLabelInfo.layer.cornerRadius = 15
        darkLabelInfo.translatesAutoresizingMaskIntoConstraints = false
        return darkLabelInfo
    }()
    
    var labelOpenInfo: UILabel = {
        let labelOpenInfo = UILabel()
        labelOpenInfo.layer.backgroundColor = UIColor(red: 1, green: 0.6, blue: 0.375, alpha: 1).cgColor
        labelOpenInfo.layer.cornerRadius = 15
        labelOpenInfo.numberOfLines = 0
        labelOpenInfo.textAlignment = .center
        let boldText  = "INFO:\n\n"
        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        labelOpenInfo.font = UIFont(name: "SF Pro Display Light", size: 15)
        let normalText = """
        Brick is wet - raining\n
        Brick is dry - sunny \n
        Brick is hard to see - fog\n
        Brick with cracks - very hot \n
        Brick with snow - snow\n
        Brick is swinging- windy\n
        Brick is gone - no Internet
        """
        let normalString = NSMutableAttributedString(string:normalText)
        attributedString.append(normalString)
        labelOpenInfo.attributedText = attributedString
        return labelOpenInfo
    }()
    
}

