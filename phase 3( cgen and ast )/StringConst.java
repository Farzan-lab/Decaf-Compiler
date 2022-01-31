//String Const
public class StringConst extends Literal {
    private String value;

    public StringConst(String value) {
        super(PrimitiveType.STRING);
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
    
    @Override
    public String toString() {
        return value+"";
    }
}