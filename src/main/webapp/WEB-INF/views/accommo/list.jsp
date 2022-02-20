<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>

<main id="main">
   <article id="accommo-list">
     <header class="section__header">
       <h1 class="section__title">FIND STAY</h1>
       <p class="section__text">머무는 것 자체로 여행이 되는 공간</p>
     </header>
     <div class="accommo-search">
       <form
         class="accommo-search__form"
         method="get"
         action="/accommo/detail"
       >
         <span id="span-address">${criteria.addressValue }</span>
         <input
           id="checkInBox"
           type="date"
           name="checkInDate"
           autocomplete="off"
           placeholder="날짜 입력"
           value="${criteria.checkInBoxValue }"
         />
         -
         <input
           id="checkOutBox"
           type="date"
           name="checkOutDate"
           autocomplete="off"
           placeholder="날짜 입력"
           value="${criteria.checkOutBoxValue }"
         />
         <input
           type="hidden"
           name="number"
           value="${criteria.maxStandardNumberValue }"
        />
      </form>
      <select
        class="accommo-search__select"
        aria-label="Default select example"
        name="accommoType"
      >
        <option selected>숙소타입</option>
        <option value="호텔">호텔</option>
        <option value="민박">민박</option>
        <option value="렌탈하우스">렌탈하우스</option>
        <option value="한옥">한옥</option>
      </select>
    </div>
    <div class="accommo-content">
      <article class="accommo__list">
      	<div class="accommos">
          
        </div>
        <div class="pagination">
        
        </div>
      </article>
      <article class="accommo__map" style="height: 600px;">
         <div id="map" style="width:100%;height:600px; position: sticky; top: 0;"></div>
      </article>
    </div>
  </article>
</main>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8606c7f07c8e2d80f27869dab7ebaec2&libraries=services,clusterer"></script>

