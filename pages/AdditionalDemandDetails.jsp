<%@page import="com.clinapps.components.StatusConstants"%>
<%@page import="com.clinapps.smartforecasting.NumberOperations"%>
<%
/*
 * $Log: AdditionalDemandDetails.jsp,v $
 * Revision 1.26  2017/10/04 12:50:12  koteswararaoy
 * modified to fix task SSF-2299
 *
 * Revision 1.25  2017/05/16 07:11:26  hiteshm
 * Task SSF-1892 fixed.
 *
 * Revision 1.24  2017/05/08 09:54:37  ramus
 * Modified for 1366 * 768 resolution changes.
 *
 * Revision 1.23  2017/04/25 07:12:37  hiteshm
 * Fixed label alignment.
 *
 * Revision 1.22  2017/04/25 04:59:13  hiteshm
 * Modified for base resolution changes.
 *
 * Revision 1.21  2016/11/07 09:01:40  santosh
 * Alignment Fixed
 *
 * Revision 1.20  2016/10/19 12:58:48  santosh
 * Task SSF-1616 Fixed
 *
 * Revision 1.19  2016/10/18 06:44:27  ramus
 * Fixed Task SSF - 1592
 *
 * Revision 1.18  2016/10/17 06:43:08  ramus
 * Fixed Task SSF - 1592
 *
 * Revision 1.17  2016/09/29 04:30:18  hemalathap
 * Fixed task PMD-1512.
 *
 * Revision 1.16  2016/07/11 06:42:09  hiteshm
 * Task SSF-1501 fixed.
 *
 * Revision 1.15  2016/04/07 08:57:17  hiteshm
 * Task SSF-1239 fixed.
 *
 * Revision 1.14  2016/04/07 07:19:39  hiteshm
 * Task SSF-1253 fixed.
 *
 * Revision 1.13  2016/04/05 03:58:59  Ashokm
 * Fixed SSF-1017.
 *
 * Revision 1.12  2016/03/25 04:39:12  rajeshk
 * Modified for new report functionality.
 *
 * Revision 1.11  2016/03/23 14:01:08  koteswararaoy
 * removed ajax
 *
 * Revision 1.10  2016/03/17 13:09:58  koteswararaoy
 * modified to implement task SSF-1137
 *
 * Revision 1.9  2016/02/11 15:46:05  ramesh
 * Addditional demand initial version.
 *
 * Revision 1.8  2016/02/09 13:53:47  ramesh
 * Modified for disable fields when discontinued.
 *
 * Revision 1.7  2016/02/08 10:34:43  ramesh
 * Addditional demand initial version.
 *
 * Revision 1.6  2016/02/02 09:27:15  hiteshm
 * Tab order and Alignments fixed.
 *
 * Revision 1.5  2016/01/29 10:36:07  sreenivasulug
 * Initial version.
 *
 * Revision 1.4  2016/01/29 09:42:53  ramesh
 * Initial version.
 *
 * Revision 1.3  2016/01/29 03:56:11  ramesh
 * Initial version.
 *
 * Revision 1.2  2016/01/27 13:57:12  sreenivasulug
 * UI Alignments and tab order fixed.
 *
 * Revision 1.1  2016/01/22 07:05:33  sreenivasulug
 * Initial Version.
 *
 *
 * Title		: AdditionalDemandDetails.jsp
 * Description	: To modify the Additional Demand.
 * Copyright	: ClinApps (c) 2016
 * Company		: ClinApps
 * @author		: Sreenivasulu g	
 * @version: $Revision: 1.26 $$Date: 2017/10/04 12:50:12 $
 */
%>
<!DOCTYPE HTML>
<html>
<head>
<title>Additional Demand Details</title>
<%@ include file="../common/importsNew.jsp"%>

<%
ItemAdditionalDemandBean localItemAdditionalDemandBean = (ItemAdditionalDemandBean) session
.getAttribute("oldDemandBean");

String createUser = localItemAdditionalDemandBean.getCreateUser();
String createDate = "";
String UpdateDate = "";
GregorianCalendar localGcCreateDate = localItemAdditionalDemandBean.getCreateDate();
if (localGcCreateDate != null)
createDate = SfUtils.getCustomizedDate(localItemAdditionalDemandBean.getCreateDate());
String updateuser = localItemAdditionalDemandBean.getUpdateUser();
GregorianCalendar localGcUpdateDate = localItemAdditionalDemandBean.getUpdateDate();
if (localGcUpdateDate != null)
UpdateDate = SfUtils.getCustomizedDate(localGcUpdateDate);
if (createDate == null) {
createDate = "";
}
if (UpdateDate == null) {
UpdateDate = "";
}
if (updateuser == null) {
updateuser = "";
}


