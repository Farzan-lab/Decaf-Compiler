import java.io.FileReader;
import java.io.IOException;



public class Scanner {
    public static void main(String[] args) throws IOException{
        Subst scanner = new Subst(new FileReader("sample.in"));
        // int i = 0;
        while(true){
            int a = scanner.yylex();
            // System.out.println(a);
            if (a==Subst.YYEOF)
                break;
        }
        // System.out.println(i);
    }
}   