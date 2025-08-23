import jsPDF from 'jspdf';
import autoTable from 'jspdf-autotable';

export function exportEntriesToPDF(entries) {
  const doc = new jsPDF();
  doc.text('Expense Tracker Entries', 14, 16);
  autoTable(doc, {
    startY: 22,
    head: [['Date', 'Type', 'Description', 'Amount']],
    body: entries.map(e => [e.date, e.type, e.description, e.amount]),
  });
  doc.save('expense-entries.pdf');
}
