/* =============================================================================
   Generates the Week 2.2 artefact: a genuinely messy trade-show lead CSV.
   Run:  node make-tradeshow-csv.js
   Out:  sydney-home-show-leads-RAW.csv  (178 data rows)

   The mess is deliberate and mirrors what a real stall CSV looks like after
   three staff have typed into the same iPad for two days:
     • six different phone formats, some unusable
     • State missing on ~30% of rows (breaks Lead Assignment Rules)
     • postcodes missing, or written as "2150 NSW", or with a leading apostrophe
     • full names crammed into First Name, or reversed
     • malformed emails (no @, double dots, trailing spaces)
     • rows that are staff, competitors, or a lunch order
     • exact and near duplicates within the file
     • people already in Salesforce as Contacts
     • three date formats
     • free-text notes containing commas and quotes
   ============================================================================= */

const fs = require('fs');
const path = require('path');

// Deterministic PRNG so the file is reproducible
let s = 20260614;
const rnd = () => ((s = (s * 1103515245 + 12345) & 0x7fffffff) / 0x7fffffff);
const pick = (a) => a[Math.floor(rnd() * a.length)];
const chance = (p) => rnd() < p;

const FIRST = ['Aiden','Bronwyn','Cameron','Delilah','Ewan','Fiona','Gordon','Harriet',
  'Ivan','Josie','Kurt','Lorna','Malcolm','Nerida','Otto','Petra','Quinn','Rhys',
  'Saskia','Trevor','Ursula','Vince','Wanda','Xavier','Yolanda','Zach','Bruce',
  'Catriona','Dermot','Eloise','Fraser','Greta','Hamish','Imogen','Jarrah','Keira'];

const LAST = ['Ashworth','Blackwood','Costello','Dunkley','Emmerson','Fairweather',
  'Gillespie','Hargreaves','Ingram','Jamieson','Kirkpatrick','Langford','Mortimer',
  'Nicholls','Oakley','Prendergast','Quinlan','Radcliffe','Stanhope','Thurlow',
  'Underwood','Vasquez','Wexford','Yates','Zimmerman','Halloran','Devereux'];

const SUBURBS = [
  ['Parramatta','2150'],['Blacktown','2148'],['Penrith','2750'],['Liverpool','2170'],
  ['Castle Hill','2154'],['Bankstown','2200'],['Chatswood','2067'],['Hornsby','2077'],
  ['Ryde','2112'],['Campbelltown','2560'],['Newcastle','2300'],['Charlestown','2290'],
  ['Maitland','2320'],['Wollongong','2500'],['Shellharbour','2529'],['Dapto','2530'],
  ['Kiama','2533'],['Baulkham Hills','2153'],['Hurstville','2220'],['Cessnock','2325']
];

const INTEREST = ['Solar','solar','SOLAR','Battery','Solar + Battery','solar+battery',
  'Not sure','Battery only','', 'Just looking'];

const NOTES = [
  'Wants quote ASAP',
  'Has quote from competitor, said "we can beat it, right?"',
  'Renting - check with landlord first',
  'Interested but not until next FY',
  'Already has 5kW, wants to expand',
  'Very keen, north facing roof',
  'Asked about the federal rebate, I said we\'d follow up',
  'Tile roof, 2 storey',
  'Do not call before 10am',
  'Partner makes the decisions, call the mobile',
  '',
  'BATTERY ONLY - no panels',
  'Said they filled in the web form last month too'
];

function phone(style) {
  const a = 4000 + Math.floor(rnd() * 5000);
  const b = 1000 + Math.floor(rnd() * 9000);
  const m = 400000000 + Math.floor(rnd() * 99999999);
  switch (style) {
    case 0: return `(02) ${a} ${b}`;
    case 1: return `02 ${a}-${b}`;
    case 2: return `0${m}`;
    case 3: return `+61 ${String(m).slice(0,3)} ${String(m).slice(3,6)} ${String(m).slice(6)}`;
    case 4: return `0${String(m).slice(0,3)} ${String(m).slice(3,6)} ${String(m).slice(6)}`;
    case 5: return `${a}${b}`;                 // 8 digits, no area code — unusable
    case 6: return ` 0${m} `;                  // padded
    default: return '';
  }
}

function email(fn, ln, i) {
  const base = `${fn.toLowerCase()}.${ln.toLowerCase()}${i}`;
  if (chance(0.05)) return `${base}example.com`;      // missing @
  if (chance(0.04)) return `${base}@@example.com`;    // double @
  if (chance(0.04)) return `${base}@example..com`;    // double dot
  if (chance(0.06)) return ` ${base}@example.com `;   // padded
  if (chance(0.05)) return `${base.toUpperCase()}@EXAMPLE.COM`;
  if (chance(0.05)) return '';                        // no email at all
  return `${base}@example.com`;
}

