import java.util.*;
import java.io.*;

class TwoSum {
  public static void main(String[] args) {
    long start = System.currentTimeMillis();
    log(String.format("Loading file %s into hash", args[0]));
    HashSet<Long> numbers = file_to_hash(args[0]);
    log("File loaded in " + (System.currentTimeMillis() - start) / 1000.00);

    int sums = number_of_sums(numbers, -10000, 10000);
    log("The number of sums is: " + sums);
    log("Completed in " + (System.currentTimeMillis() - start) / 1000.00);
  }

  private static void log(String s) {
    System.out.println(s);
  }

  private static HashSet<Long> file_to_hash(String fileName) {
    HashSet<Long> numbers = new HashSet<Long>();
    String line = null;

    try {
      FileReader fileReader = new FileReader(fileName);
      BufferedReader bufferedReader = new BufferedReader(fileReader);
      while((line = bufferedReader.readLine()) != null) {
        numbers.add(Long.parseLong(line));
      }
      bufferedReader.close();
    }
    catch(FileNotFoundException ex) {
      System.out.println( "Unable to open file '" + fileName + "'");
    }
    catch(IOException ex) {
      System.out.println( "Error reading file '" + fileName + "'");
    }

    return numbers;
  }

  private static boolean has_sum(Set<Long> numbers, int sum) {
    for(Long x : numbers) {
      if (sum - x != x && numbers.contains(sum - x)) {
        return true;
      }
    }
    return false;
  }

  private static int number_of_sums(Set<Long> numbers, int start, int end) {
    int result = 0;
    for(int i = start; i <= end; i++) {
      if (has_sum(numbers, i)) result++;
    }
    return result;
  }

}
