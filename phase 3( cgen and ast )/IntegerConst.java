// int const

public class IntegerConst extends Literal {
    private int value;

    public IntegerConst(int value) {
        super(PrimitiveType.INT);
        this.value = value;
    }
    
    public int getValue() {
        return value;
    }
    
    @Override
    public String toString() {
        return value+"";
    }
}