<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <title>객실 등록</title>
</head>
<body>
	<form class="border p-3 bg-light" id="insertRooms" method="post" action="insertRooms" enctype="multipart/form-data">
		<div class="container" id="first">
			<div class="row mb-3 ">
				<div class="col text-center">
					<h1>객실 등록하기</h1>
				</div>
			</div>
			<div class="row mb-3 d-flex justify-content-center">
				<div class="col-6 text-center">
					<div class="mb-3">
						<input type="hidden" value="${accMainDto.accNo }" id="accommoNo" name="accommoNo" />
						<input type="hidden" value="${accMainDto.hostNo }" id="hostNo" name="hostNo" />
						<input type="hidden" value="${accMainDto.hostingType }" id="hostingType" name="hostingType" />
					</div>
					<div class="mb-3">
						<label class="form-label">객실 이름</label>
						<input type="text" class="form-control" id="name" name="name" />
					</div>
					<div class="mb-3">
						<label class="form-label">평일 숙박 가격</label>
						<input type="text" class="form-control" id="weekdaysPrice" name="weekdaysPrice" />
					</div>
					<div class="mb-3">
						<label class="form-label">주말 숙박 가격</label>
						<input type="text" class="form-control" id="weekendPrice" name="weekendPrice" />
					</div>
					<div class="mb-3">
						<label class="form-label">성수기 숙박 가격</label>
						<input type="text" class="form-control" id="peakSeasonPrice" name="peakSeasonPrice" />
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
						<input type="text" class="form-control" id="pricePerPerson" name="pricePerPerson" />
					</div>
					<div class="mb-3">
						<label class="form-label">AMENITIES</label>
						<input type="text" class="form-control" id="amenity" name="amenity" />
					</div>
					<div class="mb-3">
						<label class="form-label">FEATURES</label>
						<input type="text" class="form-control" id="feature" name="feature" />
					</div>
					<div class="mb-3">
						<label class="form-label">객실 사진 첨부</label>
						<input type="file" class="form-control" name="roomImages" />
						<input type="file" class="form-control" name="roomImages" />
						<input type="file" class="form-control" name="roomImages" />
						<input type="file" class="form-control" name="roomImages" />
						<input type="file" class="form-control" name="roomImages" />
					</div>
					<div class="mb-3 text-end">
						<button class="btn btn-primary" id="submit">객실 등록</button>
					</div>					
				</div>
			</div>
		</div>
	</form>
</body>
<script type="text/javascript">
	$('#submit').click(function(){
		$("#insertRooms").submit
	})
</script>
</html>