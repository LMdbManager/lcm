#
# Imports ATTENDEES From Excel Table AbsolventenKomplett.xls
# Author: K.D. Gundermann
# Date  : 14.04.2015
#
class ImportAttendees

  SHEET_ATTENDEES = 1

  MAPPING = {
      "pID" => "pid",
      "Anrede" => "salutation",
      "Nachname" => "lastname",
      "Vorname" => "firstname",
      "Straße" => "street",
      "PLZ" => "zip",
      "Ort" => "city",
      "Land" => "country",
      "Telefon Privat"  => "phone_private",
      "Telefon Arbeit"  => "phone_work",
      "Telefon Mobil"   => "phone_mobile",
      "eMail" => "email",
      "Zuordnung" => "region",
      "Kommentar / wichtige Info" => "notes"
    }


    def self.read(import)
      self.new import
    end

    def initialize(import)
      @import = import
      read_attendees
    end

    private
    def read_attendees
      @import.log :step, description: "Import Attendees: Load Excel File"
      begin
        rows = XlsxImport.read @import.temp_filename, SHEET_ATTENDEES
      rescue XlsxImport::Error => e
        @import.log :error, e.to_s
        return
      end

      @import.log :step, description: "Import Attendees: Create Records"
      #ActiveRecord::Base.transaction do
        ActiveRecord::Base.logger.silence do
          rows.each do |row|
            import_row(row)
          end
        end
      #end
    end

    def import_row(row)
      p = Person.new
      MAPPING.each {|col,field|
        p.send(field + "=", row[col])
      }

      if p.valid?
        p.save!
      end
      @import.log :row, row: row[:row], rawdata: row, importdata: p, message: p.errors.full_messages
    end

end
