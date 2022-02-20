<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>

<main id="main">
   <article id="host-main">
     <section class="host-main__info-box">
       <div class="host-main__img"
        style='background-image: url("/resources/images/hostMainImage/${accMainDto.mainImage}")'
       ></div>
       <div class="host-main__info">
         <div class="accommo-info__btn">
           <button class="btn__accommo-modify"
            onclick="location.href='/host/modify?hostNo=${param.hostNo }&hostingType=${param.hostingType }'"
            >호스트 수정</button>
           <button class="btn__accommo-addition"
            onclick="location.href='/host/addAccInfo?hostNo=${param.hostNo }&hostingType=${param.hostingType }'"
            >
             부대시설 및 기타 안내사항 등록
           </button>
         </div>
         <ul class="accommo-info__list">
           <li class="accommo-info__item">
             <div class="accommo-info__label">연락처</div>
             <div class="accommo-info__content">${savedHost.tel}</div>
           </li>
           <li class="accommo-info__item">
             <div class="accommo-info__label">주소</div>
             <div class="accommo-info__content">
               ${accMainDto.accAddress}
             </div>
           </li>
           <li class="accommo-info__item">
             <div class="accommo-info__label">체크인/아웃</div>
             <div class="accommo-info__content">${accMainDto.accCheckInTime} / ${accMainDto.accCheckOutime}</div>
           </li>
         </ul>
         <table class="accommo-info__table">
           <colgroup>
             <col style="width: 17%" />
             <col style="width: 14%" />
             <col style="width: 14%" />
             <col style="width: 14%" />
             <col style="width: 13%" />
             <col style="width: 13%" />
             <col style="width: 15%" />
           </colgroup>
           <thead>
             <tr>
               <th>객실</th>
               <th>평일</th>
               <th>주말</th>
               <th>성수기</th>
               <th>기준인원</th>
               <th>최대인원</th>
               <th>
                 초과시 <br />
                 인당가격
               </th>
             </tr>
           </thead>
           <tbody>
             <c:forEach var="room" items="${roomList }" varStatus="loop">
             <tr>
               <td>${room.name }</td>
               <td><fmt:formatNumber value="${room.weekdaysPrice}" pattern="#,###" /></td>
               <td><fmt:formatNumber value="${room.weekendPrice}" pattern="#,###" /></td>
               <td><fmt:formatNumber value="${room.peakSeasonPrice}" pattern="#,###" /></td>
               <td>${room.standardNumber }</td>
               <td>${room.maximumNumber }</td>
               <td><fmt:formatNumber value="${room.pricePerPerson}" pattern="#,###" /></td>
             </tr>
             </c:forEach> 
           </tbody>
         </table>
       </div>
     </section>
     <section class="host-main__check-box">
       <div class="accommo-check-in">
         <div class="host-main__title">오늘 체크인 게스트</div>
         <c:if test="${empty todayCheckInList }">
	  	  <div class="check-empty">체크인 예정인 게스트가 없습니다.</div>
	  	 </c:if> 
	  	 <c:if test="${not empty todayCheckInList }"> 	
         <table class="host-main__table">
           <colgroup>
             <col style="width: 20%" />
             <col style="width: 30%" />
             <col style="width: 17%" />
             <col style="width: 20%" />
             <col style="width: 13%" />
           </colgroup>
           <thead>
             <tr>
               <th>객실</th>
               <th>기간</th>
               <th>게스트</th>
               <th>연락처</th>
               <th>추가인원</th>
             </tr>
           </thead>
           <tbody>
             <c:forEach var="checkIn" items="${todayCheckInList }" varStatus="loop">
             <tr>
               <td>${checkIn.roomName }</td>
               <td><fmt:formatDate value="${checkIn.checkInDate }" pattern="yyyy-MM-dd" type="date"/>~
                 <fmt:formatDate value="${checkIn.checkOutDate }" pattern="yyyy-MM-dd" type="date"/></td>
               <td>${checkIn.roomUserName }</td>
               <td>${checkIn.roomUserTel }</td>
               <td>${checkIn.extraPeople }</td>
             </tr>
             </c:forEach>
           </tbody>
         </table>
         </c:if>
       </div>
       <div class="accommo-check-out">
         <div class="host-main__title">오늘 체크아웃 게스트</div>
         <c:if test="${empty todayCheckOutList}">
	  	   <div class="check-empty">체크아웃 예정인 게스트가 없습니다.</div>
	  	 </c:if> 
	  	 <c:if test="${not empty todayCheckOutList}"> 	
         <table class="host-main__table">
           <colgroup>
             <col style="width: 20%" />
             <col style="width: 30%" />
             <col style="width: 17%" />
             <col style="width: 20%" />
             <col style="width: 13%" />
           </colgroup>
           <thead>
             <tr>
             
               <th>객실</th>
               <th>기간</th>
               <th>게스트</th>
               <th>연락처</th>
               <th>추가인원</th>
             </tr>
           </thead>
           <tbody>
             <c:forEach var="checkOut" items="${todayCheckOutList }" varStatus="loop">
             <tr>
               <td>${checkOut.roomName }</td>
               <td><fmt:formatDate value="${checkOut.checkInDate }" pattern="yyyy-MM-dd" type="date"/>~
               <fmt:formatDate value="${checkOut.checkOutDate }" pattern="yyyy-MM-dd" type="date"/></td>
               <td>${checkOut.roomUserName }</td>
               <td>${checkOut.roomUserTel }</td>
               <td>${checkOut.extraPeople }</td>
             </tr>
             </c:forEach>
           </tbody>
         </table>
         </c:if>
       </div>
     </section>
     <section class="host-main__review-box">
       <div class="host-main__title">
         최근 3일간 리뷰 today (+ <span>${todayReviewCount }</span>)
       </div>
       <table class="host-main__table">
         <colgroup>
           <col style="width: 8%" />
           <col style="width: 8%" />
           <col style="width: 8%" />
           <col style="width: 8%" />
           <col style="width: 48%" />
           <col style="width: 10%" />
           <col style="width: 10%" />
         </colgroup>
         <thead>
           <tr>
             <th>청결도</th>
             <th>의사소통</th>
             <th>정확도</th>
             <th>위치</th>
             <th>내용</th>
             <th>작성일</th>
             <th>답변여부</th>
           </tr>
         </thead>
         <tbody id="dataSection">
           
         </tbody>
       </table>
       <div id="pagination">
        <ul class="pagination__list" id="paginationBox">
          
        </ul>
      </div>
     </section>
     <section class="host-main__reservation-box">
       <div class="host-main__title">
         최근 3일간 예약내역 today (+ <span>${todayBookingCount }</span>)
       </div>
       <table class="host-main__table">
         <colgroup>
           <col style="width: 18%" />
           <col style="width: 20%" />
           <col style="width: 18%" />
           <col style="width: 16%" />
           <col style="width: 14%" />
           <col style="width: 14%" />
         </colgroup>
         <thead>
           <tr>
             <th>객실이름</th>
             <th>기간</th>
             <th>예약자</th>
             <th>연락처</th>
             <th>예약상태</th>
             <th>추가인원</th>
           </tr>
         </thead>
         <tbody id="dataSection1">
          
         </tbody>
       </table>
       <div id="pagination">
        <ul class="pagination__list" id="paginationBox1">
          
        </ul>
      </div>
     </section>
   </article>
 </main>

	
