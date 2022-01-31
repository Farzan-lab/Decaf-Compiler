//Float Const
public class FloatConst extends Literal {
    private double value;

    public FloatConst(double value) {
        super(PrimitiveType.FLOAT);
        this.value = value;
    }
    
    public double getValue() {
        return value;
    }
    
    @Override
    public String toString() {
        return value+"";
    }
}