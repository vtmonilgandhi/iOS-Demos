//
//  MovieManager.swift
//  FilmFest
//
//  Created by Monil.Gandhi on 01/11/18.
//  Copyright © 2018 Monil.Gandhi. All rights reserved.
//

import Foundation

class MovieManager {
    var moviesToSeeCount: Int { return moviesToSeeArray.count}
    var moviesSeenCount: Int { return moviesSeenArray.count}
    
    private var moviesToSeeArray = [Movie]()
    private var moviesSeenArray = [Movie]()
    
    func addMovie(movie: Movie) {
        if !moviesToSeeArray.contains(movie) {
            moviesToSeeArray.append(movie)
        }
    }
    
    func movieAtIndex(index: Int) -> Movie {
        return moviesToSeeArray[index]
    }
    
    func checkOffMovieAtIndex(index: Int) {
        guard index < moviesToSeeCount else {return}
        
        let checkedMovie = moviesToSeeArray.remove(at: index)
        moviesSeenArray.append(checkedMovie)
    }
    
    func checkedOffMovieAtIndex(index: Int) -> Movie {
        return moviesSeenArray[index]
    }
    
    func clearArrays() {
        moviesToSeeArray.removeAll()
        moviesSeenArray.removeAll()
    }
    
}
