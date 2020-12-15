package com.highradius.internship;

public class Entity {
	Integer orderId;
	String customerName;
	Integer customerId;
	Integer orderAmount;
	String status;
	String approvedBy;
	String notes;
	String date;
	
	public Entity()
	{
	}
	
	public Entity(Integer orderId, String customerName, Integer customerId, Integer orderAmount, String status,
			String approvedBy, String notes, String date) {
		super();
		this.orderId = orderId;
		this.customerName = customerName;
		this.customerId = customerId;
		this.orderAmount = orderAmount;
		this.status = status;
		this.approvedBy = approvedBy;
		this.notes = notes;
		this.date = date;
	}
	public Integer getOrederId() {
		return orderId;
	}
	public void setOrederId(Integer orderId) {
		this.orderId = orderId;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public Integer getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}
	public Integer getOrderAmount() {
		return orderAmount;
	}
	public void setOrderAmount(Integer orderAmount) {
		this.orderAmount = orderAmount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getApprovedBy() {
		return approvedBy;
	}
	public void setApprovedBy(String approvedBy) {
		this.approvedBy = approvedBy;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	

}
