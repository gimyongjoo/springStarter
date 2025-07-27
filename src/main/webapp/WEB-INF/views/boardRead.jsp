<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="navi.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 - 상세보기</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', 'Noto Sans KR', sans-serif;
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px 0;
            text-align: center;
            margin-bottom: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .header h1 {
            font-size: 2rem;
            font-weight: 300;
            margin-bottom: 10px;
        }

        .board-detail {
            background: white;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .post-header {
            background: #f8f9fa;
            padding: 30px;
            border-bottom: 3px solid #e9ecef;
        }

        .post-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 20px;
            line-height: 1.3;
        }

        .post-info {
            display: flex;
            flex-wrap: wrap;
            gap: 25px;
            color: #6c757d;
            font-size: 0.95rem;
        }

        .post-info span {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .post-info span::before {
            content: '';
            width: 4px;
            height: 4px;
            background: #667eea;
            border-radius: 50%;
        }

        .post-content {
            padding: 40px;
            font-size: 1.1rem;
            line-height: 1.8;
            color: #495057;
        }

        .post-content p {
            margin-bottom: 20px;
        }

        .post-stats {
            background: #f8f9fa;
            padding: 20px 40px;
            border-top: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .stats-item {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #6c757d;
            font-size: 0.9rem;
        }

        .stats-icon {
            width: 18px;
            height: 18px;
            fill: #667eea;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 40px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 117, 125, 0.4);
        }

        .btn-outline {
            background: transparent;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-outline:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
        }

        .back-to-list {
            text-align: center;
            margin-top: 40px;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            .header h1 {
                font-size: 1.5rem;
            }

            .post-title {
                font-size: 1.4rem;
            }

            .post-header, .post-content {
                padding: 20px;
            }

            .post-info {
                gap: 15px;
                font-size: 0.85rem;
            }

            .action-buttons {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                max-width: 200px;
                justify-content: center;
            }

            .post-stats {
                padding: 15px 20px;
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
<script>
    if(${msg eq 'updateSuc'}) alert("게시글 수정이 완료되었습니다.");
    if(${msg eq 'delFail'}) alert("잠시 후 다시 시도해주세요.");
</script>
<div class="container">
    <form method="post" name="deleteFrm">
        <input type="hidden" value="${dto.bno}" name="bno">
    </form>
    <div class="board-detail">
        <div class="post-header">
            <h2 class="post-title">${dto.title}</h2>
            <div class="post-info">
                <span>작성자: ${dto.writer}</span>
                <span>작성일: <fmt:formatDate value="${dto.regDate}" pattern="yyyy-MM-dd HH:mm"/></span>
            </div>
        </div>

        <div class="post-content">
            ${dto.content}
        </div>

        <div class="post-stats">
            <div class="stats-item">
                <svg class="stats-icon" viewBox="0 0 24 24">
                    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>
                </svg>
                조회수 ${dto.viewCnt}
            </div>
        </div>
    </div>

    <div class="action-buttons">
        <c:if test="${sessionScope.id eq dto.writer}">
            <button class="btn btn-secondary" onclick="location.href='<c:url value="/board/modify?bno=${param.bno}"/>'">수정</button>
            <button class="btn btn-secondary" onclick="deleteFn()">삭제</button>
        </c:if>
        <a href="<c:url value='/board/list${sc.queryString}'/>" class="btn btn-primary">목록으로 돌아가기</a>
    </div>
</div>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<%@ include file="comment.jsp" %>
<script>
    function deleteFn() {
        let check = confirm('정말로 삭제하시겠습니까?');
        if(check) {
            let frm = document.deleteFrm;
            frm.method = "post";
            frm.action = "<c:url value='/board/remove'/>";
            frm.submit();
        }
    }
</script>
</body>
</html>