public import Hash
public import Pair
public import Pair_Equation

extension Pair: @retroactive Swift.Hashable
where
    First: Hash.`Protocol` & ~Copyable,
    Second: Hash.`Protocol` & ~Copyable
{

    @inlinable
    @_disfavoredOverload
    public borrowing func hash(into hasher: inout Hasher) {
        first.hash(into: &hasher)
        second.hash(into: &hasher)
    }
}

extension Pair: @retroactive Hash.`Protocol`
where
    First: Hash.`Protocol` & ~Copyable,
    Second: Hash.`Protocol` & ~Copyable
{}
