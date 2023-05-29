#if canImport(UIKit)

import Foundation
import UIKit

public struct ClusterViewModel: RandosProviding, ViewSizeProviding {
  
  enum Constants {
    
    static let minViewWidth: Float = 3.0
    static let maxViewWidth: Float = 10.0
    
  }
  
  static func randomPosition(viewSize: CGSize) -> CGPoint {
    guard let randomX = (0...Int(viewSize.width)).randomElement(),
          let randomY = (0...Int(viewSize.height)).randomElement() else { return CGPoint.zero }
    
    let position = CGPoint(x: randomX, y: randomY)
    return position
  }
  
  static func randomSize() -> CGFloat {
    CGFloat(Float.random(in: Constants.minViewWidth..<Constants.maxViewWidth))
  }
  
  static func randomColor() -> UIColor {
    let blue: CGFloat = .random(in: 0...1)
    let red: CGFloat = 0
    return UIColor(red: red, green: .random(in: 0...1), blue: blue, alpha: 1)
  }
  
  public var randos: [Satellite] = []
  var viewWidth: CGFloat
  var viewHeight: CGFloat
  
  public init(viewWidth: CGFloat, viewHeight: CGFloat, numberOfRandos: Int = 0) {
    self.viewWidth = viewWidth
    self.viewHeight = viewHeight
    (0..<numberOfRandos).forEach { _ in addRando() }
  }
  
}

extension ClusterViewModel {
  
  mutating func addRando() {
    let position = ClusterViewModel.randomPosition(viewSize: CGSize(width: viewWidth, height: viewHeight))
    var satellite = Satellite(position: position)
    let size: CGFloat = ClusterViewModel.randomSize()
    satellite.size = CGSize(width: size, height: size)
    satellite.color = ClusterViewModel.randomColor()
    randos.append(satellite)
  }
  
}

#endif
