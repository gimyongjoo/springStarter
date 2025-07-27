<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>greenart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
        }

        a { text-decoration: none; }

        ul {
            list-style-type: none;
            height: 48px;
            background-color: #93CC8D;
            display: flex;
            align-items: center;
            padding: 0 20px;
        }

        ul > li {
            margin-right: 20px;
        }

        ul > li > a, #logo {
            color: white;
            font-size: 18px;
        }

        ul > li > a:hover {
            color: lightgray;
            border-bottom: 3px solid rgb(209, 209, 209);
        }

        #logo {
            font-weight: bold;
            margin-right: auto;
        }

        .container {
            width: 90%;
            max-width: 720px; /* ✅ 게시판 크기 줄이기 */
            margin: 40px auto;
            text-align: center;
        }

        h1 {
            margin-bottom: 30px;
            color: #222;
        }

        table {
            width: 100%; /* ✅ 줄어든 컨테이너에 맞게 */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }
        table tr td a {
            color: black;
        }
        th, td {
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #f9f9f9;
            text-align: center;
            font-weight: 600;
        }

        td:nth-child(1), td:nth-child(5), th:nth-child(1), th:nth-child(5) {
            text-align: center;
            width: 8%;
        }

        th:nth-child(1), td:nth-child(1) { width: 10%; text-align: center; } /* 번호 */
        th:nth-child(2), td:nth-child(2) { width: 40%; text-align: center; }   /* 제목 */
        th:nth-child(3), td:nth-child(3) { width: 20%; text-align: center; } /* 아이디 */
        th:nth-child(4), td:nth-child(4) { width: 20%; text-align: center; } /* 등록일 */
        th:nth-child(5), td:nth-child(5) { width: 10%; text-align: center; } /* 조회수 */

        tr:nth-child(even) {
            background-color: #fcfcfc;
        }

        tr:hover {
            background-color: #f0f8ff;
            cursor: pointer;
        }

        tr:last-child td {
            border-bottom: none;
        }
        /* 페이지 네비게이션 스타일 */
        #page {
            margin-top: 40px;
            text-align: center;
            padding: 20px 0;
        }

        #page a {
            display: inline-block;
            padding: 10px 15px;
            margin: 0 5px;
            background: linear-gradient(135deg, #ffffff, #f8fdf8);
            color: #4a7c59;
            text-decoration: none;
            border: 1px solid rgba(147, 204, 141, 0.3);
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(147, 204, 141, 0.1);
        }

        #page a:hover {
            background: linear-gradient(135deg, #93CC8D, #7AB872);
            color: white;
            border-color: #7AB872;
            box-shadow: 0 4px 8px rgba(147, 204, 141, 0.3);
            transform: translateY(-1px);
        }

        /* 현재 페이지 스타일 (활성화된 페이지용) */
        #page a.active {
            background: linear-gradient(135deg, #93CC8D, #7AB872);
            color: white;
            border-color: #7AB872;
            font-weight: bold;
            box-shadow: 0 2px 4px rgba(147, 204, 141, 0.2);
        }

        #page a.active:hover {
            transform: none;
            box-shadow: 0 2px 4px rgba(147, 204, 141, 0.2);
        }

        /* 이전/다음 버튼 스타일 */
        #page a.step{
            background: linear-gradient(135deg, #f0f8f0, #e8f5e8);
            border-color: rgba(147, 204, 141, 0.4);
            font-weight: bold;
        }
        .write-btn {
            display: inline-block;
            margin-top: 20px;
            background-color: #93CC8D;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .write-btn:hover {
            background-color: #7AB872;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }

        /* 기존 .container 스타일 유지 */
        .container {
            width: 90%;
            max-width: 720px; /* 게시판 크기 줄이기 */
            margin: 40px auto;
            /* text-align: center;  이 부분은 제거하거나 다른 요소에 적용하세요 */
        }

        /* 검색 폼을 감싸는 div (search-container)의 스타일 */
        .search-container {
            margin: 30px 0 0 auto; /* 왼쪽 마진을 auto로 설정하여 우측으로 밀어냅니다. */
            padding: 20px;
            border-radius: 10px;
            display: flex;
            justify-content: flex-end; /* 검색 폼 내부 요소를 우측으로 정렬합니다. */
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            max-width: fit-content; /* 내용물 너비에 맞게 조절 */
        }

        /* search-form도 우측 정렬에 맞춰 가운데 정렬 대신 flex-end로 변경 */
        .search-form {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: flex-end; /* 이 부분도 flex-end로 설정 */
        }

        /* 기존 검색 폼 요소들의 스타일은 그대로 유지 */
        .search-select,
        .search-input {
            padding: 12px 18px;
            font-size: 1.05rem;
            border: 1px solid #dcdcdc;
            border-radius: 8px;
            background-color: #ffffff;
            transition: all 0.3s ease;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.05);
            color: #333;
        }

        .search-select {
            min-width: 120px;
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="%237AB872" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 20px;
            cursor: pointer;
        }

        .search-select:hover {
            border-color: #93CC8D;
        }

        .search-input {
            flex-grow: 1;
            min-width: 200px;
        }

        .search-input::placeholder {
            color: #aaa;
        }

        .search-select:focus,
        .search-input:focus {
            outline: none;
            border-color: #7AB872;
            box-shadow: 0 0 0 4px rgba(147, 204, 141, 0.3);
        }

        .search-btn {
            padding: 12px 25px;
            background-color: #93CC8D;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.05rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.2s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .search-btn:hover {
            background-color: #7AB872;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .search-btn:active {
            transform: translateY(0);
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1);
        }

        .search-btn .fas {
            font-size: 1rem;
        }

        /* Adjust for smaller screens */
        @media (max-width: 600px) {
            .search-form {
                flex-direction: column;
                width: 100%;
                justify-content: center; /* 모바일에서는 다시 가운데 정렬 */
            }

            .search-select,
            .search-input,
            .search-btn {
                width: 100%;
                margin-bottom: 10px;
            }

            .search-select {
                margin-right: 0;
            }
        }
    </style>
