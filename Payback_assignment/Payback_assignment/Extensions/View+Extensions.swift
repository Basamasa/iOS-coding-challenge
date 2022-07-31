//
//  View+Extensions.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 27.07.22.
//

import SwiftUI

extension View {
    func cardStyle() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
            .padding(.all, 10)
    }
}
