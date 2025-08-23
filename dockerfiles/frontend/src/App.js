

import React, { useEffect, useState } from 'react';
import './App.css';
import { exportEntriesToPDF } from './exportPdf';

// const API_URL = "http://54.89.91.77/api/entries";
const API_URL = "http://expense-backend:8080/api/entries";

function App() {

  const [entries, setEntries] = useState([]);
  const [form, setForm] = useState({ type: 'income', description: '', amount: '', date: '' });
  const [report, setReport] = useState({ income: 0, expense: 0 });
  const [editId, setEditId] = useState(null);

  useEffect(() => {
    fetchEntries();
  }, []);

  const fetchEntries = async () => {
    const res = await fetch(API_URL);
    const data = await res.json();
    setEntries(data);
    calcReport(data);
  };

  const calcReport = (data) => {
    let income = 0, expense = 0;
    data.forEach(e => {
      if (e.type === 'income') income += e.amount;
      else expense += e.amount;
    });
    setReport({ income, expense });
  };

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };


  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!form.description || !form.amount || !form.date) return;
    if (editId) {
      await fetch(`${API_URL}/${editId}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ...form, amount: parseFloat(form.amount) })
      });
    } else {
      await fetch(API_URL, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ...form, amount: parseFloat(form.amount) })
      });
    }
    setForm({ type: 'income', description: '', amount: '', date: '' });
    setEditId(null);
    fetchEntries();
  };

  const handleEdit = (entry) => {
    setForm({
      type: entry.type,
      description: entry.description,
      amount: entry.amount,
      date: entry.date
    });
    setEditId(entry.id);
  };

  const handleDelete = async (id) => {
    await fetch(`${API_URL}/${id}`, { method: 'DELETE' });
    fetchEntries();
  };

  const handleExportPDF = () => {
    exportEntriesToPDF(entries);
  };

  return (
    <div className="App">
      <h1>Expense Tracker</h1>
      <form onSubmit={handleSubmit} className="entry-form">
        <select name="type" value={form.type} onChange={handleChange}>
          <option value="income">Income</option>
          <option value="expense">Expense</option>
        </select>
        <input name="description" placeholder="Description" value={form.description} onChange={handleChange} />
        <input name="amount" type="number" placeholder="Amount" value={form.amount} onChange={handleChange} />
        <input name="date" type="date" value={form.date} onChange={handleChange} />
        <button type="submit">Add Entry</button>
      </form>
      <h2>Entries</h2>
      <button onClick={handleExportPDF} style={{ marginBottom: 10 }}>Export PDF</button>
      <table className="entries-table">
        <thead>
          <tr>
            <th>Date</th>
            <th>Type</th>
            <th>Description</th>
            <th>Amount</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {entries.map(e => (
            <tr key={e.id}>
              <td>{e.date}</td>
              <td>{e.type}</td>
              <td>{e.description}</td>
              <td>{e.amount}</td>
              <td>
                <button onClick={() => handleEdit(e)}>Edit</button>
                <button onClick={() => handleDelete(e.id)} style={{ marginLeft: 4 }}>Delete</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      <h2>Report</h2>
      <div className="report">
        <div>Income: <b style={{ color: 'green' }}>{report.income}</b></div>
        <div>Expense: <b style={{ color: 'red' }}>{report.expense}</b></div>
        <div>Balance: <b>{report.income - report.expense}</b></div>
      </div>
    </div>
  );
}

export default App;
