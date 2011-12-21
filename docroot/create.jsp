<%
/**
 * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
 *
 * The contents of this file are subject to the terms of the Liferay Enterprise
 * Subscription License ("License"). You may not use this file except in
 * compliance with the License. You can obtain a copy of the License by
 * contacting Liferay, Inc. See the License for the specific language governing
 * permissions and limitations under the License, including but not limited to
 * distribution rights of the Software.
 *
 *
 *
 */
%>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="theme" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<portlet:defineObjects />
<theme:defineObjects />


<%@ page import="com.liferay.portlet.dlt.model.DynamicTemplate" %>
<%@ page import="com.liferay.portlet.dlt.service.DynamicTemplateLocalServiceUtil" %>

<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.liferay.portal.kernel.util.*" %>

<%@ page import="javax.portlet.*" %>
<%@ page import="java.util.*" %>

<%
List<DynamicTemplate> templates = DynamicTemplateLocalServiceUtil.getDynamicTemplates();

DynamicTemplate selectedTemplate = null;

long templateId = ParamUtil.getLong(request, "templateId");

if (templateId > 0) {
	selectedTemplate = DynamicTemplateLocalServiceUtil.fetchDynamicTemplate(templateId);
}
PortletURL selectTemplateURL = renderResponse.createRenderURL();

String name = selectedTemplate != null ? selectedTemplate.getName() : "";
String html = selectedTemplate != null ? selectedTemplate.getHtml() : "";
%>
<portlet:actionURL name="saveTemplate" var="saveTemplateURL" />
<portlet:actionURL name="deleteTemplate" var="deleteTemplateURL">
	<portlet:param name="templateId" value="<%= String.valueOf(templateId) %>"/>
	<portlet:param name="redirect" value="<%= selectTemplateURL.toString() %>"/>
</portlet:actionURL>

<aui:form action="<%= saveTemplateURL %>" method="post">

<aui:input name="redirect" type="hidden" value="<%= selectTemplateURL %>" />
<aui:input name="templateId" type="hidden" value="<%= templateId %>" />

<aui:select name="template" onChange="document.location=this.value">
	<aui:option value="<%= selectTemplateURL %>">Create A New Template</aui:option>
	<%
	for (DynamicTemplate template : templates) {
		
		selectTemplateURL.setParameter("templateId", String.valueOf(template.getTemplateId()));
		%>
		<aui:option selected="<%= templateId == template.getTemplateId() %>" value="<%= selectTemplateURL.toString() %>"><%= template.getName() %></aui:option>
		<%
	}
	%>
</aui:select>

<br/>

<aui:input name="name" type="text" value="<%= name %>" />

<br/>

<div>
	Use [$COLUMN_#$] to indicate a column where # is the column number. Example:<br/>
	<pre>
		&lt;div class="portlet-layout"&gt;
			&lt;div class="portlet-column portlet-column-only" id="column-1"&gt;
				[$COLUMN_1$]
			&lt;/div&gt;
		&lt;/div&gt;
	</pre>
</div>

<textarea name="html"><%= html %></textarea>

<aui:input name="submitButton" type="submit" value="Save" label="" inlineField="true"/>

<c:if test="<%= selectedTemplate != null %>">
	<button type="button" onclick="document.location='<%= deleteTemplateURL %>'">Delete</button>
</c:if>

<c:if test="<%= Validator.isNotNull(html) %>">
	<div id="dynamic-template">
		<div><strong>Preview</strong></div>
		<%= html %>
	</div>
</c:if>

</aui:form>