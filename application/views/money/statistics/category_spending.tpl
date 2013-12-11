<div id="title_bar" class="box_background border_color_bottom">
	<h2>Category Spending</h2>
</div>

<div id="content">
	<form action="money/statistics/category_spending">
		<p style="margin: 10px 2%;">
			<label>Year</label>
			<select name="year">
				{foreach from=$years item=y}
					<option value="{$y->year}" {if $y->year==$cur_year}selected="selected"{/if}>{$y->year}</option>
				{/foreach}
			</select>
			<input type="submit" value="Update" />
		</p>
	</form>

	<div class="widget full">
	<div class="widget_title">Category Spending</div>
	<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
		<table class="data_grid style_only">
			<thead>
				<tr>
					<th>Category</th>
					<th>Jan</th>
					<th>Feb</th>
					<th>Mar</th>
					<th>Apr</th>
					<th>May</th>
					<th>Jun</th>
					<th>Jul</th>
					<th>Aug</th>
					<th>Sep</th>
					<th>Oct</th>
					<th>Nov</th>
					<th>Dec</th>
				</tr>
			</thead>
			<tbody>
				{foreach from=$table_data item=a}
					<tr>
						 <td>{$a->category}</td>
						 <td>{$a->jan}</td>
						 <td>{$a->feb}</td>
						 <td>{$a->mar}</td>
						 <td>{$a->apr}</td>
						 <td>{$a->may}</td>
						 <td>{$a->jun}</td>
						 <td>{$a->jul}</td>
						 <td>{$a->aug}</td>
						 <td>{$a->sep}</td>
						 <td>{$a->oct}</td>
						 <td>{$a->nov}</td>
						 <td>{$a->dec}</td>
					</tr>
				{/foreach}
			</tbody>
		</table>
	</div>
</div>
	
</div>
