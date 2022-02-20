<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../views/common/tags.jsp" %>
<header id="header">
  <div class="header-wrap">
    <div class="header__logo">
      <a href="/home"><img src="../../resources/images/main/logo.png" alt="logo" class="logo" /></a>
    </div>
    <div class="search">
      <button type="button" class="search__stay" data-bs-toggle="modal" data-bs-target="#staySearchModal">STAY</button>
      <button type="button" class="search__activity" data-bs-toggle="modal" data-bs-target="#activitySearchModal">ACTIVITY</button>
    </div>
    <nav id="nav">
      <ul class="nav__menu">
        <li class="nav__item"><a href="/home/promotion">PROMOTION</a></li>
        <c:if test="${empty LOGIN_USER}">
        <li class="nav__item"><a href="/login">LOGIN</a></li> 
        </c:if>
        <c:if test="${not empty LOGIN_USER}">
        <li class="nav__item">
          <a href="/mypage/myrevlist">
            <img src="../../resources/images/main/login_icon_active.png" alt="mypage-icon" class="mypage-icon">
          </a>
        </li>
        <li class="nav__item"><a href="/logout">LOGOUT</a></li>
        </c:if>
        <li class="nav__item"><i class="fas fa-globe"></i></li>
      </ul>
    </nav>
  </div>
</header>

<!-- Stay Search Modal -->
<div class="modal fade" id="staySearchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 id="staySearchModalLabel">STAY SEARCH</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="form-search-stay" action="/accommo/list" method="get">
			<div class="row">
				<div class="col-3">
					<label for="address">위치</label>
					<input id="type" type="hidden" name="opt1" value="address">
				    <input id="address" type="text" name="addressValue" autocomplete="off" placeholder="위치 입력">
			    </div>
				<div class="col-3">
					<label for="checkInBox">체크인</label>
			        <input id="type" type="hidden" name="opt2" value="checkInBox">
			        <input id="checkInBox" type="text" name="checkInBoxValue" autocomplete="off" placeholder="날짜 입력">
				</div>
		        <div class="col-3">
	        		<label for="checkOutBox">체크아웃</label>
		        	<input id="type" type="hidden" name="opt3" value="checkOutBox">
		        	<input id="checkOutBox" type="text" name="checkOutBoxValue" autocomplete="off" placeholder="날짜 입력">
		        </div>		        
				<div class="col-3">
	        		<label for="maxStandardNumber">인원</label>
					<input id="type" type="hidden" name="opt4" value="maxStandardNumber">
			    	<input id="maxStandardNumber" type="text" name="maxStandardNumberValue" autocomplete="off" placeholder="인원 입력">
		        </div>
	        </div>
		</form>
      </div>
      <div class="modal-footer">
        <button id="serachStay" type="button" class="btn btn-dark">STAY SEARCH</button>
      </div>
    </div>
  </div>
</div>

<!-- ACTIVITY Search Modal -->
<div class="modal fade" id="activitySearchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5  id="activitySearchModalLabel">ACTIVITY SEARCH</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="form-search-stay" action="/accommo/list" method="get">
			<div class="row">
				<div class="col-3">
					<label for="address">위치</label>
					<input id="type" type="hidden" name="opt1" value="address">
				    <input id="address" type="text" name="addressValue" autocomplete="off" placeholder="위치 입력">
			    </div>
				<div class="col-3">
					<label for="">날짜</label>
			        <input id="type" type="hidden" name="opt2" value="checkInBox">
			        <input id="" type="text" name="checkInBoxValue" autocomplete="off" placeholder="날짜 입력">
				</div>
	        </div>
		</form>
      </div>
      <div class="modal-footer">
        <button id="serachActivity" type="button" class="btn btn-dark">ACTIVITY SEARCH</button>
      </div>
    </div>
  </div>
</div>

<style>
#address,
#checkInBox,
#checkOutBox,
#maxStandardNumber
 {
width: 110px;}
</style>

<script type="text/javascript">
	$(function () {
	});	
	
	// 검색 폼트리거
	$("#serachStay").click(function() {
		var opt1 = $("input[name=opt1]").val();
		var addressValue = $(":input[name=addressValue]").val();
		var opt2 = $("input[name=opt2]").val();
		var checkInBoxValue = $(":input[name=checkInBoxValue]").val();
		var opt3 = $("input[name=opt3]").val();
		var checkOutBoxValue = $(":input[name=checkOutBoxValue]").val();
		var opt4 = $("input[name=opt4]").val();
		var maxStandardNumberValue = $(":input[name=maxStandardNumberValue]").val();
		$("#form-search-stay").trigger("submit");
	});

   	datePickerSet($("#checkInBox"), $("#checkOutBox"));
	
   	// 달력생성함수 sDate:시작일 eDate:종료일
    function datePickerSet(sDate, eDate) {
	
            var sDay = sDate.val();
            var eDay = eDate.val();

            // 체크인 달력 생성
            if (!isValidStr(eDay)) {
                sDate.datepicker({
                    maxDate: new Date(eDay)
                });
            }
            
            sDate.datepicker({
                language: 'ko',
                minDate: new Date(),
                autoClose: true,
                onSelect: function () {
                    datePickerSet(sDate, eDate);
                }
            });
	
            // 체크아웃 달력 생성
            if (!isValidStr(sDay)) {
                eDate.datepicker({
                    minDate: new Date(sDay)
                });
            } 
            
            eDate.datepicker({
                language: 'ko',
                autoClose: true,
                onSelect: function () {
                    datePickerSet(sDate, eDate);
                }
            });
		
        //날짜 생성 여부
        function isValidStr(str) {
            if (str == null || str == undefined || str == "")
                return true;
            else
                return false;
        }
    }
</script>