BEGIN:VCALENDAR
PRODID:-//HomePortal//Calendar Feed v1.0//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:PUBLISH
X-WR-CALNAME:{$currentuser->name}
X-WR-TIMEZONE:Europe/London
{foreach from=$events item=e}
BEGIN:VEVENT
{$e->dateToCal('start')}
{$e->dateToCal('end')}
UID:hp{$e->id()}
DTSTAMP:{$e->created_datetime|date_format:'%Y%m%dT%H%M%SZ+01:00'}
DESCRIPTION:{$e->escapeStringIcal($e->description)}
SUMMARY:{$e->escapeStringIcal($e->title)}{if $e->tentative==1} - Unconfirmed{/if}

LAST-MODIFIED:{$e->updated_datetime|date_format:'%Y%m%dT%H%M%SZ+01:00'}
STATUS:{if $e->tentative==1}TENTATIVE{else}CONFIRMED{/if}

LOCATION:{$e->location|default:''}
SEQUENCE:{$e->sequence|default:'0'}
END:VEVENT
{/foreach}
END:VCALENDAR
