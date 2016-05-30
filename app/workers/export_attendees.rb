class ExportAttendees
  require 'xlsx_export'

  SHEET_ATTENDEES = "Attendees"

  MAPPING = {
      "pID" => "id",
      "Status" => "state",
      "Datum" => "date",
      "Nachname" => "lastname",
      "Vorname" => "firstname",
      "Rufname" => "callby",
      "Anrede" => "salutation",
      "Titel" => "title",
      "Geb.Datum" => "birthday",
      "Straße" => "street",
      "HNr" => "housenumber",
      "PLZ" => "zip",
      "Ort" => "city",
      "Land" => "country",
      "Telefon Privat"  => "phone_private",
      "Telefon Arbeit"  => "phone_work",
      "Telefon Mobil"   => "phone_mobile",
      "OOA FRK" => "ooa_es",
      "OOA Semr" => "ooa_sem",
      "eMail" => "email",
      "Zuordnung" => "code",
      "Kommentar / wichtige Info" => "notes"
    }

  def self.process(xls_workbook)
    XlsxExport.process xls_workbook, SHEET_ATTENDEES,
      Person.joins("LEFT JOIN regions ON regions.id = people.region_id")
            .order("lastname, firstname")
            .select("people.*, regions.code"),
      MAPPING.invert
  end

end
