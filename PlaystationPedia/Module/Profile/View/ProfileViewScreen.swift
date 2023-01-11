//
//  ProfileViewScreen.swift
//  PlaystationPedia
//
//  Created by rzamau on 13/10/22.
//

import SwiftUI

struct ProfileViewScreen: View {
    @ObservedObject var presenter: ProfilePresenter

    var body: some View {
        VStack(alignment: .center) {
            Image("PhotoProfile")
                .resizable()
                .clipShape(Circle())
                .shadow(radius: 10)
                .scaledToFit()
                .overlay(Circle().stroke(Color.green, lineWidth: 5))
                .frame(width: 150, height: 150)
            Text(presenter.name).font(.system(size: 32))
                .bold()
            Text(presenter.email).font(.system(size: 18))
            Button("Edit Profile") {
                presenter.showingSheet.toggle()
            }
            .sheet(isPresented: $presenter.showingSheet, onDismiss: {
                presenter.synchronize()
                presenter.getProfile()
            }, content: {
                VStack {
                    TextField("Name", text: $presenter.name)
                    TextField("Email", text: $presenter.email).keyboardType(.emailAddress)
                    Button("Save") {
                        presenter.saveProfile()
                        presenter.synchronize()
                        presenter.showingSheet.toggle()
                    }
                }.presentationDetents([.height(200)]).padding(20)
            })
        }.navigationTitle("Profile").onAppear {
            presenter.synchronize()
            presenter.getProfile()
        }
    }
}

struct ProfilViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewScreen(presenter: ProfilePresenter())
    }
}
