package artn.common.model;

import java.util.Map;

public class Delivery {
	private int id_delivery;
	private int id_group;
	private int delivery_price;
	private int free_condition;
	private int status;
	
	public Delivery(){}
	public Delivery(Map<String, Object> values){
		id_delivery = (Integer)values.get("id_delivery");
		id_group = (Integer)values.get("id_group");
		delivery_price = (Integer)values.get("delivery_price");
		free_condition = (Integer)values.get("free_condition");
		status = (Integer)values.get("status");
	}
	
	public int getId_delivery() {
		return id_delivery;
	}
	public void setId_delivery(int id_delivery) {
		this.id_delivery = id_delivery;
	}	
	public int getId_group() {
		return id_group;
	}
	public void setId_group(int id_group) {
		this.id_group = id_group;
	}
	public int getDelivery_price() {
		return delivery_price;
	}
	public void setDelivery_price(int delivery_price) {
		this.delivery_price = delivery_price;
	}
	public int getFree_condition() {
		return free_condition;
	}
	public void setFree_condition(int free_condition) {
		this.free_condition = free_condition;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}
