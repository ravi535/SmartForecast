<%@page import="com.clinapps.smartforecasting.NumberOperations"%>
<%
/*
 * $Log: ViewAdditionalDemand.jsp,v $
 * Revision 1.24  2017/05/08 09:55:04  ramus
 * Modified for 1366 * 768 resolution changes.
 *
 * Revision 1.23  2017/04/25 04:58:32  hiteshm
 * Modified for base resolution changes.
 *
 * Revision 1.22  2016/11/07 09:03:31  santosh
 * Alignment Fixed
 *
 * Revision 1.21  2016/07/14 06:11:37  hiteshm
 * Task SSF-1501 fixed.
 *
 * Revision 1.20  2016/04/21 11:39:04  santosh
 * Task SSF-1321 Fixed
 *
 * Revision 1.19  2016/04/20 12:49:57  hiteshm
 * Task SSF-1321 fixed.
 *
 * Revision 1.18  2016/04/11 13:57:46  hiteshm
 * Modified for select all checkbox alignment.
 *
 * Revision 1.16  2016/04/11 04:49:44  hiteshm
 * Task SSF-1047 fixed.
 *
 * Revision 1.15  2016/04/05 03:58:59  Ashokm
 * Fixed SSF-1017.
 *
 * Revision 1.14  2016/04/04 15:22:14  ramesh
 * Modified for SSF-1047.
 *
 * Revision 1.13  2016/03/23 05:54:22  ramesh
 * Modified for SSF-1047.
 *
 * Revision 1.12  2016/03/09 11:26:18  ramesh
 * Initial Version.
 *
 * Revision 1.11  2016/02/11 15:43:01  ramesh
 * Addditional demand initial version.
 *
 * Revision 1.10  2016/02/09 14:00:43  ramesh
 * Addditional demand initial version.
 *
 * Revision 1.9  2016/02/08 10:32:22  ramesh
 * Addditional demand initial version.
 *
 * Revision 1.8  2016/02/02 09:27:40  hiteshm
 * Tab order and Alignments fixed.
 *
 * Revision 1.7  2016/01/29 07:07:47  ramesh
 * Initial version.
 *
 * Revision 1.6  2016/01/28 10:11:35  sreenivasulug
 * Initial version.
 *
 * Revision 1.5  2016/01/28 07:03:37  ramesh
 * Initial version.
 *
 * Revision 1.4  2016/01/28 04:52:34  sreenivasulug
 * Initial version.
 *
 * Revision 1.3  2016/01/27 14:09:52  sreenivasulug
 * demand month display.
 *
 * Revision 1.1  2016/01/22 07:05:33  sreenivasulug
 * Initial Version.
 *
 *
 * Title		: ViewAdditionalDemand.jsp
 * Description	: To view the Additional Demand.
 * Copyright	: ClinApps (c) 2016
 * Company		: ClinApps
 * @author		: Sreenivasulu g	
 * @version: $Revision: 1.24 $$Date: 2017/05/08 09:55:04 $
 */
%>
<!DOCTYPE HTML>
<html>
<head>
<title>View Additional Demand</title>
<%@ include file="../common/importsNew.jsp"%>
<%! public String getDemandSeqHm(String arg){
		return  "demandSeqHm("+arg+")";
	}%>

<script type="text/javascript">
var presentSortingOrder = "<bean:write name="ViewAdditionalDemandForm" property="orderBy"/>";
var presentSortingType = "<bean:write name="ViewAdditionalDemandForm" property="sortMode"/>";
var currentSize = "<bean:write name="ViewAdditionalDemandForm" property="totalRecords"/>";
var viewPrograms="<bean:write name="ViewAdditionalDemandForm" property="pageType"/>";

    function sort(sorter)
    {
        if(currentSize>1)
        {
            document.forms[1].orderBy.value = sorter; 
        
	        if(presentSortingOrder==sorter)
	        {
	            if(presentSortingType=="ASC")
	            {
	                document.forms[1].sortMode.value="DESC";
	            }
	            else  
	            {
	                document.forms[1].sortMode.value="ASC";
	            }
	        }
	        else 
	        {
	           document.forms[1].sortMode.value="ASC";
	        }
	        document.forms[1].actionType.value="sort";
	        document.forms[1].action = "ViewAdditionalDemandPagination.do";
	        //document.forms[1].submit();
	        submit_form(document.forms[1]);
        }
    }


