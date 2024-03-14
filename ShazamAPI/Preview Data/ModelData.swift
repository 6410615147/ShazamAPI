//
//  ModelData.swift
//  ShazamAPI
//
//  Created by Babypowder on 13/3/2567 BE.
//

import Foundation

func shazam(filePath: String, completion: @escaping (String) -> Void) {
    let headers = [
        "content-type": "multipart/form-data; boundary=---011000010111000001101001",
        "X-RapidAPI-Key": "23740506bdmsh291e05b07588cefp17732ejsn2252d4a7605a",
        "X-RapidAPI-Host": "shazam-api-free.p.rapidapi.com"
    ]
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://shazam-api6.p.rapidapi.com/shazam/recognize/")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 20.0)
    
    let boundary = "---011000010111000001101001"
    request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
    request.setValue("73eea4c305msh6ca99d72a4752d0p1ccafejsn5055b66c8b80", forHTTPHeaderField: "X-RapidAPI-Key")
    request.setValue("shazam-api-free.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")

    let filename = filePath.components(separatedBy: "/").last ?? "audioToAnalyze.m4a"

    var body = Data()

    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition:form-data; name=\"upload_file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
    body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)

    if let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
        body.append(data)
    } else {
        completion("Failed to read file data")
        return
    }

    body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
    
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody = body
    

    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
        if let error = error {
            completion("Error: \(error.localizedDescription)")
        } else if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200, let data = data, let responseBody = String(data: data, encoding: .utf8) {
                completion("Response Body: \(responseBody)")
            } else {
                completion("Failed with HTTP code: \(httpResponse.statusCode)")
            }
        } else {
            completion("Unexpected error")
        }
    }
    dataTask.resume()
}
