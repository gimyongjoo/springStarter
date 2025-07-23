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
        th:nth-child(3), td:nth-child(3) { width: 15%; text-align: center; } /* 아이디 */
        th:nth-child(4), td:nth-child(4) { width: 20%; text-align: center; } /* 등록일 */
        th:nth-child(5), td:nth-child(5) { width: 15%; text-align: center; } /* 조회수 */

        td:nth-child(2) {
        }

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
        <form action="<c:url value="/board/list"/>" method="get">
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