//
//  SchedulesTab.swift
//  Scheduler-2
//
//  Created by Chakane Shegog on 1/17/22.
//

import UIKit

class SchedulesTab: UITabBarController {
    
    private let dataPersistence = Persistence<Event>(filename: "schedules.plist")
    
    // we need instances of the two tabs in our storyboard
    private lazy var schedulesNavController: UINavigationController = {
        guard let navController = storyboard?.instantiateViewController(withIdentifier: "SchedulesNavController") as? UINavigationController, let schedulesList = navController.viewControllers.first as? ScheduleList else {
            fatalError("could not load nav controller")
        }
        
        // set the dataPersistenc property
        schedulesList.dataPersistence = dataPersistence
        return navController
    }()
    
    // we need access to the UINavigationController
    // then we access the first view controller
    private lazy var completedNavController: UINavigationController = {
        guard let navController = storyboard?.instantiateViewController(withIdentifier: "CompletedNavController") as? UINavigationController, let completedController = navController.viewControllers.first as? CompletedSchedule else {
            fatalError("could not load nav controller")
        }
        
        // set dataPersistence property
        completedController.dataPersistence = dataPersistence
        
        // set our delegate object
        completedController.dataPersistence.delegate = completedController
        return navController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [schedulesNavController, completedNavController]
    }


}
