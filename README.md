# UIAutoScroll

[![swift-version](https://img.shields.io/badge/swift-5.5-blue.svg)](https://github.com/apple/swift)
[![xcode-version](https://img.shields.io/badge/xcode-13.1-brightgreen)](https://developer.apple.com/xcode/)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://en.wikipedia.org/wiki/MIT_License)
[![Swift-package-manager](https://img.shields.io/badge/SwiftPM-compatible-brightgreen)](https://github.com/apple/swift-package-manager)

## Introduction

`UIAutoScroll` supports natural scrolling through the gaze. You must use [SeeSo](https://seeso.io) to use gaze coordinates.

## Example

[Example Project](https://github.com/visualcamp/UIAutoScrollExample)
![preview](https://github.com/visualcamp/UIAutoScrollExample/blob/main/resource/preview.gif)

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. To use `UIAutoScroll` with Swift Package Manager, add it to `dependencies` in your `Package.swift`

```swift
dependencies: [
    .package(url: "https://github.com/visualcamp/UIAutoScroll.git")
]
```
  
## Usage

Firstly, import `UIAutoScroll`.

```swift
import UIAutoScroll
```
  
### Initialization

Then, there are two ways you can create `UIAutoScrollView`

- By storyboard, changing class of `UIScrollView` to `UIAutoScrollview`.

  _**Note:** Set `Module` to `UIAutoScroll`._  

- By code, using an initializer.

```swift
UIAutoScrollView(frame: frame)
```


### Control

Start Auto Scrolling.

```swift
autoScrollView.startAutoScroll()
```


Stop Auto Scrolling. 

```swift
autoScrollView.stopAutoScroll()
```

Adjusting the scroll distance through gaze coordinates.

```swift 
autoScrollView.calcScrollDistance(gazeY : gazeInfo.y)
```


### Change properties

  - accelerationFactor: How fast the scroll moves. Default is 1. A bigger number makes the scroll faster.
  
  - scrollSpeed: scrollSpeed is the amount of scroll distance moved per second.

  - timeInterval: Default is 60fps.
  
  - scrollRegion: Bottom portion of the screen where the scroll is activated.

```Swift
setParameters(timeInterval : 30, scrollSpeed : 0.4, scrollRegion : 0.5, accelerationFactor : 1.5) {
```


## License

The MIT License (MIT)

Copyright (c) 2021 [SeeSo](https://seeso.io)
