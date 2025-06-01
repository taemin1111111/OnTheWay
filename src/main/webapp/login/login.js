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

// 회원가입 폼의 비밀번호 확인 함수
function check(form) {
  const password = form.querySelector("input[name='password']").value;
  const confirmPassword = form.querySelectorAll("input[type='password']")[1].value;

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