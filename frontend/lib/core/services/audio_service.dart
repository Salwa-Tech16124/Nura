import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _player = AudioPlayer();
  final AudioPlayer _clickPlayer = AudioPlayer();
  final AudioPlayer _notificationPlayer = AudioPlayer();
  final AudioPlayer _sosPlayer = AudioPlayer();
  final AudioPlayer _voicePlayer = AudioPlayer();
  
  bool _hasPlayedStartup = false;

  // Paths relative to the assets/ directory
  static const String startupAssetPath = 'audio/startup.mp3';
  static const String clickAssetPath = 'audio/button_click.mp3';
  static const String notificationAssetPath = 'audio/notification.mp3';
  
  static const String sosBeepAssetPath = 'audio/countdown_beep.mp3';
  static const String sosSuccessAssetPath = 'audio/success.mp3';
  static const String sosCancelAssetPath = 'audio/cancel.mp3';
  
  static const String voiceMicStartAssetPath = 'audio/mic_start.mp3';
  static const String voiceListeningAssetPath = 'audio/listening.mp3';
  static const String voicePlayAssetPath = 'audio/voice_play.mp3';
  static const String voiceCallConnectAssetPath = 'audio/call_connect.mp3';
  static const String voiceCallEndAssetPath = 'audio/call_end.mp3';

  /// Plays the startup sound once. Subsequent calls do nothing.
  Future<void> playStartupSound() async {
    if (_hasPlayedStartup) return;
    _hasPlayedStartup = true;
    try {
      await _player.play(AssetSource(startupAssetPath));
    } catch (e) {
      // Gracefully catch and log if startup.mp3 doesn't exist yet
      debugPrint('AudioService: Startup sound playback skipped (file may be missing or unreadable): $e');
    }
  }

  /// Plays the button click sound. Stops the player first to allow rapid clicks.
  Future<void> playButtonClick() async {
    try {
      await _clickPlayer.stop();
      await _clickPlayer.play(AssetSource(clickAssetPath));
    } catch (e) {
      // Gracefully catch and log if button_click.mp3 doesn't exist yet
      debugPrint('AudioService: Click sound playback skipped (file may be missing or unreadable): $e');
    }
  }

  /// Plays the medication notification/reminder sound. Stops any previous playback to prevent overlap.
  Future<void> playNotificationSound() async {
    try {
      await _notificationPlayer.stop();
      await _notificationPlayer.play(AssetSource(notificationAssetPath));
    } catch (e) {
      // Gracefully catch and log if notification.mp3 doesn't exist yet
      debugPrint('AudioService: Notification sound playback skipped (file may be missing or unreadable): $e');
    }
  }

  /// Stops the notification/reminder sound.
  Future<void> stopNotificationSound() async {
    try {
      await _notificationPlayer.stop();
    } catch (e) {
      debugPrint('AudioService: Error stopping notification sound: $e');
    }
  }

  /// Plays the SOS warning beep sound. Stops first to allow rapid triggering.
  Future<void> playSosBeepSound() async {
    try {
      await _sosPlayer.stop();
      await _sosPlayer.play(AssetSource(sosBeepAssetPath));
    } catch (e) {
      debugPrint('AudioService: SOS warning beep sound skipped (file may be missing or unreadable): $e');
    }
  }

  /// Stops the SOS warning beep sound.
  Future<void> stopSosBeepSound() async {
    try {
      await _sosPlayer.stop();
    } catch (e) {
      debugPrint('AudioService: Error stopping SOS warning beep: $e');
    }
  }

  /// Plays the SOS success sound. Stops first to prevent overlap.
  Future<void> playSosSuccessSound() async {
    try {
      await _sosPlayer.stop();
      await _sosPlayer.play(AssetSource(sosSuccessAssetPath));
    } catch (e) {
      debugPrint('AudioService: SOS success sound skipped (file may be missing or unreadable): $e');
    }
  }

  /// Stops the SOS success sound.
  Future<void> stopSosSuccessSound() async {
    try {
      await _sosPlayer.stop();
    } catch (e) {
      debugPrint('AudioService: Error stopping SOS success sound: $e');
    }
  }

  /// Plays the SOS cancel sound.
  Future<void> playSosCancelSound() async {
    try {
      await _sosPlayer.stop();
      await _sosPlayer.play(AssetSource(sosCancelAssetPath));
    } catch (e) {
      debugPrint('AudioService: SOS cancel sound skipped (file may be missing or unreadable): $e');
    }
  }

  /// Plays the microphone start sound. Stops any previous voice playback to prevent overlap.
  Future<void> playVoiceMicStart() async {
    try {
      await _voicePlayer.stop();
      await _voicePlayer.play(AssetSource(voiceMicStartAssetPath));
    } catch (e) {
      debugPrint('AudioService: Mic start sound skipped (file may be missing or unreadable): $e');
    }
  }

  /// Stops the mic start sound.
  Future<void> stopVoiceMicStart() async {
    try {
      await _voicePlayer.stop();
    } catch (e) {
      debugPrint('AudioService: Error stopping mic start sound: $e');
    }
  }

  /// Plays the listening sound once.
  Future<void> playVoiceListeningSound() async {
    try {
      await _voicePlayer.stop();
      await _voicePlayer.play(AssetSource(voiceListeningAssetPath));
    } catch (e) {
      debugPrint('AudioService: Listening sound skipped (file may be missing or unreadable): $e');
    }
  }

  /// Stops the listening sound.
  Future<void> stopVoiceListeningSound() async {
    try {
      await _voicePlayer.stop();
    } catch (e) {
      debugPrint('AudioService: Error stopping listening sound: $e');
    }
  }

  /// Plays the voice play instruction sound.
  Future<void> playVoicePlaySound() async {
    try {
      await _voicePlayer.stop();
      await _voicePlayer.play(AssetSource(voicePlayAssetPath));
    } catch (e) {
      debugPrint('AudioService: Voice play guide sound skipped (file may be missing or unreadable): $e');
    }
  }

  /// Stops the voice play instruction sound.
  Future<void> stopVoicePlaySound() async {
    try {
      await _voicePlayer.stop();
    } catch (e) {
      debugPrint('AudioService: Error stopping voice play guide sound: $e');
    }
  }

  /// Plays the call connect sound.
  Future<void> playVoiceCallConnectSound() async {
    try {
      await _voicePlayer.stop();
      await _voicePlayer.play(AssetSource(voiceCallConnectAssetPath));
    } catch (e) {
      debugPrint('AudioService: Call connect sound skipped (file may be missing or unreadable): $e');
    }
  }

  /// Stops the call connect sound.
  Future<void> stopVoiceCallConnectSound() async {
    try {
      await _voicePlayer.stop();
    } catch (e) {
      debugPrint('AudioService: Error stopping call connect sound: $e');
    }
  }

  /// Plays the call end sound.
  Future<void> playVoiceCallEndSound() async {
    try {
      await _voicePlayer.stop();
      await _voicePlayer.play(AssetSource(voiceCallEndAssetPath));
    } catch (e) {
      debugPrint('AudioService: Call end sound skipped (file may be missing or unreadable): $e');
    }
  }

  /// Stops any currently playing audio on the main player.
  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (e) {
      debugPrint('AudioService: Error stopping audio: $e');
    }
  }

  /// Disposes the audio players.
  void dispose() {
    _player.dispose();
    _clickPlayer.dispose();
    _notificationPlayer.dispose();
    _sosPlayer.dispose();
    _voicePlayer.dispose();
  }
}