String show = "Created By : "
		+ SfUtils.replaceToHTMLCodeForAuditButton(createUser)
		+ "<br>Created Date : " + createDate + "<br>Updated By : "
		+ SfUtils.replaceToHTMLCodeForAuditButton(updateuser)
		+ "<br>Updated Date : " + UpdateDate + "";

%>
 
<%
long localStatusCode=localItemAdditionalDemandBean.getStatusCd();
boolean isEnable=false;
String styleClass="Fontface";

if(localStatusCode!=StatusConstants.ITEM_ADD_DMND_ACTIVE_STATUS)
{
	isEnable=true;
	styleClass="readonly";
	
}
%>
<script type="text/javascript">
function testFun() 
{ 
	 monthOnlyRequired = true;
}

var Months = new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
function discontChanged(){
	if(document.forms[1].demandStatus.checked)
	{
		document.forms[1].isChecked.value = "true";
		document.forms[1].statusChangedDate.value = getDate();
		document.forms[1].statusChangedDateDisplay.value = document.forms[1].statusChangedDate.value;
	}
	else
	{
		document.forms[1].isChecked.value = "false";
		document.forms[1].statusChangedDate.value = "";
		document.forms[1].statusChangedDateDisplay.value = document.forms[1].statusChangedDate.value;
	}
	
}
function getDate(){
	var d = new Date();
	var sdate = d.getDate()+"";
	var d1;
	if(sdate.length<2)
	{
		sdate = "0"+sdate;
	}
	d1=sdate+"-"+Months[d.getMonth()]+"-"+d.getFullYear();
	
	return d1;
}

function  doSubmit(x) 
{
		if(x=='modify')
		{
			document.forms[1].action = document.forms[1].modifyAction.value;
		}
		else if(x=='return')
		{
			document.forms[1].action = document.forms[1].returnAction.value;			
		}
		else if(x=='reset')
		{
			document.forms[1].action = document.forms[1].resetAction.value;
		}
		submit_form(document.forms[1]);
}

dropdownStyleID = [
                   {id : 'uomStyleId',
                	isOptionEmptyRequired:"false"     
                   },
                   {
            			 id:"url",
            			 isOptionEmptyRequired:"false"},
            	   {
  	                	 id : "exportType",
  	                	 selectTag:"<select name=\"exportType\"  id=\"exportType\" style=\"width:40%\" tabindex=\"1003\" ></select>"
  	               }
                   ];
 
$(document).ready(function() {
    $('#uomStyleId').select2({allowClear:false});
});
function addSeparatorsNF(nStr, inD, outD, sep)
{
	nStr += '';
	var dpos = nStr.indexOf(inD);
	
	var nStrEnd = '';
	
	if (dpos != -1)
	{
		nStrEnd = nStr.substring(dpos, nStr.length);
		nStr = nStr.substring(0, dpos);
	}
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(nStr))
	{
		nStr = nStr.replace(rgx, '$1' + sep + '$2');
	}
	return nStr + nStrEnd;
	
}
function formatNumber(obj)
{
	obj.value = removeCommas(obj.value);
	var n1 = removeCommas(obj.value);
	if(n1 != "" && !isNaN(n1))
		n1 = parseFloat(n1);
	obj.value = addSeparatorsNF(n1, ".", ".", ",");
}
function removeCommas(strValue)
{
	var objRegExp = /,/g;
	x =  strValue;
	return strValue.replace(objRegExp,'');
}
function formatQuantity()
{
	var v1 = removeCommas(document.forms[1].demandQty.value);
	if(v1!="" && !isNaN(v1))
		v1 = parseFloat(v1);
	document.forms[1].demandQty.value = addSeparatorsNF(v1, ".", ".", ",");
}

confirmSubmitValue = "AdditionDemandDetailsSubmit.do";

function sFocus() {
	if(document.getElementById('demand-qty').readOnly != true) {
		document.getElementById('demand-qty').focus();
	}
	else {
		document.forms[1].demandStatus.focus();
	}
}
</script>
</head>
<body>
<div id="divAuditAlt" style="position:absolute;z-index:3;font-family:Tahoma,arial;font-size:11px;padding:0px 2px 0px 2px;visibility:hidden;overflow:visible"><%=show%></div>
<div id="page-container">
<%@ include file="../common/SSFPageHeader.jsp" %>
<div id="div-hidden-fields"><input type="text" tabindex="100" onfocus="sFocus();" /></div>
<div class="page-header">
    <div class="headerbar headerbar-size"><img src="images/barside.jpg" alt="" /></div>
    <div class="pagename"><h1>Additional Demand Details</h1></div>
