package  com.gp.service;

//import java.sql.Time;
//import java.util.Date;

public class serviceClass {
private int id, serviceId;
private String fees, status,rating;

//private int time;


public serviceClass() {
	super();
}
public serviceClass(int id,int serviceId,String status,String fees,String rating) {
	super();
	this.id=id;
	this.serviceId=serviceId;
	this.status=status;
	this.fees=fees;
	this.rating=rating;
	
	//this.time=time;
}

public int getId() {
	return id;
}
public void setId(int id ) {
	this.id=id;
}
public int getserviceId() {
	return serviceId;
}
public void setserviceId(int serviceId) {
	this.serviceId= serviceId;
}
public String getstatus() {
	return status;

}
public void setstatus(String status) {
	this.status=status;
}

public String getfees() {
	return fees;
}
public void setfees (String fees ) {
	this.fees=fees;
}

public String getrating() {
	return rating;
}
public void setrating (String rating ) {
	this.rating=rating;
}



/*
public int getTime() {
	return time;
}
public void setTime(int time) {
 this.time=time;
}
*/
}
