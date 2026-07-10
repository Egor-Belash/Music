//
//  AudioPlayerManager.swift
//  Music
//
//  Created by Egor on 03.07.2026.
//

import AVFoundation

final class AudioPlayerManager: NSObject {
    
    // MARK: – Singleton
    static let shared = AudioPlayerManager()
    
    // MARK: – Properties
    private var player: AVAudioPlayer?
    private(set) var currentPlaylist: Playlist?
    private var currentIndex: Int = 0
    var currentTrack: Track? {
        guard let currentPlaylist,
              currentPlaylist.tracks.indices.contains(currentIndex) else { return nil }
        return currentPlaylist.tracks[currentIndex]
    }
    private(set) var isPlaying = false
    var currentTime: TimeInterval {
        player?.currentTime ?? 0
    }
    var duration: TimeInterval {
        player?.duration ?? 0
    }

    // MARK: – Setup Player
    private func setupPlayer(with song: String) {
        guard let url = Bundle.main.url(forResource: song, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            
            player?.prepareToPlay()
        } catch {
            print("Ошибка плеера: ", error)
        }
    }
    
    // MARK: – Actions
    func play(playlist: Playlist, startIndex: Int) {
        self.currentPlaylist = playlist
        self.currentIndex = startIndex
        
        playTrack()
        
        NotificationCenter.default.post(name: .playerTrackChanged, object: currentTrack)
        sendIsPlayingState(with: true)
    }
    
    func next() {
        playNextTrack()
    }
    
    func previous() {
        guard let currentPlaylist else { return }
        
        if currentIndex > 0 {
            currentIndex -= 1
            playTrack()
        } else {
            currentIndex = currentPlaylist.tracks.count - 1
            playTrack()
        }
        
        NotificationCenter.default.post(name: .playerTrackChanged, object: currentTrack)
        
        sendIsPlayingState(with: true)
    }
    
    func pause() {
        guard let player else { return }
        if player.isPlaying {
            sendIsPlayingState(with: false)
            player.pause()
        } else {
            sendIsPlayingState(with: true)
            player.play()
        }
    }
    
    func seek(to time: TimeInterval) {
        player?.currentTime = time
    }
    
    // MARK: – Privates
    private func playTrack() {
        guard let currentPlaylist else { return }
        
        setupPlayer(with: currentPlaylist.tracks[currentIndex].songFileName ?? "")
        player?.play()
    }
    
    private func playNextTrack() {
        guard let currentPlaylist else { return }
        
        if currentIndex < currentPlaylist.tracks.count - 1 {
            currentIndex += 1
            playTrack()
        } else {
            currentIndex = 0
            playTrack()
        }
        
        NotificationCenter.default.post(name: .playerTrackChanged, object: currentTrack)
        
        sendIsPlayingState(with: true)
    }
    
    private func sendIsPlayingState(with isPlaying: Bool) {
        self.isPlaying = isPlaying
        NotificationCenter.default.post(name: .playerStateChanged, object: nil)
    }

}

// MARK: – AVAudioPlayerDelegate
extension AudioPlayerManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playNextTrack()
    }
}