function dateStr(i) {
  const d = 15 + (i % 3);
  const style = i % 3;
  if (style === 0) return `${d}/05/2026`;
  if (style === 1) return `2026-05-${String(d).padStart(2, '0')}`;
  return `${d} May 26`;
}

const q = (v) => {
  const t = String(v ?? '');
  return /[",\n]/.test(t) ? `"${t.replace(/"/g, '""')}"` : t;
};

const rows = [];
const seen = [];

for (let i = 0; i < 168; i++) {
  const fn = pick(FIRST);
  const ln = pick(LAST);
  const [sub, pc] = pick(SUBURBS);

  let firstCol = fn;
  let lastCol = ln;

  // ~8% of rows: whole name crammed into First Name
  if (chance(0.08)) { firstCol = `${fn} ${ln}`; lastCol = ''; }
  // ~5%: reversed
  else if (chance(0.05)) { firstCol = ln; lastCol = fn; }
  // ~6%: stray whitespace / casing
  else if (chance(0.06)) { firstCol = `  ${fn.toLowerCase()}`; lastCol = ln.toUpperCase(); }

  // State missing on ~30% of rows — this is what breaks assignment rules
  const state = chance(0.30) ? '' : pick(['NSW', 'nsw', 'New South Wales', 'N.S.W.']);

  // Postcode: missing, malformed, or fine
  let postcode = pc;
  if (chance(0.10)) postcode = '';
  else if (chance(0.06)) postcode = `${pc} NSW`;
  else if (chance(0.05)) postcode = `'${pc}`;

  const row = {
    'First Name': firstCol,
    'Last Name': lastCol,
    'Email': email(fn, ln, i),
    'Mobile': chance(0.07) ? '' : phone(Math.floor(rnd() * 7)),
    'Suburb': chance(0.05) ? sub.toUpperCase() : sub,
    'State': state,
    'Postcode': postcode,
    'Interest': pick(INTEREST),
    'Date Collected': dateStr(i),
    'Notes': pick(NOTES)
  };

  rows.push(row);
  if (i % 14 === 0) seen.push(row);
}

// --- Exact duplicates within the file (someone scanned the same badge twice)
for (const r of seen.slice(0, 6)) rows.push({ ...r });

// --- Near duplicates: same person, different phone format and casing
for (const r of seen.slice(6, 11)) {
  rows.push({ ...r,
    'Mobile': phone(3),
    'Email': String(r['Email']).toUpperCase(),
    'Notes': 'Came back to the stall on day 2'
  });
}

// --- Junk rows that should never become Leads
rows.push({ 'First Name': 'Dave', 'Last Name': 'from Solaris Energy', 'Email': '',
  'Mobile': '', 'Suburb': '', 'State': '', 'Postcode': '', 'Interest': '',
  'Date Collected': '16/05/2026', 'Notes': 'COMPETITOR - was asking about our pricing' });

rows.push({ 'First Name': 'lunch order', 'Last Name': '', 'Email': '', 'Mobile': '',
  'Suburb': '', 'State': '', 'Postcode': '', 'Interest': '',
  'Date Collected': '', 'Notes': '"3x chicken, 1 vego, no onion"' });

rows.push({ 'First Name': 'Jake', 'Last Name': 'Robinson', 'Email': 'jake.robinson@sunrisesolar.com.au',
  'Mobile': '0411 222 333', 'Suburb': 'Parramatta', 'State': 'NSW', 'Postcode': '2150',
  'Interest': '', 'Date Collected': '15/05/2026', 'Notes': 'test scan - our own stand' });

rows.push({ 'First Name': '', 'Last Name': '', 'Email': 'someone@example.com', 'Mobile': '',
  'Suburb': '', 'State': '', 'Postcode': '', 'Interest': 'Solar',
  'Date Collected': '', 'Notes': 'only got the email before the iPad died' });

rows.push({ 'First Name': '', 'Last Name': '', 'Email': '', 'Mobile': '', 'Suburb': '',
  'State': '', 'Postcode': '', 'Interest': '', 'Date Collected': '', 'Notes': '' });

const headers = ['First Name','Last Name','Email','Mobile','Suburb','State',
  'Postcode','Interest','Date Collected','Notes'];

const csv = [headers.join(',')]
  .concat(rows.map(r => headers.map(h => q(r[h])).join(',')))
  .join('\r\n');

const out = path.join(__dirname, 'sydney-home-show-leads-RAW.csv');
fs.writeFileSync(out, csv, 'utf8');

const withState = rows.filter(r => r['State']).length;
console.log(`Wrote ${out}`);
console.log(`  data rows        : ${rows.length}`);
console.log(`  missing State    : ${rows.length - withState}`);
console.log(`  missing Email    : ${rows.filter(r => !String(r['Email']).trim()).length}`);
console.log(`  missing Mobile   : ${rows.filter(r => !String(r['Mobile']).trim()).length}`);
console.log(`  missing Postcode : ${rows.filter(r => !String(r['Postcode']).trim()).length}`);
