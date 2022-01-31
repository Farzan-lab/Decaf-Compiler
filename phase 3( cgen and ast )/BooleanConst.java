// Boolean Const
public class BooleanConst extends Literal {
    private final boolean value;
    private final int intVal;

    public BooleanConst (String value) {
        super(PrimitiveType.BOOL);
        this.value = Boolean.parseBoolean(value);
        intVal = this.value ? 1 : 0;
    }

    public int getIntVal() {
        return intVal;
    }

    public boolean getValue() {
        return value;
    }

    @Override
    public String toString() {
        return intVal + "";
    }
}
