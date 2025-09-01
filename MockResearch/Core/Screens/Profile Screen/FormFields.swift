//
//  FormFields.swift
//  MockResearch
//
//  Created by Rod Tavangar on 9/1/25.
//

import SwiftUI

// MARK: - Base Form Field
struct FormField<Content: View>: View {
    let title: String
    let isEditing: Bool
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        LabeledContent {
            content()
        } label: {
            Text(title)
                .bold()
        }
    }
}

// MARK: - Text Form Field
struct TextFormField: View {
    let title: String
    @Binding var text: String
    let isEditing: Bool
    var placeholder: String = "Required"
    var keyboardType: UIKeyboardType = .default
    var textInputAutocapitalization: TextInputAutocapitalization = .sentences
    var autocorrectionDisabled: Bool = false
    
    var body: some View {
        FormField(title: title, isEditing: isEditing) {
            if isEditing {
                TextField(placeholder, text: $text)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(textInputAutocapitalization)
                    .autocorrectionDisabled(autocorrectionDisabled)
            } else {
                Text(text.isEmpty ? placeholder : text)
                    .foregroundStyle(text.isEmpty ? .tertiary : .primary)
            }
        }
    }
}

// MARK: - Date Form Field
struct DateFormField: View {
    let title: String
    @Binding var date: Date?
    let isEditing: Bool
    var displayedComponents: DatePicker.Components = .date
    
    @State private var showingPicker = false
    @State private var tempDate = Date()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        FormField(title: title, isEditing: isEditing) {
            if isEditing {
                Button {
                    tempDate = date ?? Date()
                    showingPicker = true
                } label: {
                    if let date {
                        Text(dateFormatter.string(from: date))
                            .foregroundStyle(Color.primary)
                    } else {
                        Text("Required")
                            .foregroundStyle(Color.secondary.opacity(0.5))
                    }
                }
                .sheet(isPresented: $showingPicker) {
                    PickerSheet(onDone: {
                        date = tempDate
                    }) {
                        DatePicker("", selection: $tempDate, displayedComponents: displayedComponents)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                    }
                }
            } else {
                if let date {
                    Text(dateFormatter.string(from: date))
                        .foregroundStyle(.primary)
                } else {
                    Text("Required")
                        .foregroundStyle(.tertiary)
                }
            }
        }
    }
}

// MARK: - Region Picker Form Field
struct RegionPickerFormField: View {
    let title: String
    @Binding var regionCode: String
    let isEditing: Bool
    
    @State private var showingPicker = false
    
    private let regions: [Locale.Region] = Locale.Region.isoRegions.sorted { region1, region2 in
        let name1 = Locale.current.localizedString(forRegionCode: region1.identifier) ?? region1.identifier
        let name2 = Locale.current.localizedString(forRegionCode: region2.identifier) ?? region2.identifier
        return name1 < name2
    }
    
    private func regionDisplayName(for code: String) -> String {
        return Locale.current.localizedString(forRegionCode: code) ?? code
    }
    
    var body: some View {
        FormField(title: title, isEditing: isEditing) {
            if isEditing {
                Button {
                    showingPicker = true
                } label: {
                    Text(regionCode.isEmpty ? "Required" : regionDisplayName(for: regionCode))
                        .foregroundStyle(regionCode.isEmpty ? Color.secondary.opacity(0.5) : Color.primary)
                }
                .sheet(isPresented: $showingPicker) {
                    PickerSheet {
                        Picker("Select Region", selection: $regionCode) {
                            Text("Select Region")
                                .tag("")
                            
                            ForEach(regions, id: \.identifier) { region in
                                Text(Locale.current.localizedString(forRegionCode: region.identifier) ?? region.identifier)
                                    .tag(region.identifier)
                            }
                        }
                        .pickerStyle(.wheel)
                        .labelsHidden()
                    }
                }
            } else {
                Text(regionCode.isEmpty ? "Required" : regionDisplayName(for: regionCode))
                    .foregroundStyle(regionCode.isEmpty ? .tertiary : .primary)
            }
        }
    }
}

// MARK: - Picker Sheet
struct PickerSheet<Content: View>: View {
    @Environment(\.dismiss) private var dismiss
    
    var onDone: (() -> Void)?
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        VStack(spacing: 0) {
            Button("Done") {
                onDone?()
                dismiss()
            }
            .foregroundStyle(.blue)
            .fontWeight(.semibold)
            .padding([.horizontal, .top])
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            content()
        }
        .presentationDetents([.height(260)])
        .presentationDragIndicator(.hidden)
        .presentationCornerRadius(0)
    }
}
