//
//  CheckboxToggleStyle.swift
//  Project_#6
//
//  Created by Jansen & Gelareh on 2023-03-02.
//

import Foundation
import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }){
            HStack {
                configuration.label
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
            }
        }
    }
}
