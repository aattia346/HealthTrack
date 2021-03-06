package com.gp.user;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONException;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class Translator {
	 private FileWriter fw ;
	 private String path;
	private Map<String , String> translate = new HashMap<String , String>();
	
	public Translator() throws ParseException, JSONException, IOException {		
	}
	
	public String write(String word,String language) throws IOException, ParseException {
	
		if(translate.get(word) != null) {
			return translate.get(word);
		}else {
			return word;
		}
		
	}
	
	 public void fileWriter(String key,String value,String lang) throws IOException, ParseException {
		    JSONParser parser = new JSONParser();
			File translationFile;
			if(lang.equals("en")) {		
				translationFile = new File("src\\main\\resources\\static\\ENtranslation.json"); 
			}else {
				translationFile = new File("src\\main\\resources\\static\\ARtranslation.json"); 
			}
			path = translationFile.getPath();
					
			FileReader fr = new FileReader(path.replaceAll("\\\\","\\\\\\\\"));
			
			JSONObject obj = (JSONObject) parser.parse(fr);
			  
			JSONObject jsonObject = new JSONObject();
			
			jsonObject = (JSONObject) obj.get(lang);
					
			translate = (Map<String, String>) obj.get(lang);
			 JSONObject object = new JSONObject();
			 if(translate != null) {
			 if(lang.equals("en")){
			    translate.put(key, value);
			    object.put("en", translate);
			 }else if(lang.equals("ar")) {
				 translate.put(key, value);
				 object.put("ar", translate);
			 }else {
			       System.out.println("not available attribute");
			  }
	    	try { 		
	    		 fw = new FileWriter(path.replaceAll("\\\\","\\\\\\\\"));	
	    		 BufferedWriter writer = new BufferedWriter(fw);
				 writer.write(object.toJSONString());
				 writer.newLine();
			     writer.close();
	    		
	    	}catch(IOException e) {
	    		 System.out.println("error in filewriter");
	    	}
			 }else {
				 System.out.println("translate is equal null in filewriter");
			 }
		
	 } 
	 
	 public Translator(String language) throws ParseException, JSONException, IOException {
		 
		 	translate.clear();
			
			JSONParser parser = new JSONParser();
					
			File translationFile = new File("src\\main\\resources\\static\\ENtranslation.json"); 
			
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

	
	
}
