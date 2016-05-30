#
# Imports Teilnehmer from Excel Table LMFRK...Teilnehmerliste
# Author: K.D. Gundermann
# Date  : 14.04.2015
#

class ImportTeilnehmer

  SHEET_TEILNEHMER = "Teilnehmerliste"

  MAPPING = {
    "PID" => "id",
    "Anrede" => "salutation",
    "Name" => "lastname",
    "Nachname" => "lastname",
    "Vorname" => "firstname",
    "Rufname" => "callby",
    "Titel" => "title",
    "Straße" => "street",
    "HNr" => "housenumber",
    "PLZ" => "zip",
    "Ort" => "city",
    "Land" => "country",
    "Geb.Datum" => "birthday",
    "Telefon Privat"  => "phone_private",
    "Telefon Arbeit"  => "phone_work",
    "Telefon Mobil"   => "phone_mobile",
    "EMail" => "email",
    "Region" => "region",
    "OOA ES" => "ooa_es",
    "OOA Sem" => "ooa_sem"
  }

  def self.read(event, import)
    self.new event, import
  end

  def initialize(event, import)
    @event  = event
    @import = import
    @role = EventRoleType.where(description: "Attendee").first
    read_teilnehmer
  end

  private
  def read_teilnehmer
    step = @import.log(:step, description: "Import Teilnehmer: Load Excel File")
    begin
      rows = XlsxImport.read_sheet @import.temp_filename, SHEET_TEILNEHMER
    rescue XlsxImport::Error => e
      @import.log :error, e.to_s
      return
    end

    step.totalrows = rows.count
    step = @import.log(:step, description: "Import Teilnehmer: Update Records")
    #ActiveRecord::Base.transaction do
    ActiveRecord::Base.logger.quietly do
        rows.each do |row|
          import_row(row)
        end
    end
    #end
  end

  def import_row(row)
    # debugger  if row[:row].to_i == 1
    return if row["Name"].blank? && row["Nachname"].blank?

    if p = find_person(row)
      MAPPING.each {|col,field|
        unless row[col].blank?
          p.send(field + "=", row[col])
        end
      }
      if p.valid?
        p.save!
        p.assign_to_event @event, @role
      end
      @import.log :row, row: row[:row], rawdata: row, importdata: p, message: p.errors.full_messages
    else
      @import.log :row, row: row[:row], rawdata: row, message: show_duplicates(row)
    end
  end

  def find_person(row)
    pid=row["PID"].to_i
    if pid > 0
      if p = Person.where(pid: pid).first
        return p
      end
    end

    lastname = row["Nachname"] || row["Name"]
    firstname = row["Vorname"]
    country = row["Land"]
    country = "DE" if country == "D"

    query1 = Person.where(country: country).where(lastname: lastname).where(firstname: firstname)
    query2 = query1.where(zip: row["PLZ"])
    if query1.count == 0
      return Person.new(id: Person.new_pid)
    elsif query1.count == 1
      return query1.first
    elsif query2.count == 1
      return query2.first
    else
      return nil
    end
  end

  def show_duplicates(row)

    lastname = row["Nachname"] || row["Name"]
    firstname = row["Vorname"]
    country = row["Land"]
    country = "DE" if country == "D"

    query = Person.where(country: country).where(lastname: lastname).where(firstname: firstname)
                  .where(zip: row["PLZ"])
    query = query.select([:id, :lastname, :firstname, :country, :zip, :city, :street])
    return  "Person '#{row["Nachname"]} #{row["Vorname"]}' nicht genau bestimmbar.\nÄhnliche Personen:" + query.all.to_a.join("<br>")
  end

end
