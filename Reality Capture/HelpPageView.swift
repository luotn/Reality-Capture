//
//  HelpPageView.swift
//  Reality Capture
//
//  Created by 罗天宁 on 26/04/2022.
//

import SwiftUI

/// This method implements a tabbed tutorial view that the app displays when the user presses the help button.
struct HelpPageView: View {
    var body: some View {
        ZStack {
            Color(red: 0, green: 0, blue: 0.01, opacity: 1.0)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            TabView {
                ObjectHelpPageView()
                PhotographyHelpPageView()
                EnvironmentHelpPageView()
                WorkflowHelpPageView()
            }
            .tabViewStyle(PageTabViewStyle())
        }
        .navigationTitle(String(localized: "Scanning Info"))
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TutorialPageView: View {
    let pageName: String
    let imageName: String
    let imageCaption: String
    let pros: [String]
    let cons: [String]
    
    var body: some View {
        GeometryReader { geomReader in
            VStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 0.9 * geomReader.size.width)
                
                Text(imageCaption)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
                    // Pad the view a total of 25% (12.5% on each side).
                    .padding(.horizontal, geomReader.size.width / 12.5)
                    .multilineTextAlignment(.center)
                
                Divider()
                
                ProConListView(pros: pros, cons: cons)
                    .padding()
                
                Spacer()
            }
            .frame(width: geomReader.size.width, height: geomReader.size.height)
        }
        .navigationBarTitle(pageName, displayMode: .inline)
    }
}

struct ObjectHelpPageView: View {
    var body: some View {
        TutorialPageView(pageName: String(localized: "Object Characteristics"),
                         imageName: "ObjectCharacteristicsTips",
                         imageCaption: String(localized: "Opaque, matte objects with varied surface textures scan best.")
                            + String(localized: " Capture all sides of your object in a series of orbits.\n"),
                         pros: [String(localized: "Varied Surface Texture"),
                                String(localized: "Non-reflective, matte surface"),
                                String(localized: "Solid, opaque")],
                         cons: [String(localized: "Uniform Surface Texture"),
                                String(localized: "Shiny"),
                                String(localized: "Transparent, transluscent"),
                                String(localized: "Thin structures")])
    }
}

struct PhotographyHelpPageView: View {
    var body: some View {
        TutorialPageView(pageName: String(localized: "Photography Tips"),
                         imageName: "PhotographyTips",
                         imageCaption: String(localized: "Adjacent shots should have 70% overlap or more for alignment.")
                            + String(localized: " Each object will need a different number of photos, but aim for between 20-200."),
                         pros: [String(localized: "Capture all sides of an object"),
                                String(localized: "Capture between 20-200 images"),
                                String(localized: "70%+ overlap between photos"),
                                String(localized: "Consistent focus and image quality")],
                         cons: [String(localized: "Parts of object out of frame"),
                                String(localized: "Inconsistent camera settings")])
    }
}

struct EnvironmentHelpPageView: View {
    var body: some View {
        TutorialPageView(pageName: String(localized: "Environment Characteristics"),
                         imageName: "EnvironmentTips",
                         imageCaption: String(localized: "Make sure you have even, good lighting and a stable environment for scanning.")
                            + String(localized: " If scanning outdoors, cloudy days work best.\n"),
                         pros: [String(localized: "Diffuse lighting"),
                                String(localized: "Space around intended object")],
                         cons: [String(localized: "Sunny, directional lighting"),
                                String(localized: "Inconsistent shadows")])
    }
}

struct WorkflowHelpPageView: View {
    var body: some View {
        TutorialPageView(pageName: String(localized: "Workflow Tips"),
                         imageName: "WorkflowTips",
                         imageCaption: String(localized: "Use this app to capture image, depth and gravity data for photogrammetry session.")
                            + String(localized: " Works best with IOS devices with LiDAR sensor and Macs with Apple Silicon chip.\n"),
                         pros: [String(localized: "iPhone with LiDAR sensor"),
                                String(localized: "Mac with Apple Silicon chip")],
                         cons: [String(localized: "Damaged/Malfunction Camera"),
                                String(localized: "Intel Mac with less than 16GB RAM and/or without discrete AMD GPU and/or VRAM less than 4GB")])
    }
}

struct ProConListView: View {
    let pros: [String]
    let cons: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(pros, id: \.self) { pro in
                PositiveLabel(pro)
            }
            PositiveLabel("HIDDEN SPACER").hidden()
            ForEach(cons, id: \.self) { con in
                NegativeLabel(con)
            }
        }
    }
}

/// This label uses the `.secondary` color for its text and has a green checkmark icon. It's used to
/// denote good capture practices.
struct PositiveLabel: View {
    let text: String
    
    init(_ text: String) { self.text = text }
    
    var body: some View {
        Group {
            Label(title: {
                Text(text)
                    .foregroundColor(.secondary)
            }, icon: {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(Color.green)
            })
        }
    }
}

/// This label uses the `.secondary` color for its text and has a red X icon. It's used to denote bad
/// capture practices.
struct NegativeLabel: View {
    let text: String
    
    init(_ text: String) { self.text = text }
    
    var body: some View {
        Group {
            Label(title: {
                Text(text)
                    .foregroundColor(.secondary)
            }, icon: {
                Image(systemName: "xmark.circle")
                    .foregroundColor(Color.red)
            })
        }
    }
}

#if DEBUG
struct HelpPageView_Previews: PreviewProvider {
    static var previews: some View {
        HelpPageView()
    }
}
#endif // DEBUG
