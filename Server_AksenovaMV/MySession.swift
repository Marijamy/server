//
//  MySession.swift
//  Server_AksenovaMV
//
//  Created by Klepa on 31.10.2021.
//

import Foundation
import UIKit

final class MySession {

    private init() {}

    static let shared = MySession()

    var token: String = ""
    var userId: Int = 0

}
