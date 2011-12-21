<div class="dynamic" id="main-content" role="main">
	#set ($dynamicTemplateService = $serviceLocator.findService("dynamic-layout-templates-portlet", "com.liferay.portlet.dlt.service.DynamicTemplateLocalService"))
	#set ($dynamicTemplate = $dynamicTemplateService.getDynamicTemplateByPlid($layout.plid))
	
	#if ($dynamicTemplate)
		#set ($html = $dynamicTemplate.html)

		## if the html contains 'processor.processColumn' then the html is actually a velocity template  		
		#if ($html.indexOf('processor.processColumn') >= 0)
			#evaluate($html)
		#else
			#set ($ids = ["[$COLUMN_1$]","[$COLUMN_2$]","[$COLUMN_3$]","[$COLUMN_4$]","[$COLUMN_5$]","[$COLUMN_6$]","[$COLUMN_7$]","[$COLUMN_8$]","[$COLUMN_9$]"])
			#set ($contents = [$processor.processColumn("column-1", "portlet-column-content"),$processor.processColumn("column-2", "portlet-column-content"),$processor.processColumn("column-3", "portlet-column-content"),$processor.processColumn("column-4", "portlet-column-content"),$processor.processColumn("column-5", "portlet-column-content"),$processor.processColumn("column-6", "portlet-column-content"),$processor.processColumn("column-7", "portlet-column-content"),$processor.processColumn("column-8", "portlet-column-content"),$processor.processColumn("column-9", "portlet-column-content")])
			#set ($html = $stringUtil.replace($html,$arrayUtil.toStringArray($ids.toArray()),$arrayUtil.toStringArray($contents.toArray())))
			
			$html
		#end
	#else
		Please select a dynamic template.
		$processor.processColumn("column-1", "portlet-column-content")
		$processor.processColumn("column-2", "portlet-column-content")
		$processor.processColumn("column-3", "portlet-column-content")
		$processor.processColumn("column-4", "portlet-column-content")
		$processor.processColumn("column-5", "portlet-column-content")
		$processor.processColumn("column-6", "portlet-column-content")
		$processor.processColumn("column-7", "portlet-column-content")
		$processor.processColumn("column-8", "portlet-column-content")
		$processor.processColumn("column-9", "portlet-column-content")
	#end
	
	#if ($themeDisplay.isShowLayoutTemplatesIcon())
		<div><a id="selectTemplateLink" href="javascript:">Select Template</a></div>
		
		#set ($portletURL = $portletURLFactory.create($request, "select-dynamic-template_WAR_dynamiclayouttemplatesportlet", $layout.plid, "RENDER_PHASE"))
		$portletURL.setWindowState("exclusive")
		
		<script>
			AUI().ready('aui-dialog', function(A) {
				var selectTemplate;
				
				A.one('#selectTemplateLink').on(
					'click', 
					function(event) {
						var url = '$portletURL';
						var title = 'Select Template';
						var width = 700;
						
						if (!selectTemplate) {
							selectTemplate = new A.Dialog(
								{	
									centered: true,
									resizable: false,
									title: title,
									width: width,
								}
							).render();
							
							selectTemplate.plug(
								A.Plugin.IO,
									{
										uri: url
									}
							);
							
							selectTemplate.show();
						}
						else {
							selectTemplate.show();
						}
						
						selectTemplate.focus();
					}
				);
			});
		</script>
	#end
</div>
