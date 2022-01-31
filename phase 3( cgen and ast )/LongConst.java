//Long Const
public class LongConst extends Literal {
    private long value;

    public LongConst (long value) {
        super(PrimitiveType.LONG);
        this.value = value;
    }

    public long getValue() {
        return value;
    }

    @Override
    public String toString() {
        return value+"";
    }
}