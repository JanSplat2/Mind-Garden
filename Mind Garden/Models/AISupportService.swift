//
//  AISupportService.swift
//  Mind Garden
//
//  Created by Dittrich, Jan - Student on 2/21/26.
//

import Foundation
#if canImport(FoundationModels)
import FoundationModels
#endif

@MainActor
final class AISupportService {
    
#if canImport(FoundationModels)
    private lazy var model: Any? = {
        if #available(iOS 26.0, *) {
            return SystemLanguageModel.default
        } else {
            return nil
        }
    }()
#else
    private let model: Any? = nil
#endif
    
    func generateSupportMessage(from emotions: [Emotion]) async throws -> String {
        
        let emotionList = emotions.map { $0.rawValue }.joined(separator: ", ")
        
        let prompt = """
        The user has logged these emotions today: \(emotionList).
        Write a short, warm, supportive check-in message.
        Be gentle, caring, and encouraging.
        Keep it under 70 words.
        """
        
        #if canImport(FoundationModels)
        if #available(iOS 26.0, *), let concreteModel = model as? SystemLanguageModel {
            let session = LanguageModelSession(model: concreteModel)
            let response = try await session.respond(to: prompt)
            return response.content
        }
        #endif
        // Fallback for iOS versions earlier than 26.0 or when FoundationModels isn't available
        let fallback = "I see you're feeling \(emotionList). I'm here with you. Take a deep breath, be kind to yourself, and remember small steps count. You’ve got this."
        return fallback
    }
}