</div>
<div id="formcntnr" style="height:auto;">
<form class="form1" method="post">
				<div class="button-band"><%-- <div class="rand-file"><label>Reports :</label><div class="rand-file-field"><html:select name="AdditionalDemandForm" property="reports" styleId="url" style="width:100%;" tabindex="29"><clinapps:options collection="ReportPrintList"	scope="constants" property="url" labelProperty="name" /></html:select></div></div> --%><div class="buttons1"><div class="main-btns"><a href="#" title="Reports" id="reports" class="repicon" onclick="openReportPopUp();" tabindex="30"><span></span></a><!-- <a href="javascript:printReportInvoke(document.getElementById('url').value);" id="run-but" title="Run" tabindex="30"><span>Run</span></a> --><%if (SfUtils.isReadonly(request, session))	{ %><a class="but-disbl" title="Submit"><span>Submit</span></a><% } else { %><a href="javascript:doSubmit('modify');" title="Submit" tabindex="30"><span>Submit</span></a><%} %><a href="javascript:doSubmit('reset');" title="Reset" tabindex="31"><span>Reset</span></a><a href="javascript:doSubmit('return');" title="Return" tabindex="33"><span>Return</span></a><a id="auditBut" onmouseover="showAuditAlt('<%=show%>');" onmouseout="hideAuditAlt()"><span>A</span></a></div></div></div>
				<div id="dataGrid-view" style="padding-top:10px;">
