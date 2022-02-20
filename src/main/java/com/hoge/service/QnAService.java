package com.hoge.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hoge.dto.AdminHostQnADto;
import com.hoge.dto.AdminUserQnADto;
import com.hoge.form.CriteriaAdminQnA;
import com.hoge.form.CriteriaAdminUser;
import com.hoge.mapper.QnAMapper;
import com.hoge.vo.other.HostQnA;
import com.hoge.vo.other.UserQnA;

/**
 * 
 * @author 성하민, 유상효
 *
 */
@Service
public class QnAService {
	
	@Autowired
	private QnAMapper qnAMapper;
	

	// 성하민 호스트번호로 문의글 찾기
	public List<HostQnA> getHostQnAListByHostNo(int no, int begin, int end) {

		return qnAMapper.getHostQnAListByHostNo(no, begin, end);
	}
	//성하민
	public List<UserQnA> getUserQnAListByUserNo(int no, int begin, int end) {
		
		return qnAMapper.getUserQnAListByUserNo(no, begin, end); 
	}	
		
		
	//성하민 호스트페이지 문의 등록
	public void insertHostQnA(HostQnA hostQnA) {
		qnAMapper.insertHostQnA(hostQnA);
	}
	
	//성하민 마이페이지 문의 등록
	public void insertUserQnA(UserQnA userQnA) {
		qnAMapper.insertUserQnA(userQnA);
	}
	
	//호스트 넘버로 문의글 개수 찾기
	public int getHostQnACountByHostNo(int no) {
		return qnAMapper.getHostQnACountByHostNo(no);
	}
	
	//유저 넘버로 문의글 개수 찾기
	public int getUserQnACountByUserNo(int no) {
		return qnAMapper.getUserQnACountByUserNo(no);
	}


	// 성하민
	public int getUserQnAsTotalRows(CriteriaAdminQnA criteriaAdminQnA) {
		return qnAMapper.getUserQnAsTotalRows(criteriaAdminQnA);
	}
		
	// 성하민
	public List<AdminUserQnADto> getUserQnAsByCriteria(CriteriaAdminQnA criteriaAdminQnA) {
		return qnAMapper.getUserQnAsByCriteria(criteriaAdminQnA);
	}
	
	public UserQnA getUserQnAbyQnANo(int no) {
		return qnAMapper.getUserQnAbyQnANo(no);
	}
	public AdminUserQnADto getUserQnADtobyQnANo(int no) {
		return qnAMapper.getUserQnADtobyQnANo(no);
	}
	
	public void updateUserQnA(UserQnA userQnA) {
		qnAMapper.updateUserQnA(userQnA);
	}
	
	
	public int getHostQnAsTotalRows(CriteriaAdminQnA criteriaAdminQnA) {
		return qnAMapper.getHostQnAsTotalRows(criteriaAdminQnA);
	}
	
	// 성하민
	public List<AdminHostQnADto> getHostQnAsByCriteria(CriteriaAdminQnA criteriaAdminQnA){
		return qnAMapper.getHostQnAsByCriteria(criteriaAdminQnA);
	}
	
	public AdminHostQnADto getHostQnADtobyQnANo(int no) {
		return qnAMapper.getHostQnADtobyQnANo(no);
	}
	
	//답변쓰기
	public HostQnA getHostQnAbyQnANo(int no) {
		return qnAMapper.getHostQnAbyQnANo(no);
	}
	//업데이트
	public void updateHostQnA(HostQnA hostQnA) {
		qnAMapper.updateHostQnA(hostQnA);
	}
	
	
	
	
}
