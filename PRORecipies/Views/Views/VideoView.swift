//
//  VideoView.swift
//  PRORecipies
//
//  Created by Anvar on 18.04.2023.
//

import SwiftUI
import WebKit

struct VideoView: View {
    @Environment(\.dismiss) var dismiss
    var meal: Meal

    var body: some View {
        NavigationView {
            YoutubeVideoView(youtubeLink: meal.youTubeLink?.makeYoutubeLink() ?? "")
                .toolbar {
                    Button {
                        dismiss()
                    } label: {
                        Text("Close")
                    }
                }
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(meal: Meals.dummyData1.meals[0])
    }
}
