//
//  PageViewController.swift
//  UIPageViewController
//
//  Created by Yura Menschikov on 12/2/18.
//  Copyright © 2018 Yura Menschikov. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var cars = [CarsHelper]()
    let ferrari = UIImage(named: "f9953545bd1bdee84ee5081196eafbe2")
    let bmw = UIImage(named: "16499")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Cars"
        
        let firstCar = CarsHelper.init(name: "BMW", image: bmw!)
        let secondCar = CarsHelper.init(name: "Ferrari", image: ferrari!)
        
        cars.append(firstCar)
        cars.append(secondCar)
    }
    
    //MARK: - Create VC
    lazy var arrayCarVC: [CarViewController] = {
       var carsVC = [CarViewController]()
        
        for car in cars {
            carsVC.append(CarViewController(carWith: car))
        }
        
        
        
        return carsVC
    }()
    
    //MARK: - init UIPageVIewControler
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = UIColor.green
        self.dataSource = self
        self.delegate = self
        setViewControllers([arrayCarVC[0]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CarViewController else {return nil}
        if let index = arrayCarVC.index(of: viewController) {
            if index > 0 {
                return arrayCarVC[index - 1]
            }
        }
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CarViewController else {return nil}
        if let index = arrayCarVC.index(of: viewController) {
            if index < cars.count - 1 {
                return arrayCarVC[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return cars.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
