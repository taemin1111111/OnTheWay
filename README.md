<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=fac1c1&height=300&section=header&text=OnTheWay%20Project!&fontColor=ffffff&fontSize=90">
</div><br><br>


## 📝 프로젝트 소개 (Project Introduction)
<div align="center">
  <img src="https://github.com/user-attachments/assets/e8ea8ea9-4bf1-4cfc-9c50-223b44ac5b21" alt="mainpage" width="800" height="350">
</div>
OnTheWay는 운전자와 여행객의 편리한 이동을 돕기 위해 개발된 웹 애플리케이션입니다. 이동 경로상의 휴게소, 편의시설, 입점 매장, 이벤트 정보 등을 통합적으로 제공하여 사용자들에게 최적화된 경로 계획 및 정보 탐색 경험을 선사합니다. 특히, 고속도로 휴게소 내의 브랜드 매장, 편의점, 푸드코트 등 상세 정보를 제공함으로써 사용자가 필요한 정보를 쉽고 빠르게 얻을 수 있도록 지원합니다.<br><br><br><br>


## 🛠️ 사용된 기술 (Tech Stack)<br>
### Frontend<br>
![HTML](https://img.shields.io/badge/HTML-239120?style=for-the-badge&logo=html5&logoColor=white) ![css](https://img.shields.io/badge/CSS-239120?&style=for-the-badge&logo=css3&logoColor=white) ![js](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=JavaScript&logoColor=white)<br>
### Backend<br>
![java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)<br>
### Database<br>
![SQL](https://img.shields.io/badge/MySQL-00000F?style=for-the-badge&logo=mysql&logoColor=white)<br><br>


## 👤 사용자 관리 (User Management)
<div align="center">
  <img src="https://github.com/user-attachments/assets/eb27b984-2a43-4ac1-adb8-ca7bfd1a4143" alt="user" width="800" height="350">
</div>
> 로그인/회원가입 UI 및 기능 구현: 사용자가 손쉽게 계정을 생성하고 로그인할 수 있도록 직관적인 인터페이스를 설계하고 관련 기능을 개발했습니다.<br>
> 사용자 정보 조회 및 수정: 마이페이지에서 사용자가 자신의 정보를 확인하고 수정할 수 있는 기능을 구현하여 사용자 편의성을 높였습니다.<br><br><br><br>


## ⛽ 휴게소 정보 (Rest Area Information) & 🏪 입점 매장 정보 (Store Information)
<div align="center">
  <img src="https://github.com/user-attachments/assets/abba8619-7479-4d34-bb39-2bce4d70be1c" alt="hupage" width="800" height="350">
</div>
> 휴게소 위치 및 기본 정보 UI 구현: 전국 휴게소의 위치와 기본 정보를 시각적으로 명확하게 표시하는 UI를 구현했습니다.<br>
> 편의시설 정보 조회: 휴게소 내 음식점, 편의점 등 편의시설 정보를 사용자가 쉽게 찾아볼 수 있도록 인터랙티브한 조회 기능을 개발했습니다.<br>
> 브랜드 매장 검색 및 정보 표시: 특정 브랜드가 입점한 휴게소를 검색하고 해당 매장 정보를 효과적으로 보여주는 기능을 개발했습니다.<br>
> 편의점 및 푸드코트 정보: 휴게소별 편의점 정보와 푸드코트 메뉴를 상세하게 확인할 수 있는 UI를 구현했습니다.<br><br><br><br>


## 🎉 이벤트 정보 (Event Information)
<div align="center">
  <img src="https://github.com/user-attachments/assets/432cb15e-0273-47dc-b7ee-8962c550985f" alt="eventpage" width="800" height="350">
</div>
> 이벤트 목록 및 상세 페이지 구현: 휴게소 및 관련 브랜드의 다양한 이벤트를 모아서 보여주고, 각 이벤트의 상세 정보를 확인할 수 있는 페이지를 개발했습니다.<br><br><br><br>


## 🚗 실시간 교통 정보 (Real-time Traffic)
<div align="center">
  <img src="https://github.com/user-attachments/assets/41ded08d-8021-404e-8679-e4db2574f1ce" alt="tra" width="800" height="350">
</div>
> 교통 상황 정보 표시 UI: 주요 도로의 실시간 교통 상황을 한눈에 파악할 수 있도록 시각적으로 구현했습니다. (API 연동)<br><br><br><br>


## 주요 기능 및 담당 업무

### 프론트엔드
**메인 페이지 기본 구조 설계**
- `index.jsp`에서 `header.jsp`, `footer.jsp`, `main.jsp`를 `include` 방식으로 구성
- 페이지 이동 시 메인 영역(`main.jsp`)만 동적으로 변경되도록 설계
- 공통 네비게이션 바, 하단 푸터, 메인 콘텐츠 레이아웃 제작

**이벤트·공지사항 연동**
- 메인 페이지에 이벤트 영역과 공지사항 영역 배치 후 DB 연동
- 최신 데이터 자동 출력
- 메인 이벤트 클릭 시 이벤트 페이지로 이동, 공지사항 클릭 시 공지사항 페이지로 이동하도록 연결

**검색 기능 UI**
- 휴게소 및 관련 정보 검색창 제작
- 검색 기본 동작 구조 구현

**FAQ 페이지 제작**
- 아코디언 UI로 FAQ 화면 제작
- 현재는 하드코딩 데이터 기반으로 동작
- 추후 DB 연동이 가능하도록 구조 설계

---

### 백엔드
**휴게소 평점 및 리뷰 시스템**
- DB 설계: `REVIEW`(리뷰 정보), `GOOD`(추천 기록) 테이블 설계 및 외래키 관계 설정
- 평균 평점 계산 로직(SQL 집계 함수) 구현 및 화면 반영
- 추천/비추천 기능 구현(사용자당 1회 제한)
- 리뷰 정렬 기능: 추천순, 평점 높은순/낮은순, 최신순
- 리뷰 삭제 기능: 작성자 본인 삭제 가능, 관리자는 전체 삭제 가능
- 리뷰 작성 시 평균 평점 즉시 반영
- AJAX 기반으로 추천수 실시간 반영

<!-- 필요 시 스크린샷 자리 표시자 -->
<!-- ![메인 페이지](./images/main.png) -->
<!-- ![리뷰/평점 페이지](./images/review.png) -->
<!-- ![FAQ 페이지](./images/faq.png) -->
