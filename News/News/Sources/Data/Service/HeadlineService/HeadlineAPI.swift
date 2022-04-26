//
//  HeadlineAPI.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import RxSwift
import Moya

// MARK: - Provider setup

typealias Dict = [String: Any]

class HeadlineApi {
    
    static let shared = HeadlineApi()
    let disposedBag = DisposeBag()
    let provider = MoyaProvider<Headline>(plugins: [])
    
    private init() {}
    
    func request(target: Headline) -> Single<NewsResponse> {
        return Single.create { single in
            self.provider.rx.request(target).subscribe(onSuccess: { response in
                if let result = self.handleResponse(response, returnType: NewsResponse.self) {
                    if let status = result.status {
                        if status == "error" {
                            single(.error(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: result.message ?? ""])))
                        } else {
                            single(.success(result))
                        }
                    } else {
                        single(.error(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Status should be return in response"])))
                    }
                } else {
                    single(.error(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Parse error"])))
                }
            }, onError: { error in
                single(.error(error))
            }).disposed(by: self.disposedBag)
            return Disposables.create()
        }
        
    }
}

extension HeadlineApi {
    private func handleResponse<T: Decodable>(_ response: Response, returnType: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(returnType, from: response.data)
            return result
        } catch {
            print("error \(error)")
            return nil
        }
    }
}
