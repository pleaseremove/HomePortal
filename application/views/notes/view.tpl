<form action="notes/save">
	<div class="form_100"><label>Name</label><input type="text" name="name" value="{$note->name}"></div>
	
	<div class="form_100">
		<textarea style="height:280px;margin-top:10px;" name="note">{$note->note}</textarea>
	</div>
	
	<div class="form_30">
		<label>Private</label>
		<select name="private">
			<option value="0" {if isset($note->private) && $note->private==0} selected="selected"{/if}>No</option>
			<option value="1" {if isset($note->private) && $note->private==1} selected="selected"{/if}>Yes</option>
		</select>
	</div>

	<input type="hidden" name="note_id" value="{$note->id()|default:'0'}">
</form>