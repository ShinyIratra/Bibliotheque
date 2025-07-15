package com.bibliotheque.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;


@Service
public class LoginService {
    @Autowired
    private MemberRepository memberRepository;

    @Autowired 
    private LibrarianRepository librarianRepository;

    public Long memberConnect(String username, String password) throws RuntimeException {
        Member member = memberRepository.findByUsernameAndPassword(username, password)
            .orElseThrow(() -> new RuntimeException(""));
        return member.getId();
    }

    public Long librarianConnect(String username, String password) throws RuntimeException {
        Librarian librarian = librarianRepository.findByUsernameAndPassword(username, password)
            .orElseThrow(() -> new RuntimeException(""));
        return librarian.getId();
    }
}