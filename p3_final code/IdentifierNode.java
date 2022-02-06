
public class IdentifierNode extends Node {
    private final String name;
    public IdentifierNode(String name){
        super(NodeType.ID);
        this.name = name;
    }
}

