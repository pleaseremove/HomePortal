BEGIN:VCALENDAR
PRODID:-//HomePortal//Calendar Feed v1.0//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:PUBLISH
X-WR-CALNAME:{$currentuser->name}
X-WR-TIMEZONE:Europe/London
{foreach from=$events item=e}
BEGIN:VEVENT
DTSTART{if $e->all_day==1};VALUE=DATE:{$e->start_date|date_format:'%Y%m%d'}{else}:{$e->dateToCal('start')}{/if}

DTEND{if $e->all_day==1};VALUE=DATE:{$e->end_date|date_format:'%Y%m%d'}{else}:{$e->dateToCal('end')}{/if}

UID:hp{$e->id()}
DTSTAMP:{$e->created_datetime|date_format:'%Y%m%dT%H%M%SZ'}
DESCRIPTION:{$e->escapeStringIcal($e->details)}
SUMMARY:{$e->escapeStringIcal($e->title)}
LAST-MODIFIED:{$e->updated_datetime|date_format:'%Y%m%dT%H%M%SZ'}
LOCATION:{$e->location|default:''}
SEQUENCE:{$e->sequence|default:'0'}
END:VEVENT
{/foreach}
END:VCALENDAR