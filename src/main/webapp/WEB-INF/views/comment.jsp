<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style>
        .clist {
            width: 800px;
        }

        #commentList {
            display: flex;
        }

        #commentList ul {
            list-style: none
        }

        button {
            margin-left: 10px;
            margin-top: 10px;
        }

        .commentAll {
            display: flex;
            flex-direction: column;
            width: 800px;
            margin-right: auto;
            margin-left: auto;
        }

        .send {
            display: flex;
            width: 800px;
            flex-direction: column;
        }

        .mod {
            width: 800px;
            display: flex;

        }

        #recomment {
            width: 700px;
            height: 100px;
        }

        #comment {
            width: 700px;
            height : 100px;

        }
        html{
            scroll-behavior:smooth;
        }
        .send div{
            display: flex;
        }
        div.commenter{
            font-weight: bold;
        }

        .clist li{
            margin-bottom: 20px;
        }
    </style>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
</head>

<body>
<div class="commentAll" >
    <div class="header">
        <h2>댓글</h2>
    </div>
    <div id="commentList"></div>
    <div class="send" id="cstart">
        <label>작성자 : ${sessionScope.id}</label>
        <div>
            <input class="form-control" type="text" name="comment" id="comment" >
            <button class="btn btn-default" id="sendBtn" type="button">등록</button>
        </div>
    </div>
    <div class="mod"></div>
</div>


<div class="text-center">

</div>


<script>
    let bno = "${param.bno}";
    let mode = false;
    let cnt=0;
    let showList= function(bno){
        console.log(bno);
        let comment = $('input[name=comment]').val("");
        $.ajax({
            type:'GET',       // 요청 메서드
            url: `<c:url value="/boards/${'${bno}'}/comments"/>`, // 요청 URI
            success : function(result){
                $("#commentList").html(toHtml(result));
            },
            error:function(request, status, error){
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        }); // $.ajax()
    }

    // 문서가 로드가 되었을 때 실행되는 함수 - main함수와 동일한 역할로 생각
    $(document).ready(function(){
        console.log(cnt)
        showList(bno);
        $("#sendBtn").click(function(){
            let comment = $('input[name=comment]').val();
            if(comment.trim()==''){
                alert("입력해주세요");
                return;
            }
            $.ajax({
                type:'POST',       // 요청 메서드
                url: `<c:url value="/boards/${'${bno}'}/comments"/>`,  // 요청 URI
                headers: {"content-type" : "application/json"}, // 보내는 데이터 타입명시
                data : JSON.stringify({bno:bno, comment:comment}), // 전달 데이터
                success : function(result){ // 요청이 성공일 때 실행되는 이벤트
                    alert(result);
                    showList(bno);
                },
                error:function(request, status, error){
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            }); // $.ajax()
        });

        // 각 버튼의 수정 버튼이 눌렀을 경우
        $("#commentList").on("click", ".modBtnb" , (function(){
            let cno = $(this).parent().attr('data-cno');
            let bno = $(this).parent().attr('data-bno');
            let commentText = $('div.comment', $(this).parent()).text();
            console.log(commentText)
            // 요소 추가 (수정버튼, input)
            console.log(cno)
            $(this).parent().html('<input class="form-control" type="text" name="recomment" id="recomment"><button class="btn btn-default" id="modBtn" type="button">수정</button>');
            $('input[name="recomment"]').val(commentText);
            //텍스트 가져오기 (해당 수정글에))
            //수정 댓글 번호를 저장하기
            $("#modBtn").attr('data-cno', cno);
            console.log($('div.comment', $(this).parent()).text());
        }));


        // 등록 옆에 수정 버튼을 눌렀을 경우
        $("#commentList").on("click", "#modBtn" , (function(){
            let comment = $('input[name=recomment]').val();
            if(comment.trim()==''){
                alert("입력해주세요");
                return;
            }
            let cno = $("#modBtn").attr('data-cno');
            // 수정, input 메서드 보이지 않게 요소 숨김
            //제이쿼리 데이터나 이벤트는 삭제되지 않고, 계속 유지 append로 복구 가능
            let del = $("#recomment").detach();
            let btn = $("#modBtn").detach();
            $.ajax({
                type:'PATCH',       // 요청 메서드
                url: `<c:url value="/comments/${'${cno}'}"/>`,  // 요청 URI
                headers: {"content-type" : "application/json"},
                data : JSON.stringify({cno:cno, comment:comment}),
                complete :function(result){
                    showList(bno);
                },
                error:function(request, status, error){
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            }); // $.ajax()
        }));



        //삭제 버튼은 동적으로 생성되는 버튼이므로 이벤트를 추가하기에 적합하지 않음
        //$("#delBtn").click(function(){
        //  showList(bno);
        //});
        $("#commentList").on("click", ".delBtn" , (function(){
            let cno = $(this).parent().attr('data-cno');
            let check = confirm("삭제하시겠습니까?");
            if(!check) return;
            $.ajax({
                type:'DELETE',       // 요청 메서드
                url: `<c:url value="/boards/${'${bno}'}/comments/${'${cno}'}"/>`,  // 요청 URI
                success : function(result){
                    alert(result);
                    showList(bno);
                },
                error:function(request, status, error){
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            }); // $.ajax()
            // alert("the request is sent")
        }));

    });


    let toHtml = function(comments){
        let tmp ="<ul class=clist>"

        comments.forEach(function(comment){
            tmp += '<li data-cno='+comment.cno
            tmp += ' data-bno='+comment.bno+'>'
            tmp += '<div class="commenter"> '+comment.commenter+'</div>'
            tmp += '<div class="comment"> '+comment.comment+'</div>'
            tmp += '<div class="regDate"> '+ new Date(comment.up_date).toLocaleString()+'</div>'
            if(comment.commenter=="${sessionScope.id}"){
                tmp += '<button class="delBtn">삭제</button>'
                tmp += '<button class="modBtnb">수정</button>'
            }
            tmp += '</li>'
        })
        return tmp +'</ul>';
    }

</script>
</body>
</html>