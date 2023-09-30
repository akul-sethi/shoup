//
//  SellView.swift
//  Shoup
//
//  Created by Akul Sethi on 5/11/23.
//

import SwiftUI
import PhotosUI

struct SellView: View {
    @EnvironmentObject private var postCache: PostCache
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedItemData: Data? = nil
    @State private var priceColor = Color.gray
    @State private var name = "Sweater"
    @State private var priceString = "10"
    var price: Int {
        if let temp = Int(priceString) {
            return temp
        } else {
            priceColor = .red
            return 0
        }
    }
    @State private var description = "Slightly used"

    var body: some View {
            VStack {
                Text("New Post")
                    .font(.title2)

                Divider()

                Group {
                    TextField("Enter product name", text: $name)
                        .padding(.top, 30)
                    TextField("Enter product description", text: $description)
                }
                .textFieldStyle(OvalTextFieldStyle(.gray))
                .frame(width: 300)


          TextField("Enter Price",text: $priceString)
                .textFieldStyle(OvalTextFieldStyle(priceColor))
                .frame(width: 300)
                   .onChange(of: priceString) { newValue in
                       priceColor = Int(newValue) == nil ? .red : .gray
                }

                PhotosPicker(selection: $selectedItem,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Text("Select a photo")
                        .padding(10)

                }
                             .onChange(of: selectedItem) { item in
                                 Task {
                                     if let data = try? await item?.loadTransferable(type: Data.self) {
                                         selectedItemData = data
                                     }
                                 }
                             }

                if let data = selectedItemData,
                   let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)

                }



            Button {
                guard  let selectedItemData = selectedItemData  else {
                    print("no item selected")
                    return
                }
                postCache.post(Post(id: randomString(),
                                    seller: "Akul",
                                    university: "Northeastern",
                                    description: self.description,
                                    price: self.price,
                                    name: self.name,
                                    imageAddress: randomString()),
                               data: selectedItemData)
            } label: {
                Text("Post")
            }
            Spacer()
        }

    }

    func randomString() -> String {
        let allLetters = "qwertyuiopasdfghjklzxcvbnm1234567890"
        let random = allLetters.map {char in
            allLetters.randomElement() ?? "a"
        }
        return String(random)

    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    var shadowColor: Color

    init(_ color: Color) {
        self.shadowColor = color
    }

    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(7)
            .background(.white)
            .cornerRadius(15)
            .shadow(color: shadowColor, radius: 5)

    }


}

struct SellView_Previews: PreviewProvider {
    static var previews: some View {
        SellView()
    }
}
