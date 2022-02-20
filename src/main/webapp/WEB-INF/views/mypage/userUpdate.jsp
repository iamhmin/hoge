<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<div class="mypage__content">
  <article class="user-update">
     <div class="update-title">회원 정보 수정</div>
     <div class="section-wrap">
       
       <section class="left__form">
	   <c:if test="${not empty error }">
	     <div class="mb-3 alert alert-danger">${error }</div>
	   </c:if>
       <!-- 회원 기본정보 수정 폼 -->
         <form
           class="form__user-update"
           method="post"
           enctype="multipart/form-data"
           action="/mypage/userupdate"
         >
           <div class="update__box">
             <label for="userId">아이디</label>
             <input
               type="text"
               id="userId"
               name="id"
               value="<c:out value='${LOGIN_USER.id}'/>"
               disabled
             />
             <div class="warning" id="check_id"></div>
           </div>
           <div class="update__box">
             <label for="userName">이름</label>
             <input type="text" id="userName" name="name" 
               value="<c:out value='${LOGIN_USER.name}'/>" />
           </div>
           <div class="update__box">
             <label for="userTel">휴대전화</label>
             <input type="tel" id="userTel" name="tel" 
               value="<c:out value='${LOGIN_USER.tel}'/>" />
           </div>
           <div class="update__box">
             <label for="userEmail">이메일</label>
             <input
               type="email"
               id="userEmail"
               name="email"
               value="<c:out value='${LOGIN_USER.email}'/>"
             />
           </div>
           
         <!-- 모달창 -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <article class="modal-content">
                <header class="modal-title">
                  <p class="modal__title">회원정보 변경 동의</p>
                </header>
                <main class="modal-main">
                  <p class="modal__text">
                    수정하신 기본정보가 변경됩니다. 진행하시겠습니까?
                  </p>
                </main>
                <footer class="modal-btn">
                  <button
                    type="button"
                    class="btn__cancel"
                    data-bs-dismiss="modal"
                  >
                    저장취소
                  </button>
                  <button type="submit" class="btn__save">저장하기</button>
                </footer>
              </article>
		  </div>
		</div>
        
         </form>
 
 
       <!-- 비밀번호 수정 폼 --> 
         <form action="/mypage/userpwdupdate" method="post">
           <div class="update__box">
             <label for="userPwd">현재 비밀번호</label>
             <input
               type="password"
               id="userPwd"
               name="pwd"
               placeholder="현재 비밀번호를 입력해 주세요"
             />
             <div class="warning" id="check_pwd"></div>
           </div>
           <div class="update__box">
             <label for="changePwd">변경할 비밀번호</label>
             <input
               type="password"
               id="changePwd"
               name="changePwd"
               placeholder="변경할 비밀번호를 입력해 주세요"
             />
             <div class="warning" id="check_changePwd"></div>
           </div>
           
           <div class="update__box last">
             <label for="confirmPwd">변경할 비밀번호 확인</label>
             <input
               type="password"
               id="confirmPwd"
               name="confirmPwd"
               placeholder="변경할 비밀번호를 확인해 주세요"
             />
             <div class="warning" id="check_pwdConfirm"></div>
           </div>
           <div class="update__btn">
             <button
               type="button"
               class="btn__pw"
               data-bs-toggle="modal"
               data-bs-target="#examplepwdModal"
             >
               비밀번호 변경
             </button>
           </div>
           
         <!-- 모달창 -->
				<div class="modal fade" id="examplepwdModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				     <article class="modal-content">
		                <header class="modal-title">
		                  <p class="modal__title">비밀번호 변경동의</p>
		                </header>
		                <main class="modal-main">
		                  <p class="modal__text">
		                    수정하신 비밀번호가 변경됩니다. 진행하시겠습니까?
		                  </p>
		                  <p class="modal__text-warning">
		                    진행이 완료되면 로그인 페이지로 이동합니다.
		                  </p>
		                </main>
		                <footer class="modal-btn">
		                  <button
		                    type="button"
		                    class="btn__cancel"
		                    data-bs-dismiss="modal"
		                  >
		                    변경취소
		                  </button>
		                  <button type="submit" class="btn__save">변경하기</button>
		                </footer>
		              </article>
				  </div>
				</div>  
           
         </form>
         
         
         <div class="update__btn">
           <button
             type="button"
             class="btn__update"
             data-bs-toggle="modal"
             data-bs-target="#exampleModal"
           >
             저장하기
           </button>
         </div>
         <button
           class="btn__withdraw"
           type="button"
           data-bs-toggle="modal"
           data-bs-target="#exampleDeleteModal"
         >
           회원 탈퇴
         </button>
         
         <!-- 회원 탈퇴 폼 -->
		<form action="/mypage/userdelete" method="post">
			
			<!-- 모달창 -->
			<div class="modal fade" id="exampleDeleteModal" tabindex="-1" aria-labelledby="exampleDeleteModal" aria-hidden="true">
			  <div class="modal-dialog">
			    <article class="modal-content">
                  <header class="modal-title">
                    <p class="modal__title">회원탈퇴 동의</p>
                  </header>
                  <main class="modal-main">
                    <p class="modal__text">회원탈퇴를 진행하시겠습니까?</p>
                    <p class="modal__text-warning">
                      진행이 완료되면 모든 회원정보를 잃습니다.
                    </p>
                    <div class="withdraw__box">
                      <input
                        type="password"
                        id="withdrawPwd"
                        name="pwd"
                        placeholder="비밀번호를 입력해 주세요"
                        required
                      />
                    </div>
                  </main>
                  <footer class="modal-btn">
                    <button type="submit" class="btn__cancel">탈퇴하기</button>
                    <button
                      type="button"
                      class="btn__save"
                      data-bs-dismiss="modal"
                    >
                      탈퇴취소
                    </button>
                  </footer>
                </article>
			  </div>
			</div>
		</form>
         
       </section>
       
     <!-- 프로필 사진 -->
       <section class="right__img">
         <div class="img-wrap">
           <p class="img-title">프로필 사진</p>
           <div
             class="img-profile"
             style="background-image: url(../../resources/images/userprofiles/<c:out value='${LOGIN_USER.image}'/>)"
           ></div>
           <input
             type="file"
             class="update-imgfile"
             id="update-imgfile"
             name="myProfile"
             accept=".png, .jpg, .jpeg"
           />
           <label for="update-imgfile" class="btn__profile-img">
             <i class="fas fa-camera"></i>
           </label>
         </div>
       </section>
     </div>
   </article>
</div>