package com.gp.user;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class Translator {
	
	private Map<String , String> translate = new HashMap<String , String>();
	private HashMap<String,String> attributes = new HashMap<String,String>();
	private HashMap<Integer,HashMap<String,String>> keyAndAttributes = new HashMap<Integer,HashMap<String,String>>();
	
	private HashMap<String,String> ARattributes = new HashMap<String,String>();
	private HashMap<Integer,HashMap<String,String>> ARkeyAndAttributes = new HashMap<Integer,HashMap<String,String>>();
	JSONObject obj = new JSONObject();
	JSONArray ja= new JSONArray();
	File Filewriter ;
	FileWriter fw ;
	
	public Translator(String language) throws ParseException, JSONException, IOException {
			
		JSONParser parser = new JSONParser();
		Filewriter = new File("E:\\GP_folder\\progress\\test.json "); 
				
		File translationFile = new File("src\\main\\resources\\static\\translation.json"); 
		
		String path = translationFile.getPath();
				
		FileReader fr = new FileReader(path.replaceAll("\\\\","\\\\\\\\"));
		
		JSONObject obj = (JSONObject) parser.parse(fr);
		  
		JSONObject jsonObject = new JSONObject();
		
		jsonObject = (JSONObject) obj.get(language);
				
		translate = (Map<String, String>) obj.get(language);

	}
	
	public String write(String word) {
		
		if(translate.get(word) != null) {
			return translate.get(word);
		}else {
			return word;
		}
		
	}
	
	 public enum language {
		 en,
		 ar;
		 
	 }
	
 public void fileWeiter(String key,String value,language type) throws IOException {
		 
		 int index1 =0;
		 int index2 =0;
		 if(type.equals(language.en)){
		    attributes.put(key, value);
		    
		    keyAndAttributes.put(index1, attributes);
		    index1++;
		   // System.out.println("hash"+ hash1);
		    obj.put("en", attributes);
		    } else if(type.equals(language.ar)) {
			    ARattributes.put(key, value);
			    ARkeyAndAttributes.put(index2, ARattributes);
			    index2++;
			    obj.put("ar", ARattributes);
			 
		 }
		 else {
			 System.out.println("not available attribute");
		 }
		 
		 ja.add(obj);
		 
		    	try {
		    		 String path = Filewriter.getPath();	
		    		 fw = new FileWriter(path.replaceAll("\\\\","\\\\\\\\"));
		    		 //FileWriter file = new FileWriter("E:\\GP_folder\\progress\\test.json");
				        //fw.write(obj.toJSONString());
				        BufferedWriter writer = new BufferedWriter(fw);
						  writer.append(ja.toJSONString());			   
					      writer.close();
				        /*
				        fw.flush();
				        System.out.println(obj);
				        fw.close();
			        */
		    	}catch(IOException e) {
		    		e.getStackTrace();
		    		// System.out.println("error in filewriter");
		    	}
		    	
		    	// writer.close();
		   
	 } 
	
	public void translate2English(String key,String value) throws IOException {
		
	    int index =0;
	    attributes.put(key, value);
	    keyAndAttributes.put(index, attributes);
	    index++;
	   // System.out.println("hash"+ hash1);
	    obj.put("en", attributes);
	    try  {
	    	FileWriter file = new FileWriter("E:\\GP_folder\\progress\\test.json");
	        file.write(obj.toJSONString());
	        file.flush();
	        file.close();

	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	}
public void translate2Arabic(String key,String value) throws IOException {
		
	    int index =0;
	    ARattributes.put(key, value);
	    ARkeyAndAttributes.put(index, ARattributes);
	    index++;
	    obj.put("ar", ARattributes);
	    try  {
	    	FileWriter file = new FileWriter("E:\\GP_folder\\progress\\test.json");
	        file.write(obj.toJSONString());
	        file.flush();
	        file.close();

	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}

	
	
}
