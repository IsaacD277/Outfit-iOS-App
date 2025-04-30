//
//  SettingsView.swift
//  Outfitter
//
//  Created by Isaac D2 on 4/29/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Spacer()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text("")
            Text("This page will have settings at some point. I'm not currently sure what settings there will be, but they will exist.")
                .multilineTextAlignment(.center)
            Text("")
            Text("Go visit isaacd2.com in the meantime.")
            Text("Subscribe to my newsletter.")
            Text("Thanks! ❤️")
            Spacer()
            Text("Version 0.1.0")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
