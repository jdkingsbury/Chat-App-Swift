//
//  SelectedGroupMembersView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 7/24/23.
//

import SwiftUI

struct SelectedGroupMembersView: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach((0 ... 5), id: \.self) { _ in
                    ZStack(alignment: .topTrailing) {
                        VStack {
                            Image("batman")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .shadow(color: .gray, radius: 4, y: 2)
                            
                            Text("Bruce Wayne")
                                .font(.system(size: 11))
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 64)
                        
                        Button {
                            print("Deselect user")
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .padding(4)
                        }
                        .background(Color(.systemGray6))
                        .foregroundColor(.black)
                        .clipShape(Circle())

                        
                    }
                }
            }
        }
        .animation(.spring(), value: 0.5)
        .padding()
    }
}

struct SelectedGroupMembersView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedGroupMembersView()
    }
}
