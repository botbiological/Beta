import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provide/model/mytrackmodel.dart';

class MusicPlayerService extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  MyTrack? _currentTrack;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  double _volume = 1.0;
  bool _isLoading = false;

  // Getters
  MyTrack? get currentTrack => _currentTrack;
  bool get isPlaying => _isPlaying;
  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;
  double get volume => _volume;
  bool get isLoading => _isLoading;
  bool get hasTrack => _currentTrack != null;

  MusicPlayerService() {
    _initializePlayer();
  }

  void _initializePlayer() {
    // Listen to player state changes
    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
    });

    // Listen to duration changes
    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        _totalDuration = duration;
        notifyListeners();
      }
    });

    // Listen to position changes
    _audioPlayer.positionStream.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });

    // Listen to completion
    _audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        _isPlaying = false;
        _currentPosition = Duration.zero;
        notifyListeners();
      }
    });
  }

  Future<void> playTrack(MyTrack track) async {
    try {
      _isLoading = true;
      notifyListeners();

      // If same track is playing, just toggle play/pause
      if (_currentTrack?.id == track.id) {
        if (_isPlaying) {
          await pause();
        } else {
          await resume();
        }
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Stop current track if any
      await stop();

      _currentTrack = track;

      // Use dummy MP3 files for demo
      // These are reliable public domain audio files
      final dummyUrls = [
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      ];
      
      // Select a dummy URL based on track id
      final trackIndex = int.tryParse(track.id) ?? 1;
      final audioUrl = track.audioUrl ?? dummyUrls[(trackIndex - 1) % dummyUrls.length];

      debugPrint('Loading track: ${track.title} from $audioUrl');
      
      await _audioPlayer.setUrl(audioUrl);
      await _audioPlayer.play();
      _isPlaying = true;
      
      debugPrint('Playing track: ${track.title}');
    } catch (e) {
      debugPrint('Error playing track: $e');
      _isPlaying = false;
      _currentTrack = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
      _isPlaying = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error pausing: $e');
    }
  }

  Future<void> resume() async {
    try {
      await _audioPlayer.play();
      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error resuming: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      _isPlaying = false;
      _currentPosition = Duration.zero;
      notifyListeners();
    } catch (e) {
      debugPrint('Error stopping: $e');
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _audioPlayer.seek(position);
      notifyListeners();
    } catch (e) {
      debugPrint('Error seeking: $e');
    }
  }

  Future<void> setVolume(double volume) async {
    try {
      _volume = volume.clamp(0.0, 1.0);
      await _audioPlayer.setVolume(_volume);
      notifyListeners();
    } catch (e) {
      debugPrint('Error setting volume: $e');
    }
  }

  void clearTrack() {
    _currentTrack = null;
    _currentPosition = Duration.zero;
    _totalDuration = Duration.zero;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
