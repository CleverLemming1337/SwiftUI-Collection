//
//  Components.swift
//  SwiftUI Collection
//
//  Created by Leonard Fekete on 17.07.24.
//

import SwiftUI

// MARK: Card
public struct Card<Front: View>: View {
    let front: Front
    let material: Material
    
    public init(material: Material = .ultraThinMaterial, @ViewBuilder front: @escaping () -> Front) {
        self.front = front()
        self.material = material
    }
    
    public var body: some View {
        front
            .padding()
            .background(material)
            .cornerRadius(10)
    }
}

// MARK: TwoSideCard
public struct TwoSideCard<Front: View, Back: View>: View {
    @State private var isFlipped = false
    let front: Front
    let back: Back
    let material: Material
    
    public init(material: Material = .ultraThinMaterial, @ViewBuilder front: @escaping () -> Front, @ViewBuilder back: @escaping () -> Back) {
        self.front = front()
        self.back = back()
        self.material = material
    }
    
    public var body: some View {
        ZStack {
            if isFlipped {
                back
                    .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 0, y: 1, z: 0)
                    )
            } else {
                front
            }
        }
        .padding()
        .background(material)
        .cornerRadius(10)
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .onTapGesture {
            withAnimation {
                isFlipped.toggle()
            }
        }
    }
}

