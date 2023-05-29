#if canImport(UIKit)

import Foundation
import UIKit

protocol PositionProviding {
  
  var position: CGPoint { get }
  
}

protocol SizePoviding {
  
  var size: CGSize { get }
  
}

protocol ColorProviding {
  
  var color: UIColor { get }
  
}

protocol TextProviding {
  
  var text: String? { get }
  
}

protocol RandosProviding {
  
  var randos: [Satellite] { get }
  
}

protocol ViewSizeProviding {

  var viewWidth: CGFloat { get }
  var viewHeight: CGFloat { get }
  
}

public protocol ScalableProviding: AnyObject {
  
  var view: UIView! { get set }
  var transOrbit: Cluster { get }
  var widthConstraint: NSLayoutConstraint? { get set }
  var heightConstraint: NSLayoutConstraint? { get set }
  
}

public extension ScalableProviding {
  
  func setTransConstraint(scale: CGFloat) {
    guard let view = view else { return }
    
    if let width = widthConstraint,
       let height = heightConstraint {
      NSLayoutConstraint.deactivate([width, height])
    }
    
    let width = transOrbit.width(view: view, scale: scale)
    let height = transOrbit.height(view: view, scale: scale)
    NSLayoutConstraint.activate([width, height])
    
    widthConstraint = width
    heightConstraint = height
  }
  
  func touchBegan(location: CGPoint, viewSize: CGSize, effectType: EffectType) {
    let anchorPoint: CGPoint
    
    switch effectType {
    case .sunrings:
      anchorPoint = location.focusAnchor(viewSize: viewSize,
                                      effectType: effectType,
                                      magnitude: Constants.AnchorMagnitude.ring)
      transOrbit.transform = transOrbit.transform.rotated(by: 0.05)
    case .firework:
      anchorPoint = location.focusAnchor(viewSize: viewSize,
                                      effectType: effectType,
                                      magnitude: Constants.AnchorMagnitude.ray)
      setTransConstraint(scale: Constants.transMaxScale)
      transOrbit.scale(by: Constants.transMaxScale)
    case .slide:
      anchorPoint = location.focusAnchor(viewSize: viewSize,
                                      effectType: effectType,
                                      magnitude: Constants.AnchorMagnitude.swirl)
      transOrbit.transform = transOrbit.transform.rotated(by: 0.05)
      setTransConstraint(scale: Constants.transMaxScale)
      transOrbit.scale(by: Constants.transMaxScale)
    }
  
    transOrbit.layer.anchorPoint = anchorPoint
  }
  
  func touchMoved(location: CGPoint, viewSize: CGSize, effectType: EffectType) {
    let anchorPoint: CGPoint
    
    switch effectType {
    case .sunrings:
      anchorPoint = location.focusAnchor(viewSize: viewSize,
                                      effectType: effectType,
                                      magnitude: Constants.AnchorMagnitude.ring)
    case .firework:
      anchorPoint = location.focusAnchor(viewSize: viewSize,
                                      effectType: effectType,
                                      magnitude: Constants.AnchorMagnitude.ray)
    case .slide:
      anchorPoint = location.focusAnchor(viewSize: viewSize,
                                      effectType: effectType,
                                      magnitude: Constants.AnchorMagnitude.swirl)
    }
    
    transOrbit.layer.anchorPoint = anchorPoint
    
  }
  
  func touchEnded(effectType: EffectType) {
    switch effectType {
    case .sunrings:
      transOrbit.transform = CGAffineTransform(rotationAngle: 0.0)
    case .firework:
      setTransConstraint(scale: 1.0)
      transOrbit.scale(by: 1.0)
    case .slide:
      transOrbit.transform = CGAffineTransform(rotationAngle: 0.0)
      setTransConstraint(scale: 1.0)
      transOrbit.scale(by: 1.0)
    }
    
    transOrbit.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
  }
  
}

#endif
