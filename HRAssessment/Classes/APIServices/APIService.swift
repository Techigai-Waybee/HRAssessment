import Foundation
import UIKit

enum APIService { }

extension APIService {
    static func generateHealthReport(fileURL: URL, requestObj: HRReportRequest) async {
        guard let accessToken = await generateAccessToken() else { return }
        guard let data = try? Data(contentsOf: fileURL) else { return }
        guard let url = URL(string: "https://datav2.healthreel.com/predict/") else { return }

        var multipart = MultipartRequest()
        
        var parameters = [String: String]()
        parameters["userReferenceID"] = "999"
        parameters["weight"] = "\(requestObj.weight)"
        parameters["dob"] = "\(requestObj.dobTimestamp)"
        parameters["activityLevel"] = "\(requestObj.activityLevel)"
        parameters["height"] = "\(requestObj.height)"
        parameters["gender"] = "\(requestObj.gender)"
        parameters["race"] = "\(requestObj.race)"
        parameters["selfHealthReadiness"] = requestObj.selfHealthReadiness.string
        
        if let sdoh = requestObj.sdoh {
            parameters["sdoh"] = sdoh.string
        }
        
        if let anxietyScore = requestObj.anxietyScore {
            parameters["anxietyScore"] = "\(anxietyScore)"
        }

        if let depressionScore = requestObj.depressionScore {
            parameters["depressionScore"] = "\(depressionScore)"
        }

        if let stressScore = requestObj.stressScore {
            parameters["stressScore"] = "\(stressScore)"
        }

        if let preEclampsia = requestObj.preEclampsia {
            parameters["preEclampsia"] = preEclampsia.string
        }

        for field in parameters {
            multipart.add(key: field.key, value: field.value)
        }
        
        multipart.add(key: "video", fileName: "video", fileData: data)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue(multipart.httpContentTypeHeaderValue, forHTTPHeaderField: "Content-Type")
        request.httpBody = multipart.httpBody
        
        Task { await HRAPILoader.start() }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            Task { await HRAPILoader.stop() }
            
            guard let data = data else {
                print(String(describing: error))
                return
            }

            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
    
    private static func generateAccessToken() async -> AccessToken? {
        guard let url = URL(string: "https://healthreel-nodejs-36xee.ondigitalocean.app/bi/v2/access-token/generate") else {
            return nil
        }
        
        let parameters = "apiKey=pB3EFWLbFhapWTzdPeK79hToRxzNiFSJCq7FBttU8UORLndBJkWTsMkYWcSU4xtHI%2B%2BTdh2g%2BCrebksCZkQeYvtlkaVyWBgVxE%2Bws9lNqxpqGr1eypofMoIdNumhGTpxBj7MsOouehUem%2B9P3J%2BocGxgdJxZ5u2BfhkTDKifXlQ%3D&businessUniqueId=InovCares&appUniqueId=InovCares&callbackUrl=https%3A%2F%2Finovcares.com%2Fuser%2Fpublic%2Fapi%2Fv3%2Freports"
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let accessTokenResponse = try JSONDecoder().decode(AccessTokenResponse.self, from: data)
            let accessToken = accessTokenResponse.data["accessToken"]
            return accessToken
        } catch {
            return nil
        }
    }
}

extension Collection {
    fileprivate var string: String? {
        if self.isEmpty { return nil }
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(data: data, encoding: .utf8)
        } catch {
            print(error)
            return nil
        }
    }
}