<script>
$(function() {
	$("input[name=checkInDate], input[name=checkOutDate]").change(function() {
		clusterer.clear();
    	// 클릭한 페이지내비게이션의 페이지번호 조회하기
        // var pageNo = $(this).attr("data-page");
        // 검색폼의 히든필드에 클릭한 페이지내비게이션의 페이지번호 설정
        //$(":input[name=page]").val(pageNo);
      	var bounds = map.getBounds();
      	
        // 영역의 남서쪽 좌표를 얻어옵니다 
        var swLatLng = bounds.getSouthWest(); 
       
        // 영역의 북동쪽 좌표를 얻어옵니다 
        var neLatLng = bounds.getNorthEast(); 
      
        var number = $("input[name=number]").val();
        var checkIn = $("input[name=checkInDate]").val();
        var checkOut = $("input[name=checkOutDate]").val();
        var page = $(this).attr("data-page");
        var accommoType = $("select[name=accommoType]").val();
        
      	mapAreaList(number, checkIn, checkOut, page, accommoType, swLatLng.getLat(), swLatLng.getLng(), neLatLng.getLat(), neLatLng.getLng());
      
      	// 검색폼에 onsubmit 이벤트 발생시키기
      	// $("#form-search-accommo").trigger("submit");
	})

   	// 페이지내비게이션의 링크를 클릭했을 때 실행될 이벤트핸들러 함수를 등록한다.
	$(document).on("click", ".pagination button", function (e) {
		clusterer.clear();
    	// 클릭한 페이지내비게이션의 페이지번호 조회하기
        // var pageNo = $(this).attr("data-page");
        // 검색폼의 히든필드에 클릭한 페이지내비게이션의 페이지번호 설정
        //$(":input[name=page]").val(pageNo);
      	var bounds = map.getBounds();
      	
        // 영역의 남서쪽 좌표를 얻어옵니다 
        var swLatLng = bounds.getSouthWest(); 
       
        // 영역의 북동쪽 좌표를 얻어옵니다 
        var neLatLng = bounds.getNorthEast(); 
      
        var number = $("input[name=number]").val();
        var checkIn = $("input[name=checkInDate]").val();
        var checkOut = $("input[name=checkOutDate]").val();
        var page = $(this).attr("data-page");
        var accommoType = $("select[name=accommoType]").val();
        
      	mapAreaList(number, checkIn, checkOut, page, accommoType, swLatLng.getLat(), swLatLng.getLng(), neLatLng.getLat(), neLatLng.getLng());
      
      	// 검색폼에 onsubmit 이벤트 발생시키기
      	// $("#form-search-accommo").trigger("submit");
   	});
   
   
   // 카카오지도 API
   var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };
   
   // 지도를 생성합니다    
   var map = new kakao.maps.Map(mapContainer, mapOption);
   
   if ($("#span-address").text() != '') {
      // 장소 검색 객체를 생성합니다
      var ps = new kakao.maps.services.Places(); 
      
      // 키워드로 장소를 검색합니다
      ps.keywordSearch($("#span-address").text(), placesSearchCB); 
      
      // 키워드 검색 완료 시 호출되는 콜백함수 입니다
      function placesSearchCB (result, status) {
          if (status === kakao.maps.services.Status.OK) {
            
              // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
              // LatLngBounds 객체에 좌표를 추가합니다
              var bounds = new kakao.maps.LatLngBounds();
              
              for (var i=0; i<result.length; i++) {
                  bounds.extend(new kakao.maps.LatLng(result[i].y, result[i].x));
              }       
      
              // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
              map.setBounds(bounds);
          } 
      }
   } else {
      // HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
      if (navigator.geolocation) {
          
          // GeoLocation을 이용해서 접속 위치를 얻어옵니다
          navigator.geolocation.getCurrentPosition(function(position) {
              
             var coords = new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude); // 위도
                  
              map.setCenter(coords);
                  
            });
          
      } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
          
          var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
              message = 'geolocation을 사용할수 없어요..'
              
          displayMarker(locPosition, message);
      }
   }
   
   // 지도 영역 변화 이벤트를 등록한다
   kakao.maps.event.addListener(map, 'bounds_changed', function () {
	   clusterer.clear();
	   var bounds = map.getBounds();
	   
      // 영역의 남서쪽 좌표를 얻어옵니다 
       var swLatLng = bounds.getSouthWest(); 
       
       // 영역의 북동쪽 좌표를 얻어옵니다 
       var neLatLng = bounds.getNorthEast(); 
      
       var number = $("input[name=number]").val();
       var checkIn = $("input[name=checkInDate]").val();
       var checkOut = $("input[name=checkOutDate]").val();
       var page = '1';
       var accommoType = $("select[name=accommoType]").val();
       console.log(accommoType);
      mapAreaList(number, checkIn, checkOut, page, 
    		      accommoType,  
    		      swLatLng.getLat(), swLatLng.getLng(), neLatLng.getLat(), neLatLng.getLng());

   });
   
   var positions = [];
   
   // 지도 영역의 list 출력
   function mapAreaList(number, checkIn, checkOut, page, 
		   				accommoType,
		   				swLat, swLng, neLat, neLng) {
      $.ajax({
         type: 'get',
         url: '/rest/accommo/mapArea',
         data: {number: number, checkIn: checkIn, checkOut: checkOut, page: page, 
        	 accommoType: accommoType,
        	 swLat: swLat, swLng: swLng, neLat: neLat, neLng: neLng},
         dataType: 'json',
         success: function(accommoPagination) {
            var $accommos = $('.accommos').empty();
            var $pagination = $('.pagination').empty();
            
            if (accommoPagination.accommos == "" || accommoPagination.accommos == null || accommoPagination.accommos == undefined || ( accommoPagination.accommos != null && typeof accommoPagination.accommos == "object" && !Object.keys(accommoPagination.accommos).length)) {
               var row = '<tr>';
               row += '<td class="text-center" colspan="6">검색 조건에 맞는 숙소 정보가 없습니다.</td>';
               row += '</tr>';
               
            } else {
				positions = [];
                var row = "";
                var pageRow = "";
                $.each(accommoPagination.accommos, function(index, accommo) {
                	row += '<div class="accommo">'
                	row += '<a href="/accommo/detail?accNo='+accommo.no+'&check_in=${criteria.checkInBoxValue}&check_out=${criteria.checkOutBoxValue}">'
                    row += '<h3 class="accommo-no" data-no='+accommo.no+' style="display:inline;">'+accommo.name+'</h3></a>';
                    if (accommo.isDiscountPromotion && accommo.isOfferPromotion) {
                    	row += '<h6 style="display:inline;">Sale | Gifts</h6>';
                    } else if (accommo.isDiscountPromotion) {
                    	row += '<h6 style="display:inline;">Sale</h6>';
                    } else if (accommo.isOfferPromotion) {
                    	row += '<h6 style="display:inline;">Gifts</h6>';
                    }
                    row += '<h6 class="accommo-type" style="margin: 0;">'+accommo.type+'</h6>';
                    row += '<div class="row">';
                    row += '<div class="col-3">';
                    row += '<ul class="accommo-list__menu">';
                    row += '<li class="discount__text">'+accommo.regionDepth1+'</li>';
                    row += '<li class="discount__text">기준 '+accommo.minNumber+'명(최대 '+accommo.maxNumber+'명)</li>';
                    row += '<li class="discount__text">￦'+parseInt(accommo.minPrice).toLocaleString()+'~'+parseInt(accommo.maxPrice).toLocaleString()+'</li>';
                    row += '<li class="discount__text"><i class="fa-solid fa-star acc"></i>'+accommo.averageStar+'</li>';
                    row += '<li class="btn__accommo-list"><a href="/accommo/detail?accNo='+accommo.no+'&check_in=${criteria.checkInBoxValue}&check_out=${criteria.checkOutBoxValue}"><span class="btn__accommo-list-book">예약하기</span></a></li>';
                  	row += '</ul>';
                  	row += '</div>';
                  	row += '<div class="col-7">';
                  	row += '<div id="carouselExampleIndicators'+accommo.no+'" class="carousel slide" data-bs-interval="false">';
                  	row += '<div class="carousel-indicators">';
                  	$.each (accommo.accommoImages, function (index, image) {
                  		if (index == 0) {
    	                  	row += '<button type="button" data-bs-target="#carouselExampleIndicators'+accommo.no+'" data-bs-slide-to="'+index+'" class="active" aria-current="true" aria-label="Slide '+index+'"></button>';
                  		} else {
    	                  	row += '<button type="button" data-bs-target="#carouselExampleIndicators'+accommo.no+'" data-bs-slide-to="'+index+'" aria-label="Slide '+index+'"></button>';
                  		}
                  	});
                  	row += '</div>';
                  	row += '<div class="carousel-inner">';
                  	$.each (accommo.accommoImages, function (index, image) {
                    	if (index == 0) {
                        	row += '<div class="carousel-item active">';
                     	} else {
                        	row += '<div class="carousel-item">';
                     	}
                    row += '<a href="/accommo/detail?accNo='+accommo.no+'&check_in=${criteria.checkInBoxValue}&check_out=${criteria.checkOutBoxValue}"><img src="/resources/images/accommodation/'+image.image+'" class="d-block w-100" alt="image"></a>';
                    row += '</div>';
                  	});
                  	row += '</div>';
                  	row += '<button class="carousel-control-prev" type="button" data-bs-target="carouselExampleIndicators'+accommo.no+'" data-bs-slide="prev">';
                  	row += '<span class="carousel-control-prev-icon" aria-hidden="true"></span>';
                  	row += '<span class="visually-hidden">Previous</span>';
                 	row += '</button>';
                  	row += '<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators'+accommo.no+'" data-bs-slide="next">';
                  	row += '<span class="carousel-control-next-icon" aria-hidden="true"></span>';
                  	row += '<span class="visually-hidden">Next</span>';
                  	row += '</button>';
                  	row += '</div>';
                  	row += '</div>';
                  	row += '<div class="col-2">';
                  	row += '<button class="insertButton" onclick="handelHeart('+accommo.no+')">';
                  	row += '<span class="favorite">';
                  	row += '<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24">';
                  	row += '<path d="M0 0h24v24H0z" fill="none"/>';
                  	row += '<path d="M16.5 3c-1.74 0-3.41.81-4.5 2.09C10.91 3.81 9.24 3 7.5 3 4.42 3 2 5.42 2 8.5c0 3.78 3.4 6.86 8.55 11.54L12 21.35l1.45-1.32C18.6 15.36 22 12.28 22 8.5 22 5.42 19.58 3 16.5 3zm-4.4 15.55l-.1.1-.1-.1C7.14 14.24 4 11.39 4 8.5 4 6.5 5.5 5 7.5 5c1.54 0 3.04.99 3.57 2.36h1.87C13.46 5.99 14.96 5 16.5 5c2 0 3.5 1.5 3.5 3.5 0 2.89-3.14 5.74-7.9 10.05z"/>';
                  	row += '</svg>';
                  	row += '</span>';
                  	row += '</button>';
                  	row += '</div>';
                  	row += '</div>';
                  
                  positions.push({
                     name: accommo.name,
                     latlng: new kakao.maps.LatLng(accommo.xce, accommo.yce),
                     no: accommo.no,
                     type: accommo.type,
                     star: accommo.averageStar,
                     minPrice: accommo.minPrice,
                     maxPrice: accommo.maxPrice,
                     minNumber: accommo.minNumber,
                     maxNumber: accommo.maxNumber,
                     image: accommo.accommoImages[0].image
                  });
               })
               
               
               if (accommoPagination.pagination.existPrev) {
                  pageRow += '<li class="page-item">';
               } else {
                  pageRow += '<li class="page-item disabled">';
               }
               pageRow += '<button class="page-link" data-page="'+accommoPagination.pagination.prevPage+'"> <i class="fas fa-chevron-left"></i></button>';
               pageRow += '</li>';
               for (var i = accommoPagination.pagination.beginPage; i <= accommoPagination.pagination.endPage; i++) {
                  if (accommoPagination.pagination.pageNo == i) {
                     pageRow += '<li class="page-item active">';
                  } else {
                     pageRow += '<li class="page-item">';
                  }
                  pageRow += '<button class="page-link" data-page="'+i+'">'+i+'</button>';
                  pageRow += '</li>';
               }
               if (accommoPagination.pagination.existNext) {
                  pageRow += '<li class="page-item">';
               } else {
                  pageRow += '<li class="page-item disabled">';
               }
               pageRow += '<button class="page-link" data-page="'+accommoPagination.pagination.nextPage+'"><i class="fas fa-chevron-right"></i></button>';
               pageRow += '</li>';
               
               $pagination.append(pageRow);
            }
            
            $accommos.append(row);
            
            console.log(positions);
            markerAdd(positions);
            
            const favorites = document.querySelectorAll(".favorite")
            favorites.forEach(favorite => {
               favorite.addEventListener("click", () => {
                  favorite.classList.toggle("active")
                      if(favorite.classList.contains("active")) {
                    	 favorite.innerHTML='<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M0 0h24v24H0z" fill="none"/><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>'
                      } else {
                         favorite.innerHTML='<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M0 0h24v24H0z" fill="none"/><path d="M16.5 3c-1.74 0-3.41.81-4.5 2.09C10.91 3.81 9.24 3 7.5 3 4.42 3 2 5.42 2 8.5c0 3.78 3.4 6.86 8.55 11.54L12 21.35l1.45-1.32C18.6 15.36 22 12.28 22 8.5 22 5.42 19.58 3 16.5 3zm-4.4 15.55l-.1.1-.1-.1C7.14 14.24 4 11.39 4 8.5 4 6.5 5.5 5 7.5 5c1.54 0 3.04.99 3.57 2.36h1.87C13.46 5.99 14.96 5 16.5 5c2 0 3.5 1.5 3.5 3.5 0 2.89-3.14 5.74-7.9 10.05z"/></svg>'
                      }
               })
            }); 
         },
         error:function(request,status,error){
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
         }
      });
   }
   
   var clusterer = new kakao.maps.MarkerClusterer({});
   
   // 마커 생성 기능
    function markerAdd(positions) {
    	for (var i = 0; i < positions.length; i ++) {
        	addMarker(positions[i]);
      	}
    }
   
   
    // 마커 이미지의 이미지 주소입니다
   var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 

   // 마커를 생성하고 지도 위에 표시하고, 마커에 mouseover, mouseout, click 이벤트를 등록하는 함수입니다
   function addMarker(position) {
      
      // 마커 이미지의 이미지 크기 입니다
       var imageSize = new kakao.maps.Size(24, 35); 
       // 마커 이미지 생성
       var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
       
       // 마커를 생성합니다
       var marker = new kakao.maps.Marker({
           map: map,
           position: position.latlng, // 마커를 표시할 위치
           name : position.name,
           image : markerImage
       });
       
       clusterer.addMarker(marker);
       
       var iwContent = '<div class="row" style="padding:5px; width:400px; height:130px;">';
       iwContent += '<div class="col-8" >';
       iwContent += '<h5 class="mini-title">'+position.name+'</h5>';
       iwContent += '<div class="d-flex align-items-end">'
       iwContent += '<p class="discount__text mini">기준 '+position.minNumber+'명(최대 '+position.maxNumber+'명)</br>';
       iwContent += '<i class="fa-solid fa-star acc"></i>'+position.star+'</br>';
       iwContent += parseInt(position.minPrice).toLocaleString()+'~'+parseInt(position.maxPrice).toLocaleString()+'</p>';
       iwContent += '</div>';
       iwContent += '</div>';
       iwContent += '<div class="col-4 d-flex justify-content-end">';
       iwContent += '<img src="/resources/images/accommodation/'+position.image+'" height="120" width="120" alt="image">';
       iwContent += '</div>';
       iwContent += '</div>';
       
       
       var iwPosition = new kakao.maps.LatLng(position.latlng); //인포윈도우 표시 위치입니다

      // 인포윈도우를 생성합니다
      var infowindow = new kakao.maps.InfoWindow({
          position : iwPosition, 
          content : iwContent 
      });
        
       // 마커에 mouseover 이벤트를 등록합니다
       kakao.maps.event.addListener(marker, 'mouseover', function() {
           // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
          infowindow.open(map, marker); 
       });

       // 마커에 mouseout 이벤트를 등록합니다
       kakao.maps.event.addListener(marker, 'mouseout', function() {
           infowindow.close();
       });

       // 마커에 click 이벤트를 등록합니다
       kakao.maps.event.addListener(marker, 'click', function() {
    	   var checkIn = $("input[name=checkInDate]").val();
    	   var checkOut = $("input[name=checkOutDate]").val();
    	   location.replace('/accommo/detail?accNo='+position.no+'&check_in='+checkIn+'&check_out='+checkOut);
       });
   };
   
});

function handelHeart(accommoNo) {
 	
 	$.ajax({
 	    url: '/rest/mypage/mylovelist/insertlovelist',
 	    type: 'get',
 	    data: {"accommoNo" : accommoNo},
 	    success: function (result){
 	    	console.log("관심목록이 변경되었습니다.");
 	    },
 	    error: function (error){
 	        alert("에러");
 	    }
    });
}


</script>

</body>
</html>