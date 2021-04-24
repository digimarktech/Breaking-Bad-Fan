//
//  DetailRowView.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import SwiftUI

/// Displays character information in a horizontal row.
struct DetailRowView: View {
    
    /// The text to use for the label.
    var label: String
    
    /// The value of the label.
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.white)
                .font(.subheadline)
                .fontWeight(.medium)
            Text(value)
                .foregroundColor(.white)
                .font(.subheadline)
        }
    }
}

struct DetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        DetailRowView(label: "Real name: ", value: "Bob Odenkirk")
    }
}
