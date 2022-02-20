package com.hoge.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hoge.mapper.HostTransactionMapper;
import com.hoge.mapper.StatisticsMapper;
import com.hoge.vo.other.HostTransaction;

/**
 * 
 * @author 성하민
 *
 */
@Service
public class HostTransactionService {

	
	@Autowired
	private HostTransactionMapper hostTransactionMapper;
	//성하민
	public List<HostTransaction> getHostTransactionByHostNo(int no, int begin, int end){
		return hostTransactionMapper.getHostTransactionByHostNo(no, begin, end);
	}
	//성하민
	public int getHostTransactionCountByHostNo(int no) {
		return hostTransactionMapper.getHostTransactionCountByHostNo(no);
	}
	

	public void insertHostsalesTransaction(HostTransaction hostTransaction) {
		hostTransactionMapper.insertHostsalesTransaction(hostTransaction);
	}
	
}
