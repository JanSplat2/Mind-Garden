//
//  AIChatView.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 2/21/26.
//


import SwiftUI
import FoundationModels

struct AIChatView: View {
    
    @State private var messages: [ChatMessage] = []
    @State private var userInput: String = ""
    @State private var isLoading = false
    
    #if canImport(FoundationModels)
    private var model: Any? {
        if #available(iOS 26.0, *) {
            return SystemLanguageModel.default
        } else {
            return nil
        }
    }
    #else
    private var model: Any? { nil }
    #endif
    
    var body: some View {
        VStack {
            
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(messages) { message in
                        HStack {
                            if message.isUser {
                                Spacer()
                            }
                            
                            Text(message.text)
                                .padding()
                                .background(message.isUser ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                                .cornerRadius(12)
                            
                            if !message.isUser {
                                Spacer()
                            }
                        }
                    }
                }
                .padding()
            }
            
            Divider()
            
            HStack {
                TextField("How are you feeling?", text: $userInput)
                    .textFieldStyle(.roundedBorder)
                
                Button("Send") {
                    sendMessage()
                }
                .disabled(userInput.isEmpty || isLoading)
            }
            .padding()
        }
        .frame(minWidth: 500, minHeight: 500)
    }
    
    private func sendMessage() {
        let input = userInput
        userInput = ""
        
        messages.append(ChatMessage(text: input, isUser: true))
        
        Task {
            await generateResponse(for: input)
        }
    }
    
    @MainActor
    private func generateResponse(for input: String) async {
        isLoading = true

        #if canImport(FoundationModels)
            if #available(iOS 26.0, *), let model = model as? SystemLanguageModel {
                do {
                    let session = LanguageModelSession(model: model)
                    let prompt = """
                    You are a warm, supportive wellness companion.
                    The user says: "\(input)"
                    Respond kindly and thoughtfully.
                    Keep it under 120 words.
                    """
                    let response = try await session.respond(to: prompt)
                    messages.append(ChatMessage(text: response.content, isUser: false))
                } catch {
                    messages.append(ChatMessage(text: "I'm here with you 🌱", isUser: false))
                }
            } else {
                messages.append(ChatMessage(text: fallbackResponse(for: input), isUser: false))
            }
        #else
            messages.append(ChatMessage(text: fallbackResponse(for: input), isUser: false))
        #endif

        isLoading = false
    }
    
    private func fallbackResponse(for input: String) -> String {
        let prefix = "Thanks for sharing. "
        let generic = "I'm here to listen and support you. Try to take a slow, deep breath and be kind to yourself right now. If you'd like, tell me a bit more about what's on your mind."
        if input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { return generic }
        return prefix + generic
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}
