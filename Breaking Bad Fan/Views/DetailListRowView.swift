//
//  DetailListRowView.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import SwiftUI

/// Displays detail information in a list.
struct DetailListRowView: View {
    
    /// The text to use for the label.
    var label: String
    
    /// The items to display in the list.
    var items: [String]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(label)
                .foregroundColor(.white)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.bottom, 2)
            ForEach(items, id: \.self) { item in
                HStack {
                    Text("∗ ")
                    Text(item)
                }
                .foregroundColor(.white)
                .font(.subheadline)
            }
        }
    }
}

struct DetailListRowView_Previews: PreviewProvider {
    static var previews: some View {
        DetailListRowView(label: "Occupation: ", items: ["Lawyer"])
    }
}
