package com.gp.user;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import java.util.regex.Pattern;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.validator.routines.EmailValidator;

import com.gp.database.DBConnection;


public class Validation {
	
	public static boolean validateUsername(String username) {
		
		return Pattern.matches("\\S[a-zA-Z0-9]*", username);
	}
	
	public static String encryptePssword(String password) throws NoSuchAlgorithmException {
		
		MessageDigest mDigest = MessageDigest.getInstance("SHA1");
        byte[] result = mDigest.digest(password.getBytes());
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < result.length; i++) {
            sb.append(Integer.toString((result[i] & 0xff) + 0x100, 16).substring(1));
        }
		
        return sb.toString();
	}
	
	public static boolean validateEmail(String email) {
		
		EmailValidator emailValidator = EmailValidator.getInstance();
		return emailValidator.isValid(email);
	}
	
	public static boolean checkIfSomethingExists(String somthing , String table, String value)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection con = DBConnection.getConnection();
		String sql="SELECT * FROM " + table +" WHERE "+somthing + " =?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, value);
		ResultSet result = ps.executeQuery();
		result.next();
		boolean exist=false;
		
		if(result.getRow()==1) {
			exist = true;
		}
		
		return exist;
	}
	
	public static boolean validateName(String name) {
		
		return Pattern.matches("\\S[a-zA-Z]*", name.trim());
	}
	
	public static boolean validatePhone(String phone) {
	
		int length = phone.length();
		if(length!=11) {
			return false;
		}else {
			return true;
			}
		}
	
	public static int generateCode() {
		
		Random rand = new Random();

		int  code = rand.nextInt(9999) + 1000;
		//maximum number generated is 9999 and the minimum is 1000
		
		return code;
	}
	
	public static void sendEmail(String RECIPIENT, String name,int code) throws AddressException {
		
		String USER_NAME = "aattia346";  // GMail user name (just the part before "@gmail.com")
		String PASSWORD = "1230asdASD"; // GMail password

		String from = USER_NAME;
	    String pass = PASSWORD;
	    String[] to = { RECIPIENT }; // list of recipient email addresses
	    String subject = "verify your account in HealthTrack";
	    String body = "hi " + name + " your verification code is " + Integer.toString(code);

		    sendFromGMail(from, pass, to, subject, body);
		}

	private static void sendFromGMail(String from, String pass, String[] to, String subject, String body) {
		    Properties props = System.getProperties();
		  String host = "smtp.gmail.com";

		    props.put("mail.smtp.starttls.enable", "true");

		    props.put("mail.smtp.ssl.trust", host);
		    props.put("mail.smtp.user", from);
		    props.put("mail.smtp.password", pass);
		    props.put("mail.smtp.port", "587");
		    props.put("mail.smtp.auth", "true");


		    Session session = Session.getDefaultInstance(props);
		    MimeMessage message = new MimeMessage(session);

		    try {


		        message.setFrom(new InternetAddress(from));
		        InternetAddress[] toAddress = new InternetAddress[to.length];

		        // To get the array of addresses
		        for( int i = 0; i < to.length; i++ ) {
		            toAddress[i] = new InternetAddress(to[i]);
		        }

		        for( int i = 0; i < toAddress.length; i++) {
		            message.addRecipient(Message.RecipientType.TO, toAddress[i]);
		        }



		        message.setSubject(subject);
		        message.setText(body);


		        Transport transport = session.getTransport("smtp");


		        transport.connect(host, from, pass);
		        transport.sendMessage(message, message.getAllRecipients());
		        transport.close();

		    }
		    catch (AddressException ae) {
		        ae.printStackTrace();
		    }
		    catch (MessagingException me) {
		        me.printStackTrace();
		    }
		    }
	  
	public static boolean validateNumber(int num) {
		
		return Pattern.matches("\\S[0-9]*", Integer.toString(num));
	}
	public static boolean validateNumber(String num) {
		
		return Pattern.matches("\\S[0-9]*", num);
	}

	public static boolean validateBookDate(int serviceId, Date bookDate)
	throws ParseException, InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
	
		boolean valid = true;
						
		List<Booking> bookings = ServiceDao.getVerifiedBookingsByServiceId(serviceId);
		
		for(Booking B : bookings) {
			
			if((bookDate.after(B.getDateFrom()) || bookDate.equals(B.getDateFrom())) && (bookDate.before(B.getDateTo()) ||bookDate.equals(B.getDateTo())) ){
				valid = false;
			}
			
		}
		
		return valid;
	}
	
}

