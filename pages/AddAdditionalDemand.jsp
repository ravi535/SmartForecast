<%
/*
 * $Log: AddAdditionalDemand.jsp,v $
 * Revision 1.20  2017/10/04 12:50:11  koteswararaoy
 * modified to fix task SSF-2299
 *
 * Revision 1.19  2017/05/16 07:11:10  hiteshm
 * Task SSF-1892 fixed.
 *
 * Revision 1.18  2017/05/08 09:54:16  ramus
 * Modified for 1366 * 768 resolution changes.
 *
 * Revision 1.17  2017/04/25 07:13:01  hiteshm
 * Fixed label alignment.
 *
 * Revision 1.16  2017/04/25 04:59:36  hiteshm
 * Modified for base resolution changes.
 *
 * Revision 1.15  2016/11/07 09:03:53  santosh
 * Alignment Fixed
 *
 * Revision 1.14  2016/10/18 06:44:05  ramus
 * Fixed Task SSF - 1592
 *
 * Revision 1.13  2016/10/17 06:42:44  ramus
 * Fixed Task SSF - 1592
 *
 * Revision 1.12  2016/09/29 04:27:19  hemalathap
 * Fixed task PMD-1512.
 *
 * Revision 1.11  2016/07/14 06:12:05  hiteshm
 * Task SSF-1501 fixed.
 *
 * Revision 1.10  2016/04/05 03:58:59  Ashokm
 * Fixed SSF-1017.
 *
 * Revision 1.9  2016/02/11 15:44:48  ramesh
 * Addditional demand initial version.
 *
 * Revision 1.8  2016/02/02 09:27:00  hiteshm
 * Tab order and Alignments fixed.
 *
 * Revision 1.7  2016/01/29 09:47:59  ramesh
 * Initial version.
 *
 * Revision 1.6  2016/01/29 08:46:28  sreenivasulug
 * Initial version.
 *
 * Revision 1.5  2016/01/28 04:52:01  sreenivasulug
 * Initial version.
 *
 * Revision 1.4  2016/01/27 16:36:04  ramesh
 * Initial version.
 *
 * Revision 1.3  2016/01/27 14:08:59  sreenivasulug
 * demand month display.
 *
 * Revision 1.2  2016/01/27 06:57:06  ramesh
 * Initial version.
 *
 * Revision 1.1  2016/01/22 07:05:33  sreenivasulug
 * Initial Version.
 *
 *
 * Title		: AddAdditionalDemand.jsp
 * Description	: To Add the new Additional Demand.
 * Copyright	: ClinApps (c) 2016
 * Company		: ClinApps
 * @author		: Sreenivasulu g	
 * @version: $Revision: 1.20 $$Date: 2017/10/04 12:50:11 $
 */
%>
<!DOCTYPE HTML>
<html>
<head>
<title>Add Additional Demand</title>
<%@ include file="../common/importsNew.jsp"%>
<script type="text/javascript">
function ItemSearch()
{
	document.forms[1].pageTypeSI.value = "search";
	if(document.forms[1].itemId.value != null && document.forms[1].itemId.value != "")
	{
		document.forms[1].action = "AddAdditionalDamandItemSearch.do";
	}
	else
	{
		document.forms[1].action = "AddItemAddDemnandSearchItem.do";
		document.forms[1].returnPageSI.value = "AddAdditionalDamandItemSearch.do";
	}
	submit_form(document.forms[1]);
}
function testFun() 
{ 
	 monthOnlyRequired = true;
}
function doSubmit(x) {
	
	if(x=='modify')
	{
		document.forms[1].action = document.forms[1].modifyAction.value;
	}
	else if(x=='clear')
	{
		document.forms[1].action = document.forms[1].clearAction.value;
	}
	else if(x=='return')
	{
		document.forms[1].action = document.forms[1].returnAction.value;
	}
	submit_form(document.forms[1]);
	
}dropdownStyleID = [
                    {
                   	 id:"uomvalue",
                   	isOptionEmptyRequired:"false"
                   	}
                     ];
                     
