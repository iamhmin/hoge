<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title></title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div class="container">
	<div>
		<h1>RESERVATIONS</h1>
		<P>예약 확인</P>
		<h1>감사합니다. 예약신청이 완료되었습니다.</h1>
	</div>
	<div class="row mb-3">
		<div class="col-6">
			<div>
				<h2>${activity.name }</h2>
				<p><fmt:formatDate value="${book.activityTime }" pattern="yyyy-MM-dd HH:ss"/><br/>
				인원 : ${book.numberOfPeople } 명</p>
			</div>
			<div>
				<h3>￦<fmt:formatNumber value="${book.paidPrice }" /></h3>
				<p>결제 완료(<fmt:formatDate value="${book.bookingMadeDate }" pattern="yyyy-MM-dd"/>)
			</div>
		</div>
		<div class="col-6">
			<img style="height: 500px;" alt="activityImage" src="/resources/images/activities/${images[0].image}">
		</div>
	</div>
	<div class="row">
		<div class="col" style="width: 100%">
			<table class="table" style="table-layout: fixed;">
				<thead>
					<tr>
						<th>예약 번호</th>
						<th>이름</th>
						<th>연락처</th>
						<th>이메일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${book.no }</td>
						<td>${user.name }</td>
						<td>${user.tel }</td>
						<td>${user.email }</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<button type="button" class="btn btn-dark">예약 상세 확인</button>
			<button type="button" class="btn btn-light">예약 취소</button>
		</div>
	</div>
</div>
</body>
</html>