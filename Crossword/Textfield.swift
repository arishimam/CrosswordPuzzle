//
//  Textfield.swift
//  Crossword
//
//  Created by csuftitan on 5/17/23.
//

import Foundation
import SwiftUI
import UIKit

struct FocusedTextField: UIViewRepresentable {
    @Binding var text: String
    var isUserInteractionEnabled: Bool
    var onCommit: () -> Void
    var onUpdate: (String) -> Void
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.isUserInteractionEnabled = isUserInteractionEnabled
        textField.textAlignment = .center
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: FocusedTextField

        init(_ textField: FocusedTextField) {
            self.parent = textField
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let oldText = textField.text, let r = Range(range, in: oldText) else {
                return true
            }
            let newText = oldText.replacingCharacters(in: r, with: string)
            if newText.count > 1 {
                return false
            }
            parent.text = newText
            if newText.count == 1 {
                textField.resignFirstResponder()
            }
            parent.onUpdate(newText)
            return true
        }
    }
}
