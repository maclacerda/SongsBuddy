//
//  MusicRepositoryFactory.metal
//  SBData
//
//  Created by Marcos Ferreira on 4/10/26.
//

import Foundation
import SBCore
import SBDomain

public enum MusicRepositoryFactory {
    // MARK: - Methods
    public static func makeDefault() -> MusicRepository {
        let httpClient = URLSessionHTTPClient()

        let remoteDataSource = ITunesMusicRemoteDataSource(
            httpClient: httpClient
        )

        return MusicRepository(
            remoteDataSource: remoteDataSource
        )
    }
}
