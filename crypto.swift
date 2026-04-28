import Foundation
import CryptoKit

public func runCrypto() {
    print("CryptoKit 测试...")
        print("准备生成")
        var checksum: UInt64 = 0
        for i in 1...1_000_000 {
            let key = SymmetricKey(size: .bits256)
            let data = key.withUnsafeBytes { $0.load(as: UInt64.self) }
            checksum ^= data
            if i % 200_000 == 0 {
                print("已生成 \(i) 个密钥...")
            }
        }
        print("测试完成！")
}

