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
                "email": "adam@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/cx4Fesrbh8jv6WKvh_adam.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "X9yHznAzPqbtd5Ewy",
                "name": "Alexandra",
                "email": "alexandra@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/X9yHznAzPqbtd5Ewy_alexandra.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "X4WeFLp3wEaeY3Z8d",
                "name": "Andrew",
                "email": "andrew@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/X4WeFLp3wEaeY3Z8d_andrew.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "sQ9mEDi36CLP9S2Jq",
                "name": "Baurine",
                "email": "baurine@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/sQ9mEDi36CLP9S2Jq_baurine.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "KtLSRyhzNsqXbWFvT",
                "name": "Bob",
                "email": "bob@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/KtLSRyhzNsqXbWFvT_bob.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "PEw3knjcKS3fjxGWE",
                "name": "Chessy",
                "email": "chessy@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/PEw3knjcKS3fjxGWE_chessy.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "WmSxppKoMrgy353E8",
                "name": "Claire",
                "email": "claire@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/WmSxppKoMrgy353E8_claire.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "rPcfBezkdKdD4SJ4f",
                "name": "Coco",
                "email": "coco@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/rPcfBezkdKdD4SJ4f_coco.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "bD7gGHjkjY5BJunJs",
                "name": "Eloise",
                "email": "eloise@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/bD7gGHjkjY5BJunJs_eloise.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "CSHi9s3vffuMoNrbq",
                "name": "Jimmy",
                "email": "jimmy@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/CSHi9s3vffuMoNrbq_jimmy.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "sDxmgnZsTb8r4vWJg",
                "name": "Johanne",
                "email": "johanne@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/sDxmgnZsTb8r4vWJg_johanne.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "7AFZpHgyAisu6TLsv",
                "name": "Julien",
                "email": "julien@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/7AFZpHgyAisu6TLsv_julien.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "GHxh9WLXyh7JEYQkf",
                "name": "Julien",
                "email": "julien.linglain@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/GHxh9WLXyh7JEYQkf_julien.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "jz2uXNkiugEnGR8zm",
                "name": "Karen",
                "email": "karen@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/jz2uXNkiugEnGR8zm_karen.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "EsHHjPbwzgFiMWeNS",
                "name": "Leo",
                "email": "leo@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/EsHHjPbwzgFiMWeNS_leo.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "6ieYxx4D9XyMG2ZmJ",
                "name": "Lily",
                "email": "lily@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/6ieYxx4D9XyMG2ZmJ_lily.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "EfdHLcXJ4gL74fvL3",
                "name": "Maggie",
                "email": "maggie@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/EfdHLcXJ4gL74fvL3_maggie.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "2yEA9TqRQeq5mPx8o",
                "name": "Maverick",
                "email": "maverick@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/2yEA9TqRQeq5mPx8o_maverick.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "XBQKDb6nzL9uREW5t",
                "name": "Maxence",
                "email": "maxence@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/XBQKDb6nzL9uREW5t_maxence.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "9W36J5jPXmD4b5859",
                "name": "Maxime",
                "email": "maxime@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/9W36J5jPXmD4b5859_maxime.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "czjqMtg2jATNerM37",
                "name": "Meganne",
                "email": "meganne@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/czjqMtg2jATNerM37_meganne.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "t9vLZERK68YBkiHM8",
                "name": "Mickey",
                "email": "mickey@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/t9vLZERK68YBkiHM8_mickey.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "YemtkGeYWEKJ4reyf",
                "name": "Nathan",
                "email": "nathan@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/YemtkGeYWEKJ4reyf_nathan.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "qpmiwr9StmtytuQvp",
                "name": "Noriko",
                "email": "noriko@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/qpmiwr9StmtytuQvp_noriko.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "bYaySgo8hJZgtDB3b",
                "name": "Scott",
                "email": "scott@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/bYaySgo8hJZgtDB3b_scott.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "KBbF3YxqtwykJPu99",
                "name": "Shao",
                "email": "shaozhuang@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/KBbF3YxqtwykJPu99_shao.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "JeY4qvarNuy752wrb",
                "name": "Shen",
                "email": "shenlong@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/JeY4qvarNuy752wrb_shen.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "va2LHfFAbwLvk7XNv",
                "name": "Shushana",
                "email": "shushana@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/va2LHfFAbwLvk7XNv_shushana.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "YaRxhdNuNA6ihCBnf",
                "name": "Summer",
                "email": "summer@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/YaRxhdNuNA6ihCBnf_summer.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "5MEMBtvDeLzFZYpE5",
                "name": "Tiphaine",
                "email": "tiphaine@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/5MEMBtvDeLzFZYpE5_tiphaine.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "AuLeXw7edX2KPeJ9J",
                "name": "Vincent",
                "email": "vincent@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/AuLeXw7edX2KPeJ9J_vincent.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "Ya87Qqv8QCn4bbqrH",
                "name": "Xiaoming",
                "email": "jin.xiaoming@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/Ya87Qqv8QCn4bbqrH_xiaoming.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "NuvEYBhcRNyrdWXBL",
                "name": "Yohann",
                "email": "yohann@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/NuvEYBhcRNyrdWXBL_yohann.jpg",
                "team_id": "pmEn8uixQEtccsztz"
            ],
            [
                "id": "EqpTXxpAnWhMcX6hE",
                "name": "Zoe",
                "email": "zoe@ekohe.com",
                "avatar": "http://standup.ekohe.com/uploads/EqpTXxpAnWhMcX6hE_zoe.jpg",
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
    
    static func remove(filename: String) -> AnyObject? {
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