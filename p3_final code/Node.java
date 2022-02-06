import java.util.ArrayList;

public abstract class Node {

    public Node(NodeType nodeType){
        this.nodeType = nodeType;
    }

    public ArrayList<Node> children = new ArrayList<>();
    public Node parent;
    public NodeType nodeType; 


    void addChild(Node node){
        this.children.add(node);
    }

    void setParent(Node parent){
        this.parent = parent;
    }

}
