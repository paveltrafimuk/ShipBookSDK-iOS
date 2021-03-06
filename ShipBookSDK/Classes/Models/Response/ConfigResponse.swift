//
//  ConfigResponse.swift
//  ShipBook
//
//  Created by Elisha Sterngold on 06/11/2017.
//  Copyright © 2018 ShipBook Ltd. All rights reserved.
//

import Foundation
struct ConfigResponse : Decodable {
  let eventLoggingDisabled : Bool?
  let exceptionReportDisabled: Bool?
  
  let appenders: [AppenderResponse]
  let loggers: [LoggerResponse]
  let root: RootResponse?
}

class AppenderResponse: Decodable {
  let type: String
  let name: String
  let config: Config?
  
  enum CodingKeys: String, CodingKey
  {
    case type
    case name
    case config
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    type = try container.decode(String.self, forKey: .type)
    name = try container.decode(String.self, forKey: .name)
    config = try container.decodeIfPresent(Config.self, forKey: .config)
  }
}

struct LoggerResponse: Decodable {
  let name: String?
  let severity: String
  let callStackSeverity: String?
  let appenderRef: String
}

struct RootResponse: Decodable {
  let severity: String
  let appenderRef: String
}


