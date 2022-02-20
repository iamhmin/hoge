<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>

<style>

.message__chatting { display:none;
}

#booking-info {
  height: 600px;
  overflow-y: auto;
}
#booking-info-on-selected-date {display:none;}

</style>
<main id="main">
  <article id="host-chat">
  
  <!-- 예약문의 리스트 -->
  
    <section class="chat-list">
      <div class="section-title">예약 문의 리스트</div>
      <div class="section-main">
      <c:choose>
		<c:when test="${empty chatList }">
			사용자 없음
		</c:when>
		<c:otherwise>
	      <ul class="sender-list__menu">
		    <c:forEach var="chatRoom" items="${chatList }" varStatus="loop">
		     <c:if test="${not empty chatRoom.lastMessage }">
	          <li class="sender-list__item" id="box-${chatRoom.chatRoomNo }" onclick="enter(${chatRoom.chatRoomNo })">
	            <img
	              src="../../resources/images/userprofiles/${chatRoom.image }"
	              class="sender__img"
	              id="userImg"
	            />
	            <div class="sender-info">
	              <p class="userName" id="userName">${chatRoom.name }</p>
	              <p class="lastmessage" id="lastmessage-${chatRoom.chatRoomNo }">
	                ${chatRoom.lastMessage }
	              </p>
	              <p class="lastSendingTime" id="lastSendingTime-${chatRoom.chatRoomNo }">
	                <fmt:formatDate value="${chatRoom.updatedDate}" pattern="yyyy.MM.dd HH:mm"/>
	              </p>
	            </div>
	            <div class="unreadcount" style="${chatRoom.unreadCount eq 0 ? 'background-color: white' : 'background-color: #000000'}" id="unreadcount-${chatRoom.chatRoomNo }">
	              ${chatRoom.unreadCount }
	            </div>
	          </li>
	          </c:if>
        	</c:forEach>
	      </ul>
		</c:otherwise>
      </c:choose>
      </div>
    </section>
    
  <!-- 예약문의 : 채팅창 -->
  
    <section class="chat-message">
      <div class="section-title">예약 문의</div>
      <div class="section-main" id="chatting-content">
      	<div id="chatting-waiting">
	      	<c:choose>
			  <c:when test="${empty chatList }">
				<div>
					예약상담이 없습니다.
				</div>>
			  </c:when>
			  <c:otherwise>
				<div>
					예약상담을 시작하기 위해 왼쪽의 리스트에서 게스트를 선택하세요.
				</div>
			  </c:otherwise>
			</c:choose>
		</div>
		<div id="chatting-detail">
			<input type="hidden" id="sessionId" value="">
			<input type="hidden" id="roomNumber" value="">
	        <ul class="message__list">
	          
	        </ul>
        </div>
      </div>
      <div class="message__chatting">
        <textarea
          class="chatting"
          id="chatting"
          placeholder="Press Enter for sending a message."
        ></textarea>
      </div>
    </section>
    
  <!-- 예약정보 -->  
    <section class="chat-info">
      <div class="section-title">예약 정보</div>
      <div class="section-main" id="booking-info">
      <!-- 달력 -->
      	  <div id="calendarForm"></div>
      	  
      	  <!--  예약정보  -->
      	  <div id="booking-info-on-selected-date">
	        <div class="book-info">
              <table class="book-info__table">
                <p class="book-info__title">객실 예약정보</p>
                <thead>
                  <tr>
                    <th>객실</th>
                    <th>예약자</th>
                    <th>상태</th>
                  </tr>
                </thead>
                <tbody id="bookedRoomListSection">
                 
                </tbody>
              </table>
              </div>
	      	  
	      	  <div class="book-room">
                <p class="book-room__title">예약가능 객실</p>
	      	    <div id="availableRoomSection">
	      	  
	      	  </div>
            </div>  
      	  </div>
      </div>
    </section>
  </article>
</main>



<script type="text/javascript">

activeMenu('게스트문의');
$(document).ready(function () {
	if (ws) {
		ws.close();
	}
	ws = new WebSocket("ws://localhost/chatting/"+"${chatListString}");
	console.log('웹소켓 열림');
	wsEvt();
});

function getFullYmdStr(){
    //년월일시분초 문자열 생성
    var d = new Date();
    return d.getFullYear() + "." + ('0' + (d.getMonth() + 1)).slice(-2) + "."
+ ('0' + d.getDate()).slice(-2) + "    " + ('0' + d.getHours()).slice(-2) + ":" + ('0' + d.getMinutes()).slice(-2);
}

const userNo = "${LOGIN_USER.no }";
const hostName = "${savedHost.name }";
const hostNo = "${savedHost.no }";
const hostImg = "${savedHost.mainImage }";
let ws;

