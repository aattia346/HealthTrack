package com.gp.user;

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
	
	private Map<String , String> translate = new HashMap<String , String>();
	
	public Translator(String language) throws ParseException, JSONException, IOException {
				
		JSONParser parser = new JSONParser();
				
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
	
	
}
