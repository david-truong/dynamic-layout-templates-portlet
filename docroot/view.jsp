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

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<portlet:defineObjects />
<theme:defineObjects />


<%@ page import="com.liferay.portlet.dlt.model.DynamicTemplate" %>
<%@ page import="com.liferay.portlet.dlt.service.DynamicTemplateLocalServiceUtil" %>

<%@ page import="com.liferay.portal.util.PortalUtil" %>

<%@ page import="java.util.*" %>

<%
List<DynamicTemplate> templates = DynamicTemplateLocalServiceUtil.getDynamicTemplates();
%>

<portlet:actionURL name="selectTemplate" var="saveURL"/>

<aui:form action="<%= saveURL %>" method="post">
	<aui:input name="redirect" type="hidden" value="<%= PortalUtil.getLayoutFriendlyURL(layout, themeDisplay) %>" />
	
	<aui:select name="templateId">
	<%
	for (DynamicTemplate template : templates) {
		%>
		
			<aui:option value="<%= template.getTemplateId() %>"><%= template.getName() %></aui:option>
		<%
	}
	%>
	</aui:select>
	
	<aui:input name="selectTemplateButton" type="submit" value="Select" label="" />
</aui:form>

