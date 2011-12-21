create table DLT_DynamicTemplate (
	templateId LONG not null primary key,
	createDate DATE null,
	modifiedDate DATE null,
	companyId LONG,
	groupId LONG,
	name VARCHAR(75) null,
	html TEXT null
);