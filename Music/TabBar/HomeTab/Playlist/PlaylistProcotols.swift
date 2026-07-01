//
//  PlaylistProcotols.swift
//  Music
//
//  Created by Egor on 01.07.2026.
//

protocol PlaylistViewProtocol: AnyObject {
    func showPlaylist(playlist: Playlist)
}

protocol PlaylistPresenterProtocol: AnyObject {
    func viewDidLoad()
}

protocol PlaylistRouterProtocol: AnyObject {
    
}
