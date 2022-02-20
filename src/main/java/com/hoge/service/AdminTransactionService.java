package com.hoge.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hoge.dto.WithdrawalHostDto;
import com.hoge.form.Criteria;
import com.hoge.mapper.TransactionMapper;
import com.hoge.mapper.WithdrawalMapper;
import com.hoge.vo.other.Transaction;
import com.hoge.vo.other.Withdrawal;

/**
 * 
 * @author 성하민
 *
 */
@Service
public class AdminTransactionService {

	
	@Autowired
	private TransactionMapper transactionMapper;
	@Autowired
	private WithdrawalMapper withdrawalMapper;
	
	public List<Transaction> getTransactionList(Criteria criteria){
		List<Transaction> transactionList = transactionMapper.getTransactionList(criteria);
		return transactionList;
	}
	
	public int getTransactionListTotalRows(Criteria criteria) {
		return transactionMapper.getTransactionListTotalRows(criteria);
		
	}
	
	public long getTotalDeposit(Criteria criteria) {
		return transactionMapper.getTotalDeposit(criteria);
	}
	public long getTotalWithdrawal(Criteria criteria) {
		return transactionMapper.getTotalWithdrawal(criteria);
		
	}
	


	  public List<WithdrawalHostDto> getApprovedWithdrawalList(Criteria criteria){
		  return withdrawalMapper.getApprovedWithdrawalList(criteria);
	  }
	  public int getApprovedWithdrawalCount(Criteria criteria) {
		  return withdrawalMapper.getApprovedWithdrawalCount(criteria);
	  }
	
	  
	   
	  
	  public List<WithdrawalHostDto> getWaitingWithdrawalList(Criteria criteria){
		  return withdrawalMapper.getWaitingWithdrawalList(criteria);
	  }
	  public int getWaitingWithdrawalCount(Criteria criteria) {
		  return withdrawalMapper.getWaitingWithdrawalCount(criteria);
	  }
	  
	  public void approveWithdrawal(int withdrawalNo) {
		  withdrawalMapper.approveWithdrawal(withdrawalNo);
	  }
	  
	  public void insertHostTransaction(Transaction transaction) {
		  transactionMapper.insertHostTransaction(transaction);
	  }
		
	  public Withdrawal getWithdrawalByWithdrawalNo(int no){
		  return withdrawalMapper.getWithdrawalByWithdrawalNo(no);
	  }
	  
	  public Transaction getlatestTransaction() {
		  return transactionMapper.getlatestTransaction();
	  }
	  
}
