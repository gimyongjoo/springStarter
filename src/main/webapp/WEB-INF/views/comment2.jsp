<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    // bno를 boardRead.jsp의 hidden input에서 가져오는 것이 더 안정적입니다.
    // jQuery가 로드된 후에 실행되어야 하므로 $(document).ready() 안으로 옮기는 것을 권장합니다.
    let bno = "${param.bno}"; // 임시로 유지하되, 아래 ready 함수 내에서 재정의할 것입니다.
    let mode = false;
    let cnt=0;
    let showList= function(currentBno){ // 파라미터 이름을 bno와 구분하여 currentBno로 변경
        console.log("showList 호출, BNO:", currentBno); // 디버깅용
        let comment = $('input[name=comment]').val("");
        $.ajax({
            type:'GET',       // 요청 메서드
            // JSTL EL 문법 오류 수정: ${'${bno}'} -> ${currentBno}
            url: `<c:url value="/boards/${currentBno}/comments"/>`, // 요청 URI
            success : function(result){
                $("#commentList").html(toHtml(result));
            },
            error:function(request, status, error){
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    }

    // 문서가 로드가 되었을 때 실행되는 함수 - main함수와 동일한 역할로 생각
    $(document).ready(function(){
        // boardRead.jsp에서 bno 값을 가져와서 사용
        bno = $('input[name="bno"]').val(); // boardRead.jsp의 hidden input에서 가져오기
        console.log("댓글 JS 초기화, BNO:", bno); // 디버깅용
        showList(bno); // 초기 댓글 목록 로드

        $("#sendBtn").click(function(){
            let comment = $('input[name=comment]').val();
            if(comment.trim()==''){
                alert("입력해주세요");
                return;
            }
            $.ajax({
                type:'POST',       // 요청 메서드
                // JSTL EL 문법 오류 수정: ${'${bno}'} -> ${bno}
                url: `<c:url value="/boards/${bno}/comments"/>`,  // 요청 URI [cite: 19, 56]
                headers: {"content-type" : "application/json"}, // 보내는 데이터 타입명시
                data : JSON.stringify({bno:bno, comment:comment}), // 전달 데이터
                success : function(result){ // 요청이 성공일 때 실행되는 이벤트
                    alert(result);
                    showList(bno);
                },
                error:function(request, status, error){
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            });
        });

        // 각 버튼의 수정 버튼이 눌렀을 경우
        $("#commentList").on("click", ".modBtnb" , (function(){
            let cno = $(this).parent().attr('data-cno');
            //let bno = $(this).parent().attr('data-bno'); // 이미 전역 bno 사용
            let commentText = $('div.comment', $(this).parent()).text();
            console.log(commentText);

            console.log(cno);
            $(this).parent().html('<input class="form-control" type="text" name="recomment" id="recomment"><button class="btn btn-default" id="modBtn" type="button">수정</button>');
            $('input[name="recomment"]').val(commentText);
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
            let del = $("#recomment").detach();
            let btn = $("#modBtn").detach();
            $.ajax({
                type:'PATCH',       // 요청 메서드
                // JSTL EL 문법 오류 수정: ${'${cno}'} -> ${cno}
                url: `<c:url value="/comments/${cno}"/>`,  // 요청 URI [cite: 27, 64]
                headers: {"content-type" : "application/json"},
                data : JSON.stringify({cno:cno, comment:comment}),
                complete :function(result){
                    showList(bno);
                },
                error:function(request, status, error){
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            });
        }));


        $("#commentList").on("click", ".delBtn" , (function(){
            let cno = $(this).parent().attr('data-cno');
            let check = confirm("삭제하시겠습니까?");
            if(!check) return;
            $.ajax({
                type:'DELETE',       // 요청 메서드
                // JSTL EL 문법 오류 수정: ${'${bno}'} -> ${bno}, ${'${cno}'} -> ${cno}
                url: `<c:url value="/boards/${bno}/comments/${cno}"/>`,  // 요청 URI [cite: 33, 70]
                success : function(result){
                    alert(result);
                    showList(bno);
                },
                error:function(request, status, error){
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            });
        }));

    });


    let toHtml = function(comments){
        let tmp ="<ul class=clist>"

        comments.forEach(function(comment){
            tmp += '<li data-cno='+comment.cno
            tmp += ' data-bno='+comment.bno+'>'
            tmp += '<div class="commenter"> '+comment.commenter+'</div>'
            tmp += '<div class="comment"> '+comment.comment+'</div>'
            tmp += '<div class="regDate"> '+ new Date(comment.up_date).toLocaleString()+'</div>' [cite: 36, 73]
            if(comment.commenter=="${sessionScope.id}"){
                tmp += '<button class="delBtn">삭제</button>'
                tmp += '<button class="modBtnb">수정</button>'
            }
            tmp += '</li>'
        })
        return tmp +'</ul>';
    }
</script>
