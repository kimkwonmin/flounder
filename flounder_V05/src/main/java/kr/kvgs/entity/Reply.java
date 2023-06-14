package kr.kvgs.entity;

import java.util.Date;

import lombok.Data;

@Data
public class Reply {
	private int r_id;
	private int c_id;
	private String r_email;
	private Date r_date;
	private String reply;
	private String r_name;
}