function doSubmit(x){
	if(x=='search')
	{
		document.forms[1].actionType.value=x;
		document.forms[1].action=document.forms[1].searchAction.value;
	}
	else if(x=='modify')
	{
		document.forms[1].formType.value = "VIEW";
		document.forms[1].action=document.forms[1].modifyAction.value;
		
	}
	else if(x=='add')
	{
		document.forms[1].action=document.forms[1].addAction.value;	
	}
	else if(x=='duplicate')
	{
		document.forms[1].action=document.forms[1].duplicateAction.value;	
	}
	else if(x=='clear')
	{
		document.forms[1].action=document.forms[1].clearAction.value;	
	}
	else if(x == 'delete')
	{
		document.forms[1].formType.value = "Delete";
		document.forms[1].action=document.forms[1].deleteAction.value;
	}
	submit_form(document.forms[1]);
}

function next(param)
{
   document.forms[1].actionType.value=param;
   document.forms[1].action = "ViewAdditionalDemandPagination.do";		   
    submit_form(document.forms[1]);
}
function testFun() 
{ 
	 monthOnlyRequired = true;
}
dropdownStyleID = [
                   {
                	 id:"status",
                	 normalSearch:"true"
                	}
                  ];
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
function setDefaultStaus(obj)
{
	if(obj.checked==true)
	{
	
		var localDoc = document.forms[1];
		for(var i=0;i<localDoc.length;i++)
		{
			var objName = localDoc.elements[i].name;
			var newfield = objName.substring(0,11);
			if(localDoc.elements[i].type=="checkbox"&&"demandSeqHm"==newfield)
			{
				localDoc.elements[i].checked = true;
				document.forms[1].checkAll.value="Y";
			}
		}
		setTimeout(function(){obj.checked = true;},100);
	}
	else
	{
	    var localDoc = document.forms[1];
		for(var i=0;i<localDoc.length;i++)
		{
			var objName = localDoc.elements[i].name;
			var newfield = objName.substring(0,11);
			if(localDoc.elements[i].type=="checkbox")
			{
				if(newfield=="demandSeqHm" && localDoc.elements[i].disabled!=true)
				{
					localDoc.elements[i].checked = false;
					document.forms[1].checkAll.value="N";
				}
			}
		}
		setTimeout(function(){obj.checked = false;},100);
	}	
} 
function unselect()
{
	 
	var loopCount = 0;
	var funcCount = 0;
	var localDoc = document.forms[1];	
	for(var i=0;i<localDoc.length;i++)
	{	
		var objName = localDoc.elements[i].name;
		var newfield = objName.substring(0,11);
		
		if(localDoc.elements[i].type=="checkbox" && newfield=="demandSeqHm")
		{
			if(localDoc.elements[i].disabled!=true)
			{
				loopCount = loopCount+1;	
			}				
		}
	}
   
	for(var i=0;i<localDoc.length;i++)
	{
		var objName = localDoc.elements[i].name;
		var newfield = objName.substring(0,11);
		
		if(localDoc.elements[i].type=="checkbox" && newfield=="demandSeqHm")
		{
			if(localDoc.elements[i].checked)
			{
				if(localDoc.elements[i].disabled!=true)
				{
					funcCount = funcCount+1;
				}	
			}
		}
	}
		
	if(funcCount == loopCount&&loopCount>0)
	{
		var selectAllObj = document.getElementById("AllCheckBox");
		selectAllObj.checked = true;
	}
	else
	{
		var selectAllObj = document.getElementById("AllCheckBox");
		selectAllObj.checked = false;
	}
}

</script>
</head>
<body>
<div id="page-container">
<div id="div-hidden-fields"><input type="text" tabindex="100" onfocus="$('#itemId').focus();" /></div>
<%@ include file="../common/SSFPageHeader.jsp" %>
<div class="page-header">
    <div class="headerbar headerbar-size"><img src="images/barside.jpg" alt="" /></div>
    <div class="pagename"><h1>View Additional Demand</h1></div>
