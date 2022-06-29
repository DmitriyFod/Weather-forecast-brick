

import SnapshotTesting
import XCTest

@testable import WeatherBrick

@available(iOS 13.0, *)
class SnapShotTests: XCTestCase {
    var vc: ViewController!
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        vc.loadViewIfNeeded()
        
        
    }
    override func tearDown() {
            vc = nil
        }
        
        func testGetData() {
            let expectation = expectation(description: "Expectation in " + #function)
            
            vc.locationManager
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                expectation.fulfill()
            })
            waitForExpectations(timeout: 3, handler: nil)
            if let resultWeatherDescription = self.vc.weather.text {
                XCTAssertNotEqual(resultWeatherDescription, "Clouds")
            }
            if let resultWeatherDescription = self.vc.temperature.text {
                XCTAssertNotEqual(resultWeatherDescription, "16")
            }
            if let resultWeatherDescription = self.vc.cityCountry.text {
                XCTAssertNotEqual(resultWeatherDescription, "Страна, город")
            }
        }
        
        func testSnapshotStartScreen() {
            isRecording = false
            assertSnapshot(matching: vc, as: .image)
            assertSnapshot(matching: vc, as: .image(on: .iPhone8))
            assertSnapshot(matching: vc, as: .image(on: .iPhoneX))
        }

        func testSnapshotOpenInfo() {
            let expectation = expectation(description: "Expectation in " + #function)
            vc.locationManager
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                expectation.fulfill()
            })
            waitForExpectations(timeout: 3, handler: nil)
            vc.openInfoView()
            isRecording = false
            assertSnapshot(matching: vc, as: .image)
            assertSnapshot(matching: vc, as: .image(on: .iPhone8))
            assertSnapshot(matching: vc, as: .image(on: .iPhoneX))
        }
    }

