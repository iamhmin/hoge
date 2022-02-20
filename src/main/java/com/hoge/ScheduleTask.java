package com.hoge;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.hoge.dto.ActivityBookingBatchDto;
import com.hoge.dto.RoomBookingBatchDto;
import com.hoge.service.HostTransactionService;
import com.hoge.service.ScheduleTaskService;
import com.hoge.vo.other.HostTransaction;

@Component
public class ScheduleTask {

	// 서비스나 디에이오 매퍼 오토와이어드 해서 실행한다.
	@Autowired 
	ScheduleTaskService scheduleTaskService;
	
	@Autowired 
	HostTransactionService hostTransactionService;

			
	
	@Scheduled(cron = "	0 * * * * ?")
	public void sendHostPaidMoney() {
		//관리자 앞으로 입금된 금액을 호스트에게 보낸다
				//방 체크인 익일 12시에 보냄
		
		List<RoomBookingBatchDto> roomBookingBatchDto = scheduleTaskService.getRoomBookingBatchDto();
		 System.out.println(roomBookingBatchDto);
		 for (RoomBookingBatchDto dto : roomBookingBatchDto) {
			 scheduleTaskService.completeAccBookingState(dto.getRoomBookingNo());
			 long amount = (long) ((1 - dto.getCommissionRate()) * dto.getRoomTaxIncludedPrice());
			 System.out.println(amount);
			 scheduleTaskService.sendHostBookingPayment(dto.getHostNo(),amount);
			 
			 HostTransaction hostTransaction = new HostTransaction();
			 hostTransaction.setAmount(amount);
			 hostTransaction.setType(1);
			 hostTransaction.setHostNo(dto.getHostNo());
			 hostTransactionService.insertHostsalesTransaction(hostTransaction);
			 
			 long pnt = (long) (dto.getRoomPaidPrice()*0.01);
			 System.out.println(pnt);
			 scheduleTaskService.addUserPoint(dto.getUserNo(), pnt);
			 
		 }
		
		 List<ActivityBookingBatchDto> activityBookingBatchDto  = scheduleTaskService.getActivityBookingBatchDto();
		 for (ActivityBookingBatchDto dto : activityBookingBatchDto) {
			 scheduleTaskService.completeActBookingState(dto.getActivityBookingNo());
			 long amount = (long) ((1 - dto.getCommissionRate()) * dto.getTaxIncludedPrice());
			 System.out.println(amount);
			 scheduleTaskService.sendHostBookingPayment(dto.getHostNo(),amount);
			 
			 HostTransaction hostTransaction = new HostTransaction();
			 hostTransaction.setAmount(amount);
			 hostTransaction.setType(1);
			 hostTransaction.setHostNo(dto.getHostNo());
			 hostTransactionService.insertHostsalesTransaction(hostTransaction);
			 
			 long pnt = (long) (dto.getPaidPrice()*0.01);
			 System.out.println(pnt);
			 scheduleTaskService.addUserPoint(dto.getUserNo(), pnt);
			 
			 
			 
		 }
		 
	}
	
	@Scheduled(cron = "	0 1 * * * ?")
	public void expirePromotion() {
		//프로모션 기간 만료되게 만드는 메소드
		scheduleTaskService.closePromotion();
	}
	
	@Scheduled(cron = "	0 1 * * * ?")
	public void expireActivityTime() {
		//체험타임테이블 기간 만료되게 만드는 메소드
		scheduleTaskService.closeActivityTime();
	}
}