$(document).ready(function() {
    $('#uomvalue').select2({allowClear:false});
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
function sFocus(){
	$('#item-id').focus();
}
</script>
</head>
<body>
<div id="page-container">
<%@ include file="../common/SSFPageHeader.jsp" %>
<div id="div-hidden-fields"><input type="text" tabindex="100" onfocus="$('#item-id').focus();" /></div>
<div class="page-header">
    <div class="headerbar headerbar-size"><img src="images/barside.jpg" alt="" /></div>
    <div class="pagename"><h1>Add Additional Demand</h1></div>
</div>
<div id="formcntnr" style="height:auto;">
<form class="form1" method="post">
<div class="button-band"><div class="buttons"><%if (SfUtils.isReadonly(request, session)){ %><a class="but-disbl" title="Submit"><span>Submit</span></a><a class="but-disbl" title="Clear"><span>Clear</span></a><% }else{%><a href="javascript:doSubmit('modify');" title="Submit" tabindex="30"><span>Submit</span></a><a href="javascript:doSubmit('clear');" title="Clear" tabindex="31"><span>Clear</span></a><%} %><a href="javascript:doSubmit('return');" title="Return" tabindex="32"><span>Return</span></a></div></div>
<div id="dataGrid-view" style="padding-top:10px;">
<input type="hidden" name="returnPageSI" />
<input type="hidden" name="pageTypeSI" />
	
		<html:hidden name="AdditionalDemandForm" property="requestFrom"/>
		<html:hidden name="AdditionalDemandForm" property="itemSeq"/>
		
		<input type="hidden" name="clearAction" value="AddAdditionalDemandClear.do" />
		<input type="hidden" name="returnAction" value="AddAdditionalDemandReturn.do" />
		<input type="hidden" name="modifyAction" value="AddAdditionalDemandSubmit.do"/>
		
<table style="width:100%; table-layout: fixed;">
<tr>
	<td width="26%">
		<table style="width:100%;">
			<tr height="25">
				<td align="right" width="131"><div class="label-man" style="width:95%;"><span>* Item ID</span></div></td>
				<td style="padding-right:2px;">
				<div class="field-button-icon"><div class="f-input"><html:text name="AdditionalDemandForm" property="itemId" onblur="trimValues(this)" styleId="item-id" tabindex="1" style="width:100%;"/></div>	
				<div class="a-icon"><%if (!SfUtils.isReadonly(request, session)){ %><a href="JAVASCRIPT:ItemSearch();" class="qstn" tabindex="2"><span>?</span></a><%}else{%><a class="qstn-disbl"><span>?</span></a><%} %></div></div>
				</td>
			</tr>	
			<tr height="25">
				<td align="right"><div class="label-black" style="width:95%"><span>Classification</span></div></td>
				<td style="padding-right:2px;">
				<html:text name="AdditionalDemandForm" property="classification" styleClass="readonly" style="width:100%;" readonly="true" onclick="sFocus()" />
				</td>
			</tr>
		</table>
	</td>
	<td width="74%">
		<table style="width:100%;">
			<tr height="25">
				<td align="right" width="280"><div class="label-black" style="width:95%;"><span>Item Description</span></div></td>
				<td style="padding-right:47px;">
				<html:text name="AdditionalDemandForm" property="itemName" styleClass="readonly" style="width:100%;" readonly="true" onclick="sFocus()" />
				</td>
			</tr>
			<tr height="25">
				<td align="right"><div class="label-black" style="width:95%"><span>Sub-Classification</span></div></td>
				<td>
					<table style="width:100%;">
						<tr>
							<td width="45%"><html:text name="AdditionalDemandForm" property="subClassification" styleClass="readonly" style="width:100%;" readonly="true" onclick="sFocus()" /></td>
							<td align="right" width="120"><div class="label-black" style="width:95%;"><span>UOM</span></div></td>
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
						<td width="30%" style="padding-right:2px;"><html:text name="AdditionalDemandForm" property="demandQty" onblur="trimValues(this),formatNumber(this)" style="width:100%;" tabindex="3" /></td>
						<td>				
						  <html:select name="AdditionalDemandForm" property="uomSeq" styleId="uomvalue" style="width:100%;" tabindex="4">
											<html:option value=""></html:option>
							<logic:present name="UomList">
												<clinapps:options collection="UomList" property="property" labelProperty="labelProperty" charlength="17"/>
												</logic:present>
						</html:select></td> 
					</tr>
				</table>
			</td>
			<td width="74%"></td>
		</tr>	
		<tr height="25">
			<td width="26%">
				<table style="width:100%;">
					<tr>
						<td align="right" width="130"><div class="label-man" style="width:95%;"><span>* Demand Month</span></div></td>
						<td width="30%" style="padding-right:2px;">
						<bean:define id="demdDate" name="AdditionalDemandForm" property="demandDate"/>
							<html:text name="AdditionalDemandForm" property="demandDate" styleId="demandDate" style="width:100%;" styleClass="FontFace" onkeyup="testFun();" onmousedown="testFun()" tabindex="5" />
						</td>
						<td></td>
					</tr>
				</table>
			</td>
		<td></td>
		</tr>
		<tr height="155">
			<td colspan="2">
				<table style="width:100%;">
					<tr>
						<td align="right" style="vertical-align: top;" width="130"><div class="label-black" style="width:95%;"><span>Demand Description</span></div></td>
						<td>
						<html:textarea name="AdditionalDemandForm" property="description" onblur="trimValues(this)" style="width:100%; height:150px;" tabindex="6"></html:textarea>
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
	$('#host').focus();	
	testFun();
	var obj1 = document.getElementById('demandDate');	
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