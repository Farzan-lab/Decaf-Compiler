
public class PrimitiveNode extends Node {
    PrimitiveType primitiveType;
    public PrimitiveNode(PrimitiveType pt){
        super(NodeType.PRIMITIVE);
        this.primitiveType = pt;
    }
}
