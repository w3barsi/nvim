; extends
(call_expression
	function: (await_expression
		(identifier) @_idt (#eq? @_idt "sql")
	) 
	type_arguments: (type_arguments) @_type

	(template_string) @injection.content
	(#offset! @injection.content 0 1 0 -1)
	(#set! injection.language "sql")	
)


