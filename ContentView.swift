// ContentView.swift
// PetAdvice

import SwiftUI

struct ContentView: View {

    @State private var selectedHousing: HousingType = .house
    @State private var hoursAtHome: String = ""
    @State private var recommendedPet: String? = nil
    @State private var showResult: Bool = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {

                    // Header
                    VStack(spacing: 8) {
                        Text("🐾")
                            .font(.system(size: 64))
                        Text("What pet suits you?")
                            .font(.largeTitle.bold())
                            .multilineTextAlignment(.center)
                        Text("Answer two quick questions and we'll find your perfect companion.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 12)

                    // Housing Picker
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Where do you live?", systemImage: "building.2")
                            .font(.headline)
                        Picker("Housing Type", selection: $selectedHousing) {
                            ForEach(HousingType.allCases) { type in
                                Text(type.label).tag(type)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    // Hours Input
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Hours at home per day?", systemImage: "clock")
                            .font(.headline)
                        HStack {
                            TextField("e.g. 8", text: $hoursAtHome)
                                .keyboardType(.decimalPad)
                                .font(.title2)
                                .padding(12)
                                .background(Color(.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text("hrs")
                                .foregroundStyle(.secondary)
                                .font(.title3)
                        }
                    }
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    // Submit Button
                    Button(action: submitAdvice) {
                        Label("Find My Pet", systemImage: "pawprint.fill")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }

                    // Result Card
                    if showResult, let pet = recommendedPet {
                        VStack(spacing: 10) {
                            Text("We recommend...")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text(pet)
                                .font(.title.bold())
                                .foregroundStyle(Color.accentColor)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .background(Color(.systemBackground))
                                .navigationTitle("Pet Advisor")
                    }

                    Spacer(minLength: 40)
                }
                .padding()
            }
            .navigationTitle("Pet Advisor")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Invalid Input", isPresented: $showError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
        }
    }

    private func submitAdvice() {
        guard let hours = Double(hoursAtHome) else {
            errorMessage = "Please enter a valid number of hours (e.g. 8 or 10.5)."
            showError = true
            return
        }
        guard hours >= 0, hours <= 24 else {
            errorMessage = "Hours at home must be between 0 and 24."
            showError = true
            return
        }
        if let pet = petAdvisor.recommend(hoursAtHome: hours, housing: selectedHousing) {
            withAnimation(.spring(duration: 0.4)) {
                recommendedPet = pet
                showResult = true
            }
        }
    }
}

#Preview {
    ContentView()
}

