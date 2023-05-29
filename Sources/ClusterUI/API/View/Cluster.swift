#if canImport(UIKit)

import Foundation
import UIKit

final public class Cluster: UIView {
  
  public var viewModel: ClusterViewModel? = nil {
    didSet {
      updateViews()
    }
  }
  
  public var scale: CGFloat = 1.0
  
  private var satelliteViews: [UIView] = []
  private var satelliteView: UIView {
    let view = UIView()
    view.backgroundColor = .blue
    view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    return view
  }

}

extension Cluster {
  
  public func scale(by value: CGFloat) {
    scale = value
    updateViews()
  }
  
  func updateViews() {
    guard let viewModel = viewModel else { return }
    guard satelliteViews.count == viewModel.randos.count else {
      removeSatellites()
      
      satelliteViews = (0..<viewModel.randos.count).map { index in
        let view = satelliteView
        let position = CGPoint(x: viewModel.randos[index].position.x,
                               y: viewModel.randos[index].position.y)
        view.frame.size.width = viewModel.randos[index].size.width
        view.frame.size.height = viewModel.randos[index].size.height
        view.layer.cornerRadius = viewModel.randos[index].size.width / 2
        view.center = CGPoint(x: position.x * scale, y: position.y * scale)
        
        view.backgroundColor = viewModel.randos[index].color

        return view
      }
      
      addSatellites(views: satelliteViews)
      return
    }
    
    (0..<viewModel.randos.count).forEach { index in
      let view = satelliteViews[index]
      let posX = viewModel.randos[index].position.x
      let posY = viewModel.randos[index].position.y
      view.center = CGPoint(x: posX * scale, y: posY * scale)
    }
  }
  
  private func addSatellites(views: [UIView]) {
    views.forEach { satellite in
      addSubview(satellite)
    }
  }
  
  private func removeSatellites() {
    satelliteViews.forEach { satellite in
      satellite.removeFromSuperview()
    }
  }
  
}

#endif