<script type="text/javascript">
const accNo = ${accMainDto.accNo};
getMainBookingList();
getMainAccReviewList();
function getMainAccReviewList(page) {
	
	
			$.ajax({
				type: 'POST',
				url : "/host/getMainAccReviewList.do", //서비스 주소 
				data : { //서비스 처리에 필요한 인자값
					page : page,
					no : accNo
				},
				success : function(result) {
					const list = result['list'];
					const pagination = result['pagination'];
					var data = "";
					var block = "";

					console.log(pagination);
					console.log(list);
					for (var i = 0; i < list.length; i++) {
						data += "<tr>";
						data += "<td>" + list[i].cleanlinessStar + "</td>";
						data += "<td>" + list[i].communicationStar + "</td>";
						data += "<td>" + list[i].accuracyStar + "</td>";
						data += "<td>" + list[i].locationStar + "</td>";
						data += "<td>" + list[i].content + "</td>";
						data += "<td>" + list[i].createdDate + "</td>";
						if (list[i]['answered'] == 'N') {
						data += "<td>미완료</td>";
						} else {
							data += "<td>완료</td>";
						} 
						data += "</tr>";
					}
					$("#dataSection").html(data);

					// 이전버튼 활성화 여부를 결정하는 부분
					if (pagination['prevPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='getMainAccReviewList("
								+ (pagination['beginPage'] - 1)
								+ ")'> <i class='fas fa-chevron-left'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-left'></i> </a></li>";
					}

					// 번호를 표시하는 부분
					for (var i = pagination['beginPage']; i <= pagination['endPage']; i++) {
						if (page !== i) {
							block += "<li class='page-item'><a class='page-link' onclick='getMainAccReviewList("
									+ i + ")'>" + (i) + "</a></li>";
						} else {
							block += "<li class='page-item disabled'><a class='page-link'>"
									+ (i) + "</a></li>";
						}
					}

					if (pagination['nextPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='getMainAccReviewList("
								+ (pagination['endPage'] + 1)
								+ ")'> <i class='fas fa-chevron-right'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-right'></i> </a></li>";
					}
					
					$("#paginationBox").html(block);
				}
			})
}
function getMainBookingList(page) {
	
	
			$.ajax({
				type: 'POST',
				url : "/host/getMainBookingList.do", //서비스 주소 
				data : { //서비스 처리에 필요한 인자값
					page : page,
					no : accNo
				},
				success : function(result) {
					const list = result['list'];
					const pagination = result['pagination'];
					var data = "";
					var block = "";

					console.log(pagination);
					console.log(list);
					for (var i = 0; i < list.length; i++) {
						data += "<tr>";
						data += "<td>" + list[i].roomName + "</td>";
						data += "<td>" + list[i].checkInDate+ "~" + list[i].checkOutDate + "</td>";
						data += "<td>" + list[i].roomUserName; + "</td>";
						data += "<td>" + list[i].roomUserTel + "</td>";
						if (list[i]['status'] == 1) {
						data += "<td>예약중</td>";
						} else if (list[i]['status'] == 2) {
							data += "<td>예약취소</td>";
						} else {
							data += "<td>종료</td>";
						}
						data += "<td>" + list[i].extraPeople  + "</td>";
						data += "</tr>";
					}
					$("#dataSection1").html(data);

					// 이전버튼 활성화 여부를 결정하는 부분
					if (pagination['prevPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='getMainBookingList("
								+ (pagination['beginPage'] - 1)
								+ ")'> <i class='fas fa-chevron-left'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-left'></i> </a></li>";
					}

					// 번호를 표시하는 부분
					for (var i = pagination['beginPage']; i <= pagination['endPage']; i++) {
						if (page !== i) {
							block += "<li class='page-item'><a class='page-link' onclick='getMainBookingList("
									+ i + ")'>" + (i) + "</a></li>";
						} else {
							block += "<li class='page-item disabled'><a class='page-link'>"
									+ (i) + "</a></li>";
						}
					}

					if (pagination['nextPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='getMainBookingList("
								+ (pagination['endPage'] + 1)
								+ ")'> <i class='fas fa-chevron-right'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-right'></i> </a></li>";
					}
					
					$("#paginationBox1").html(block);
				}
			})
}


</script>
	
	