import Foundation
import CoreFoundation

extension CGPoint {
  
  public func focusAnchor(viewSize: CGSize, effectType: EffectType, magnitude: CGPoint) -> CGPoint {
    let normalizedPoint = normalizedPosition(viewSize: viewSize)
    let anchorPoint = scale(point: normalizedPoint, magnitude: magnitude)

    let focus: CGPoint
    switch effectType {
    case .sunrings:
      focus = CGPoint(x: anchorPoint.y, y: 1.0 - anchorPoint.x)
    case .firework:
      focus = CGPoint(x: anchorPoint.x, y: anchorPoint.y)
    case .slide:
      let rotatedPoint = CGPoint(x: anchorPoint.x, y: anchorPoint.y)
        .rotatePoint(origin: CGPoint(x: 0.5, y: 0.5), byDegrees: -55.0)
      focus = CGPoint(x: rotatedPoint.x, y: 1.0 - rotatedPoint.y)
    }

    return focus
  }
  
  private func normalizedPosition(viewSize: CGSize) -> CGPoint {
    CGPoint(x: x / viewSize.width, y: y / viewSize.height)
  }
  
  private func scale(point: CGPoint, magnitude: CGPoint) -> CGPoint {
    CGPoint(x: scale(value: point.x, magnitude: magnitude.x),
            y: scale(value: point.y, magnitude: magnitude.y))
  }
  
  private func scale(value: CGFloat, magnitude: CGFloat) -> CGFloat {
    (value - 0.5) * magnitude + 0.5
  }
  
  private func rotatePoint(origin: CGPoint, byDegrees: CGFloat) -> CGPoint {
    let dx = x - origin.x
    let dy = y - origin.y
    let radius = sqrt(dx * dx + dy * dy)
    let azimuth = atan2(dy, dx) // in radians
    let newAzimuth = azimuth + byDegrees * CGFloat(.pi / 180.0)// convert it to radians
    let x = origin.x + radius * cos(newAzimuth)
    let y = origin.y + radius * sin(newAzimuth)
    return CGPoint(x: x, y: y)
  }
  
}

