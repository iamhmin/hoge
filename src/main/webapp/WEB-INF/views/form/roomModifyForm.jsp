<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../views/common/tags.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
	<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
  <meta charset="UTF-8">
  <title>객실 수정</title>
</head>
<body>
	<form class="border p-3 bg-light" id="roomModify" method="post" action="roomModify" enctype="multipart/form-data">
		<div class="row mb-3 ">
			<div class="col text-center">
				<h1>객실 수정하기</h1>
			</div>
		</div>
		<div class="row mb-3 d-flex justify-content-center">
			<div class="col-6 text-center">
				<div class="mb-3">
					<input type="hidden" value="${accMainDto.accNo }" id="accommoNo" name="accommoNo" />
					<input type="hidden" value="${accMainDto.hostNo }" id="hostNo" name="hostNo" />
					<input type="hidden" value="${accMainDto.hostingType }" id="hostingType" name="hostingType" />
					<input type="hidden" value="${roomDto.no }" id="no" name="no" />
				</div>
				<div class="mb-3">
					<label class="form-label">객실 이름</label>
					<input type="text" class="form-control" id="name" name="name" value="${roomDto.name }"/>
				</div>
				<div class="mb-3">
					<label class="form-label">평일 숙박 가격</label>
					<input type="text" class="form-control" id="weekdaysPrice" name="weekdaysPrice" value="${roomDto.weekdaysPrice }"/>
				</div>
				<div class="mb-3">
					<label class="form-label">주말 숙박 가격</label>
					<input type="text" class="form-control" id="weekendPrice" name="weekendPrice" value="${roomDto.weekendPrice }"/>
				</div>
				<div class="mb-3">
					<label class="form-label">성수기 숙박 가격</label>
					<input type="text" class="form-control" id="peakSeasonPrice" name="peakSeasonPrice" value="${roomDto.peakSeasonPrice }"/>
				</div>
				<div class="mb-3">
					<label class="form-label">기준 인원</label>
					<select class="form-control text-center" id="standardNumber" name="standardNumber">
						<option value="1">1명</option>
						<option value="2">2명</option>
						<option value="3">3명</option>
						<option value="4">4명</option>
						<option value="5">5명</option>
						<option value="6">6명</option>
						<option value="7">7명</option>
						<option value="8">8명</option>
						<option value="9">9명</option>
						<option value="10">10명</option>
						<option value="11">11명</option>
						<option value="12">12명</option>
					</select>
				</div>
				<div class="mb-3">
					<label class="form-label">최대 인원</label>
					<select class="form-control text-center" id="maximumNumber" name="maximumNumber">
						<option value="1">1명</option>
						<option value="2">2명</option>
						<option value="3">3명</option>
						<option value="4">4명</option>
						<option value="5">5명</option>
						<option value="6">6명</option>
						<option value="7">7명</option>
						<option value="8">8명</option>
						<option value="9">9명</option>
						<option value="10">10명</option>
						<option value="11">11명</option>
						<option value="12">12명</option>
					</select>
				</div>
				<div class="mb-3">
					<label class="form-label">1인당 추가 비용</label>
					<input type="text" class="form-control" id="pricePerPerson" name="pricePerPerson" value="${roomDto.pricePerPerson }"/>
				</div>
				<div class="mb-3">
					<label class="form-label">AMENITIES</label>
					<input type="text" class="form-control" id="amenity" name="amenity" value="${roomDto.amenity }"/>
				</div>
				<div class="mb-3">
					<label class="form-label">FEATURES</label>
					<input type="text" class="form-control" id="feature" name="feature" value="${roomDto.feature }"/>
				</div>
				<div class="mb-3">
					<label class="form-label">객실 사진 첨부</label>
					<input type="file" class="form-control" name="roomImages" />
					<input type="file" class="form-control" name="roomImages" />
					<input type="file" class="form-control" name="roomImages" />
					<input type="file" class="form-control" name="roomImages" />
					<input type="file" class="form-control" name="roomImages" />
				</div>
				<c:forEach var="image" items="${roomImages}">
		    		<img src="/resources/images/room/${image.image }" width="200" />
		    	</c:forEach>
				<div class="mb-3 text-end">
					<button type="submit" class="btn btn-primary" id="submit">객실 수정</button>
				</div>			
			</div>
		</div>
	</form>
</body>
<script type="text/javascript">

$('#standardNumber option[value=${roomDto.standardNumber}]').prop('selected', 'selected').change();
$('#maximumNumber option[value=${roomDto.maximumNumber}]').prop('selected', 'selected').change();

</script>
</html>