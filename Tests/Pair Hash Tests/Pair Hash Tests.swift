import Hash
import Pair
import Pair_Hash
import Testing

struct Ranked: ~Copyable, Sendable {
    let value: Int
}

extension Ranked: Hash.`Protocol` {
    borrowing func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

@Suite
struct `Pair Hash Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
    @Suite(.serialized) struct Performance {}
}

extension `Pair Hash Tests`.Unit {

    @Test
    func `hashable conformance`() {
        let a = Pair(1, 2)
        let b = Pair(1, 2)
        #expect(a.hashValue == b.hashValue)
    }

    @Test
    func `hash protocol noncopyable pair hashes`() {
        let a = Pair(Ranked(value: 7), Ranked(value: 8))
        let b = Pair(Ranked(value: 7), Ranked(value: 8))
        var ha = Hasher()
        var hb = Hasher()
        a.hash(into: &ha)
        b.hash(into: &hb)
        #expect(ha.finalize() == hb.finalize())
    }
}
