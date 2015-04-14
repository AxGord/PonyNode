<_include=all title="Guest Book">
	<_GuestBook>
		<center>
			%include=mEmpty%
			<_many div=post cols=author,date,text/>
			<_insert auto fix=author>New message</_insert>
		</center>
	</_GuestBook>
</_include>