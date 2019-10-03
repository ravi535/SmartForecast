<%@page import="com.clinapps.smartforecasting.NumberOperations"%>
<%
/*
 * $Log: DeleteAdditionalDemand.jsp,v $
 * Revision 1.13  2017/05/08 09:53:57  ramus
 * Modified for 1366 * 768 resolution changes.
 *
 * Revision 1.12  2016/04/11 08:50:28  santosh
 * Task SSF-1275 Fixed
 *
 * Revision 1.11  2016/04/11 05:49:32  rajeshk
 * Fixed SSF-1275.
 *
 * Revision 1.10  2016/04/05 03:58:59  Ashokm
 * Fixed SSF-1017.
 *
 * Revision 1.9  2016/03/23 14:01:08  koteswararaoy
 * removed ajax
 *
 * Revision 1.8  2016/03/17 13:08:41  koteswararaoy
 * modified to implement task SSF-1137
 *
 * Revision 1.7  2016/03/09 11:25:30  ramesh
 * Initial Version.
 *
 * Revision 1.6  2016/02/09 14:07:40  ramesh
 * Addditional demand initial version.
 *
 * Revision 1.5  2016/02/08 10:30:44  ramesh
 * Addditional demand initial version.
 *
 * Revision 1.4  2016/02/02 09:27:27  hiteshm
 * Tab order and Alignments fixed.
 *
 * Revision 1.3  2016/01/29 09:39:42  ramesh
 * Initial version.
 *
 * Revision 1.2  2016/01/27 13:38:11  sreenivasulug
 * implement delet confirm.
 *
 * Revision 1.1  2016/01/22 07:05:33  sreenivasulug
 * Initial Version.
 *
 *
 * Title		: DeleteAdditionalDemand.jsp
 * Description	: To delete the Additional Demand.
 * Copyright	: ClinApps (c) 2016
 * Company		: ClinApps
 * @author		: Sreenivasulu g	
 * @version: $Revision: 1.13 $$Date: 2017/05/08 09:53:57 $
 */
%>
<!DOCTYPE HTML>
<html>
<head>
<title>Delete Additional Demand</title>
<%@ include file="../common/importsNew.jsp"%>
<script type="text/javascript">
function doSubmit(x)
{
	if(x=='confirm')
	{
		document.forms[1].action = document.forms[1].confirmAction.value;;
	}
	else if(x=='return')
	{
		document.forms[1].formType.value="Delete";
		document.forms[1].action = document.forms[1].returnAction.value;		
	}
	
	submit_form(document.forms[1]);
}
function sFocus() 
{
	document.getElementById('dummy').focus();
}

confirmSubmitValue = "deleteConfirm.do";
</script>
</head>
<body>
<div id="page-container">
<%@include file="../common/SSFPageHeader.jsp" %>
<div id="div-hidden-fields"><input type="text" id="dummy" tabindex="1" /><input type="text" id="dummy1" tabindex="100" onfocus="$('#but').focus();" /></div>
<div class="page-header"><div class="headerbar headerbar-size"><img src="images/barside.jpg" ></div><div class="pagename"><h1>Delete Additional Demand</h1></div></div>
<div id="formcntnr">
<form class="form1" method="post">
<html:hidden name="ViewAdditionalDemandForm" property="formType"/>
	<div class="button-band"><div class="buttons"><%if (SfUtils.isReadonly(request, session)){ %><a class="but-disbl" title="Confirm"><span>Confirm</span></a><% } else {%><a href="javascript:doSubmit('confirm');" id="but" title="Confirm" tabindex="30"><span>Confirm</span></a><%} %><a href="javascript:doSubmit('return');" title="Return" tabindex="31"><span>Return</span></a></div></div>
	<div class="del-addDemand-grid">
	<table id="del-add-demand" style="width:100%;height:100%">
		<input type="hidden" name="confirmAction" value="deleteConfirm.do"/>
		<input type="hidden" name="returnAction" value="AdditionDemandDetailsReturn.do"/>
    <thead>
    <tr height="25">
    <th data-options="field:'itemid',width:'20%',sortable:false,resizable:false"><div class="col-name"><span>Item ID</span></div></th>
    <th data-options="field:'itemname',width:'45%',sortable:false,resizable:false"><div class="col-name"><span>Item Description</span></div></th>
    <th data-options="field:'demanddate',width:'10%',sortable:false,resizable:false"><div class="col-name"><span>Demand Month</span></div></th>
    <th data-options="field:'qty',width:'10%',sortable:false,resizable:false"><div class="col-name"><span>Demand Qty.</span></div></th>
    <th data-options="field:'uom',width:'15%',sortable:false,resizable:false"><div class="col-name"><span>UOM</span></div></th>
    </tr>
    </thead>
    <tbody>
    <logic:present name="AdditionalDemandDeleteList" scope="session">
    <logic:notEmpty name="AdditionalDemandDeleteList">
    <logic:iterate id="deleteList" name="AdditionalDemandDeleteList">
    <bean:define id="demandMonth" name="deleteList" property="demandMonth"/>
    <%String localDemandMonth = (String) SfUtils.getCustomizedDate((GregorianCalendar)demandMonth); 
    localDemandMonth = localDemandMonth.substring(localDemandMonth.indexOf("-")+1);
    %>
    <tr>
    <td><div class="datagrid-cell-nowrap" onmouseover="sOverTip(this);"><clinapps:write name="deleteList" property="itemId"/></div></td>
    <td><div class="datagrid-cell-nowrap" onmouseover="sOverTip(this);"><clinapps:write name="deleteList" property="itemName"/></div></td>
    <td><div class="datagrid-cell-nowrap" onmouseover="sOverTip(this);"><%=localDemandMonth %></div></td>
    <bean:define id="demandQuantity" name="deleteList" property="demandQty" type="java.lang.Double"/>
	<%
		NumberOperations localNumberOperations=new NumberOperations(demandQuantity);
		String localDemandQty=localNumberOperations.formatValue();
	%>
    <td><div class="datagrid-cell-nowrap" onmouseover="sOverTip(this);"><%=localDemandQty %></div></td>
    <td><div class="datagrid-cell-nowrap" onmouseover="sOverTip(this);"><clinapps:write name="deleteList" property="addDmndUomCd"/></div></td>
    </tr>
    </logic:iterate>
    </logic:notEmpty>
    </logic:present>
    </tbody>
    </table>
    <script type="text/javascript">
    $(function(){
      	 $('#del-add-demand').datagrid({
      		 singleSelect: true,
       onClickRow:function(rowIndex){
    	   $('.datagrid-row-selected').css('background','#fff');
       } 
      	 });
      	sFocus();
	});
	</script>
	</div>
</form>
</div>
</div>
</body>
</html>
<%@ include file="../common/FooterNew.jsp"%>
