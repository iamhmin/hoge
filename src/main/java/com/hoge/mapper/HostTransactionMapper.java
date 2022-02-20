package com.hoge.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hoge.vo.other.HostTransaction;
import com.hoge.vo.other.Withdrawal;



@Mapper
public interface HostTransactionMapper {
	
	List<HostTransaction> getHostTransactionByHostNo(@Param("no") int no, @Param("begin") int begin, @Param("end") int end);
	
	
	int getHostTransactionCountByHostNo(int no);
	
	void insertHostsalesTransaction(HostTransaction hostTransaction);
}
