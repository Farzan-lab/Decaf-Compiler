package compiler;

import java.io.*;
import java.util.*;

public class Main {

    public static String run(java.io.File inputFile) throws Exception {

        mn scanner = new mn(new FileReader(inputFile));
        while(true){
            int a = scanner.yylex();

            if (a==mn.YYEOF)
                break;
        }
        return scanner.text;
    }
}


    // public class Scanner {
    //     public static void main(String[] args) throws IOException{
    //         // StringBuilder str = new StringBuilder();
    
    //         mn scanner = new mn(new FileReader("sample.in"));
    //         // int i = 0;
    //         while(true){
    //             int a = scanner.yylex();
    
    //             if (a==mn.YYEOF)
    //                 break;
    //         }
    //         System.out.println(mn.text);
    //         // System.out.println(i);
    //     }
    // }    
    