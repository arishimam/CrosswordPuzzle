//
//  ProfileView.swift
//  Crossword
//
//  Created by csuftitan on 5/19/23.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var emailAddress = ""

    var body: some View {
        Form {
            HStack {
                Spacer()
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                Spacer()
            }

            Section(header: Text("Personal Information")) {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email Address", text: $emailAddress)
            }
            
            Section {
                Button(action: {
                    print("Save changes")
                }) {
                    Text("Save Changes")
                }
            }
        }
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}
