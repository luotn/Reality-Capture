//
//  PhotogrammetryView.swift
//  Reality Capture
//
//  Created by 罗天宁 on 22/02/2024.
//

import SwiftUI

struct PhotogrammetryView: View {
    
    @State var inputFolder = ""
    @State var outputFolder = ""
    var orders = [String(localized: "Unordered"), String(localized: "Sequential")]
    @State var ordered = String(localized: "Sequential")
    var sensitivities = [String(localized: "Normal"), String(localized: "High")]
    @State var sensitivity = String(localized: "Normal")
    @State var processing = String(localized: "Process!")
    @State var stop = String(localized: "Stop")
    @StateObject var constructor = Constructor.init()
    @State public var progress = 0.0
    @State public var compeleted = false
    
    var body: some View {
        VStack {
            Text("Reality Parser Mobile").padding([.bottom], 5).font(.system(size: 30, weight: .bold, design: .monospaced));
            Label(String(localized: "Input"), systemImage: "1.circle")
                .font(.system(size: 20, weight: .bold, design: .monospaced))
            .padding([.bottom], 1)
            Button(String(localized: "Select Folder")) {
                inputFolder = self.selectInputFolder()
                print(String(localized: "Input Folder selected: ") + inputFolder)
            }.padding([.bottom], 5)
            HStack {
                if (inputFolder != "") {
                    Image(systemName: "checkmark.circle").foregroundColor(Color.green)
                    Text(inputFolder).font(.system(size: 11))
                } else {
                    Image(systemName: "x.circle").foregroundColor(Color.red)
                    Text(String(localized: "Input folder not selected.")).font(.system(size: 11))
                }
            }.padding([.bottom], 2)
            
            Label(String(localized: "Output"), systemImage: "2.circle")
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .padding([.bottom], 1);
            Button(String(localized: "Select Folder")) {
                outputFolder = self.selectOutputFolder()
                print(String(localized: "Output Folder selected: ") + outputFolder)
            }.padding([.bottom], 5)
            HStack {
                if (outputFolder != "") {
                    Image(systemName: "checkmark.circle").foregroundColor(Color.green)
                    Text(outputFolder).font(.system(size: 11))
                } else {
                    Image(systemName: "x.circle").foregroundColor(Color.red)
                    Text(String(localized: "Output location not selected.")).font(.system(size: 11))
                }
            }.padding([.bottom], 2)
            
            Label(String(localized: "Preferences"), systemImage: "3.circle")
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .padding([.bottom], 1)
                .font(.system(size: 9))
            Picker(String(localized: "Order"), selection: $ordered) {
                ForEach(orders, id: \.self) {
                    Text($0)
                }
            }.pickerStyle(.segmented)
            Text(String(localized: "Setting to sequential may speed up computation.")).font(.system(size: 9))
            Picker(String(localized: "Sensitivity"), selection: $sensitivity) {
                ForEach(sensitivities, id: \.self) {
                    Text($0)
                }
            }.pickerStyle(.segmented)
            Text(String(localized: "High if the scanned object does not contain discernible structures, edges or textures."))
                .font(.system(size: 9))
        }
        
        HStack {
            Button(processing) {
                if(inputFolder != "" && outputFolder != "") {
                    do{
                        
                        self.progress = 0.0
                        self.compeleted = false
                        
                        try constructor.process(inputFolder: inputFolder, outputFilename: outputFolder,
                                                ordering: ordered == orders[0] ? "unordered" : "sequential",
                                                sensitivity: sensitivity == sensitivities[0] ? "normal" : "high",
                                                PhotogrammetryView: self)
                    } catch {
                        print((String(describing: error)))
                    }
                }
                if (progress == 1.0) {
                    processing = String(localized: "Done!")
                } else if (progress != 0.0) {
                    processing = String(localized: "Processing...")
                }
            }.disabled(inputFolder == "" || outputFolder == "" || (progress != 0.0 && !self.compeleted))
            Button(stop) {
                constructor.cancelSession()
            }.disabled((progress == 0.0 || self.compeleted))
        }
    }
    
    private func selectInputFolder() -> String{
//        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.folder])
//        documentPicker.delegate = self
//        present(documentPicker, animated: true) {
//            print("done presenting")
//        }
        return "";
    }
    
    private func selectOutputFolder() -> String{
//        let savePanel = NSSavePanel()
//        savePanel.nameFieldStringValue = String(localized: "Untitled.usdz");
//        savePanel.showsResizeIndicator = true;
//        
//        if (savePanel.runModal() == NSApplication.ModalResponse.OK) {
//            let result = savePanel.url
//            
//            if (!result!.path.isEmpty) {
//                
//            }
//            if (result != nil) {
//                return result!.path
//            }
//        }
        return "";
    }
    
    public func updateProgress(fractionComplete: Double) {
        self.progress = fractionComplete
    }
}

//#Preview {
//    PhotogrammetryView()
//}