</div>
<div id="formcntnr">
<form class="form1" method="post">
				<div class="button-band">
					<span class="header-m">&nbsp;Search Criteria</span>
					<div class="buttons"><a href="javascript:doSubmit('search');" title="Search" tabindex="30"><span>Search</span></a><% if (SfUtils.isReadonly(request, session)){	%><a class="but-disbl" title="Add"><span>Add</span></a><% }	else{ %><a href="javascript:doSubmit('add');" title="Add" tabindex="31"><span>Add</span></a><%}	%><a href="javascript:doSubmit('modify');" title="Details" tabindex="32"><span>Details</span></a><%	if (SfUtils.isReadonly(request, session)){%><a class="but-disbl" title="Duplicate"><span>Duplicate</span></a><a class="but-disbl" title="Delete"><span>Delete</span></a><%}	else {%><a href="javascript:doSubmit('duplicate');" title="Duplicate" tabindex="33"><span>Duplicate</span></a><a href="javascript:doSubmit('delete');" title="Delete" tabindex="34"><span>Delete</span></a><%} %><a	href="javascript:doSubmit('clear');" title="Clear" tabindex="35"><span>Clear</span></a></div>
				</div>
			 	<div class="header-plain"><div class="numberpath-new"><logic:greaterThan name="ViewAdditionalDemandForm" property="totalRecords" value="0"><table><tr><logic:greaterThan name="ViewAdditionalDemandForm" property="previousViewSize" value="1"><td class="prev-icon"><a href="JavaScript:next('previous');" tabindex="99" title="Display previous <%=session.getAttribute(Constants.DEFAULT_VIEW_SIZE)%> records"></a></td></logic:greaterThan><bean:define id="displaySize" name="ViewAdditionalDemandForm"	property="currentViewSize" type="Integer" /><bean:define id="previousSize" name="ViewAdditionalDemandForm" property="previousViewSize" type="Integer" /><bean:define id="totalSize" name="ViewAdditionalDemandForm"	property="totalRecords" type="Integer" /><td class="count-msg">Records&nbsp;<clinapps:write name="previousSize" />&nbsp;-&nbsp;<logic:greaterEqual name="ViewAdditionalDemandForm" property="totalRecords" value="<%=displaySize.toString()%>"><clinapps:write name="displaySize" /></logic:greaterEqual><logic:lessThan name="ViewAdditionalDemandForm" property="totalRecords" value="<%=displaySize.toString()%>"><clinapps:write name="totalSize" /></logic:lessThan>&nbsp;of&nbsp;<clinapps:write name="totalSize" /></td><logic:greaterThan name="ViewAdditionalDemandForm" property="totalRecords" value="<%=displaySize.toString()%>"><td class="next-icon"><a href="JavaScript:next('next');" tabindex="99" title="Display next <%=session.getAttribute(Constants.DEFAULT_VIEW_SIZE)%> records"></a></td></logic:greaterThan></tr></table></logic:greaterThan></div></div>
	<div id="dataGrid-view" style="padding-top:0px;">
	<table id="view-add-demand" style="width:100%;height:100%">
						<input type="hidden" name="searchAction" value="ViewAdditionalDemandPagination.do"/>
						<input type="hidden" name="addAction" value="AddAdditionalDemand.do"/>
						<input type="hidden" name="modifyAction" value="AdditionalDemandDetails.do"/>
						<input type="hidden" name="duplicateAction" value="AdditionalDemandDuplicate.do"/>
						<input type="hidden" name="clearAction" value="AdditionalDemandClear.do"/>
						<input type="hidden" name="deleteAction" value="AdditionalDemandDelete.do"/>
						<html:hidden name="ViewAdditionalDemandForm" property="selectedId"/>
						<html:hidden name="ViewAdditionalDemandForm" property="rowSelected" value="false"/>
						<html:hidden name="ViewAdditionalDemandForm" property="orderBy"/>
						<html:hidden name="ViewAdditionalDemandForm" property="sortMode"/>
						<html:hidden name="ViewAdditionalDemandForm" property="formType"/>
						<html:hidden name="ViewAdditionalDemandForm" property="actionType"/>
	
	<thead>
	<tr height="25">
	<th data-options="field:'DemandSeq',width:'0%',hidden:true,resizable:false"></th>
		<logic:equal name="ViewAdditionalDemandForm" property="rowSelected" value="true">
	<th data-options="field:'itemid',width:'13%',sortable:false,resizable:false"><html:text name="ViewAdditionalDemandForm" property="itemId" styleId="itemId" style="width:100%" tabindex="1"  onblur="trimValues(this)"/></th>
	<th data-options="field:'itemname',width:'',sortable:false, resizable:false"><html:text name="ViewAdditionalDemandForm" property="itemName" style="width:100%" tabindex="2"  onblur="trimValues(this)"/></th>
	<th data-options="field:'demanddate',width:'9%',sortable:false, resizable:false"><html:text name="ViewAdditionalDemandForm" property="demandDate" styleId="viewdemandDate" onkeyup="testFun();" onmousedown="testFun()" style="width:100%" tabindex="3"  onblur="trimValues(this)"/></th>
	<th data-options="field:'qty',width:'8%',sortable:false, resizable:false"><html:text name="ViewAdditionalDemandForm" property="demandQty" style="width:100%" tabindex="4"  onblur="trimValues(this),formatNumber(this)"/></th>
	<th data-options="field:'uom',width:'8%',sortable:false,resizable:false"><html:text name="ViewAdditionalDemandForm" property="uomCd" style="width:100%" tabindex="5"  onblur="trimValues(this)"/></th>
	<th data-options="field:'demanddesc',width:'25%',sortable:false, resizable:false"><html:text name="ViewAdditionalDemandForm" property="description" style="width:100%" tabindex="6"  onblur="trimValues(this)"/></th>
	<th data-options="field:'discontd',width:'70',sortable:false, resizable:false">
	 <html:select name="ViewAdditionalDemandForm" styleId="status" property="status" style="width:100%" tabindex="7">
      <html:option value="" ></html:option>
    <html:option value="N" >N</html:option>
    <html:option value="Y" >Y</html:option>
    </html:select></th>
	 
	</logic:equal>
		<logic:notEqual name="ViewAdditionalDemandForm" property="rowSelected" value="true">
		<bean:define id="searchItemId" name="ViewAdditionalDemandForm" property="searchItemId" type="String"/>
		<bean:define id="searchItemName" name="ViewAdditionalDemandForm" property="searchItemName" type="String"/>
		<bean:define id="searchDemandDate" name="ViewAdditionalDemandForm" property="searchDemandDate" type="String"/>
		<bean:define id="searchDemandQty" name="ViewAdditionalDemandForm" property="searchDemandQty" type="String"/>
		<bean:define id="searchUomCd" name="ViewAdditionalDemandForm" property="searchUomCd" type="String"/>
		<bean:define id="searchDescription" name="ViewAdditionalDemandForm" property="searchDescription" type="String"/>
		<bean:define id="searchStatus" name="ViewAdditionalDemandForm" property="searchStatus" type="String"/>
									
	<th data-options="field:'itemid',width:'13%',sortable:false,resizable:false"><html:text name="ViewAdditionalDemandForm" property="itemId" styleId="itemId" value="<%=searchItemId %>" style="width:100%" tabindex="1"  onblur="trimValues(this)"/></th>
	<th data-options="field:'itemname',width:'',sortable:false, resizable:false"><html:text name="ViewAdditionalDemandForm" property="itemName" value="<%=searchItemName %>" style="width:100%" tabindex="2"  onblur="trimValues(this)"/></th>
	<th data-options="field:'demanddate',width:'9%',sortable:false, resizable:false"><html:text name="ViewAdditionalDemandForm" property="demandDate" styleId="viewdemandDate" value="<%=searchDemandDate %>" onkeyup="testFun();" onmousedown="testFun()" style="width:100%" tabindex="3"  onblur="trimValues(this)"/></th>
	<th data-options="field:'qty',width:'8%',sortable:false, resizable:false"><html:text name="ViewAdditionalDemandForm" property="demandQty" value="<%=searchDemandQty %>" style="width:100%" tabindex="4"  onblur="trimValues(this),formatNumber(this)"/></th>
	<th data-options="field:'uom',width:'8%',sortable:false,resizable:false"><html:text name="ViewAdditionalDemandForm" property="uomCd" value="<%=searchUomCd %>" style="width:100%" tabindex="5"  onblur="trimValues(this)"/></th>
	<th data-options="field:'demanddesc',width:'25%',sortable:false, resizable:false"><html:text name="ViewAdditionalDemandForm" property="description" value="<%=searchDescription %>" style="width:100%" tabindex="6"  onblur="trimValues(this)"/></th>
	<th data-options="field:'discontd',width:'70',sortable:false, resizable:false">
	 <html:select name="ViewAdditionalDemandForm" styleId="status" property="status" value="<%=searchStatus %>" style="width:100%" tabindex="7">
      <html:option value="" ></html:option>
    <html:option value="N" >N</html:option>
    <html:option value="Y" >Y</html:option>
    </html:select></th>
	</logic:notEqual>
	<th data-options="field:'sel',width:'40',sortable:false, resizable:false"></th>
	</tr>
	<tr>
	<th data-options="field:'DemandSeq',width:'0%',hidden:true,resizable:false"></th>
	<logic:equal name="ViewAdditionalDemandForm" property="orderBy" value="ITEM_ID">
	<th data-options="field:'itemid',width:'13%',sortable:false, resizable:false">
	<logic:equal name="ViewAdditionalDemandForm" property="sortMode" value="ASC">
	       	<div class="sort-up" onclick="sort('ITEM_ID');">Item ID</div>
	  	</logic:equal>
	    
	     <logic:equal name="ViewAdditionalDemandForm" property="sortMode" value="DESC">
	      	 <div class="sort-down" onclick="sort('ITEM_ID');">Item ID</div>
	      </logic:equal>
	      	</th>
	</logic:equal>
	<logic:notEqual name="ViewAdditionalDemandForm" property="orderBy" value="ITEM_ID">
		       <th data-options="field:'itemid',width:'13%', resizable:false" onclick="sort('ITEM_ID');">
		        <div onclick="sort('ITEM_ID');">Item ID</div>
		        </th>
	</logic:notEqual>   
	
