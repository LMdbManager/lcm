class ExportAssignments

  MAPPING = {
    'zID' => 'id',
    'pID' => 'pid',
    'eID' => 'eid',
    'Event' => 'shortname'
  }

  def self.process(xls_workbook)
    XlsxExport.process xls_workbook, "Assignments",
      PersonEventAssignment
        .joins(:person, :event)
        .order("events.id, people.id")
        .select("person_event_assignments.* ,people.id as pid,events.id as eid,shortname"),
      MAPPING.invert
  end

end
