import java.io.FileReader;
import java.io.IOException;



public class Scanner {
    public static void main(String[] args) throws IOException{
        Subst scanner = new Subst(new FileReader("test.txt"));
        int i = 0;
        while(true){
            int a = scanner.yylex();
            if (a==Subst.YYEOF)
                break;
            ++i;
        }
        System.out.println(i);
    }
    
}
