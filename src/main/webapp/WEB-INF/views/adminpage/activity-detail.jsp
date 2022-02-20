<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<!-- 
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
 -->	
 <style>

#mainImg { width: 450px; height:350px;}
</style>
<main id="main">
    <article id="admin-user">
    	<div class="row">
    		<div class="col-4">
    			 <img
	              src="../../resources/images/hostMainImage/${host.mainImage }"
	              id="mainImg"
	            />
    		</div>
    		<div class="col-8">
		    	<p>호스트 기본 정보</p>
		 		<table class="user-list-table mt-2 mb-5">
					<colgroup>
		            <col style="width: 8%" />
		            <col style="width: 10%" />
		            <col style="width: 8%" />
		            <col style="width: 16%" />
		            <col style="width: 10%" />
		            <col style="width: 10%" />
		            <col style="width: 10%" />
		          </colgroup>
		          <thead>
		            <tr>
		              <th>호스트번호</th>
		              <th>호스트이름</th>
		              <th>회원번호</th>
		              <th>연락처</th>
		              <th>등급</th>
		              <th>승인</th>
		              <th>승인상세</th>
		            </tr>
		          </thead>
					<tbody>
						<tr class="text-middle">
							<td>${host.no }</td>
							<td>${host.name }</td>
							<td>${host.userNo }</td>
							<td>${host.tel }</td>
							<td>${host.gradeName }</td>
							<td>${host.status }</td>
							<td>${host.statusDetail }</td>
						</tr>
					</tbody>
				</table>
				<p>출금정보</p>
		 		<table class="user-list-table mt-2">
					<colgroup>
		            <col style="width: 25%" />
		            <col style="width: 25%" />
		            <col style="width: 25%" />
		            <col style="width: 25%" />
		          </colgroup>
		          <thead>
		            <tr>
		              <th>현재 누적금액</th>
		              <th>예금주</th>
		              <th>계좌번호</th>
		              <th>은행명</th>
		            </tr>
		          </thead>
					<tbody>
						<tr class="text-middle">
							<td><fmt:formatNumber value="${host.accumulatedMoney }" pattern="#,###" />원</td>
							<td>${host.accountHolderName }</td>
							<td>${host.accountNumber }</td>
							<td>${host.bankName }</td>
						</tr>
					</tbody>
				</table>
    		</div>
    	</div>
    	
    
    	
    	<p>숙소정보</p>
    	<div class="row">
    		<div class="col-4">
    		</div>
    		
    	</div>	
    	
    	<p>객실 리스트</p>
    	<div class="row">
    		<div class="col-4">
				    		<table border="1" bordercolor="blue" width ="500" height="300" align = "center" >
				    <tr bgcolor="blue" align ="center">
					<p><td colspan = "3" span style="color:white">오늘의 수입/지출</td></p>
				    </tr>
				    <tr align = "center" bgcolor="skybule">
					<td>내용</td>
					<td>수입</td>
					<td>지출</td>
					<td>지출</td>
				    </tr>
				    <tr>
					<td>월급!</td>
					<td>1,000,000</td>
					<td></td>
					<td></td>
				    </tr>
				    <tr>
					<td>점심값</td>
					<td></td>
					<td>5,000</td>
					<td>5,000</td>
				    </tr>
				    <tr>
					<td>부모님선물</td>
					<td></td>
					<td>30,000</td>
					<td>30,000</td>
				    </tr>
				    <tr>
					<td rowspan="3" align = "center" bgcolor="skyblue">총계</td>
					<td>수입</td>
					<td>지출</td>
					<td>지출</td>
				    </tr>
				    <tr>
					<td>1,000,000</td>
					<td>35,000</td>	
					<td>35,000</td>	
				    </tr>
				    <tr>
					<td>남은돈</td>
					<td>965,000</td>	
					<td>965,000</td>	
				    </tr>
				</table>
    		</div>
    		
    	</div>	
    	
    	<p>출금정보</p>
    	<div class="row">
    		<div class="col-4">
    		</div>
    		
    	</div>	
     	

  
	</article>
</main>

<script type="text/javascript">
$(function(){
	
	activeMenuTab("숙소관리");
	})




</script>

</html>