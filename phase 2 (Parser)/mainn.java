import java.io.File;
import java.io.FileReader;

public class mainn {
    public static void main(String[] args) throws Exception{

        FileReader filereader = new FileReader(new File("test.txt"));
        Lexer lexer = new Lexer(filereader);
        parser pars = new parser(lexer);
        pars.parse();
        System.out.println("Ok");
    }
    
}
