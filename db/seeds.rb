# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << admin.email


reg_ger = Region.create! code: "GER", description: "Germany"

loc_frk = Location.create! code: "FRK", city: "Frankfurt"
loc_ham = Location.create! code: "HAM", city: "Hamburg"
loc_muc = Location.create! code: "MUC", city: "München"
loc_bln = Location.create! code: "BLN", city: "Berlin"
loc_lnd = Location.create! code: "LND", city: "London"

loc_han  = Location.create! code: "HAN", city: "Hanau"
loc_lfr  = Location.create! code: "LFR", city: "London / Frankfurt"
loc_ist  = Location.create! code: "IST", city: "Istanbul"
loc_eur  = Location.create! code: "EUR", city: "Europa"
loc_sin  = Location.create! code: "SIN", city: "Singapore"



evt_lmf   = EventType.create! code: "LMF", description: "Landmark Forum"
evt_fgk   = EventType.create! code: "FGK", description: "Fortgeschrittenenkurs"
evt_cap   = EventType.create! code: "CAP", description: "Kommunikation: Zugang durch Kraft / Access to Power"
evt_cpc   = EventType.create! code: "CPC", description: "Kommunikation: Die Kraft zu Kreieren / The Power to Create"
evt_mev   = EventType.create! code: "MEV", description: "Marken Event"

evt_ilp   = EventType.create! code: "ILP", description: "Einführungsleiterprogramm"
evt_csp   = EventType.create! code: "CSP", description: "Course Supervisor Program"
evt_tml   = EventType.create! code: "TML", description: "Team, Management und Leadership Program"
evt_sel   = EventType.create! code: "SEL", description: "Self Expression and Leadership Program"
evt_wis   = EventType.create! code: "WIS", description: "Wisdom Programm"

evt_inl  = EventType.create! code: "SemINL", description: "Seminar Ein erfundenes Leben leben / Invented Live"
evt_bex  = EventType.create! code: "SemBEX", description: "Seminar Aussergewöhnlich sein / Being Extraordinary"
evt_byf  = EventType.create! code: "SemBYF", description: "Seminar Beyond Fitness"
evt_blb  = EventType.create! code: "SemBLB", description: "Seminar Durchbrüche / Breakthroughs: Living Outside the Box"
evt_ctm  = EventType.create! code: "SemCTM", description: "Seminar Wunder verursachen / Causing the Miraculous"
evt_cpa  = EventType.create! code: "SemCPA", description: "Seminar Verpflichtung / Commitment: Pathway to Adventure"
evt_cha  = EventType.create! code: "SemCHA", description: "Seminar Glücklichsein kreieren / Creating Happiness"
evt_cld  = EventType.create! code: "SemCLD", description: "Seminar Kreativität / Creativity"
evt_eff  = EventType.create! code: "SemEFF", description: "Seminar Effektivität / Effectiveness"
evt_eiz  = EventType.create! code: "SemEIZ", description: "Seminar Excellence / Excellence in the Zone"
evt_ibl  = EventType.create! code: "SemIBL", description: "Seminar Integrität / Integrity: The Bottom Line"
evt_fia  = EventType.create! code: "SemFIA", description: "Seminar Forum in Aktion / Forum in Action"
evt_lps  = EventType.create! code: "SemLPS", description: "Seminar Leidenschaftlich Leben / Living Passionately"
evt_lpo  = EventType.create! code: "SemLPO", description: "Seminar Kraftvoll Leben / Living Powerfully"
evt_mcf  = EventType.create! code: "SemMCF", description: "Seminar Geld / Money"
evt_trs  = EventType.create! code: "SemTRS", description: "Seminar Beziehung / Relationships"
evt_sai  = EventType.create! code: "SemSAI", description: "Seminar Sex und Intimität / Sex and Intimacy"
evt_suc  = EventType.create! code: "SemSUC", description: "Seminar Erfolg / Success: The Power of Context"

evt_suc  = EventType.create! code: "SemGES", description: "Seminar Geschwindigkeit"



tt_assist = TeamType.create! code: "ASS", description: "Assistance Programm"
tt_admins = TeamType.create! code: "ADM", description: "Administration"

rl_fol   = EventRoleType.create! description: "Forum Leader"
rl_fos   = EventRoleType.create! description: "Forum Supervisor"
rl_om    = EventRoleType.create! description: "Operations Manager"
rl_att   = EventRoleType.create! description: "Attendee"
rl_int   = EventRoleType.create! description: "Interested"

rl_admin = TeamRoleType.create! description: "Administrator"
rl_ass   = TeamRoleType.create! description: "Assistant"

admins = Team.create!(team_type: tt_admins, title: "Germany", startdate: "2015-01-01")

puts "Created Team: #{admins}"

# PersonTeamAssignment.create!(person: admin_person, team: admins, team_role_type: rl_admin)

# -----------------------------------------------------------------
# Create Landmark Forum Frankfurt 2015/05
=begin

forum = Event.create!(event_type: evt_lmf, location: loc_frk,
                      startdate: "2015-05-01", event_state: "open")
puts "Created Event: #{forum}"

PersonEventAssignment.create!(person: klaus, event: forum, event_role_type: rl_att)

# -----------------------------------------------------------------
# Create Seminar Excellence Munich 2015/02-03

excellence = Event.create!(event_type: evt_exc, location: loc_muc,
                           startdate: "2015-02-01", event_state: "open")
puts "Created Event: #{excellence}"

PersonEventAssignment.create!(person: klaus, event: excellence, event_role_type: rl_att)

# -----------------------------------------------------------------
# Create Assistance Programm Germany

assistance = Team.create!(team_type: tt_assist, region: reg_ger)
puts "Created Event: #{assistance}"

PersonTeamAssignment.create!(person: klaus, team: assistance, team_role_type: rl_ass, startdate: "2015-02-01", enddate: "2015-03-31")
=end

# -----------------------------------------------------------------
# Reporting

Report.create!(
  name: 'POT Frankfurt',
  url_name: 'pot_frankfurt',
  description: 'Alle Teilnehmer, die mindestens entweder FGK und ein Seminar oder zwei Seminare gemacht haben'
)
Report.create!(
  name: 'Absolventen FGK',
  url_name: 'absolventen_fgk',
  description: 'Alle Absolventen, die an einem FGK teilgenommen haben.'
)
Report.create!(
  name: 'POT CPC',
  url_name: 'pot_cpc',
  description: 'Alle Absolventen, die an einem CAP und keinem CPC teilgenommen haben.'
)
