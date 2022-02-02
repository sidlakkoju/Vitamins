//
//  MedicationStore.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 12/31/21.
//

import Foundation
import SwiftUI


class MedicationStore: ObservableObject {
    var Medications: [Medication] = []
    
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                        in: .userDomainMask,
                                        appropriateFor: nil,
                                        create: false)
            .appendingPathComponent("medications.data")
    }
    
    static func load(completion: @escaping (Result<[Medication], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let meds = try JSONDecoder().decode([Medication].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(meds))
                }
                
            } catch {
                DispatchQueue.main.async {
                      completion(.failure(error))
                  }
            }
        }
    }
    
    static func save(Medications: [Medication], completion: @escaping (Result<Int, Error>)->Void) {
        
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(Medications)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(Medications.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    
    
    func addMedication(theme: Theme, title: String, remHour: Int, remMinute: Int) {        
        self.Medications.append(Medication(title: title, theme: theme, remHour: remHour, remMinute: remMinute))
    }
    
    func removeMedication(med: Medication) {
        var i: Int = 0
        while (i < Medications.count) {
            if (med.id == Medications[i].id) {
                Medications.remove(at: i)
                break
            }
            i = i + 1;
        }
    }
}
