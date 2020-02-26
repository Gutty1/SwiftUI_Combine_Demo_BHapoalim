//
//  ImageView.swift
//  HapoalimSwiftUIRX
//
//  Created by Arie Guttman on 07/01/2020.
//  Copyright © 2020 Arie Guttman. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    var imageString: String
        
    @State private var drag: CGSize = .zero
    
    var body: some View {
        //        Text("Hello, World!")
        
        ZStack (alignment: .bottomLeading) {
            Image(imageString)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .cornerRadius(20)
                .shadow(radius: 10)
            Text("Baby Yoda")
                .foregroundColor(.white)
                .padding()

        }
        .offset(drag)
        .animation(.linear(duration: 2))
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.drag = value.translation
            }
            .onEnded({ _ in
                self.drag = .zero
            }))
        
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageString: "bYoda")
    }
}


