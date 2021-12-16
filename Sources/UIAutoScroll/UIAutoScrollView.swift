//
//  UIAutoScroll.swift
//  AutoScroll
//
//  Created by SeeSo on 2021/12/01.
//  Copyright © 2021 SeeSo. All rights reserved.
//

import UIKit

@objc public class UIAutoScrollView: UIScrollView {
  
  
  // How fast the scroll moves. Default is 1. Bigger number makes the scroll faster.
  private(set) var accelerationFactor : Double = 1
  
 
  // scrollSpeed is amount of scroll distance moved per a second.
  private(set) lazy var scrollSpeed =  self.bounds.height * 0.05
  // 60fps
  private(set) var timeInterval : Double = 1/60
  // Bottom portion of screen where the scroll is activated.
  private(set) var scrollRegion : CGFloat = 0.4
  
  // scrollDistance is minimum distance auto scroll will move at a time.
  private var scrollDistance : Double = 0
  // defaultScrollDistance is calculated using timeInterval and scrollSpeed.
  private var defaultScrollDistance : Double = 0
  
  
  private var isStart : Bool = false
  private var timer : Timer = Timer()
  private var semaphore : DispatchSemaphore = DispatchSemaphore(value: 1)
  private lazy var screenHeight : CGFloat = .zero
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    calcParameter()
    
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    calcParameter()
  }
  
  /// This function can set all parameters at once.
  ///
  ///   - Parameter timeInterval : Cycle time to scroll. (The higher it is, the faster it goes.)
  ///   - Parameter scrollSpeed : scrollSpeed is amount of scroll distance moved per a second.
  ///   - Parameter scrollRegion : Bottom portion of screen where the scroll is activated.
  ///   - Parameter accelerationFactor : How fast the scroll moves. Default is 2. Bigger number makes the scroll faster.
  public func setParameters(timeInterval : Double?, scrollSpeed : Double?, scrollRegion : CGFloat?, accelerationFactor : Double?) {
    
  }
  
  /// This function sets the timeInterval value.
  ///
  ///  - Parameter timeInterval : Cycle time to scroll. (The higher it is, the faster it goes.)
  public func setTimeInterval(timeInterval : Double?){
    if let time = timeInterval {
      self.timeInterval = time
      calcParameter()
    }
  }
  
  /// This function sets the scrollSpeed value.
  ///
  /// - Parameter scrollSpeed : scrollSpeed is amount of scroll distance moved per a second.
  
  public func setScrollSpeed(scrollSpeed : Double?){
    if let speed = scrollSpeed {
      self.scrollSpeed = speed
      calcParameter()
    }
  }
  
  ///  This function sets the scrollRegion value.
  ///
  ///  - Parameter scrollRegion : Bottom portion of screen where the scroll is activated.
  public func setScrollRegion(scrollRegion : CGFloat?){
    if let region = scrollRegion {
      self.scrollRegion = region
    }
  }
  
  /// This function sets the accelerationFactor value.
  ///
  /// - Parameter accelerationFactor : How fast the scroll moves. Default is 2. Bigger number makes the scroll faster.
  public func setaccelerationFactor(accelerationFactor : Double?){
    if let factor = accelerationFactor {
      self.accelerationFactor = factor
    }
  }
  
  /// This function activates the auto scroll function.
  ///
  ///
  public func startAutoScroll(){
    semaphore.wait()
    isStart = true
    startTimer()
    semaphore.signal()
  }
  
  /// This function disables the auto scroll function.
  ///
  ///
  public func stopAutoScroll(){
    semaphore.wait()
    isStart = false
    timer.invalidate()
    semaphore.signal()
  }
  
  /// This function returns whether the auto scroll function is activated.
  ///
  ///
  public func isStarted() -> Bool {
    semaphore.wait()
    let result = isStart
    semaphore.signal()
    return result
  }
  
  /// This function calculates the scroll distance in real time by inserting the gaze coordinates.
  ///
  ///
  public func calcScrollDistance(gazeY : Double){
    if (gazeY >= screenHeight * scrollRegion){
      scrollDistance = defaultScrollDistance * (CGFloat(gazeY)/screenHeight) * accelerationFactor
    }else{
      scrollDistance = -defaultScrollDistance
    }
  }
  
  
  
  private func calcParameter(){
    screenHeight = UIScreen.main.bounds.height
    defaultScrollDistance = scrollSpeed * timeInterval
  }
  
  
  
  @objc func scrolling(){
    var offsetY = self.contentOffset.y + defaultScrollDistance + scrollDistance
    if offsetY > self.contentSize.height - bounds.height {
      timer.invalidate()
      offsetY = self.contentSize.height - bounds.height
      UIView.animate(withDuration: self.timeInterval * 2, delay: 0, options: .curveLinear){
        self.contentOffset.y = offsetY
      }
      
    }else{
      UIView.animate(withDuration: self.timeInterval, delay: 0, options: .curveLinear){
        self.contentOffset.y = offsetY
      }
    }
  }
  
  private func startTimer(){
    timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(scrolling), userInfo: nil, repeats: true)
  }
  
}
