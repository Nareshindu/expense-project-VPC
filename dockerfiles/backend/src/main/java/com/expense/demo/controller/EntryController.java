package com.expense.demo.controller;

import com.expense.demo.model.Entry;
import com.expense.demo.repository.EntryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/entries")
@CrossOrigin(origins = "http://54.224.231.100")
public class EntryController {
    @Autowired
    private EntryRepository entryRepository;

    @GetMapping
    public List<Entry> getAllEntries() {
        return entryRepository.findAll();
    }

    @PostMapping
    public Entry addEntry(@RequestBody Entry entry) {
        return entryRepository.save(entry);
    }

    @GetMapping("/type/{type}")
    public List<Entry> getEntriesByType(@PathVariable String type) {
        return entryRepository.findByType(type);
    }

    @GetMapping("/report")
    public List<Entry> getEntriesByDateRange(@RequestParam String start, @RequestParam String end) {
        LocalDate startDate = LocalDate.parse(start);
        LocalDate endDate = LocalDate.parse(end);
        return entryRepository.findByDateBetween(startDate, endDate);
    }

    @PutMapping("/{id}")
    public Entry updateEntry(@PathVariable Long id, @RequestBody Entry entry) {
        Entry existing = entryRepository.findById(id).orElseThrow();
        existing.setType(entry.getType());
        existing.setDescription(entry.getDescription());
        existing.setAmount(entry.getAmount());
        existing.setDate(entry.getDate());
        return entryRepository.save(existing);
    }

    @DeleteMapping("/{id}")
    public void deleteEntry(@PathVariable Long id) {
        entryRepository.deleteById(id);
    }
}
