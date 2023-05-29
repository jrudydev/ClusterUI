#if canImport(UIKit)

import Foundation
import UIKit

extension UIView {
  
  func width(view: UIView, scale: CGFloat) -> NSLayoutConstraint {
    NSLayoutConstraint(item: self,
                       attribute: .width,
                       relatedBy: .equal,
                       toItem: view,
                       attribute: .width,
                       multiplier: scale,
                       constant: 0)
  }
  
  func height(view: UIView, scale: CGFloat) -> NSLayoutConstraint {
    NSLayoutConstraint(item: self,
                       attribute: .height,
                       relatedBy: .equal,
                       toItem: view,
                       attribute: .height,
                       multiplier: scale,
                       constant: 0)
  }
  
}

#endif