var textarea = document.getElementById('chatting');
textarea.addEventListener("keydown", function(e){
	if(e.keyCode == 13){ 
		send();
	}
});	
	
		
function wsEvt() {
		ws.onopen = function(data){
			//소켓이 열리면 초기화 세팅하기
		}
		
		ws.onmessage = function(data) {
			
			console.log('메세지 받기 시도');
			var msg = JSON.parse(data.data);
			console.log('메세지 받았음');
			if(msg.type == "getId"){
				var si = msg.sessionId != null ? msg.sessionId : "";
				if(si != ''){
					$("#sessionId").val(si); 
					console.log('1');
				}
			}else if(msg.type == "message"){
				$("#lastmessage-"+msg.roomNumber).html(msg.message);
				$("#lastSendingTime-"+msg.roomNumber).html(msg.sendingTime);
				if(msg.sessionId == $("#sessionId").val() &&  msg.roomNumber == $("#roomNumber").val()){
					console.log('2');
				    appendMyMessage(msg.message, msg.sendingTime, msg.checked);
				}else if(msg.sessionId != $("#sessionId").val() &&  msg.roomNumber == $("#roomNumber").val()){
					console.log('3');
					ChangeToZeroChecked($("#roomNumber").val()); //메시지 읽음 확인
				    appendMessage(msg.senderName, msg.message, msg.sendingTime, msg.senderImg);
				}  else {
					var unreadCount = Number($("#unreadcount-"+msg.roomNumber).html())+1;
					$("#unreadcount-"+msg.roomNumber).css("background-color","#000000");        
					$("#unreadcount-"+msg.roomNumber).html(unreadCount);
				}
			}else if(msg.type = "check" && msg.sessionId != $("#sessionId").val()) {
				
				if (msg.roomNumber == $("#roomNumber").val()) {
					console.log('4');
					
				$(".readStatus").text("(읽음)");
				}
			}else{
				console.warn("unknown type!")
			}
		}
}
	
	
	


	  
	function send() {
		var msg = {
			    type: "message", 
			    roomNumber: $("#roomNumber").val(),
				sessionId : $("#sessionId").val(),
			    senderName: hostName, 
			    message: $("#chatting").val(), 
			    sendingTime: getFullYmdStr(),
			    senderImg: hostImg,
			    checked: "N"
			    
			  };
		console.log($("#sessionId").val());
		console.log($("#chatting").val());
		console.log($("#roomNumber").val());
		console.log('메세지 보냈음');
		ws.send(JSON.stringify(msg));
		
		   
	    $.ajax({
			type: 'POST',								// 요청방식
			url: '/host/message.do',										// 요청URL
			data: JSON.stringify({chatRoomNo: $("#roomNumber").val(), sendingUserNo:userNo, content:$("#chatting").val()}),			// 서버로 보내는 데이터
			contentType: 'application/json',		// 서버로 보내는 데이터의 컨텐츠 타입, 기본값은 "application/x-www-form-urlencoded" 다
			dataType: 'json'		// 서버로부터 응답으로 받을 것으로 예상되는 컨텐츠 타입을 지정한다.
			//success: function(responseData) {					// 서버로부터 성공적인 응답이 왔을 때 실행되는 함수다.
				
			//},
			//error: function() {									// 서버로 보낸 요청이 실패했을 때 실행되는 함수다.
			
			//}
		})
		
	    $('#chatting').val('');

	}
	
	
	 
	function ChangeToZeroChecked(ChatRoomNo) {
		console.log("체크메시지 전송")
	    	var msg = {
	    		    type: "check", 
	    		    roomNumber: $("#roomNumber").val(),
	    			sessionId : $("#sessionId").val()
	    		  };
	    	ws.send(JSON.stringify(msg));
	       
	    	 $.ajax({
	 			type: 'POST',					
	 			url: '/host/checkMessage',										
	 			data: JSON.stringify({"no": ChatRoomNo}),	
	 			contentType: 'application/json',	
	 			dataType: 'json'			
	 		}) 
	    }
		

	
	
	
	


    // 메세지 태그 append
    function appendMessage(senderName, message, sendingTime, senderImg) {
    	var data ="";
    	data +=
    	 "<li class='message__item left'><img src='../../resources/images/userprofiles/"+senderImg+"' id='senderImg' class='sender__img'/>";
        data += "<div class='message-box'>";
        data += "<p class='sender'>"+senderName+"</p>";
        data += "<p class='message'>"+message+"</p>";
       data += "</div>";
       data += "<p class='sendingTime left'>"+sendingTime+"</p></li>"
  	
    	
   		$(".message__list").append(data);
 
        // 스크롤바 아래 고정
        $("#chatting-detail").scrollTop($("#chatting-detail")[0].scrollHeight);
   
    }
    
    
    // 메세지 태그 append
    function appendMyMessage(myMessage, sendingTime, checked)  {
    	if(checked == 'N') {
        	checked = "(읽지않음)";
        } else {
        	checked = "(읽음)";
        	
        }
    	var data ="";
    	data += "<li class='message__item right'>"
    	data += "<div class='my-message-info'>"
    	data += "<p class='readStatus'>"+checked+"</p>"
    	data += "<p class='sendingTime'>"+sendingTime+"</p>"
    	data += "</div>"
    	data += "<p class='myMessage'>"+myMessage+"</p>"
    	data += "</li>"
    	
    	$(".message__list").append(data);
 
 
        // 스크롤바 아래 고정
        $("#chatting-detail").scrollTop($("#chatting-detail")[0].scrollHeight);
   
    }
	
 
    
    
    function enter(ChatRoomNo) {

    	$(".sender-list__item").css("border","1px solid var(--color-input-gray)");
		$("#box-"+ChatRoomNo).css("border","3px solid black");
    	
    	
    	if (ChatRoomNo != $("#roomNumber").val()) {
	    	console.log(ChatRoomNo);
	    	console.log('함수버튼 눌렀을 때 받아온 룸넘버');
			$('.message__list').empty();
			$("#chatting-waiting").hide();
			$("#chatting-detail").show();
			$(".message__chatting").show();
			
			var Myelement = document.getElementById("roomNumber");
			
			console.log('포맷 안 처음 룸넘버');
			console.log(Myelement.value);
			Myelement.value = ChatRoomNo;
			console.log('포맷 안바뀐 룸넘버');
			console.log(Myelement.value);
		 	ChangeToZeroChecked(ChatRoomNo); //메시지 읽음 확인
			$("#unreadcount-"+ChatRoomNo).empty();
			$("#unreadcount-"+ChatRoomNo).css("background-color","white");        


			
	    	console.log('여기까지 오키');
			
			$.getJSON('/host/chat-enter.do', {no:ChatRoomNo}, function(messageDtos) {
				console.log('가져오는 거 오키');
				$.each(messageDtos, function(index, value) {
					
					if(value.sendingUserNo == userNo){
						console.log('2');
						console.log(value.checked);
						appendMyMessage(value.content, value.sendingDate, value.checked);
					}else{
						console.log('3');
						 appendMessage(value.sendingUserName, value.content, value.sendingDate, value.sendingUserImage);
					}
					
				})
	    });
		
			
			
	    } else {
	    	$("#chatting-detail").show();
	    }
    }	
    
  (function () {
      calendarMaker($("#calendarForm"), new Date());
  })();

    var nowDate = new Date();
    function calendarMaker(target, date) {
        if (date == null || date == undefined) {
            date = new Date();
        }
        nowDate = date;
        if ($(target).length > 0) {
            var year = nowDate.getFullYear();
            var month = nowDate.getMonth() + 1;
            $(target).empty().append(assembly(year, month));
        } else {
            console.error("custom_calendar Target is empty!!!");
            return;
        }

        var thisMonth = new Date(nowDate.getFullYear(), nowDate.getMonth(), 1);
        var thisLastDay = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, 0);


        var tag = "<tr>";
        var cnt = 0;
        //빈 공백 만들어주기
        for (i = 0; i < thisMonth.getDay(); i++) {
            tag += "<td></td>";
            cnt++;
        }

        //날짜 채우기
        for (i = 1; i <= thisLastDay.getDate(); i++) {
            if (cnt % 7 == 0) { tag += "<tr>"; }
            var dataMonth = month;
            
            if (month <= 9) {
            	dataMonth = "0"+month;
            }
            var dataDay = i;
            
            if (i <= 9) {
            	dataDay = "0"+i;
            }
            

            tag += "<td id='"+year+"-"+dataMonth+"-"+dataDay+"'>" + i + "</td>";
            cnt++;
            if (cnt % 7 == 0) {
                tag += "</tr>";
            }
        }
        $(target).find("#custom_set_date").append(tag);
        calMoveEvtFn();

        function assembly(year, month) {
            var calendar_html_code =
            	"<div class='book-calendar'>" +
            	"<div class='book-calendar__date'>" +
                "<button type='button' class='date-prev'>" +
                "<i class='fas fa-chevron-left'></i>" +
                "</button>" +
                "<p class='date-number'>"+ year +"년 "+ month +"월</p>" +
                "<button type='button' class='date-next'>" +
                "<i class='fas fa-chevron-right'></i>" +
                "</button>" +
                "</div>" +
                "<table class='book-calendar__table'>" +
                "<thead class='cal__week'>" +
                "<tr>" +
                "<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>" +
                "</tr>" +
                "</thead>" +
                "<tbody id='custom_set_date'>" +
                "</tbody>" +
          		"</table>" +
          		"</div>";
            	
            return calendar_html_code;
        }

        function calMoveEvtFn() {
            //전달 클릭
            $(".book-calendar__date").on("click", ".date-prev", function () {
                nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() - 1, nowDate.getDate());
                calendarMaker($(target), nowDate);
            });
            //다음날 클릭
            $(".book-calendar__date").on("click", ".date-next", function () {
                nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, nowDate.getDate());
                calendarMaker($(target), nowDate);
            });
            //일자 선택 클릭
            $(".book-calendar__table").on("click", "td", function () {
                $(".book-calendar__table .select_day").removeClass("select_day");
                $(this).removeClass("select_day").addClass("select_day");
                
                
                
                console.log($(this).attr("id"));
         		var bookedDate = $(this).attr("id");
         		$("#booking-info-on-selected-date").show();
            
        	$.ajax({
        		type: 'POST',
        		url : "/host/get-room-info.do", //서비스 주소 
        		contentType: 'application/json',
        		data : JSON.stringify({ //서비스 처리에 필요한 인자값
        			hostNo : hostNo,
        			bookedDate : bookedDate
        		}),
        		success : function(result) {
        			const availableRoomList = result['availableRoomList'];
        			const bookedRoomList = result['bookedRoomList'];
        			var availableRoomData = "";
        			var bookedRoomData = "";
        			
        			if (bookedRoomList.length == 0) {
        				bookedRoomData += "<tr>";
        				bookedRoomData += "<td colspan='3'>예약정보가 없습니다<td>";
        				bookedRoomData += "</tr>";
        				
        			}else {
        			
        			
        			// 테이블의 row를 삽입하는 부분
        			for (var i = 0; i < bookedRoomList.length; i++) {
        				
        				bookedRoomData += "<tr>";
        				bookedRoomData += "<td>" + bookedRoomList[i].name + "</td>";
        				bookedRoomData += "<td>" + bookedRoomList[i].roomBookingName + "</td>";
        				
        				if (bookedRoomList[i]['roomBookingStatus'] == '0') {
        					bookedRoomData += "<td>종료</td>";
        				} else if (bookedRoomList[i]['roomBookingStatus'] == '1'){
        					bookedRoomData += "<td>예약중</td>";
        				} else {
        					bookedRoomData += "<td>예약취소</td>";
        				}
        				bookedRoomData += "</tr>";
        			}}
        			$("#bookedRoomListSection").html(bookedRoomData);
        			
        			
        			if (availableRoomList.length == 0) {
        				availableRoomData += "<p>예약가능한 객실이 없습니다</p>";
        				
        				
        			} else {
        			

        			for (var i = 0; i < availableRoomList.length; i++) {
        				availableRoomData += "<table class='book-info__table room'>";
        				availableRoomData += "<thead>";
        				availableRoomData += "<tr><th colspan='3'>" +availableRoomList[i].name+ "</th></tr>";
        				availableRoomData += "</thead>";
        				availableRoomData += "<tbody><tr><td>인원</td>";
        				availableRoomData += "<td colspan='2'>기준:"+availableRoomList[i].standardNumber+"명 / 최대:"+availableRoomList[i].maximumNumber+"명 / 기준초과시 인당 "+availableRoomList[i].pricePerPerson+"원</td></tr>";
        				availableRoomData += "<tr><td>amenities</td>";
        				availableRoomData += "<td colspan='2'>"+availableRoomList[i].amenity+"</td></tr>";
        				availableRoomData += "<tr><td>features</td>";
        				availableRoomData += "<td colspan='2'>"+availableRoomList[i].feature+"</td></tr>";
        				availableRoomData += "<tr><td rowspan='3' id='td-price'>가격</td>";
        				availableRoomData += "<td style='width: 30%'>평일</td><td>"+availableRoomList[i].weekdaysPrice+"</td></tr>";
        				availableRoomData += "<tr><td>주말/공휴일</td><td>"+availableRoomList[i].weekendPrice+"</td></tr>";
        				availableRoomData += "<tr><td>성수기</td><td>"+availableRoomList[i].peakSeasonPrice+"</td></tr>";
        				availableRoomData += "</tbody></table>";
        		
        			}}
        		
        			$("#availableRoomSection").html(availableRoomData);
        		
        			}
        	})
            
            
                
                
                
                
                
            });
        }
    }
    

	
			
</script>
</html>