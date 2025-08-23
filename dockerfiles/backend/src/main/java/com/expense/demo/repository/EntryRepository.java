package com.expense.demo.repository;

import com.expense.demo.model.Entry;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface EntryRepository extends JpaRepository<Entry, Long> {
    List<Entry> findByType(String type);
    List<Entry> findByDateBetween(LocalDate start, LocalDate end);
}