<table style="width:100%;">
		<input type="hidden" name="returnAction" value="AdditionDemandDetailsReturn.do"/>
		<input type="hidden" name="modifyAction" value="AdditionDemandDetailsSubmit.do"/>
		<input type="hidden" name="resetAction" value="AdditionDemandDetailsReset.do"/>
		<html:hidden name="AdditionalDemandForm" property="isChecked"/>
		<tr>
		<td width="26%">
			<table style="width:100%;">
				<tr height="25">
					<td align="right" width="131"><div class="label-black" style="width:95%;"><span>Item ID</span></div></td>
					<td style="padding-right:2px;"><html:text name="AdditionalDemandForm" property="itemId" styleClass="readonly" style="width:100%;" tabindex="1" readonly="true" onclick="sFocus()" /></td>
				</tr>
				<tr height="25">
					<td align="right"><div class="label-black" style="width:95%"><span>Classification</span></div></td>
					<td style="padding-right:2px;"><html:text name="AdditionalDemandForm" property="classification" styleClass="readonly" style="width:100%;" readonly="true" onclick="sFocus()" /></td>
				</tr>
			</table>
		</td>
		<td width="74%">
			<table style="width:100%;">
				<tr height="25">
					<td align="right" width="280"><div class="label-black" style="width:95%;"><span>Item Description</span></div></td>
					<td style="padding-right:47px;"><html:text name="AdditionalDemandForm" property="itemName" styleClass="readonly" style="width:100%;" readonly="true" onclick="sFocus()" /></td>
				</tr>
				<tr height="25">
					<td align="right"><div class="label-black" style="width:95%"><span>Sub-Classification</span></div></td>
					<td>
					<table style="width:100%;">
					<tr>
					<td width="45%"><html:text name="AdditionalDemandForm" property="subClassification" styleClass="readonly" style="width:100%;" readonly="true" onclick="sFocus()" /></td>
					<td align="right" width="100"><div class="label-black" style="width:95%;"><span>UOM</span></div></td>
					<td style="padding-right:47px;">
					<html:text name="AdditionalDemandForm" property="uomCd" styleClass="readonly" style="width:100%;" readonly="true" onclick="sFocus()" />
					</td>
					</tr>
					</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table style="width:100%;margin-top:5px;" class="block-brdr">
	<tr><td class="block-header"><h1>Additional Demand Details</h1></td></tr>
	<tr>
	<td style="padding-right:10px;">
	<table style="width:100%;margin-top:5px;">
		<tr height="25">
		<td width="26%">
			<table style="width:100%;">
				<tr>
					<td align="right" width="130"><div class="label-man" style="width:95%;"><span>* Demand Qty.</span></div></td>
					<td width="30%" style="padding-right:2px;"><html:text name="AdditionalDemandForm" property="demandQty" onblur="trimValues(this),formatNumber(this)" readonly="<%=isEnable %>" styleId="demand-qty" styleClass="<%=styleClass %>" style="width:100%;" tabindex="1" /></td>
					<td>
						<%-- 	<%
							Vector<UomBean> localUomBeanList = (Vector)session.getAttribute("UomList");
							String localUomSeq = "";
							String localDispUom="";
							
							if(localUomBeanList  != null)
							{
							%>
							<html:select name="AdditionalDemandForm" property="uomSeq" styleId="uomStyleId" style="width:100%;margin-left:5px;">
									<% for(int localCounter = 0; localCounter < localUomBeanList.size();localCounter++){
										UomBean localUomBean = (UomBean)localUomBeanList.get(localCounter);
										localUomSeq = localUomBean.getUomSequence()+"";
										localDispUom = localUomBean.getUomCd();
										
										
										%>
										
										<bean:define id="UOMF" value="<%=localDispUom %>" />
										<html:option value="<%=localUomSeq %>"><clinapps:write
												name="UOMF" /></html:option>
										<%
									}
									%>
								</html:select>
								
					<%}
					else
					{%>
					<html:select name="AdditionalDemandForm" property="uomSeq" styleId="uomStyleId" style="width:100%;margin-left:5px;">
			</html:select>
					<%} %> --%>
					<html:select name="AdditionalDemandForm" property="uomSeq" styleId="uomStyleId" disabled="<%=isEnable %>" styleClass="<%=styleClass %>" style="width:100%;" tabindex="2">
								<html:option value=""></html:option>
											<clinapps:options collection="UomList" property="property" labelProperty="labelProperty" charlength="17"/>
					</html:select> 
					</td>
				</tr>
			</table>
		</td>
		<td width="13%"></td>
		<td width="24%"></td>
		<td width="37%"></td>
		</tr>	
		<tr height="25">
			<td width="26%">
				<table style="width:100%;">
					<tr>
						<td align="right" width="130"><div class="label-man" style="width:95%;"><span>* Demand Month</span></div></td>
						<td width="30%">
							<bean:define id="demdDate" name="AdditionalDemandForm" property="demandDate"/>
							<html:text name="AdditionalDemandForm" property="demandDate" styleId="demandDate1" style="width:100%;" readonly="<%=isEnable %>" styleClass="<%=styleClass %>" onkeyup="testFun();" onmousedown="testFun()" tabindex="3" />
						</td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</td>
			<td colspan="3"></td>
		</tr>
		<tr height="155">
		<td colspan="4">
			<table style="width:100%;">
				<tr>
					<td align="right" style="vertical-align: top;" width="130"><div class="label-black" style="width:95%;"><span>Demand Description</span></div></td>
					<td>
					<html:textarea name="AdditionalDemandForm" property="description" onblur="trimValues(this)" readonly="<%=isEnable %>" styleClass="<%=styleClass %>" style="width:100%; height:150px;" tabindex="4"></html:textarea>
					</td>
				</tr>
			</table>
		</td>
		</tr>
		<tr height="25">
		<td colspan="4">
			<table style="width:100%;">
				<tr>
					<td align="right" width="130"><div class="label-black" style="width:95%;"><span>Discontinue</span></div></td>
					<td>
					<html:checkbox name="AdditionalDemandForm" property="demandStatus" value='Y' onclick="javascript:discontChanged();" tabindex="5"/>
					</td>
					<td align="right"><div class="label-black" style="width:95%;"><span>Discontinued Date</span></div></td>
					<td>
					<input type=text name="statusChangedDateDisplay" readonly="readonly" class="readonly" style="width: 20%;" onclick="sFocus()" /> 
					<html:hidden name="AdditionalDemandForm" property="statusChangedDate"/>
					</td>
				</tr>
			</table>
		</td>
		</tr>
	</table>
	</td>
	</tr>
	</table>
		<script type="text/javascript">
		$(document).ready(function(){
			document.forms[1].statusChangedDateDisplay.value = document.forms[1].statusChangedDate.value;
			$('#host').focus();	
			testFun();
			var obj1 = document.getElementById('demandDate1');	
			calCalendarDate(obj1);
			sFocus();
		});
		formatQuantity();
		</script>
</div>
</form>
</div>
</div>
</body>
</html>
<%@ include file="../common/FooterNew.jsp"%>