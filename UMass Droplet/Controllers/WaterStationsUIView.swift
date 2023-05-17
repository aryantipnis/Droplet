//
//  WaterStationsUIView.swift
//  UMass Droplet
//
//  Created by Utthkarsh Kottali  on 5/16/23.
//

import SwiftUI
import SafariServices

struct WaterStationsUIView: View {
    
  private var venue: Venue?
  @State private var showForm = false
    
  init(venue: Venue?) {
    self.venue = venue
  }
  var body: some View {
    VStack {
          if let venue = venue {
              HStack {
                                  Spacer()
                                  Button(action: { showForm = true
                                  }) {
                                    Text("Report").font(.headline)
                                      .foregroundColor(.blue)
                                  }
                                  .padding(.trailing, 16)
                                  .sheet(isPresented: $showForm) {
                                                          SafariView(url: URL(string: "https://forms.gle/TcJiLk8CFMuja1vR8")!)
                                                      }
                  
                        }
            Text(venue.title ?? "")
              .font(.title)
              .bold()
              .padding()
              
            ScrollView {
              VStack(spacing: 16) {
                ForEach(venue.stationList, id: \.stationID) { station in
                  VStack(alignment: .leading, spacing: 8) {
                    Text("Floor:")
                      .font(.headline)
                      .frame(width: 80, alignment: .leading)
                    Text("\(station.floor ?? -1 == -1 ? 0 : station.floor ?? 0)")
                      .font(.subheadline)
                      .foregroundColor(.gray)
                      .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Status:")
                      .font(.headline)
                      .frame(width: 80, alignment: .leading)
                    Text("\(station.status ?? "")")
                      .font(.subheadline)
                      .foregroundColor(.gray)
                      .frame(maxWidth: .infinity, alignment: .leading)
                    if let notes = station.notes, !notes.isEmpty {
                                      Text("Area:")
                                        .font(.headline)
                                        .frame(width: 80, alignment: .leading)
                                      Text(notes)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                  }
                  .padding()
                  .background(Color.white)
                  .cornerRadius(8)
                  .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                }
              }
              .padding()
            }
          } else {
            Text("No venue available")
          }
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        // No update needed
    }
}

struct WaterStationsUIView_Previews: PreviewProvider {
  static var previews: some View {
    WaterStationsUIView(venue: AccountManager.shared.venue)
  }
}
