#if canImport(UIKit)

import Foundation
import UIKit

public struct Satellite: PositionProviding, SizePoviding, ColorProviding, TextProviding {

  public var position: CGPoint
  public var size: CGSize
  public var color: UIColor
  public var text: String? = nil
  
  public init(position: CGPoint, size: CGSize = .zero, color: UIColor = .blue) {
    self.position = position
    self.size = size
    self.color = color
  }
  
}

#endif

