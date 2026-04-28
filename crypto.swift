import Foundation
import CryptoKit

public func runCrypto() {
    NSLog("CryptoKit 测试...")            
    NSLog("准备生成")
    
    var checksum: UInt64 = 0
    for i in 1...1_000_000 {
        let key = SymmetricKey(size: .bits256)
        let data = key.withUnsafeBytes { $0.load(as: UInt64.self) }
        checksum ^= data
        if i % 200_000 == 0 {
            NSLog("已生成 %d 个密钥...", i)  
        }
    }
    
    NSLog("测试完成！")
}
