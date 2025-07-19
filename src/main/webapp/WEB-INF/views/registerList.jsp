<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원목록</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 20px;

            color: #333;
        }

        h1 {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
            font-size: 0.9em;
            min-width: 400px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            background-color: #ffffff;
            text-align: center;
        }

        table thead tr {
            background-color: #009879;
            color: #ffffff;
            text-align: left;
        }

        table th,
        table td {
            padding: 12px 15px;
            border: 1px solid #dddddd;
        }

        table tbody tr {
            border-bottom: 1px solid #dddddd;
        }

        table tbody tr:nth-of-type(even) {
            background-color: #f3f3f3;
        }

        table tbody tr:last-of-type {
            border-bottom: 2px solid #009879;
        }
        table tbody tr:not(:first-child):hover {
            background-color: #e2f0ef;
            cursor: pointer;
        }

        button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.85em;
            transition: background-color 0.2s ease;
        }

        button:hover {
            opacity: 0.6;
        }

        .btn2 {
            background-color: red;
        }

        .mody:hover {
            background-color: #0056b3;
        }

        .mody:active {
            background-color: #004085;
        }

        /* 삭제 버튼은 빨간색으로 */
        .del { /* 마지막 버튼(삭제 버튼) */
            background-color: #dc3545;
        }

        .del:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
<h1>회원 목록</h1>

<table border="1">
    <tr>
        <th>id</th>
        <th>pwd</th>
        <th>name</th>
        <th>email</th>
        <th>birth</th>
        <th>sns</th>
        <th>reg_date</th>
        <th colspan="2">function</th>
    </tr>
    <c:forEach items="${mlist}" var="m">
        <tr>
            <td>${m.id}</td>
            <td>${m.pwd}</td>
            <td>${m.name}</td>
            <td>${m.email}</td>
            <td><fmt:formatDate value="${m.birth}" pattern="yyyy-MM-dd" /></td>
            <td>${m.sns}</td>
            <td><fmt:formatDate value="${m.regDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
            <td><button type="button" onclick="location.href='update'">수정</button></td>
            <td><button class="btn2" type="button" onclick="location.href='delete'">삭제</button></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>