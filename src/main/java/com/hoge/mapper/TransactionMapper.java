package com.hoge.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import com.hoge.form.Criteria;
import com.hoge.vo.other.Transaction;



@Mapper
public interface TransactionMapper {
	
	List<Transaction> getTransactionList(Criteria criteria);
	
	int getTransactionListTotalRows(Criteria criteria);
	
	
	long getTotalDeposit(Criteria criteria);
	long getTotalWithdrawal(Criteria criteria);
	
	void insertHostTransaction(Transaction transaction);
	void insertUserTransaction(Transaction transaction);
	
	Transaction getlatestTransaction();
	
	
}
