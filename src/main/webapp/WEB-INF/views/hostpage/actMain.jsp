<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>

<main id="main">
   <article id="host-main">
     <section class="host-main__info-box">
       <div class="host-main__img"
        style='background-image: url("/resources/images/hostMainImage/${actMainDto.mainImage}")'
       ></div>
       <div class="host-main__info">
         <div class="accommo-info__btn">
           <button class="btn__accommo-modify"
            onclick="location.href='/host/modify?hostNo=${param.hostNo }&hostingType=${param.hostingType }'"
            >호스트 수정</button>
           <button class="btn__accommo-addition"
            onclick="location.href='/host/addActInfo?hostNo=${param.hostNo }&hostingType=${param.hostingType }'"
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
               ${actMainDto.actAddress}
             </div>
           </li>
           <li class="accommo-info__item">
             <div class="accommo-info__label">최대인원/인당가격</div>
             <div class="accommo-info__content">${actMainDto.actMaximumNumber }명 / <fmt:formatNumber value="${actMainDto.actPricePerPerson}" pattern="#,###" />원</div>
           </li>
         </ul>
         <table class="accommo-info__table">
           <colgroup>
             <col style="width: 40%" />
             <col style="width: 30%" />
             <col style="width: 30%" />
             
           </colgroup>
           <thead>
             <tr>
               <th>time</th>
               <th>예약인원</th>
               <th>마감여부</th>
             </tr>
           </thead>
           <tbody>
             <c:forEach var="act" items="${actTimeList }" varStatus="loop">
             <tr>
               <td><fmt:formatDate value="${act.time }" pattern="yy-MM-dd hh:mm" type="date"/></td>
               <td>${act.soFarBookedNumberOfPeople } / ${actMainDto.actMaximumNumber }</td>
              <c:if test="${act.closed == 'N'}">
              <td>예약중</td>
              </c:if> 
              <c:if test="${act.closed == 'Y'}">
              <td>마감</td>
              </c:if> 
             </tr>
             </c:forEach> 
           </tbody>
         </table>
       </div>
     </section>
       
     <section class="host-main__review-box">
       <div class="host-main__title">
         최근 3일간 리뷰 today (+ <span>${todayReviewCount }</span>)
       </div>
       <table class="host-main__table">
         <colgroup>
           <col style="width: 8%" />
           <col style="width: 48%" />
           <col style="width: 10%" />
           <col style="width: 10%" />
         </colgroup>
         <thead>
           <tr>
             <th>별점</th>
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
           <col style="width: 18%" />
           <col style="width: 16%" />
           <col style="width: 14%" />
           <col style="width: 14%" />
         </colgroup>
         <thead>
           <tr>
             <th>시간</th>
             <th>예약자</th>
             <th>연락처</th>
             <th>예약상태</th>
             <th>신청인원</th>
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
const actNo = ${actMainDto.actNo};
getMainBookingList();
getMainActReviewList();
function getMainActReviewList(page) {
	
	
			$.ajax({
				type: 'POST',
				url : "/host/getMainActReviewList.do", //서비스 주소 
				data : { //서비스 처리에 필요한 인자값
					page : page,
					no : actNo
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
						data += "<td>" + list[i].star + "</td>";
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
						block += "<li class='page-item'><a class='page-link' onclick='getMainActReviewList("
								+ (pagination['beginPage'] - 1)
								+ ")'> <i class='fas fa-chevron-left'></i> </a></li>";
					} else {
						block += "<li class='page-item disabled'><a class='page-link'> <i class='fas fa-chevron-left'></i> </a></li>";
					}

					// 번호를 표시하는 부분
					for (var i = pagination['beginPage']; i <= pagination['endPage']; i++) {
						if (page !== i) {
							block += "<li class='page-item'><a class='page-link' onclick='getMainActReviewList("
									+ i + ")'>" + (i) + "</a></li>";
						} else {
							block += "<li class='page-item disabled'><a class='page-link'>"
									+ (i) + "</a></li>";
						}
					}

					if (pagination['nextPage']) {
						block += "<li class='page-item'><a class='page-link' onclick='getMainActReviewList("
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
				url : "/host/getMainActBookingList.do", //서비스 주소 
				data : { //서비스 처리에 필요한 인자값
					page : page,
					no : actNo
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
						data += "<td>" + list[i].activityTime + "</td>";
						data += "<td>" + list[i].participantName + "</td>";
						data += "<td>" + list[i].participantTel + "</td>";
						if (list[i]['status'] == 1) {
						data += "<td>예약중</td>";
						} else if (list[i]['status'] == 2) {
							data += "<td>예약취소</td>";
						} else {
							data += "<td>종료</td>";
						}
						data += "<td>" + list[i].numberOfPeople  + "명</td>";
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
	
	