</head>
<body>
<script>
    if(${msg eq 'writeSuc'}) alert('작성이 완료되었습니다.');
    if(${msg eq 'delSuc'}) alert('삭제가 완료되었습니다.');
</script>
<div id="menu">
    <ul>
        <li id="logo">greenart</li>
        <li><a href="<c:url value='/'/>">Home</a></li>
        <li><a href="<c:url value='/board/list'/>">Board</a></li>
        <c:choose>
            <c:when test="${not empty sessionScope.id}">
                <li><a href="<c:url value='/logout'/>">Logout</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="<c:url value='/register/add'/>">Sign in</a></li>
                <li><a href="<c:url value='/login1'/>">Login</a></li>
            </c:otherwise>
        </c:choose>
        <li><a href=""><i class="fas fa-search small"></i></a></li>
    </ul>
</div>
<div style="text-align:center" class="container">
    <h1>게시판 화면</h1>
    <div class="search-container">
        <form action="<c:url value="/board/list"/>" method="get" class="search-form">
            <select name="option" class="search-select">
                <option value="T" ${param.option eq 'T' ? 'selected' : ''}>제목</option>
                <option value="W" ${param.option eq 'W' ? 'selected' : ''}>작성자</option>
                <option value="A" ${param.option eq 'A' ? 'selected' : ''}>제목+내용</option>
            </select>

            <input type="text" name="keyword" class="search-input" placeholder="검색어를 입력하세요."
                    required value="${not empty param.keyword ? param.keyword : ''}">

            <button type="submit" class="search-btn">
                <i class="fas fa-search"></i> 검색
            </button>
        </form>
    </div>
    <table>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>아이디</th>
            <th>등록일</th>
            <th>조회수</th>
        </tr>
        <c:forEach items="${list}" var="b">
            <tr>
                <td>${b.bno}</td>
                <td><a href="<c:url value='/board/read${ph.sc.queryString}&bno=${b.bno}'/>">${b.title}</a></td>
                <td>${b.writer}</td>
                    <fmt:formatDate value="${b.regDate}" pattern="yyyy-MM-dd" var="postDate" />
                    <fmt:formatDate value="<%= new Date() %>" pattern="yyyy-MM-dd" var="today" />
                <c:choose>
                    <c:when test="${postDate eq today}">
                        <td><fmt:formatDate value="${b.regDate}" pattern="HH:mm"/></td>
                    </c:when>
                    <c:otherwise>
                        <td>${postDate}</td>
                    </c:otherwise>
                </c:choose>
                <td>${b.viewCnt}</td>
            </tr>
        </c:forEach>
    </table>
    <div id="page">
        <c:if test="${ph.showPrev}">
            <a class="step" href='<c:url value="/board/list${ph.sc.getQueryString(ph.beginPage - 1)}"/>'>이전</a>
        </c:if>
        <c:forEach begin="${ph.beginPage}" end="${ph.endPage}" var="i">
            <a class="${i == ph.sc.page ? 'active' : ''}" href='<c:url value="/board/list${ph.sc.getQueryString(i)}"/>'>${i}</a>
        </c:forEach>
        <c:if test="${ph.showNext}">
            <a class="step" href='<c:url value="/board/list${ph.sc.getQueryString(ph.endPage + 1)}"/>'>다음</a>
        </c:if>
    </div>
    <button type="button" onclick="location.href='<c:url value="/board/write" />'" class="write-btn">글쓰기</button>
</div>
</body>
</html>