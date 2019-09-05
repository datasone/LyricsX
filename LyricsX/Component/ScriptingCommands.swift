//
//  ScriptingCommands.swift
//  LyricsX
//
//  Created by datasone on 3/9/2019.
//  Copyright © 2019 ddddxxx. All rights reserved.
//

import Foundation
import Cocoa
import MusicPlayer

class SetPlayerTrackCommand: NSScriptCommand {
    override func performDefaultImplementation() -> Any? {
        let params = self.evaluatedArguments
        var title = "", album = "", artist = "", url: URL? = nil, duration = 0.0
        if let args = params {
            if let TrackTitle = args["TrackTitle"] as? String {
                title = TrackTitle
            }
            if let TrackAlbum = args["TrackAlbum"] as? String {
                album = TrackAlbum
            }
            if let TrackArtist = args["TrackArtist"] as? String {
                artist = TrackArtist
            }
            if let fURL = args["URL"] as? String {
                url = URL(string: fURL)
            }
            if let TrackDuration = args["TrackDuration"] as? Double {
                duration = TrackDuration
            }
        }

        guard let player = AppController.shared.playerManager.player as? AppleScriptPlayer else {
            return nil
        }
        
        player.updatePlayerState(state: MusicPlaybackState.playing, position: 0)
        
        player.updateCurrentTrack(title: title, album: album, artist: artist, duration: duration, url: url)
        
        return nil
    }
}

class SetPlayerState: NSScriptCommand {
    override func performDefaultImplementation() -> Any? {
        let params = self.evaluatedArguments
        var isPlaying = false, position = 0.0
        if let args = params {
            if let IsPlaying = args["IsPlaying"] as? Bool {
                isPlaying = IsPlaying
            }
            if let Position = args["Position"] as? Double {
                position = Position
            }
        }
        guard let player = AppController.shared.playerManager.player as? AppleScriptPlayer else {
            return nil
        }
        
        player.updatePlayerState(state: isPlaying ? MusicPlaybackState.playing : MusicPlaybackState.paused, position: position)
        
        return nil
    }
}
