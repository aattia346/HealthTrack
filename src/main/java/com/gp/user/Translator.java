package com.gp.user;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
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
	 private FileWriter fw ;
	 private String path;
	private Map<String , String> translate = new HashMap<String , String>();
	
	
	public Translator() throws ParseException, JSONException, IOException {		
		

	}
	
	public String write(String word,String language) throws IOException, ParseException {
		JSONParser parser = new JSONParser();
		File translationFile;
		if(language.equals("en")) {		
			translationFile = new File("E:\\GP_folder\\json\\ENtranslation.txt"); 
			System.out.println("open ENtranslation.txt");
		}
		else {
			translationFile = new File("E:\\GP_folder\\json\\ARtranslation.txt"); 
			System.out.println("open ARtranslation.txt");
		}
		
		path = translationFile.getPath();
				
		FileReader fr = new FileReader(path.replaceAll("\\\\","\\\\\\\\"));
		
		JSONObject obj = (JSONObject) parser.parse(fr);
		  
		JSONObject jsonObject = new JSONObject();
		
		jsonObject = (JSONObject) obj.get(language);
		//System.out.println("jsonObject :"+ jsonObject);
				
		translate = (Map<String, String>) obj.get(language);
		//System.out.println("translate :"+ translate);
		if(translate.get(word) != null) {
			System.out.println("translate not equal null");
			return translate.get(word);
			
		}else {
			System.out.println("translate is equal to null");
			return word;
			
		}
		
	}
	 public enum langType {
		 en,
		 ar;	 
	 }
	
	 public void fileWriter(String key,String value,String lang) throws IOException, ParseException {
		    JSONParser parser = new JSONParser();
			File translationFile;
			if(lang.equals("en")) {		
				translationFile = new File("E:\\GP_folder\\json\\ENtranslation.txt"); 
			}else {
				translationFile = new File("E:\\GP_folder\\json\\ARtranslation.txt"); 
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
			    System.out.println(translate);
			
			        
	    	try { 		
	    		 fw = new FileWriter(path.replaceAll("\\\\","\\\\\\\\"));	
	    		 BufferedWriter writer = new BufferedWriter(fw);
				 writer.write(object.toJSONString());
				 // System.out.println(translate);
				 writer.newLine();
			     writer.close();
	    		
	    	}catch(IOException e) {
	    		 System.out.println("error in filewriter");
	    	}
			 }else {
				 System.out.println("translate is equal null in filewriter");
			 }
		
	 } 
	
	
}
