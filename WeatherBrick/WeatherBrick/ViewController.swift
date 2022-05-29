//
//  Created by Volodymyr Andriienko on 11/3/21.
//  Copyright © 2021 VAndrJ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import NVActivityIndicatorView
import Foundation
@available(iOS 13.0, *)
class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var rock: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weather: UILabel!
    @IBOutlet weak var cityCountry: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var locationLabel: UIImageView!
    @IBOutlet weak var searchLabel: UIImageView!
    var gradientLayer = CAGradientLayer()
    let buttonHide = buttonH().buttonToHide
    let labelInfo = LabelInfo().labelOpenInfo
    let darkInfo = LabelInfo().darkLabelInfo
    enum State {
        case close
        case open
    }
    var state : State = .close
    @IBAction func infoPressed(_ sender: Any) {
        infoView()
    }
    let apiKey = "00431c949d9475cc6765cb11c5a3b7c8"
    var lat : Double = 0.0
    var lon : Double = 0.0
    var activityIndicator : NVActivityIndicatorView!
    var locationManager = CLLocationManager()
    class buttonH : UIButton {
        var buttonToHide: UIButton = {
            let buttonToHide = UIButton()
            buttonToHide.layer.backgroundColor = UIColor(red: 1, green: 0.6, blue: 0.375, alpha: 1).cgColor
            buttonToHide.frame = CGRect(x: 140, y: 575, width: 115, height: 31)
            buttonToHide.titleLabel?.textColor = UIColor.orange
            buttonToHide.layer.cornerRadius = buttonToHide.frame.height / 2
            buttonToHide.clipsToBounds = true
            buttonToHide.layer.borderWidth = 1
            buttonToHide.isUserInteractionEnabled = true
            buttonToHide.setTitle("Hide", for: .normal)
            buttonToHide.addTarget(ViewController.buttonH.self, action: #selector(closeInfoView), for: .touchUpInside)
            return buttonToHide
        }()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let indicatorSize: CGFloat = 70
        let indicatorFrame = CGRect(x: 245, y: 600, width: indicatorSize, height: indicatorSize)
        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.darkGray, padding: 4.0)
        view.addSubview(activityIndicator)
        infoButton.layer.cornerRadius = 15
        infoButton.layer.masksToBounds = true
        locationManager.requestWhenInUseAuthorization()
        activityIndicator.startAnimating()
        if(CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
        let string = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric") ?? URL(string: "Error")
        AF.request(string ?? "https://api.openweathermap.org/data/2.5/weather?lat=15&lon=60&appid=\(apiKey)&units=metric").responseJSON {
            response in
            if let responseStr = response.value {
                let jsonResponse = JSON(responseStr)
                let jsonWeather = jsonResponse["weather"].array![0]
                let jsonTemp = jsonResponse["main"]
                let iconId = jsonWeather["id"].intValue
                self.cityCountry.text = jsonResponse["name"].stringValue
                self.weather.text = jsonWeather["main"].stringValue
                switch iconId {
                case 0...200 :
                    self.rock.image = UIImage(named: "image_stone_cracks")
                case 200...599 :
                    self.rock.image = UIImage(named: "image_stone_wet")
                case 600...699 :
                    self.rock.image = UIImage(named: "image_stone_snow")
                case 700...762 :
                    self.rock.image = UIImage(named: "image_stone_normal")
                    self.animationFog()
                case 763...799 :
                    self.rock.image = UIImage(named: "image_stone_normal")
                    self.animationWind()
                case 800...900 :
                    self.rock.image = UIImage(named: "image_stone_normal")
                default:
                    self.rock.image = UIImage(named: "image_stone_normal")
                }
                self.temperature.text = "\(Int(round(jsonTemp["temp"].doubleValue)))°"
            }
            self.activityIndicator.stopAnimating()
            
        }
    }
    func animationWind () {
        UIView.animateKeyframes(withDuration: 3, delay: 0.5, options: [.repeat, .autoreverse], animations: {
            self.rock.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
            self.rock.transform = CGAffineTransform(rotationAngle: 0.1)
        }, completion: nil)
    }
    func animationFog () {
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: [.calculationModeLinear], animations: {
            self.rock.alpha = 0.4
        }, completion: nil)
    }
    func infoView() {
        switch state {
        case .close:
            closeInfoView()
        case .open:
            openInfoView ()
        }
    }
    func openInfoView () {
        self.rock.isHidden = true
        temperature.isHidden = true
        cityCountry.isHidden = true
        weather.isHidden = true
        infoButton.isHidden = true
        searchLabel.isHidden = true
        locationLabel.isHidden = true
        labelInfo.isHidden = false
        darkInfo.isHidden = false
        
        
        let parent = self.view!
        parent.addSubview(darkInfo)
        darkInfo.translatesAutoresizingMaskIntoConstraints = false
        darkInfo.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.75).isActive = true
        darkInfo.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.45).isActive = true
        darkInfo.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 49).isActive = true
        darkInfo.topAnchor.constraint(equalTo: parent.topAnchor, constant: 220).isActive = true
    
        parent.addSubview(labelInfo)
        labelInfo.translatesAutoresizingMaskIntoConstraints = false
        labelInfo.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.73).isActive = true
        labelInfo.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.45).isActive = true
        labelInfo.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 49).isActive = true
        labelInfo.topAnchor.constraint(equalTo: parent.topAnchor, constant: 220).isActive = true
        state = .close
        parent.addSubview(buttonHide)
    }

    @objc func closeInfoView () {
        
        rock.isHidden = false
        temperature.isHidden = false
        cityCountry.isHidden = false
        weather.isHidden = false
        infoButton.isHidden = false
        labelInfo.isHidden = true
        darkInfo.isHidden = true
        state = .open
    }
}

