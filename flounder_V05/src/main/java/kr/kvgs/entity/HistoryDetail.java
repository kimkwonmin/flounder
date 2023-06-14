package kr.kvgs.entity;

import java.util.Date;

import lombok.Data;

@Data
public class HistoryDetail {
	private long 	dd_id;
	private String 	org_img;
	private String 	dt_img;
	private String 	dd_email;
	private Date 	dd_date;
	private String 	dd_comment;
	private String 	m_name;
}
