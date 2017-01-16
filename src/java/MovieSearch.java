

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;

import me.jhenrique.manager.TweetManager;
import me.jhenrique.manager.TwitterCriteria;
import me.jhenrique.model.Tweet;

public class MovieSearch {

	private static final String SEPARATOR = "\t";
	
	public static void main(String[] args) {
		
		System.out.println("Tweets Search started ..:");
		
		try{
			
		/**
		 * Reusable objects
		 */
		TwitterCriteria criteria = null;
 
		/**
		 *  Get tweets by query search
		 **/
		String movieName = args[0];
		String since = args[1];
		String until = args[2];
		int noOfTwees = Integer.parseInt(  args[3]);
		String fileName = args[4];
		
		System.out.println("Input params:");
		System.out.println(movieName  + ";" +  since + ";" +  until + ";" +  noOfTwees + ";" +  fileName  );
		
		criteria = TwitterCriteria.create()
				.setQuerySearch(movieName)
				.setSince(since)
				.setUntil(until)
				.setMaxTweets(noOfTwees);
		
		ArrayList<Tweet> tweets = (ArrayList<Tweet>) TweetManager.getTweets(criteria);
		
		System.out.println("Tweets result count:" + tweets.size());
	 	
			File f = new File(fileName);
			
			PrintWriter writer = null;
			
			//f.getParentFile().mkdirs(); 
			if(f.exists()) {
			
				writer = new PrintWriter(new FileOutputStream(f, true));
				      
			    
				
			} else {
				 f.createNewFile();
				 writer = new PrintWriter(f );
				 writer.println("Text"  + SEPARATOR +  "Date" + SEPARATOR + "Username" );
			}
			

		    
			for (int i = 0; i < tweets.size(); i++) {
				Tweet t = tweets.get(i);
			    writer.println(t.getText()  + SEPARATOR +  t.getDate() + SEPARATOR + t.getUsername() );
			}
		    writer.close();
		} catch (Exception e) {
		   // do something
			e.printStackTrace();
		}
		System.out.println("End!");
	}
	
}