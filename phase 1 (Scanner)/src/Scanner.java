import java.io.FileReader;
import java.io.IOException;



public class Scanner {
    public static void main(String[] args) throws IOException{
        // StringBuilder str = new StringBuilder();

        mn scanner = new mn(new FileReader("sample.in"));
        // int i = 0;
        while(true){
            int a = scanner.yylex();

            if (a==mn.YYEOF)
                break;
        }
        System.out.println(mn.text);
        // System.out.println(i);
    }
}    

// // package compiler;

// import java.io.*;
// import java.util.*;

// public class Scanner {

//     public static String run(java.io.File inputFile) throws Exception {
//         StringBuilder str = new StringBuilder();

//         mainn scanner = new mainn(new FileReader(inputFile));
//         while (true) {
//           str.append(
//               scanner.text.toString());

//             }
//         }
//         return str.toString();
//     }