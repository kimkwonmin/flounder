package kr.kvgs.entity;

import java.util.Date;
import lombok.Data;

@Data
public class ShareDetail {
		private int	c_id;
		private String 	title;
		private Date 	c_date;
		private String 	m_name;
		private String 	img_path;
		private String 	c_text;
		private String 	w_email;

}
