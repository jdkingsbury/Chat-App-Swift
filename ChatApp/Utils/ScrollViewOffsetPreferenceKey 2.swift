//
//  ScrollViewOffsetPreferenceKey.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 8/8/23.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
  static var defaultValue = CGFloat.zero

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value += nextValue()
  }
}
