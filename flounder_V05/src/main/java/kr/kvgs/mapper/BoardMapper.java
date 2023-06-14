package kr.kvgs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import kr.kvgs.entity.Community;
import kr.kvgs.entity.DetectDis;
import kr.kvgs.entity.Dis_search;
import kr.kvgs.entity.HistoryDetail;
import kr.kvgs.entity.Member;
import kr.kvgs.entity.Reply;
import kr.kvgs.entity.ShareDetail;

public interface BoardMapper {
	// 회원 로그인 처리 메서드 정의
	@Select("select * from member where m_email=#{m_email} and m_pw=#{m_pw}")
	public Member login(Member mvo);

	public List<DetectDis> getHistory(Member mvo);
	public List<Community> getCommunity();
	public List<Dis_search> getSearch(String str_search);
	public String getDsDetail(int ds_id);

	public int dd_insert(DetectDis vo);
	
	public ShareDetail getShareDetail(int c_id);
	
	public HistoryDetail getHistoryDetail(int dd_id);

	public void remove(int c_id);
	
	public Community get(int c_id);

	public int modify(Community com);
	
	public void history_remove(int dd_id);
	
	public int comm_write(Community com);
	
	public int reply_insert(Reply re);

	public List<Reply> getReply(int c_id);
}
