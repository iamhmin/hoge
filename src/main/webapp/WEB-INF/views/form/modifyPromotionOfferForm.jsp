<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
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
	<form class="border p-3 bg-light" id="" method="post" action="modifyPromotionOffer" enctype="multipart/form-data">
		<div class="container" id="first">
			<div class="row mb-3 ">
				<div class="col text-center">
					<h1>증정 프로모션 수정</h1>
				</div>
			</div>
			<div class="row mb-3 d-flex justify-content-center">
				<div class="col-6 text-center">
					<c:choose>
						<c:when test="${(param.hostingType) == 1 }">
							<div class="mb-3">
								<input type="hidden" value="${accMainDto.accNo }" id="accommoNo" name="accommoNo" />
								<input type="hidden" value="${accMainDto.hostNo }" id="hostNo" name="hostNo" />
								<input type="hidden" value="${accMainDto.hostingType }" id="hostingType" name="hostingType" />
							</div>
						</c:when>
						<c:otherwise>
							<div class="mb-3">
								<input type="hidden" value="${actMainDto.actNo }" id="activityNo" name="activityNo" />
								<input type="hidden" value="${actMainDto.hostNo }" id="hostNo" name="hostNo" />
								<input type="hidden" value="${actMainDto.hostingType }" id="hostingType" name="hostingType" />
							</div>
						</c:otherwise>
					</c:choose>
					<div class="mb-3">
						<input type="hidden" value="${param.no }" name="no" />
						<label class="form-label">프로모션 소개</label>
						<input type="text" class="form-control" value="${promotionOffer.introContent }" name="introContent" />
					</div>
					<div class="mb-3">
						<label class="form-label">증정 내용</label>
						<input type="text" class="form-control" value="${promotionOffer.content }" name="content" />
					</div>
					<div>
						<label class="form-label">프로모션 시작일</label>
						<input type="date" value="<fmt:formatDate value="${promotionOffer.startingDate}" pattern="yyyy-MM-dd"/>" name="startingDate" class="form-control" />
						<label class="form-label">프로모션 종료일</label>
	   					<input type="date" value="<fmt:formatDate value="${promotionOffer.endingDate}" pattern="yyyy-MM-dd"/>" name="endingDate" class="form-control" />
					</div>
					<div class="mb-3 text-end">
						<button class="btn btn-primary" type="submit">프로모션 수정</button>
					</div>					
				</div>
			</div>
		</div>
	</form>
</body>
<script type="text/javascript">



</script>
</html>