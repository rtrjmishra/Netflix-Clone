//
//  ApiCaller.swift
//  Netflix Clone
//
//  Created by Rituraj Mishra on 25/02/22.
//  Copyright © 2022 rtrjmishra. All rights reserved.
//

import Foundation


struct Constants
{
    static let apiKey = "13f6b83cb0571606206b75b81c1b0920"
    static let baseUrl = "https://api.themoviedb.org"
}

enum APIError: Error
{
    case failedTogetData
}

class ApiCaller
{
    static let shared = ApiCaller()
    
    //MARK: -Trending Movies
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
    {
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return }
            
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    //MARK: -Tranding Tv
    func getTrendingTvs(completion: @escaping (Result<[Tv], Error>) -> Void)
    {
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/tv/day?api_key=\(Constants.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return }
            
            do{
                let results = try JSONDecoder().decode(TrendingTvResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    //MARK: -Upcoming Movies
    func getUpcoming(completion: @escaping (Result<[Movie], Error>) -> Void)
    {
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/upcoming?api_key=\(Constants.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return }
            
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    //MARK: -Popular Movies
    func getPopular(completion: @escaping (Result<[Movie], Error>) -> Void)
    {
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return }
            
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    //MARK: -Top Rated Movies
    func getTopRated(completion: @escaping (Result<[Movie], Error>) -> Void)
    {
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/top_rated?api_key=\(Constants.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return }
            
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
