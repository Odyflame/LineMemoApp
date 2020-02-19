//
//  LiMeMo.swift
//  LineMemoApp
//
//  Created by apple on 2020/02/11.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Foundation

struct LIMeMo {
    
    var MeMoTitle: String?
    var MeMoContent: String?
    var MeMoImage: [UIImage] = []
    var MeMoDate: String?
    
}

//singleTon으로 메모들을 리스트로 앱 내 어디서든 쓸 수 있게 구현
class LiMeMoList {
    static let shared = LiMeMoList()
    
    var memoList: [LIMeMo] = []
}
