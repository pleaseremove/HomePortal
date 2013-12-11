<div id="title_bar" class="box_background border_color_bottom">
	<h2>Money Utilities: Forward Planning</h2>
</div>

<div id="content">
	<div class="widget full">
		<div class="widget_title">Plan details</div>
		<div style="overflow:auto;" class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
			<form action="money/utils/forward_planning" method="post">
				<div style="float:left;">
					<h3>Income</h3>
					<table>
						<tr>
							<td>January</td>
							<td><input type="text" name="jan_in" value="{$smarty.post.jan_in}" /></td>
						</tr>
						<tr>
							<td>February</td>
							<td><input type="text" name="feb_in" value="{$smarty.post.feb_in}" /></td>
						</tr>
						<tr>
							<td>March</td>
							<td><input type="text" name="mar_in" value="{$smarty.post.mar_in}" /></td>
						</tr>
						<tr>
							<td>April</td>
							<td><input type="text" name="apr_in" value="{$smarty.post.apr_in}" /></td>
						</tr>
						<tr>
							<td>May</td>
							<td><input type="text" name="may_in" value="{$smarty.post.may_in}" /></td>
						</tr>
						<tr>
							<td>June</td>
							<td><input type="text" name="jun_in" value="{$smarty.post.jun_in}" /></td>
						</tr>
						<tr>
							<td>July</td>
							<td><input type="text" name="jul_in" value="{$smarty.post.jul_in}" /></td>
						</tr>
						<tr>
							<td>August</td>
							<td><input type="text" name="aug_in" value="{$smarty.post.aug_in}" /></td>
						</tr>
						<tr>
							<td>September</td>
							<td><input type="text" name="sep_in" value="{$smarty.post.sep_in}" /></td>
						</tr>
						<tr>
							<td>October</td>
							<td><input type="text" name="oct_in" value="{$smarty.post.oct_in}" /></td>
						</tr>
						<tr>
							<td>November</td>
							<td><input type="text" name="nov_in" value="{$smarty.post.nov_in}" /></td>
						</tr>
						<tr>
							<td>December</td>
							<td><input type="text" name="dec_in" value="{$smarty.post.dec_in}" /></td>
						</tr>
					</table>
				</div>
				<div style="float:left;">
					<h3>Outgoings</h3>
					<table>
						<tr>
							<td>January</td>
							<td><input type="text" name="out[1]" value="{$smarty.post.out.1|default:$outgoing.1}" /></td>
						</tr>
						<tr>
							<td>February</td>
							<td><input type="text" name="out[2]" value="{$smarty.post.out.2|default:$outgoing.2}" /></td>
						</tr>
						<tr>
							<td>March</td>
							<td><input type="text" name="out[3]" value="{$smarty.post.out.3|default:$outgoing.3}" /></td>
						</tr>
						<tr>
							<td>April</td>
							<td><input type="text" name="out[4]" value="{$smarty.post.out.4|default:$outgoing.4}" /></td>
						</tr>
						<tr>
							<td>May</td>
							<td><input type="text" name="out[5]" value="{$smarty.post.out.5|default:$outgoing.5}" /></td>
						</tr>
						<tr>
							<td>June</td>
							<td><input type="text" name="out[6]" value="{$smarty.post.out.6|default:$outgoing.6}" /></td>
						</tr>
						<tr>
							<td>July</td>
							<td><input type="text" name="out[7]" value="{$smarty.post.out.7|default:$outgoing.7}" /></td>
						</tr>
						<tr>
							<td>August</td>
							<td><input type="text" name="out[8]" value="{$smarty.post.out.8|default:$outgoing.8}" /></td>
						</tr>
						<tr>
							<td>September</td>
							<td><input type="text" name="out[9]" value="{$smarty.post.out.9|default:$outgoing.9}" /></td>
						</tr>
						<tr>
							<td>October</td>
							<td><input type="text" name="out[10]" value="{$smarty.post.out.10|default:$outgoing.10}" /></td>
						</tr>
						<tr>
							<td>November</td>
							<td><input type="text" name="out[11]" value="{$smarty.post.out.11|default:$outgoing.11}" /></td>
						</tr>
						<tr>
							<td>December</td>
							<td><input type="text" name="out[12]" value="{$smarty.post.out.12|default:$outgoing.12}" /></td>
						</tr>
					</table>
				</div>
				<div style="float:left;">
					<p>
						<label>Date to:</label>
						<input type="text" name="date" class="date_picker" value="{$smarty.post.date}" />
					</p>
				</div>
				<input type="submit" name="plan_submit" value="Run" />
			</form>
		</div>
	</div>
	
	{if isset($show_result)}
	<div class="widget full">
		<div class="widget_title">Plan</div>
		<div class="widget_content box_background border_color_bottom border_color_top border_color_left border_color_right">
			<table>
				<thead>
					<tr>
						<th>Month</th>
						<th>Total In</th>
						<th>Total Out</th>
						<th>Balance</th>
						<th>Credit</th>
						<th>Debit</th>
					</tr>
				</thead>
				<tbody>
					{foreach from=$results item=r}
						<tr>
							<td>{$r.date|date_format:'%b %Y'}</th>
							<td>{$r.in}</td>
							<td>{$r.out}</td>
							<td style="color:{if $r.balance<0}red{else}green{/if}">{$r.balance}</td>
							<td style="color:{if $r.credit<0}red{else}green{/if}">{$r.credit}</td>
							<td style="color:{if $r.debit<0}red{else}green{/if}">{$r.debit}</td>
						</tr>
					{/foreach}
				</tbody>
			</table>
		</div>
	</div>
	{/if}
</div>