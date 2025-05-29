// 모달 열기/닫기 (기존과 동일)
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
  if (e.target === modal) {
    console.log("모달 바깥 클릭으로 닫기");
    modal.style.display = "none";
  }
};

// 탭 전환 (로그인/회원가입) (기존과 동일)
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

// 마이페이지 탭 전환 (기존과 동일)
const tabButtons = document.querySelectorAll(".tab-btn");
const content = document.querySelector(".content");

tabButtons.forEach(btn => {
  btn.onclick = () => {
    console.log("탭 클릭:", btn.textContent);
    tabButtons.forEach(b => b.classList.remove("active"));
    btn.classList.add("active");
    if (btn.textContent === "회원정보수정") {
      content.style.display = "block";
    } else if (btn.textContent === "회원탈퇴") {
      content.style.display = "none";
      alert("회원 탈퇴를 진행하시겠습니까?");
    } else {
      content.style.display = "none";
    }
  };
});

// 수정/완료 버튼 (기존과 동일)
const editBtn = document.querySelector(".edit-btn");
const saveBtn = document.querySelector(".save-btn");
const inputs = document.querySelectorAll(".form-section input");

editBtn.onclick = () => {
  console.log("수정 버튼 클릭");
  inputs.forEach(input => {
    input.removeAttribute("readonly");
    input.style.background = "#fff";
  });
};

saveBtn.onclick = () => {
  console.log("저장 버튼 클릭");
  inputs.forEach(input => {
    input.setAttribute("readonly", true);
    input.style.background = "#f0f0f0";
  });
  alert("프로필이 저장되었습니다.");
};

// 카카오 로그인 초기화 및 로그인 처리 (기존과 동일)
Kakao.init('YOUR_KAKAO_APP_KEY'); // 실제 앱 키로 교체 필요
function kakaoLogin() {
  console.log("카카오 로그인 시도");
  Kakao.Auth.login({
    success: function(authObj) {
      console.log("카카오 인증 성공");
      Kakao.API.request({
        url: '/v2/user/me',
        success: function(res) {
          const user = {
            id: res.id,
            email: res.kakao_account.email,
            nickname: res.properties.nickname
          };
          alert(`카카오 로그인 성공! 환영합니다, ${user.nickname}님!`);
          modal.style.display = "none";
          content.style.display = "block";
          console.log("카카오 사용자 정보:", user);
        },
        fail: function(err) {
          console.log("카카오 사용자 정보 요청 실패");
          alert("카카오 사용자 정보를 가져오지 못했습니다.");
          console.error(err);
        }
      });
    },
    fail: function(err) {
      console.log("카카오 로그인 실패");
      alert("카카오 로그인 실패!");
      console.error(err);
    }
  });
}

// 네이버 로그인 초기화 및 로그인 처리 (기존과 동일)
const naverLogin = new naver.LoginWithNaverId({
  clientId: "YOUR_NAVER_CLIENT_ID",
  callbackUrl: "YOUR_CALLBACK_URL",
  isPopup: true,
  loginButton: { color: "green", type: 3, height: 40 }
});
naverLogin.init();
document.getElementById("naverIdLogin").onclick = () => {
  console.log("네이버 로그인 시도");
  naverLogin.authorize();
};
window.addEventListener('load', () => {
  naverLogin.getLoginStatus(status => {
    if (status) {
      console.log("네이버 로그인 상태 확인");
      const user = {
        id: naverLogin.user.getId(),
        email: naverLogin.user.getEmail(),
        nickname: naverLogin.user.getNickName()
      };
      alert(`네이버 로그인 성공! 환영합니다, ${user.nickname}님!`);
      modal.style.display = "none";
      content.style.display = "block";
      console.log("네이버 사용자 정보:", user);
    }
  });
});

// 구글 로그인 초기화 및 로그인 처리 (기존과 동일)
window.onload = () => {
  console.log("구글 로그인 초기화");
  google.accounts.id.initialize({
    client_id: "YOUR_GOOGLE_CLIENT_ID",
    callback: handleGoogleSignIn
  });
  google.accounts.id.renderButton(
    document.getElementById("googleSignInButton"),
    { theme: "outline", size: "large", width: 280, text: "Google로 로그인" }
  );
};

function handleGoogleSignIn(response) {
  console.log("구글 로그인 콜백");
  const user = JSON.parse(atob(response.credential.split('.')[1]));
  alert(`구글 로그인 성공! 환영합니다, ${user.name}님!`);
  modal.style.display = "none";
  content.style.display = "block";
  console.log("구글 사용자 정보:", {
    id: user.sub,
    email: user.email,
    name: user.name
  });
}

// 일반 로그인 폼 제출 (Java 서버로 변경)
document.querySelector("#loginForm button[type='submit']").onclick = async (e) => {
  e.preventDefault();
  const email = loginForm.querySelector("input[type='email']").value;
  const password = loginForm.querySelector("input[type='password']").value;
  console.log("로그인 시도:", { email, password });

  try {
    const response = await fetch('http://localhost:8080/api/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username: email, password })
    });

    const data = await response.json();
    console.log("서버 응답:", data);
    if (response.ok) {
      alert(data.message);
      modal.style.display = "none";
      content.style.display = "block";
    } else {
      alert(data.message);
    }
  } catch (error) {
    console.error('로그인 요청 오류:', error);
    alert('로그인 중 오류가 발생했습니다.');
  }
};

// 일반 회원가입 폼 제출 (아직 구현 안됨, 필요 시 추가 예정)
document.querySelector("#signupForm button[type='submit']").onclick = async (e) => {
  e.preventDefault();
  const name = signupForm.querySelector("input[type='text']").value;
  const email = signupForm.querySelector("input[type='email']").value;
  const password = signupForm.querySelector("input[type='password']").value;
  const confirmPassword = signupForm.querySelectorAll("input[type='password']")[1].value;
  console.log("회원가입 시도:", { name, email, password });

  if (!name || !email || !password || !confirmPassword) {
    alert("모든 필드를 입력해주세요.");
    return;
  }
  if (password !== confirmPassword) {
    alert("비밀번호가 일치하지 않습니다.");
    return;
  }

  alert("회원가입 기능은 아직 구현되지 않았습니다. 백엔드에서 추가 예정!");
};