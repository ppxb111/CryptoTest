import Foundation
import CryptoKit
import os.log 

public func runCrypto() {
    let log = OSLog(subsystem: "com.yourcompany.crypto", category: "Performance")
    
    os_log("CryptoKit 测试...", log: log, type: .info)
    os_log("准备生成", log: log, type: .info)
    
    var checksum: UInt64 = 0
    for i in 1...1_000_000 {
        let key = SymmetricKey(size: .bits256)
        let data = key.withUnsafeBytes { $0.load(as: UInt64.self) }
        checksum ^= data
        if i % 200_000 == 0 {
            os_log("已生成 %d 个密钥...", log: log, type: .info, i) 
        }
    }
    
    os_log("测试完成！", log: log, type: .info)
}
