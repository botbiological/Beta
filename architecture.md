# Architecture Overview

## Presentation Layer
- UI screens live under `lib/view/` and are grouped by audience (User, Artist, Producer, DJ, Auth, Settings, etc.).
- Reusable widgets/components are kept under `lib/widgets/` and `lib/res/components/` to keep views lean and focused on layout logic.
- Responsive sizing helpers sit in `lib/utils/routes/responsive.dart` and are consumed across screens for consistent scaling.

## State & Services
- Viewmodels in `lib/viewmodel/` leverage `ChangeNotifier` + Provider for lightweight state management (e.g., `MusicPlayerService`, `LoginProvider`, `TrackViewmodel`).
- Data access/services live under `lib/services/` and `lib/repository/`, separating Firebase/network logic from the UI.

## Navigation
- Named routes are centralized in `lib/utils/routes/` (see `routes.dart` and `routes_name.dart`).
- Feature-specific flows also push pages directly via `MaterialPageRoute` when additional arguments/context are required.
- Artist discovery flow: `HomeView` (user) lists artists, and tapping an artist pushes `ArtistProfilePublicView` for the detailed profile experience.

## Theming
- Colors, typography, and shared visual tokens live inside `lib/res/components/app_color.dart` plus the global theme configuration to ensure consistent styling across modules.
