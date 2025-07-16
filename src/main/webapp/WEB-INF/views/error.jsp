<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>ERROR</title>
</head>
<body>
    <h1>예외가 발생했습니다.</h1>
<%--    발생한 예외 : ${ex} <br>--%>
<%--    예외 메시지 : ${ex.message} <br>--%>
    발생한 예외 : ${pageContext.exception} <br>
    예외 메시지 : ${pageContext.exception.message} <br>
    <ol>
<%--    <c:forEach items="${ex.stackTrace}" var="i">    --%>
        <c:forEach items="${pageContext.exception.stackTrace}" var="i">
            <li>${i.toString()}</li>
        </c:forEach>
    </ol>
</body>
</html>