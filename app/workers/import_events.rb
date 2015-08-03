#
# Imports COURSES(Events) From Excel Table AbsolventenKomplett.xls
# Author  : K.D. Gundermann
# Date:   : 14.04.2015
#
class ImportEvents

  SHEET_EVENTS = 3

  MAPPING = {
    'eID' => 'eid',
    'eName' => 'setshortname',
    'eBeschreibung' => 'title',
    'eOrt' => 'city'
  }

  def self.read(import)
    self.new import
  end

  def initialize(import)
    @import = import
    read_events
  end

  private

  def read_events
    @import.log :step, description: 'Import Events: Load Excel File'
    begin
      rows = XlsxImport.read @import.temp_filename, SHEET_EVENTS
    rescue XlsxImport::Error => e
      @import.log :error, e.to_s
      return
    end

    @import.log :step, description: 'Import Events: Create Records'
    # ActiveRecord::Base.transaction do
    ActiveRecord::Base.logger.silence do
      rows.each do |row|
        next if row['eID'].blank?
        import_row(row)
      end
    end
    # end
  end

  def import_row(row)
    c = Event.new
    MAPPING.each { |col, field| c.send(field + '=', row[col]) }

    #c.event_type_id = 1
    unless row['eJahr'].blank?
      if row['eZeitraum'].blank?
        c.startdate = row['eJahr'] + '0101'
      else
        c.startdate = row['eJahr'] + row['eZeitraum'][0..1] + '01'
      end
    else
      c.startdate = '20000101'
    end
    c.event_state = :closed

    if c.valid?
      c.save!
    end
    @import.log :row,  row: row[:row], rawdata: row, importdata: c, message: c.errors.full_messages
  end
end
