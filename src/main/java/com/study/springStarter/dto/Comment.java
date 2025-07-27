package com.study.springStarter.dto;

import java.util.Date;
import java.util.Objects;

public class Comment {
    private Integer cno;
    private Integer bno;
    private String comment;
    private String commenter;
    private Date reg_date;
    private Date up_date;

    public Comment(Integer bno, String comment, String commenter) {
        this.bno = bno;
        this.comment = comment;
        this.commenter = commenter;
    }

    public Comment() {
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Comment comment1 = (Comment) o;
        return Objects.equals(cno, comment1.cno) && Objects.equals(bno, comment1.bno) && Objects.equals(comment, comment1.comment) && Objects.equals(commenter, comment1.commenter);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cno, bno, comment, commenter);
    }

    @Override
    public String toString() {
        return "Comment{" +
                "cno=" + cno +
                ", bno=" + bno +
                ", comment='" + comment + '\'' +
                ", commenter='" + commenter + '\'' +
                ", reg_date=" + reg_date +
                ", up_date=" + up_date +
                '}';
    }

    public Integer getCno() {
        return cno;
    }

    public void setCno(Integer cno) {
        this.cno = cno;
    }

    public Integer getBno() {
        return bno;
    }

    public void setBno(Integer bno) {
        this.bno = bno;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getCommenter() {
        return commenter;
    }

    public void setCommenter(String commenter) {
        this.commenter = commenter;
    }

    public Date getReg_date() {
        return reg_date;
    }

    public void setReg_date(Date reg_date) {
        this.reg_date = reg_date;
    }

    public Date getUp_date() {
        return up_date;
    }

    public void setUp_date(Date up_date) {
        this.up_date = up_date;
    }
}
