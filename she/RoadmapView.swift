//  Created by Kashvi on 8/16/23.

import Foundation
import SwiftUI
import UIKit
import UniformTypeIdentifiers
class ImagePickerViewModel: ObservableObject {
    @Published var isImagePickerDisplayed: Bool = false
    @Published var selectedImage: UIImage? = nil
}

struct RoadmapView: View {
    @StateObject var imagePickerViewModel = ImagePickerViewModel()
    @State var draggedOffset = CGSize.zero
    @State var images: [UIImage] = []
    var image: Binding<UIImage?> {
        Binding<UIImage?>(
            get: { self.imagePickerViewModel.selectedImage },
            set: {
                self.imagePickerViewModel.selectedImage = $0
                if let newImage = $0 {
                    images.append(newImage)
                    self.imagePickerViewModel.selectedImage = nil
                }
            }
        )
    }
    var body: some View {
        NavigationStack {
            ZStack {
                Image("background").ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("user's roadmap")
                        .fontWeight(.light)
                        .font(.title)
                        .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/-30.0/*@END_MENU_TOKEN@*/)
                    Button("+") {
                        imagePickerViewModel.isImagePickerDisplayed.toggle()
                    }
                    .imagePicker(isDisplayed: $imagePickerViewModel.isImagePickerDisplayed, image: $imagePickerViewModel.selectedImage)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 164)
                    .padding(.vertical, 18)
                    .background(Color.black)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(Color.white, lineWidth: 1))
                    .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: -20)
                    .dynamicTypeSize(/*@START_MENU_TOKEN@*/.xxxLarge/*@END_MENU_TOKEN@*/)

                    RoundedRectangle(cornerRadius: 45)
                        .fill(Color.black.opacity(0.4))
                        .frame(width: 360, height: 600)
                        .overlay(
                            VStack {
                                ForEach(images.indices, id: \.self) { index in
                                    Image(uiImage: images[index])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .onDrag {
                                            let data = String(index).data(using: .utf8)!
                                            return NSItemProvider(item: data as NSData, typeIdentifier: UTType.plainText.identifier)
                                        }
                                        .onDrop(of: [UTType.plainText], delegate: DragRelocateDelegate(item: images[index], listData: $images, currentIndex: index, draggedOffset: $draggedOffset))
                                }
                            }
                        )
                        .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: -10)
                }
                .padding(.top, 50)
            }
        }
    }
}


struct DragRelocateDelegate: DropDelegate {
    var item: UIImage
    @Binding var listData: [UIImage]
    var currentIndex: Int?
    @Binding var draggedOffset: CGSize
    
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    func dropEntered(info: DropInfo) {
        if let itemProvider = info.itemProviders(for: [UTType.plainText.identifier]).first {
            itemProvider.loadItem(forTypeIdentifier: UTType.plainText.identifier, options: nil) { (item, error) in
                if let data = item as? Data, let fromIndexString = String(data: data, encoding: .utf8), let fromIndex = Int(fromIndexString) {
                    DispatchQueue.main.async {
                        if fromIndex != currentIndex {
                            let fromPage = listData[fromIndex]
                            listData[fromIndex] = listData[currentIndex!]
                            listData[currentIndex!] = fromPage
                        }
                    }
                }
            }
        }
    }
}

extension View {
    func imagePicker(isDisplayed: Binding<Bool>, image: Binding<UIImage?>) -> some View {
        self.background(
            ImagePicker(isDisplayed: isDisplayed, image: image)
        )
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isDisplayed: Bool
    @Binding var image: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> some UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isDisplayed: $isDisplayed, image: $image)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var isDisplayed: Bool
        @Binding var image: UIImage?

        init(isDisplayed: Binding<Bool>, image: Binding<UIImage?>) {
            _isDisplayed = isDisplayed
            _image = image
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            image = uiImage
            isDisplayed = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isDisplayed = false
        }
    }
}

struct RoadmapView_Previews: PreviewProvider {
    static var previews: some View {
        RoadmapView()
    }
}

