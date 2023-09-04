//
//  PrivacyView.swift
//  ChatApp
//
//  Created by Jerry Kingsbury on 9/4/23.
//

import SwiftUI

struct PrivacyView: View {
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(PrivacyOptionsViewModel.allCases) { viewModel in
                        Text(viewModel.title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.primaryText)
                    }
                }
            }
        }
        .navigationTitle("Privacy & safety")
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

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
