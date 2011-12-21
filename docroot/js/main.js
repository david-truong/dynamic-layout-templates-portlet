Liferay.DynamicTemplate = {
	
	init: function(params) {
		id = params.id;
		
	},
		
	addRow: function() {
		var text = A.one(id);
		
		container.append();
	},

	addColumn: function() {
		
	},
	
	id: '',
	A: AUI()
};