<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>

<main id="main">
 <article id="host-promotion">
   <section class="promotion-header">
     <ul class="promotion-check__list">
       <li class="promotion-check__item icon">
         <i class="fa-solid fa-square-check"></i>
       </li>
       <li class="promotion-check__item all">
         <button
           class="btn__promotion-check"
           onclick="location.href='/host/mainPromotion?hostNo=${param.hostNo }&hostingType=${param.hostingType }&status=A'"
         >
           전체프로모션
         </button>
       </li>
       <li class="promotion-check__item">
         <button
           class="btn__promotion-check"
           onclick="location.href='/host/mainPromotion?hostNo=${param.hostNo }&hostingType=${param.hostingType }&status=Y'"
         >
           진행중
         </button>
       </li>
       <li class="promotion-check__item">
         <button
           class="btn__promotion-check"
           onclick="location.href='/host/mainPromotion?hostNo=${param.hostNo }&hostingType=${param.hostingType }&status=W'"
         >
           승인대기
         </button>
       </li>
       <li class="promotion-check__item">
         <button
           class="btn__promotion-check"
           onclick="location.href='/host/mainPromotion?hostNo=${param.hostNo }&hostingType=${param.hostingType }&status=N'"
         >
           승인거절
         </button>
       </li>
       <li class="promotion-check__item">
         <button
           class="btn__promotion-check"
           onclick="location.href='/host/mainPromotion?hostNo=${param.hostNo }&hostingType=${param.hostingType }&status=D'"
         >
           종료
         </button>
       </li>
     </ul>
     <div class="promotion-add">
       <button
         class="btn__promotion-add"
         onclick="location.href='/host/addPromotionDiscount?hostNo=${param.hostNo }&hostingType=${param.hostingType }'"
       >
         할인 프로모션 추가
       </button>
       <button
         class="btn__promotion-add"
         onclick="location.href='/host/addPromotionOffer?hostNo=${param.hostNo }&hostingType=${param.hostingType }'"
       >
         증정 프로모션 추가
       </button>
     </div>
   </section>
   
  <!-- 할인 프로모션 --> 
   <section class="promotion-discount">
     <div class="host-main__title">할인 프로모션</div>
     <table class="host-table">
       <colgroup>
         <col style="width: 8%" />
         <col style="width: 40%" />
         <col style="width: 10%" />
         <col style="width: 10%" />
         <col style="width: 8%" />
         <col style="width: 8%" />
         <col style="width: 8%" />
         <col style="width: 8%" />
       </colgroup>
       <thead>
         <tr>
           <th>상태</th>
           <th>소개글</th>
           <th>시작일</th>
           <th>종료일</th>
           <th>평일할인율</th>
           <th>주말할인율</th>
           <th>성수기할인율</th>
           <th></th>
         </tr>
       </thead>
       <tbody>
         <c:choose>
		 <c:when test="${empty promotionDiscountList}">
			<tr>
				<td style="height: 200px;" colspan="8">등록된 할인 프로모션이 없습니다.</td>
			</tr>
		 </c:when>
		 <c:otherwise>
			<c:forEach var="promotionDiscountList" items="${promotionDiscountList}">
	         <tr>
	           <c:choose>
				 <c:when test="${promotionDiscountList.status eq 'Y'}">
					<td>진행중</td>
				 </c:when>
				 <c:when test="${promotionDiscountList.status eq 'W'}">
					<td>승인대기</td>
				 </c:when>
				 <c:when test="${promotionDiscountList.status eq 'N'}">
					<td>승인거절</td>
				 </c:when>
				 <c:when test="${promotionDiscountList.status eq 'D'}">
					<td>종료</td>
				 </c:when>
			   </c:choose>
	           <td>${promotionDiscountList.introContent}</td>
	           <td><fmt:formatDate value="${promotionDiscountList.startingDate}" pattern="yyyy.MM.dd"/></td>
	           <td><fmt:formatDate value="${promotionDiscountList.endingDate}" pattern="yyyy.MM.dd"/></td>
	           <td><fmt:formatNumber value="${promotionDiscountList.weekdaysDiscountRate}" type="percent"/></td>
	           <td><fmt:formatNumber value="${promotionDiscountList.weekendDiscountRate}" type="percent"/></td>
	           <td><fmt:formatNumber value="${promotionDiscountList.peakSeasonDiscountRate}" type="percent"/></td>
	           <td>
	             <button class="btn__modal"
	               onclick="location.href='/host/modifyPromotionDiscount?hostNo=${param.hostNo }&hostingType=${param.hostingType }&no=${promotionDiscountList.no}'"
	             >
	               수정
	             </button>
	           </td>
	         </tr>
           </c:forEach>
		   </c:otherwise>
	     </c:choose>
       </tbody>
     </table>
   </section>
 
  <!-- 증정 프로모션 --> 
   <section class="promotion-event">
     <div class="host-main__title">증정 프로모션</div>
     <table class="host-table">
       <colgroup>
         <col style="width: 10%" />
         <col style="width: 30%" />
         <col style="width: 30%" />
         <col style="width: 10%" />
         <col style="width: 10%" />
         <col style="width: 10%" />
        </colgroup>
        <thead>
          <tr>
            <th>상태</th>
            <th>소개글</th>
            <th>증정품</th>
            <th>시작일</th>
            <th>종료일</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
			<c:when test="${empty promotionOfferList}">
				<tr>
					<td style="height: 200px;" colspan="6">등록된 증정 프로모션이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
			<c:forEach var="promotionOfferList" items="${promotionOfferList}">
	          <tr>
	            <c:choose>
					<c:when test="${promotionOfferList.status eq 'Y'}">
						<td>진행중</td>
					</c:when>
					<c:when test="${promotionOfferList.status eq 'W'}">
						<td>승인대기</td>
					</c:when>
					<c:when test="${promotionOfferList.status eq 'N'}">
						<td>승인거절</td>
					</c:when>
					<c:when test="${promotionOfferList.status eq 'D'}">
						<td>종료</td>
					</c:when>
				</c:choose>
	            <td>${promotionOfferList.introContent}</td>
	            <td>${promotionOfferList.content}</td>
	            <td><fmt:formatDate value="${promotionOfferList.startingDate}" pattern="yyyy.MM.dd"/></td>
	            <td><fmt:formatDate value="${promotionOfferList.endingDate}" pattern="yyyy.MM.dd"/></td>
	            <td>
	              <button class="btn__modal"
	                 onclick="location.href='/host/modifyPromotionOffer?hostNo=${param.hostNo }&hostingType=${param.hostingType }&no=${promotionOfferList.no}'"
	              >
	                수정
	              </button>
	            </td>
	          </tr>
          	</c:forEach>
			</c:otherwise>
		  </c:choose>
        </tbody>
      </table>
    </section>
  </article>
</main>


<script type="text/javascript">
activeMenu('프로모션');

</script>