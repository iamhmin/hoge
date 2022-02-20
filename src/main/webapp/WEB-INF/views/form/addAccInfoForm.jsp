<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부대시설/기타 등록</title>
</head>
<body>
	<form class="border p-3 bg-light" method="post" action="addAccInfo" enctype="multipart/form-data">
		<div>
			<div class="row mb-3 ">
				<div class="col text-center">
					<h1>부대시설 안내 및 기타 안내 사항 등록</h1>
				</div>
			</div>
			<div class="row mb-3 d-flex justify-content-center">
				<div class="col-6 text-center">
					<div class="mb-3">
						<input type="hidden" value="${accMainDto.accNo }" name="accommoNo" />
						<input type="hidden" value="${accMainDto.hostNo }" name="hostNo" />
						<input type="hidden" value="${accMainDto.hostingType }" name="hostingType" />
					</div>
					<div class="mb-3">
						<label class="form-label">유형 선택</label>
						<select class="form-control text-center" name="type">
							<option value="1">부대시설 안내</option>
							<option value="2">기타 안내</option>
						</select>
						<label class="form-label">제목</label>
						<input type="text" class="form-control" name="title" />
						<label class="form-label">내용</label>
						<textarea class="form-control" rows="10" name="content">• </textarea>
					</div>
					<div class="mb-3 text-end">
						<button class="btn btn-outline-dark" type="submit">등록 완료</button>
					</div>					
				</div>
			</div>
		</div>
	</form>
</body>

<script type="text/javascript">


	
</script>
</html>

