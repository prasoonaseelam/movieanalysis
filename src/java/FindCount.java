import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;


public class FindCount {

	public FindCount() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param args
	 */
	
	public static void main2(String args[]) throws IOException {
		
		float c = 145;
		float total = 500;
				
	    System.out.println(   " Perc:"+ (   (c ) / total )  );

	    System.out.println(   " Perc:"+ ( c %  total )  );


	}
	public static void main(String args[]) throws IOException {
		
	    Set<String> positive = loadDictionary("/Users/Prasoona/R/data/positivewords.txt");
	    Set<String> negative = loadDictionary("/Users/Prasoona/R/data/negitivewords.txt");

	    String movieName = args[1];
	    
	    int logic = Integer.parseInt( args[2] );
	    
	    Set<String> phrases = loadPhrases("/Users/Prasoona/R/data/myphrases.txt" , movieName );
    
	    File file = new File(args[0]);
	        
	    BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));

	    	long lineNo = 0;
	    	
	    	float totalPositiveTweekCount = 0;
	    	float totalNegitiveTweekCount = 0;
	    	float totalNeutralTweekCount = 0;
	    	
	        for(String line; (line = br.readLine()) != null; ) {
	        	
	        int phrasesFound = stringContainsItemFromList(line, phrases);
	        int positiveFound = stringContainsItemFromList(line, positive);
	        int negitiveFound = stringContainsItemFromList(line, negative);
	        
			if (phrasesFound > 0) {
				System.out.println(lineNo + "~" + phrasesFound + "~"
						+ positiveFound + "~" + negitiveFound);
			}

			if (phrasesFound > 0) {
				totalPositiveTweekCount = totalPositiveTweekCount + 1;
			} else {

				if (logic == 1) {
					if (positiveFound > 0) {
						totalPositiveTweekCount = totalPositiveTweekCount + 1;
					} else if (negitiveFound > 0) {
						totalNegitiveTweekCount = totalNegitiveTweekCount + 1;
					} else {
						totalNeutralTweekCount = totalNeutralTweekCount + 1;
					}
				}
				else if (logic == 2) {
					if (negitiveFound > 0) {
						totalNegitiveTweekCount = totalNegitiveTweekCount + 1;
					} 
					else if (positiveFound > 0) {
						totalPositiveTweekCount = totalPositiveTweekCount + 1;
					} else {
						totalNeutralTweekCount = totalNeutralTweekCount + 1;
					}
				}
				else if (logic == 3) {
					int diff = positiveFound - negitiveFound;
					if (diff > 0) {
						totalPositiveTweekCount = totalPositiveTweekCount + 1;
					} else if (diff < 0) {
						totalNegitiveTweekCount = totalNegitiveTweekCount + 1;
					} else {
						
						totalNeutralTweekCount = totalNeutralTweekCount + 1;
					}
				}
				
				
				
			}
	        lineNo = lineNo + 1;
	      
	    }
	    
 
	    br.close();
	      
	    
	    System.out.println("positiveCount:"+totalPositiveTweekCount);
	    System.out.println("negativeCount:"+totalNegitiveTweekCount);
	    System.out.println("neutralCount:"+totalNeutralTweekCount);
	    
	    float total = (totalPositiveTweekCount + totalNegitiveTweekCount + totalNeutralTweekCount);
	    
	    System.out.println( movieName + " Total:"+ total);
	 
	    System.out.println( movieName + " Lines:"+ lineNo );
		    
	    System.out.println( movieName + " Percents:"+ ( totalPositiveTweekCount /  total ) * 100 + " ; " +  ( totalNegitiveTweekCount /  total ) * 100 + " ; " + ( totalNeutralTweekCount /  total ) * 100   );
	    
	}


	public static Set<String> loadDictionary(String fileName) throws IOException {
	    Set<String> words = new HashSet<String>();
	    File file = new File(fileName);
	    BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
	    Scanner sc = new Scanner(br);
	    while (sc.hasNext()) {
	        words.add(sc.next());
	    }
	    br.close();
	    return words;
	}
	
	
	
	public static Set<String> loadPhrases(String fileName, String movieName) throws IOException {
	    Set<String> phrases = new HashSet<String>();
	    File file = new File(fileName);
	    BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
	   
	    for(String line; (line = br.readLine()) != null; ) {

	    	line = line.replace("[movie]" , movieName );
	    	
	    	//System.out.println( line );
	    	phrases.add(line);
	    }
	    br.close();
	    return phrases;
	}
	
	
	
	
	
	
	public static int stringContainsItemFromList(String line, Set<String> list)
	{
		Object[] items =  list.toArray();
		int count = 0;
	    for(int i =0; i < items.length; i++)
	    {
	    	//System.out.println("word::"+items[i].toString());
	        if(line.contains(items[i].toString()))
	        {
	            count++;
	        }
	    }
	    return count;
	}
	
	
}
