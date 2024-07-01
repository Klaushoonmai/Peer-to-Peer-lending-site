<!DOCTYPE html>
<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="config.DbHelper"%>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>Loan Letter</title>
        <style>
            body{
                width:80%;
                margin:auto;
            }
            p{
                text-align:justify;
            }

            .invoice-box{
                max-width:800px;
                margin:auto;
                padding-left:30px;
                padding-right:30px;
                padding-bottom:30px;
                padding-top:0px;

                font-size:16px;
                line-height:20px;
                font-family:'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
                color:#555;
            }

            .invoice-box  table{
                width:100%;
                line-height:inherit;
                text-align:left;

            }


            #customers table, #customers td, #customers th {    
                border: 1px solid #ddd;
                text-align: left;
            }

            #customers table {
                border-collapse: collapse;
                width: 100%;
            }

            #customers th, #customers td {
                padding: 15px;
            }

            .sk{

            }

            .invoice-box table td{
                padding:5px;
                vertical-align:top;
            }

            .invoice-box table tr td:nth-child(2){
                text-align:right;
            }

            .invoice-box table tr.top table td{
                padding-bottom:20px;
            }

            .invoice-box table tr.top table td.title{
                font-size:45px;
                line-height: 0px;

                color:#333;
            }

            .invoice-box table tr.information table td{
                padding-bottom:40px;
            }

            .invoice-box table tr.heading td{
                background:#eee;
                border-bottom:1px solid #ddd;
                font-weight:bold;
            }

            .invoice-box table tr.details td{
                padding-bottom:20px;
            }

            .invoice-box table tr.item td{
                border-bottom:1px solid #eee;
            }

            .invoice-box table tr.item.last td{
                border-bottom:none;
            }

            .invoice-box table tr.total td:nth-child(2){
                border-top:2px solid #eee;
                font-weight:bold;
            }

            @media only screen and (max-width: 600px) {
                .invoice-box table tr.top table td{
                    width:100%;
                    display:block;
                    text-align:center;
                }

                .invoice-box table tr.information table td{
                    width:100%;
                    display:block;
                    text-align:center;
                }

            }
            @media print {
                * {
                    -webkit-print-color-adjust: exact;
                }
            }
        </style>
    </head>
<%
String loanid=request.getParameter("id");
Map<String,String> loan=DbHelper.executeDQLReturnSingle("SELECT l.*,b.*,p.*,s.iamount FROM loan_list l join borrowers b on l.borrower_id=b.id join loan_plan p on p.id=l.plan_id join loan_schedules s on s.loan_id=l.loan_id WHERE l.loan_id=? limit 1", loanid);
%>
<body onload="window.print()">
        <div class="invoice-box">
            <div class="jumbotron text-center rounded-0 mb-0">
            	<h4>Loan Approval Letter</h4>
            </div>
            <table class="sk" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr class="top">
                        <td colspan="2">
                            <table>
                                <tbody>
                                    <tr>
                                        <td class="title"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr class="information">
                        <td colspan="2">
                            <table>
                                <tbody>
                                    <tr>
                                        <td>
                                            Ref:- <%= loanid %>
                                        </td>
                                        <td style="float:right;">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>


                </tbody></table>
            <div style="background: url('images/bglogo.png');
                 background-repeat: no-repeat;
                 background-position: center;
                 height:300px;position: absolute;
                 width:400px;z-index: -10;
                 top:40%;left:35%;
                 opacity:0.25;
                 background-size: 100% 100%;"></div>
            <div>

                <p>  To, <span style="float:right;">Date: <%= new Date() %></span><br></p>
                <p style="margin-bottom: 0px;"><%= loan.get("fname") %> <%= loan.get("lname") %></p>
                <p style="margin-top: 2px;"><%= loan.get("address") %></p>
                <p><b>Subject: </b> Approval of Loan</p>
                <p>Respected Sir/Madam,</p>
                <p>We are very glad to inform you that in response to your request for a Loan in order to meet your
                    financial problems, we have approved your request. You are requested a short term loan, sum of loan
                    amount INR <?= $loan_amount ?> for the tenure of <?= $loan_tenure ?> months on dated <?= date("d-m-Y",strtotime($loan_date)) ?>.</p>

                <p>The interest rate that you will have to pay on the loan will be <%= loan.get("perc") %>%. The interest rate has been
                    calculated with the help of standard formula used for calculating an interest rate. we hope that this
                    interest rate will be good for you.
                </p>
                <p>Monthly EMI for <%= loan.get("months") %> months is &#8377; <%= loan.get("iamount") %>/- at the rate of <%= loan.get("perc") %>% reducing rate of interest through N.R.I. funding
                    scheme.</p>
                <p>When you submit your amount its company responsibility to
                    handover your loan amount of &#8377; <%= loan.get("amount") %> after verify your credit ability.
                </p>
                <p>Please continue your Loan process without any hesitation.</p>
            </div>


        </div>


    </body>
</html>