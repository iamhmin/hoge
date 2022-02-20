<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<head>
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div id="map" style="width:950px;height:700px;"></div>

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8606c7f07c8e2d80f27869dab7ebaec2&libraries=services"></script>
<script>
$(function() {
	function formatDate(date) {
	    
	    var d = new Date(date),
	    
	    month = '' + (d.getMonth() + 1) , 
	    day = '' + d.getDate(), 
	    year = d.getFullYear();
	    
	    if (month.length < 2) month = '0' + month; 
	    if (day.length < 2) day = '0' + day; 
	    
	    return [year, month, day].join('.');
	    
	}
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(35.84351, 127.78032), 	// 지도의 중심좌표
		level : 13, 											// 지도의 확대 레벨
		mapTypeId : kakao.maps.MapTypeId.ROADMAP				// 지도종류
	};

	// 지도를 생성한다 
	var map = new kakao.maps.Map(mapContainer, mapOption);

	var positions = [];

	$.ajax({
		type : 'get',
		url : '/rest/mypage/mytourlist',
		dataType : 'json',
		success : function(results) {
			console.log(results);
			$.each(results, function(index, result) {
				
				if (result.accommoImages != null) {
					positions.push({
						no : result.no,
						name : result.name,
						checkIn : formatDate(result.checkIn),
						checkOut : formatDate(result.checkOut),
						roomName : result.roomName,
						price : result.price,
						latlng: new kakao.maps.LatLng(result.xce, result.yce),
						images : result.accommoImages
					});
				} else if (result.accommoImages == null && (result.activityImages != "" || result.activityImages != null || result.activityImages != undefined || ( result.activityImages == null && typeof result.activityImages != "object" && Object.keys(result.activityImages).length))) {
					positions.push({
						no : result.no,
						name : result.name,
						checkIn : formatDate(result.checkIn),
						price : result.price,
						latlng: new kakao.maps.LatLng(result.xce, result.yce),
						images : result.activityImages
					});
				} else {
					positions.push({
						name : result.name,
						checkIn : formatDate(result.checkIn),
						price : result.price,
						latlng: new kakao.maps.LatLng(result.xce, result.yce),
					});
				}
			});
			
			console.log(positions);
			markerAdd(positions);
		}, 
		error : function(request,status,error){
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})

	// 마커 생성 기능
	function markerAdd(positions) {
		for (var i = 0; i < positions.length; i++) {
			addMarker(positions[i]);
		}
	}

	
	var array = [];
	// 마커를 생성하고 지도 위에 표시하고, 마커에 mouseover, mouseout, click 이벤트를 등록하는 함수입니다
	function addMarker(position) {

		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new kakao.maps.Size(24, 35);
		if (position.checkOut) {
			// 숙소 아이콘
			var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
		} else {
			// 체험 아이콘
			var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
		}
		// 마커 이미지 생성
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			map : map,
			position : position.latlng, // 마커를 표시할 위치
			name : position.name,
			image : markerImage
		});

		var iwContent = '<div class="row" style="padding:5px; width:400px; height:130px;">';
		iwContent += '<div class="col-7" style="padding: 15px 0 10px 20px;">';
		iwContent += '<h5 class="map-name" style="margin-bottom: 20px;">' + position.name + '</h5>';
		if (position.checkOut) {
			iwContent += '<h6 class="map-room" >' + position.roomName + '</h6>';
		} 
		iwContent += '<div class="d-flex align-items-end">'
		iwContent += '<p class="discount__text">' + position.checkIn;
		if (position.checkOut) {
			iwContent += ' ~ ' + position.checkOut;
		} 
		iwContent += '</p>';
		iwContent += '</div>';
		iwContent += '</div>';
		iwContent += '<div class="col-5 d-flex justify-content-end">';
		
		
		if (position.images) {
			iwContent += '<div id="carouselExampleIndicators'+position.no+'" class="carousel slide" data-bs-interval="false">';
	      	iwContent += '<div class="carousel-indicators">';
			$.each (position.images, function (index, image) {
	      		if (index == 0) {
	              	iwContent += '<button type="button" data-bs-target="#carouselExampleIndicators'+position.no+'" data-bs-slide-to="'+index+'" class="active" aria-current="true" aria-label="Slide '+index+'"></button>';
	      		} else {
	              	iwContent += '<button type="button" data-bs-target="#carouselExampleIndicators'+position.no+'" data-bs-slide-to="'+index+'" aria-label="Slide '+index+'"></button>';
	      		}
	      	});
	      	iwContent += '</div>';
	      	iwContent += '<div class="carousel-inner">';
	      	if (position.checkOut) {
		      	$.each (position.images, function (index, image) {
		        	if (index == 0) {
		            	iwContent += '<div class="carousel-item active">';
		         	} else {
		            	iwContent += '<div class="carousel-item">';
		         	}
			        iwContent += '<img width="139" height="115" src="/resources/images/accommodation/'+image.image+'" class="d-block w-100" alt="image">';
			        iwContent += '</div>';
		      	});
	      	} else {
	      		$.each (position.images, function (index, image) {
		        	if (index == 0) {
		            	iwContent += '<div class="carousel-item active">';
		         	} else {
		            	iwContent += '<div class="carousel-item">';
		         	}
			        iwContent += '<img width="100%" height="100%" src="/resources/images/activities/'+image.image+'" class="d-block w-100" alt="image">';
			        iwContent += '</div>';
		      	});
	      	}
	      	iwContent += '</div>';
	      	iwContent += '<button class="carousel-control-prev" type="button" data-bs-target="carouselExampleIndicators'+position.no+'" data-bs-slide="prev">';
	      	iwContent += '<span class="carousel-control-prev-icon" aria-hidden="true"></span>';
	      	iwContent += '<span class="visually-hidden">Previous</span>';
	     	iwContent += '</button>';
	      	iwContent += '<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators'+position.no+'" data-bs-slide="next">';
	      	iwContent += '<span class="carousel-control-next-icon" aria-hidden="true"></span>';
	      	iwContent += '<span class="visually-hidden">Next</span>';
	      	iwContent += '</button>';
	      	iwContent += '</div>';
		}
		
		
		iwContent += '</div>';
		iwContent += '</div>';

		

		function closeInfoWindow() {
		    for(var idx=0; idx<array.length; idx++){
		        array[idx].close();
		    }
		}
		
		var iwPosition = new kakao.maps.LatLng(position.latlng); //인포윈도우 표시 위치입니다

		// 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
			position : iwPosition,
			content : iwContent
		});
		
		array.push(infowindow);
		
		var isOpen = false;
		// 마커에 mouseover 이벤트를 등록합니다
		kakao.maps.event.addListener(marker, 'mouseover', function() {
			// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
			
		});

		// 마커에 mouseout 이벤트를 등록합니다
		kakao.maps.event.addListener(marker, 'mouseout', function() {
			
		});

		// 마커에 click 이벤트를 등록합니다
		kakao.maps.event.addListener(marker, 'click', function() {
			closeInfoWindow();
			infowindow.open(map, marker);
		});

	};
	
	
})
</script>
</body>
</html>