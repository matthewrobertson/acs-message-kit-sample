// --------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for
// license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is
// regenerated.
// --------------------------------------------------------------------------

import AzureCore
import Foundation
// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length
// swiftlint:disable type_body_length

extension CharacterSet {
    static let azureUrlQueryAllowed = urlQueryAllowed.subtracting(.init(charactersIn: "!*'();:@&=+$,/?"))
    static let azureUrlPathAllowed = urlPathAllowed.subtracting(.init(charactersIn: "!*'()@&=+$,/:"))
}

public final class AzureCommunicationChatClient: PipelineClient, PageableClient {
    public func continuationUrl(forRequestUrl _: URL, withContinuationToken token: String) -> URL? {
        return URL(string: token)
    }

    /// API version of the  to invoke. Defaults to the latest.
    public enum ApiVersion: String {
        /// API version "2020-09-21-preview2"
        case v20200921preview2 = "2020-09-21-preview2"

        /// The most recent API version of the
        public static var latest: ApiVersion {
            return .v20200921preview2
        }
    }

    /// Options provided to configure this `AzureCommunicationChatClient`.
    public let options: AzureCommunicationChatClientOptions

    // MARK: Initializers

    /// Create a AzureCommunicationChatClient client.
    /// - Parameters:
    ///   - endpoint: Base URL for the AzureCommunicationChatClient.
    ///   - authPolicy: An `Authenticating` policy to use for authenticating client requests.
    ///   - options: Options used to configure the client.
    public init(
        endpoint: URL,
        authPolicy: Authenticating,
        withOptions options: AzureCommunicationChatClientOptions
    ) throws {
        self.options = options
        super.init(
            endpoint: endpoint,
            transport: options.transportOptions.transport ?? URLSessionTransport(),
            policies: [
                UserAgentPolicy(for: AzureCommunicationChatClient.self, telemetryOptions: options.telemetryOptions),
                RequestIdPolicy(),
                AddDatePolicy(),
                authPolicy,
                ContentDecodePolicy(),
                LoggingPolicy(),
                NormalizeETagPolicy()
            ],
            logger: options.logger,
            options: options
        )
    }

    public func url(
        host hostIn: String? = nil,
        template templateIn: String,
        pathParams pathParamsIn: [String: String]? = nil,
        queryParams queryParamsIn: [QueryParameter]? = nil
    ) -> URL? {
        var template = templateIn
        var hostString = hostIn
        if template.hasPrefix("/") { template = String(template.dropFirst()) }

        if let pathParams = pathParamsIn {
            for (key, value) in pathParams {
                if let encodedPathValue = value.addingPercentEncoding(withAllowedCharacters: .azureUrlPathAllowed) {
                    template = template.replacingOccurrences(of: "{\(key)}", with: encodedPathValue)
                }
                if let host = hostString {
                    hostString = host.replacingOccurrences(of: "{\(key)}", with: value)
                }
            }
        }

        if let hostUnwrapped = hostString,
            !hostUnwrapped.hasSuffix("/") {
            hostString = hostUnwrapped + "/"
        }
        let urlString = (hostString ?? endpoint.absoluteString) + template
        guard let url = URL(string: urlString) else {
            return nil
        }

        guard !(queryParamsIn?.isEmpty ?? false) else { return url }

        return appendingQueryParameters(url: url, queryParamsIn ?? [])
    }

    private func appendingQueryParameters(url: URL, _ queryParams: [QueryParameter]) -> URL? {
        guard !queryParams.isEmpty else { return url }
        guard var urlComps = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }

        let queryItems = queryParams.map { name, value in URLQueryItem(
            name: name,
            value: value?.addingPercentEncoding(withAllowedCharacters: .azureUrlQueryAllowed)
        ) }
        urlComps.percentEncodedQueryItems = queryItems
        return urlComps.url
    }

    public lazy var azureCommunicationChatService: AzureCommunicationChatService =
        AzureCommunicationChatService(client: self)
}
