package com.gp.user;

import java.io.BufferedReader;
import java.io.OutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class WhatsappSender {
	
	// TODO: Replace the following with your instance ID, Forever Green Client ID and Secret:
	  private static final String INSTANCE_ID = "12";
	  private static final String CLIENT_ID = "aattia346@gmail.com";
	  private static final String CLIENT_SECRET = "5dd8b516919e4d79a266de9f1b696b23";
	  private static final String WA_GATEWAY_URL = "http://api.whatsmate.net/v3/whatsapp/single/text/message/" + INSTANCE_ID;
	  /**
	   * Entry Point
	   
	  public static void main(String[] args) throws Exception {
	    String number = "01099691970";  //  TODO: Specify the recipient's number here. NOT the gateway number
	    String message = "Howdy, isn't this exciting?";

	    WhatsappSender.sendMessage(number, message);
	  }

	  /**
	   * Sends out a WhatsApp message via WhatsMate WA Gateway.
	   */
	  public static void sendMessage(String number, String message) throws Exception {
	    // TODO: Should have used a 3rd party library to make a JSON string from an object
	    String jsonPayload = new StringBuilder()
	      .append("{")
	      .append("\"number\":\"")
	      .append(number)
	      .append("\",")
	      .append("\"message\":\"")
	      .append(message)
	      .append("\"")
	      .append("}")
	      .toString();

	    URL url = new URL(WA_GATEWAY_URL);
	    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	    conn.setDoOutput(true);
	    conn.setRequestMethod("POST");
	    conn.setRequestProperty("X-WM-CLIENT-ID", CLIENT_ID);
	    conn.setRequestProperty("X-WM-CLIENT-SECRET", CLIENT_SECRET);
	    conn.setRequestProperty("Content-Type", "application/json");

	    OutputStream os = conn.getOutputStream();
	    os.write(jsonPayload.getBytes());
	    os.flush();
	    os.close();

	    int statusCode = conn.getResponseCode();
	    System.out.println("Response from WA Gateway: \n");
	    System.out.println("Status Code: " + statusCode);
	    BufferedReader br = new BufferedReader(new InputStreamReader(
	        (statusCode == 200) ? conn.getInputStream() : conn.getErrorStream()
	      ));
	    String output;
	    while ((output = br.readLine()) != null) {
	        System.out.println(output);
	    }
	    conn.disconnect();
	  }

	}