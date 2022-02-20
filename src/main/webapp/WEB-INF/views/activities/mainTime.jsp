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
         <button class="btn__promotion-check" onclick="location.href='/activity/mainTime?hostNo=${param.hostNo }&hostingType=${param.hostingType }&status=A'">전체타임테이블</button>
       </li>
       <li class="promotion-check__item">
         <button class="btn__promotion-check" onclick="location.href='/activity/mainTime?hostNo=${param.hostNo }&hostingType=${param.hostingType }&status=N'">진행중타임테이블</button>
       </li>
       <li class="promotion-check__item">
         <button class="btn__promotion-check" onclick="location.href='/activity/mainTime?hostNo=${param.hostNo }&hostingType=${param.hostingType }&status=Y'">종료된타임테이블</button>
       </li>
     </ul>
     <div class="promotion-add">
       <button class="btn__promotion-add" onclick="location.href='/activity/addTimeTable?hostNo=${param.hostNo }&hostingType=${param.hostingType }'">타임테이블 등록</button>
     </div>
   </section>
   <section class="promotion-discount">
     <table class="host-table">
       <colgroup>
         <col style="width: 15%" />
         <col style="width: 40%" />
         <col style="width: 15%" />
         <col style="width: 15%" />
         <col style="width: 15%" />
       </colgroup>
       <thead>
         <tr>
           <th>상태</th>
           <th>체험시간</th>
           <th>예약인원</th>
           <th>최대인원</th>
           <th></th>
         </tr>
       </thead>
       <tbody>
         <c:choose>
		 <c:when test="${empty timeList}">
			<tr>
				<td style="height: 200px;" colspan="8">등록된 타임테이블이 없습니다.</td>
			</tr>
		 </c:when>
		 <c:otherwise>
			<c:forEach var="timeList" items="${timeList}">
	         <tr>
	           <c:choose>
				 <c:when test="${timeList.closed eq 'N'}">
					<td>진행중</td>
				 </c:when>
				 <c:when test="${timeList.closed eq 'Y'}">
					<td>종료</td>
				 </c:when>
			   </c:choose>
			   <td><fmt:formatDate value="${timeList.time}" pattern="yy년 M월 d일 kk시mm분"/></td>
			   <td>${timeList.soFarBookedNumberOfPeople} 명</td>
			   <td>${actMainDto.actMaximumNumber} 명</td>
			   <td><button class="btn__modal" onclick="location.href='/activity/modifyTime?hostNo=${param.hostNo }&hostingType=${param.hostingType }&no=${timeList.no}'">수정</button></td>
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