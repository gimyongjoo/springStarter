</html><%@ page language="java" contentType="text/html; charset=UTF-8"
                pageEncoding="UTF-8"%>
<%@ include file="navi.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 - 글쓰기</title>
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

        .writeFrm-container {
            max-width: 800px;
            margin: 60px auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .page-header {
            background: linear-gradient(135deg, #93CC8D 0%, #7AB872 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .page-header h1 {
            font-size: 2rem;
            font-weight: 300;
            margin: 0;
        }

        .form-container {
            padding: 40px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
            font-size: 1.1rem;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 1rem;
            font-family: inherit;
            transition: all 0.3s ease;
            background-color: #fafbfc;
        }

        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            border-color: #93CC8D;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(147, 204, 141, 0.1);
            transform: translateY(-1px);
        }

        textarea {
            resize: vertical;
            min-height: 200px;
            line-height: 1.6;
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        input[type="submit"],
        .btn {
            padding: 15px 40px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            min-width: 120px;
            justify-content: center;
        }

        input[type="submit"] {
            background: linear-gradient(135deg, #93CC8D 0%, #7AB872 100%);
            color: white;
        }

        input[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(147, 204, 141, 0.4);
        }

        .btn-cancel {
            background: #6c757d;
            color: white;
        }

        .btn-cancel:hover {
            background: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 117, 125, 0.4);
        }

        /* 폼 유효성 검사 스타일 */
        .form-group.error input,
        .form-group.error textarea {
            border-color: #dc3545;
            box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
        }

        .error-message {
            color: #dc3545;
            font-size: 0.9rem;
            margin-top: 5px;
            display: none;
        }

        .form-group.error .error-message {
            display: block;
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .page-header {
                padding: 20px;
            }

            .page-header h1 {
                font-size: 1.5rem;
            }

            .form-container {
                padding: 20px;
            }

            input[type="text"],
            textarea {
                padding: 12px;
            }

            .button-group {
                flex-direction: column;
                align-items: center;
            }

            input[type="submit"],
            .btn {
                width: 100%;
                max-width: 250px;
            }
        }

        /* 추가 스타일링 */
        .form-tips {
            background: #f8f9fa;
            border-left: 4px solid #93CC8D;
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 0 10px 10px 0;
        }

        .form-tips h3 {
            color: #2c3e50;
            margin-bottom: 8px;
            font-size: 1rem;
        }

        .form-tips ul {
            margin-left: 20px;
            color: #6c757d;
        }

        .form-tips li {
            margin-bottom: 5px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
<script>
    if(${msg eq 'updateFail'}) alert('글 수정에 실패했습니다. 잠시 후 다시 시도 부탁드립니다.');
</script>
<div class="writeFrm-container">
    <div class="page-header">
        <h1>수정</h1>
    </div>

    <div class="form-container">
        <form method="post" id="writeForm">
            <input type="hidden" id="writer" name="writer" value="${dto.writer}">
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" value="${dto.title}">
                <div class="error-message">제목을 입력해주세요.</div>
            </div>

            <div class="form-group">
                <label for="content">내용</label>
                <textarea rows="10" id="content" name="content">${dto.content}</textarea>
                <div class="error-message">내용을 입력해주세요.</div>
            </div>

            <div class="button-group">
                <input type="submit" value="수정하기">
                <input type="reset" onclick="location.href='<c:url value="/board/list"/>'" class="btn btn-cancel" value="취소">
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('writeForm');
        const titleInput = document.getElementById('title');
        const contentTextarea = document.getElementById('content');

        // 폼 유효성 검사
        form.addEventListener('submit', function(e) {
            let isValid = true;

            // 제목 검사
            if (titleInput.value.trim() === '') {
                showError(titleInput, '제목을 입력해주세요.');
                isValid = false;
            } else {
                hideError(titleInput);
            }

            // 내용 검사
            if (contentTextarea.value.trim() === '') {
                showError(contentTextarea, '내용을 입력해주세요.');
                isValid = false;
            } else {
                hideError(contentTextarea);
            }

            if (!isValid) {
                e.preventDefault();
            }
        });

        // 실시간 유효성 검사
        titleInput.addEventListener('blur', function() {
            if (this.value.trim() === '') {
                showError(this, '제목을 입력해주세요.');
            } else {
                hideError(this);
            }
        });

        contentTextarea.addEventListener('blur', function() {
            if (this.value.trim() === '') {
                showError(this, '내용을 입력해주세요.');
            } else {
                hideError(this);
            }
        });

        // 에러 표시 함수
        function showError(element, message) {
            const formGroup = element.closest('.form-group');
            const errorMessage = formGroup.querySelector('.error-message');

            formGroup.classList.add('error');
            errorMessage.textContent = message;
        }

        // 에러 숨김 함수
        function hideError(element) {
            const formGroup = element.closest('.form-group');
            formGroup.classList.remove('error');
        }
    });
</script>
</body>
</html>