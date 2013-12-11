{$ci->load->model('money_stats_model')}
{assign var='total_jan' value=0}
{assign var='total_feb' value=0}
{assign var='total_mar' value=0}
{assign var='total_apr' value=0}
{assign var='total_may' value=0}
{assign var='total_jun' value=0}
{assign var='total_jul' value=0}
{assign var='total_aug' value=0}
{assign var='total_sep' value=0}
{assign var='total_oct' value=0}
{assign var='total_nov' value=0}
{assign var='total_dec' value=0}
{assign var='total_target' value=0}

<div class="widget full">
	<div class="widget_title">Category Year breakdown</div>
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
				{foreach from=$ci->money_stats_model->year_cat_breakdown($smarty.post.year) item=a}
					{assign var='total_jan' value=$total_jan+$a->Jan}
					{assign var='total_feb' value=$total_feb+$a->Feb}
					{assign var='total_mar' value=$total_mar+$a->Mar}
					{assign var='total_apr' value=$total_apr+$a->Apr}
					{assign var='total_may' value=$total_may+$a->May}
					{assign var='total_jun' value=$total_jun+$a->Jun}
					{assign var='total_jul' value=$total_jul+$a->Jul}
					{assign var='total_aug' value=$total_aug+$a->Aug}
					{assign var='total_sep' value=$total_sep+$a->Sep}
					{assign var='total_oct' value=$total_oct+$a->Oct}
					{assign var='total_nov' value=$total_nov+$a->Nov}
					{assign var='total_dec' value=$total_dec+$a->Dec}
					{assign var='total_target' value=$total_target+$a->target_amount}
					<tr>
						 <td>{$a->Category}</td>
						 <td style="color:{if $a->Jan < $a->target_amount}green{else}red{/if}">{$a->Jan}</td>
						 <td style="color:{if $a->Feb < $a->target_amount}green{else}red{/if}">{$a->Feb}</td>
						 <td style="color:{if $a->Mar < $a->target_amount}green{else}red{/if}">{$a->Mar}</td>
						 <td style="color:{if $a->Apr < $a->target_amount}green{else}red{/if}">{$a->Apr}</td>
						 <td style="color:{if $a->May < $a->target_amount}green{else}red{/if}">{$a->May}</td>
						 <td style="color:{if $a->Jun < $a->target_amount}green{else}red{/if}">{$a->Jun}</td>
						 <td style="color:{if $a->Jul < $a->target_amount}green{else}red{/if}">{$a->Jul}</td>
						 <td style="color:{if $a->Aug < $a->target_amount}green{else}red{/if}">{$a->Aug}</td>
						 <td style="color:{if $a->Sep < $a->target_amount}green{else}red{/if}">{$a->Sep}</td>
						 <td style="color:{if $a->Oct < $a->target_amount}green{else}red{/if}">{$a->Oct}</td>
						 <td style="color:{if $a->Nov < $a->target_amount}green{else}red{/if}">{$a->Nov}</td>
						 <td style="color:{if $a->Dec < $a->target_amount}green{else}red{/if}">{$a->Dec}</td>
					</tr>
				{/foreach}
			</tbody>
			<tfoot>
				<tr>
					<td>Total:</td>
					<td style="color:{if $total_jan < $total_target}green{else}red{/if}">{$total_jan}</td>
					<td style="color:{if $total_feb < $total_target}green{else}red{/if}">{$total_feb}</td>
					<td style="color:{if $total_mar < $total_target}green{else}red{/if}">{$total_mar}</td>
					<td style="color:{if $total_apr < $total_target}green{else}red{/if}">{$total_apr}</td>
					<td style="color:{if $total_may < $total_target}green{else}red{/if}">{$total_may}</td>
					<td style="color:{if $total_jun < $total_target}green{else}red{/if}">{$total_jun}</td>
					<td style="color:{if $total_jul < $total_target}green{else}red{/if}">{$total_jul}</td>
					<td style="color:{if $total_aug < $total_target}green{else}red{/if}">{$total_aug}</td>
					<td style="color:{if $total_sep < $total_target}green{else}red{/if}">{$total_sep}</td>
					<td style="color:{if $total_oct < $total_target}green{else}red{/if}">{$total_oct}</td>
					<td style="color:{if $total_nov < $total_target}green{else}red{/if}">{$total_nov}</td>
					<td style="color:{if $total_dec < $total_target}green{else}red{/if}">{$total_dec}</td>
				</tr>
			</tfoot>
		</table>
	</div>
</div>