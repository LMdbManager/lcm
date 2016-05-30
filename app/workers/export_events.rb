class ExportEvents
  require 'xlsx_export'

  SHEET_EVENTS = "Events"

  MAPPING = {
    'eID' => 'id',
    'eName' => 'shortname',
    'eBeschreibung' => 'title',
    'eOrt' => 'city',
    'eJahr' => 'year'
  }

  def self.process(xls_workbook)
    XlsxExport.process xls_workbook, SHEET_EVENTS,
      Event.joins(:location).order("events.id").select("*"),
      MAPPING.invert
  end

end