<logic:equal name="ViewAdditionalDemandForm" property="orderBy" value="ITEM_NAME">
	<th data-options="field:'itemname',width:'24%',sortable:false,resizable:false">
	<logic:equal name="ViewAdditionalDemandForm" property="sortMode" value="ASC">
	       	<div class="sort-up" onclick="sort('ITEM_NAME');">Item Description</div>
	  	</logic:equal>
	    
	     <logic:equal name="ViewAdditionalDemandForm" property="sortMode" value="DESC">
	      	 <div class="sort-down" onclick="sort('ITEM_NAME');">Item Description</div>
	      </logic:equal>
	      	</th>
	</logic:equal>
	<logic:notEqual name="ViewAdditionalDemandForm" property="orderBy" value="ITEM_NAME">
		      <th data-options="field:'itemname',width:'24%',resizable:false" onclick="sort('ITEM_NAME');">
		        <div onclick="sort('ITEM_NAME');">Item Description</div>
		        </th>
	     </logic:notEqual>   

<logic:equal name="ViewAdditionalDemandForm" property="orderBy" value="DEMAND_MONTH">
	<th data-options="field:'demanddate',width:'9%',sortable:false,resizable:false">
	<logic:equal name="ViewAdditionalDemandForm" property="sortMode" value="ASC">
	       	<div class="sort-up" onclick="sort('DEMAND_MONTH');">Demand Month</div>
	  	</logic:equal>
	    
	     <logic:equal name="ViewAdditionalDemandForm" property="sortMode" value="DESC">
	      	 <div class="sort-down" onclick="sort('DEMAND_MONTH');">Demand Month</div>
	      </logic:equal>
	      	</th>
	</logic:equal>
	<logic:notEqual name="ViewAdditionalDemandForm" property="orderBy" value="DEMAND_MONTH">
		      <th data-options="field:'demanddate',width:'9%',resizable:false" onclick="sort('DEMAND_MONTH');">
		        <div onclick="sort('DEMAND_MONTH');">Demand Month</div>
		        </th>
	     </logic:notEqual>   

	<logic:equal name="ViewAdditionalDemandForm" property="orderBy" value="DEMAND_QTY">
	<th data-options="field:'qty',width:'8%',sortable:false,resizable:false">
	<logic:equal name="ViewAdditionalDemandForm" property="sortMode" value="ASC">
	       	<div class="sort-up" onclick="sort('DEMAND_QTY');">Demand Qty.</div>
	  	</logic:equal>
	    
	     <logic:equal name="ViewAdditionalDemandForm" property="sortMode" value="DESC">
	      	 <div class="sort-down" onclick="sort('DEMAND_QTY');">Demand Qty.</div>
	      </logic:equal>
	      	</th>
	</logic:equal>
	<logic:notEqual name="ViewAdditionalDemandForm" property="orderBy" value="DEMAND_QTY">
		      <th data-options="field:'qty',width:'8%',resizable:false" onclick="sort('DEMAND_QTY');">
		        <div onclick="sort('DEMAND_QTY');">Demand Qty.</div>
		        </th>
	     </logic:notEqual>   
	
	<logic:equal name="ViewAdditionalDemandForm" property="orderBy" value="ADD_DMND_UOM_CD">
		<th data-options="field:'uom',width:'8%',sortable:false,resizable:false">
	<logic:equal name="ViewAdditionalDemandForm" property="sortMode" value="ASC">
	       	<div class="sort-up" onclick="sort('ADD_DMND_UOM_CD');">UOM</div>
	  	</logic:equal>
	    
	     <logic:equal name="ViewAdditionalDemandForm" property="sortMode" value="DESC">
	      	 <div class="sort-down" onclick="sort('ADD_DMND_UOM_CD');">UOM</div>
	      </logic:equal>
	      	</th>
	</logic:equal>
	<logic:notEqual name="ViewAdditionalDemandForm" property="orderBy" value="ADD_DMND_UOM_CD">
		      	<th data-options="field:'uom',width:'8%',resizable:false" onclick="sort('ADD_DMND_UOM_CD');">
		        <div onclick="sort('ADD_DMND_UOM_CD');">UOM</div>
		        </th>
	     </logic:notEqual>   
	
	<logic:equal name="ViewAdditionalDemandForm" property="orderBy" value="DESCRIPTION">
		<th data-options="field:'demanddesc',width:'25%',sortable:false,resizable:false">
	<logic:equal name="ViewAdditionalDemandForm" property="sortMode" value="ASC">
	       	<div class="sort-up" onclick="sort('DESCRIPTION');">Demand Description</div>
	  	</logic:equal>
	    
	     <logic:equal name="ViewAdditionalDemandForm" property="sortMode" value="DESC">
	      	 <div class="sort-down" onclick="sort('DESCRIPTION');">Demand Description</div>
	      </logic:equal>
	      	</th>
	</logic:equal>
	<logic:notEqual name="ViewAdditionalDemandForm" property="orderBy" value="DESCRIPTION">
		      <th data-options="field:'demanddesc',width:'25%',resizable:false" onclick="sort('DESCRIPTION');">
		        <div onclick="sort('DESCRIPTION');">Demand Description</div>
		        </th>
	     </logic:notEqual>   
	

	<logic:equal name="ViewAdditionalDemandForm" property="orderBy" value="STATUS_CD">
		<th data-options="field:'discontd',width:'7%',sortable:false,resizable:false">
	<logic:equal name="ViewAdditionalDemandForm" property="sortMode" value="ASC">
	       	<div class="sort-up" onclick="sort('STATUS_CD');">Discont'd</div>
	  	</logic:equal>
	    
	     <logic:equal name="ViewAdditionalDemandForm" property="sortMode" value="DESC">
	      	 <div class="sort-down" onclick="sort('STATUS_CD');">Discont'd</div>
	      </logic:equal>
	      	</th>
	</logic:equal>
	
	<logic:notEqual name="ViewAdditionalDemandForm" property="orderBy" value="STATUS_CD">
		      <th data-options="field:'discontd',width:'7%',resizable:false" onclick="sort('STATUS_CD');">
		        <div onclick="sort('STATUS_CD');">Discont'd</div>
		        </th>
	     </logic:notEqual>  
	
	<th data-options="field:'sel',width:'6%',sortable:false,resizable:false">
		<div class="checkbox-label"><logic:equal name="ViewAdditionalDemandForm" property="totalRecords" value="0"><input type="checkbox" name="checkAll" id="AllCheckBox" disabled="disabled"></logic:equal><logic:notEqual name="ViewAdditionalDemandForm" property="totalRecords" value="0"><input type="checkbox" name="checkAll" Id="AllCheckBox" onclick="setDefaultStaus(this)" tabindex="7" /></logic:notEqual>&nbsp;All</div>
	</th>
	</tr>
	</thead>
	<tbody>
	<logic:present name="ViewScreenRecordsList" scope="session">
	<logic:notEmpty name="ViewScreenRecordsList">
	<logic:iterate id="adtDemandList" name="ViewScreenRecordsList" scope="session">
	<bean:define id="demandMonth" name="adtDemandList" property="demandMonth"/>
		<% String localDemandMonth = SfUtils.getCustomizedDate((GregorianCalendar)demandMonth); 
		localDemandMonth = localDemandMonth.substring(localDemandMonth.indexOf("-")+1);
		
		%>	
	<tr>
	 <bean:define id="demandSeq" name="adtDemandList" property="itemAddDmndSeq"/> 
	<td><clinapps:write name="adtDemandList" property="itemAddDmndSeq"/></td>
	<td><div class="datagrid-cell-nowrap" onmouseover="sOverTip(this);"><clinapps:write name="adtDemandList" property="itemId"/></div></td>
	<td><div class="datagrid-cell-nowrap" onmouseover="sOverTip(this);"><clinapps:write name="adtDemandList" property="itemName"/></div></td>
	<td><div class="datagrid-cell-nowrap" onmouseover="sOverTip(this);"><%=localDemandMonth %></div></td>
	<bean:define id="demandQuantity" name="adtDemandList" property="demandQty" type="java.lang.Double"/>
	<%
		NumberOperations localNumberOperations=new NumberOperations(demandQuantity);
		String localDemandQty=localNumberOperations.formatValue();
	%>
	<td><div class="datagrid-cell-nowrap" onmouseover="sOverTip(this);"><%=localDemandQty %></div></td>
	<td><div class="datagrid-cell-nowrap" onmouseover="sOverTip(this);"><clinapps:write name="adtDemandList" property="addDmndUomCd"/></div></td>
	<td><div class="datagrid-cell-nowrap" onmouseover="sOverTip(this);"><clinapps:write name="adtDemandList" property="description"/></div></td>
	<td><div style="text-align:center;">
		<logic:equal name="adtDemandList" property="statusCd" value="350">
		<input type="checkbox" disabled name="checkbox" value="checkbox" >			
		</logic:equal>
		<logic:notEqual name="adtDemandList" property="statusCd" value="350">
		<input type="checkbox" disabled name="checkbox" value="checkbox" checked>
		</logic:notEqual></div>
	 </td>
	<td><div class="cell-checkbox">
		<html:multibox name="ViewAdditionalDemandForm" tabindex="8"	property="<%=getDemandSeqHm(String.valueOf(demandSeq))%>" value="on" onclick="unselect();"/>
	    <html:hidden name="ViewAdditionalDemandForm" property="<%=getDemandSeqHm(String.valueOf(demandSeq))%>" value="off" />
	</div></td>
	</tr>
	</logic:iterate>
	</logic:notEmpty>
	</logic:present>
	</tbody>
	</table>
	<script>
	var indexValue = 0;
    var selectedID1 = "<clinapps:write name="ViewAdditionalDemandForm" property="selectedId" />";
        $(document).ready(function(){
        $('#view-add-demand').datagrid({
        	fitColumns:true,
        	singleSelect: true,
        	checkOnSelect:false,
        	onClickRow:function(rowIndex){
        		var row = $('#view-add-demand').datagrid('getSelected');
        		document.forms[1].selectedId.value=row.DemandSeq;
        	},
        	onDblClickRow: function()
        	{   
        		var row = $('#view-add-demand').datagrid('getSelected');
        		document.forms[1].selectedId.value=row.DemandSeq;
        		doSubmit('modify');
        	}
        	
        });
    	changeColor1();
    	 $('#view-add-demand').datagrid('selectRow',indexValue);
    	 $('#itemId').focus();
    });
		
	function changeColor1() {
	 var table = document.getElementById('view-add-demand');
	 var rowLength = table.rows.length;
	 for(var i=0; i<rowLength; i+=1){
	   var row = table.rows[i];
	     var cell = row.cells[0];
	     if(selectedID1 == cell.innerHTML)
	    	 {
	    	 indexValue = i-2;
	    	 break;
	    	 }
	   }
	 	
 }	
		
	
	
	</script>
	<script type="text/javascript">
$(document).ready(function(){
	testFun();
	var obj1 = document.getElementById('viewdemandDate');	
	calCalendarDate(obj1);
	removeFields();
	unselect();
});
function removeFields()
{   
     var table= document.getElementById("view-add-demand");
      if(table!=null)
     {
          while(table.rows.length > 0)
          {
           table.deleteRow(0);
          }
      }
 }	
</script>
</div>
</form>
</div>
</div>
</body>
</html>
<%@ include file="../common/FooterNew.jsp"%>