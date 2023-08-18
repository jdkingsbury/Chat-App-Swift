//
//  DarkModeView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 8/16/23.
//

import SwiftUI

struct DarkModeView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            List {
                ForEach(DarkModeOptionsViewModel.allCases) { option in
                    Button {
                        
                    } label: {
                        Text(option.title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.primaryText)
                    }
                }
            }
        }
        .navigationTitle("Dark mode")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(Color.theme.primaryText, Color.theme.secondaryBackground)
                    .onTapGesture {
                        Task {
                            dismiss()
                        }
                    }
            }
        }
    }
}

struct DarkModeView_Previews: PreviewProvider {
    static var previews: some View {
        DarkModeView()
    }
}
