 const modal = document.getElementById("loginModal");
    const openBtn = document.getElementById("openModalBtn");
    const closeBtn = document.getElementById("closeModalBtn");

    openBtn.onclick = () => {
      console.log("모달 열기 버튼 클릭");
      modal.style.display = "block";
    };

    closeBtn.onclick = () => {
      console.log("모달 닫기 버튼 클릭");
      modal.style.display = "none";
    };

    window.onclick = e => {
      console.log("모달 바깥 클릭으로 닫기");
      if (e.target === modal) {
        modal.style.display = "none";
      }
    };

    const loginTab = document.getElementById("loginTab");
    const signupTab = document.getElementById("signupTab");
    const loginForm = document.getElementById("loginForm");
    const signupForm = document.getElementById("signupForm");

    loginTab.onclick = () => {
      console.log("로그인 탭 선택");
      loginTab.classList.add("active");
      signupTab.classList.remove("active");
      loginForm.classList.add("active");
      signupForm.classList.remove("active");
    };

    signupTab.onclick = () => {
      console.log("회원가입 탭 선택");
      signupTab.classList.add("active");
      loginTab.classList.remove("active");
      signupForm.classList.add("active");
      loginForm.classList.remove("active");
    };

    // 탭 메뉴 전환
    const tabButtons = document.querySelectorAll(".tab-menu .tab-btn");
    tabButtons.forEach(btn => {
      btn.onclick = () => {
        tabButtons.forEach(b => b.classList.remove("active"));
        btn.classList.add("active");
        // 콘텐츠 전환 로직 추가 가능
      };
    });

    // 회원가입 폼의 비밀번호 확인 함수
    function check(form) {
      const password = form.querySelector("input[name='password']").value;
      const confirmPassword = form.querySelector("input[name='confirmPassword']").value;

      if (password !== confirmPassword) {
        alert("비밀번호가 일치하지 않습니다.");
        return false;
      }

      console.log("회원가입 폼 제출:", {
        name: form.name.value,
        id: form.id.value,
        email: form.email.value,
        password: form.password.value
      });
      return true;
    }

    // 로그인 폼 제출
    loginForm.querySelector("button[type='submit']").onclick = async (e) => {
      e.preventDefault();
      const email = loginForm.querySelector("input[name='email']").value;
      const password = loginForm.querySelector("input[name='password']").value;

      console.log("로그인 시도:", { email, password });

      try {
        const response = await fetch('http://localhost:8080/WebApp/api/login', {
          method: 'POST',
          headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
          body: `username=${encodeURIComponent(email)}&password=${encodeURIComponent(password)}`
        });

        const data = await response.json();
        console.log("서버 응답:", data);
        if (response.ok) {
          alert(data.message);
          modal.style.display = "none";
          // 로그인 성공 시 프로필 정보 업데이트
          document.querySelector(".form-section input[placeholder='닉네임']").value = data.user.username;
          document.querySelector(".form-section input[placeholder='아이디']").value = data.user.id;
          document.querySelector(".form-section input[placeholder='이메일']").value = data.user.email;
        } else {
          alert(data.message);
        }
      } catch (error) {
        console.error('로그인 요청 오류:', error);
        alert('로그인 중 오류가 발생했습니다.');
      }
    };

    // 회원가입 폼 제출
    signupForm.querySelector("button[type='submit']").onclick = async (e) => {
      e.preventDefault();
      if (!check(signupForm)) return;

      const name = signupForm.querySelector("input[name='name']").value;
      const id = signupForm.querySelector("input[name='id']").value;
      const email = signupForm.querySelector("input[name='email']").value;
      const password = signupForm.querySelector("input[name='password']").value;

      console.log("회원가입 시도:", { name, id, email, password });

      try {
        const response = await fetch('http://localhost:8080/WebApp/api/signup', {
          method: 'POST',
          headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
          body: `id=${encodeURIComponent(id)}&name=${encodeURIComponent(name)}&email=${encodeURIComponent(email)}&password=${encodeURIComponent(password)}`
        });

        const data = await response.json();
        console.log("서버 응답:", data);
        if (response.ok) {
          alert(data.message);
          modal.style.display = "none";
        } else {
          alert(data.message);
        }
      } catch (error) {
        console.error('회원가입 요청 오류:', error);
        alert('회원가입 중 오류가 발생했습니다.');
      }
    };

    // 카카오 로그인 초기화
    Kakao.init('YOUR_KAKAO_APP_KEY');
    function kakaoLogin() {
      Kakao.Auth.login({
        success: function(authObj) {
          console.log("카카오 로그인 성공:", authObj);
        },
        fail: function(err) {
          console.error("카카오 로그인 실패:", err);
        }
      });
    }

    // 네이버 로그인 초기화
    const naverLogin = new naver.LoginWithNaverId({
      clientId: "YOUR_NAVER_CLIENT_ID",
      callbackUrl: "http://localhost:8080/WebApp/callback",
      isPopup: false,
      loginButton: {color: "green", type: 3, height: 60}
    });
    naverLogin.init();

    // 구글 로그인 초기화
    google.accounts.id.initialize({
      client_id: "YOUR_GOOGLE_CLIENT_ID",
      callback: (response) => {
        console.log("구글 로그인 성공:", response);
      }
    });
    google.accounts.id.renderButton(
      document.getElementById("googleSignInButton"),
      { theme: "outline", size: "large" }
    );