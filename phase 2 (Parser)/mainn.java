// package TEST1;
import java.io.*;
import java.util.*;

public class mainn {
    
    public static boolean main(String[] args) throws Exception {
        FileReader fr = new FileReader("inputFile.txt");
        Lexer lexer = new Lexer(fr);
        parser pars = new parser(lexer); 
        return true;
    }
}
