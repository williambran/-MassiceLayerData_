//
//  PostLocalDataSource.swift
//  data
//
//  Created by wito on 22/12/22.
//

import Foundation
import domain

public protocol PostLocalDataSourceInterface {
    func getCachedPosts(handler: @escaping ([PostEntity]) -> ())
}
