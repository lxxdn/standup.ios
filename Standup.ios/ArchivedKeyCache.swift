//
//  ArchivedKeyCache.swift
//  Standup.ios
//
//  Created by julien on 3/26/16.
//  Copyright © 2016 julien. All rights reserved.
//

import Foundation

class ArchivedKeyCache{
    
    struct StaticKeyName{
        static let project_list = "project_list"
        static let user_list = "user_list"
    }
    struct StaticData{
        static let default_user_list = [
            [
                "id": "cx4Fesrbh8jv6WKvh",
                "name": "Adam",
                "avatar": "https://lh4.googleusercontent.com/-tpyN-_X2oZU/AAAAAAAAAAI/AAAAAAAAAGg/DYBIhh-FzmU/photo.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "X9yHznAzPqbtd5Ewy",
                "name": "Alexandra",
                "avatar": "https://lh4.googleusercontent.com/-Fly5-JFsdqA/AAAAAAAAAAI/AAAAAAAAAOY/4L4juAuBQM0/photo.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "X4WeFLp3wEaeY3Z8d",
                "name": "Andrew",
                "avatar": "https://lh3.googleusercontent.com/-csWzQSWtm_w/AAAAAAAAAAI/AAAAAAAAAD4/hD2niB2m49c/photo.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "sQ9mEDi36CLP9S2Jq",
                "name": "Baurine",
                "avatar": "https://lh5.googleusercontent.com/-T_o_bo0jGDY/AAAAAAAAAAI/AAAAAAAAAAw/VdHp0Yhki14/photo.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "KtLSRyhzNsqXbWFvT",
                "name": "Bob",
                "avatar": "https://lh3.googleusercontent.com/-MAf0irbrzok/AAAAAAAAAAI/AAAAAAAAABA/_cQiGy-h688/photo.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "PEw3knjcKS3fjxGWE",
                "name": "Chessy",
                "avatar": "https://lh6.googleusercontent.com/-ppdAm3gTOo8/AAAAAAAAAAI/AAAAAAAAACM/lZs7MBVVoDM/photo.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "WmSxppKoMrgy353E8",
                "name": "Claire",
                "avatar": "https://lh3.googleusercontent.com/-PHcSDNOyFAU/AAAAAAAAAAI/AAAAAAAAABQ/VjVMsFesLQ4/photo.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "rPcfBezkdKdD4SJ4f",
                "name": "Coco",
                "avatar": "https://lh5.googleusercontent.com/-t2YMQtMe7n4/AAAAAAAAAAI/AAAAAAAAAOU/gr_0hbt5dxc/photo.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "bD7gGHjkjY5BJunJs",
                "name": "Eloise",
                "avatar": "https://lh3.googleusercontent.com/-lD1C7GbpJJo/AAAAAAAAAAI/AAAAAAAAAAs/N-RHmf_tiDc/photo.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ]
        ]
        static let default_project_list = [
            [
                "id": "8uaLCAAqcHqvbX42a",
                "name": "1001trackslists",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "9uceZHHjanLEKqAdi",
                "name": "Admin",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "v6afjykQzdq2AHTYK",
                "name": "Airpocalypse",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "TvECGoRKd8gN8mXkS",
                "name": "Arcane Network",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "PCC2NFiuRfQ3Ma7F8",
                "name": "Arcane Platform",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "juk75spGfcet8qjAk",
                "name": "Bare Square",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "fKomFuTpTK49r3KTA",
                "name": "Carevoice",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "t56tFzRHjjFxpqtBv",
                "name": "Cinemit",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "FddnH6Ys7et6abrja",
                "name": "Creative Friday",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "at8HALmBRbQe7Dt2D",
                "name": "Doctor Forum",
                "team_id": "pmEn8uixQEtccsztz"
            ]
        ]
    }
    static var path = { NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] }
    
    static func save(data: AnyObject, filename: String){
        let completePath = path().stringByAppendingString("/\(filename)")
        NSKeyedArchiver.archiveRootObject(data, toFile: completePath)
    }
    
    static func load(filename: String) -> AnyObject? {
        let completePath = path().stringByAppendingString("/\(filename)")
        return NSKeyedUnarchiver.unarchiveObjectWithFile(completePath)
    }
    
    static func prepareForDefaultValue(){
        if ((ArchivedKeyCache.load(StaticKeyName.project_list) as? Array<NSDictionary>) == nil){
            ArchivedKeyCache.save(StaticData.default_project_list, filename: StaticKeyName.project_list)
        }
        if ((ArchivedKeyCache.load(StaticKeyName.user_list) as? Array<NSDictionary>) == nil){
            ArchivedKeyCache.save(StaticData.default_user_list, filename: StaticKeyName.user_list)
        }

    }
}