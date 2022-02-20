<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../common/tags.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) -->
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<!-- jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<style>

:root {
  --fc-small-font-size: .85em;
  --fc-page-bg-color: #fff;
  --fc-neutral-bg-color: rgba(208, 208, 208, 0.3);
  --fc-neutral-text-color: black;
  --fc-border-color: #ddd;

  --fc-button-text-color: #fff;
  --fc-button-bg-color: #2C3E50;
  --fc-button-border-color: #2C3E50;
  --fc-button-hover-bg-color: #1e2b37;
  --fc-button-hover-border-color: #1a252f;
  --fc-button-active-bg-color: #1a252f;
  --fc-button-active-border-color: #151e27;

  --fc-event-bg-color: #3788d8;
  --fc-event-border-color: #3788d8;
  --fc-event-text-color: #fff;
  --fc-event-selected-overlay-color: rgba(0, 0, 0, 0.25);

  --fc-more-link-bg-color: #d0d0d0;
  --fc-more-link-text-color: inherit;

  --fc-event-resizer-thickness: 8px;
  --fc-event-resizer-dot-total-width: 8px;
  --fc-event-resizer-dot-border-width: 1px;

  --fc-non-business-color: rgba(215, 215, 215, 0.3);
  --fc-bg-event-color: rgb(143, 223, 130);
  --fc-bg-event-opacity: 0.3;
  --fc-highlight-color: rgba(188, 232, 241, 0.3);
  --fc-today-bg-color: rgba(253, 161, 249, 0.3);
  --fc-now-indicator-color: red;
}

  #calendar {
        max-width: 850px;
        margin: 0 auto;
        
    }

/*월화수목 색깔*/
.fc-col-header-cell-cushion {color:black;} 
/*날짜 색깔*/
.fc-daygrid-day-number {color:black;} 

.fc .fc-button-primary:not(:disabled).fc-button-active, .fc .fc-button-primary:not(:disabled):active {
    color: black;
    color: black;
    background-color: white;
    background-color: white;
    border-color: gray;
    border-color: gray;
}

.fc .fc-button-primary {
    color: black;
  	 background-color: white;
       border-color: gray;
}

.fc .fc-toolbar-title {
    font-size: 1.3em;
    margin: 0;
}

.fc .fc-button {

    padding: 0.2em 0.35em;
}
</style>
</head>
<body>
<!-- calendar 태그 -->
<div id='calendar-container' class="mt-10 pt-5">
<div id='calendar'></div>
</div>
<script>
activeMenu('예약캘린더');
const hostNo = ${savedHost.no };
document.addEventListener('DOMContentLoaded', function() { 
	var calendarEl = document.getElementById('calendar'); 
// new FullCalendar.Calendar(대상 DOM객체, {속성:속성값, 속성2:속성값2..}) 
var calendar = new FullCalendar.Calendar(calendarEl, {
	headerToolbar: { left: 'prev,next today', center: 'title', right: 'dayGridMonth,timeGridWeek,timeGridDay' }, 
	//initialDate: '2021-04-12', // 초기 로딩 날짜. 
	navLinks: true, // can click day/week names to navigate views 
	//selectable: true, 
	locale: 'ko',
	//selectMirror: true, // 이벤트명 : function(){} : 각 날짜에 대한 이벤트를 통해 처리할 내용.. 
	//select: function(arg) { console.log(arg); var title = prompt('입력할 일정:'); // title 값이 있을때, 화면에 calendar.addEvent() json형식으로 일정을 추가 
	//if (title) { calendar.addEvent({ 
	//	title: title, 
	//	start: arg.start, 
	//	end: arg.end, 
	//	allDay: arg.allDay, 
	//	backgroundColor:"yellow", 
	//	textColor:"black" }) } calendar.unselect() }, 
	//eventClick: function(arg) { // 있는 일정 클릭시, 
	//	console.log(arg.title); 
	//console.log(arg.textColor); 
	//}, editable: true, 
	//dayMaxEvents: true, // allow "more" link when too many events 
	events: function(info, successCallback, failureCallback){ // ajax 처리로 데이터를 로딩 시킨다. 
		$.ajax({
			url: '/host/hostCalendar.do',										// 요청URL
			data: {hostNo: hostNo},	
            dataType: 'json',
            success: 
                function(result) {

                    var events = [];
                   
                    if(result!=null){
                        
                            $.each(result, function(index, event) {
                            var enddate=event.end;
                             if(enddate==null){
                                 enddate=event.startdate;
                             }
                             
                             var startdate=moment(event.start).format('YYYY-MM-DD');
                             var enddate=moment(enddate).format('YYYY-MM-DD');
                             
                                 events.push({
                                        title: event.title,
                                        start: startdate,
                                        end: enddate,
                                         //url: "${pageContext.request.contextPath }/detail.do?seq="+element.seq,
                                        backgroundColor: event.backgroundcolor,
                                        textColor: event.textColor,
                                        borderColor: event.bordercolor,                                                
                                     }); //.push()
                             
                             
                        }); //.each()
                        
                        console.log(events);
                        
                    }//if end                           
                    successCallback(events);                               
                }//success: function end                          
     }); //ajax end

	}
	//,
	//eventClick: function(event) {
  //          alert("dkdkdk"+event.title);
 //   }
		
		}); 
		calendar.render(); 
		});

</script>
</body>
</html>