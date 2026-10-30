# Preview adapters and stories

Design items should render the implementation your product uses. Adapters translate the shared design-library contract to the project's runtime; they do not replace the component with a drawing.

## Web

Register real component/page source with controlled fixtures, props, states and variants. A useful story represents a composed interface block and realistic states, including empty/loading/error behavior when relevant. Install project dependencies separately, then review the registered source in Component Studio or page review.

The web adapter builds source into an interactive browser sandbox. Use sample fixtures instead of live account secrets. Optional PNG snapshots support exports/comparison; live iteration does not require regenerating images. Existing Storybook targets can complement the fixture/preview workflow.

Component contracts describe intended usage, public props, platform implementation, source provenance and tokens. Agents should read these and inspect consumers before changing a shared block.

## iOS and watchOS

Native previews use real Debug story hosts and Xcode builds through an Apple adapter. Prepare the target/scheme and story entry points, install the required Simulator runtime, and use macOS with Xcode. A device hub/Simulator is the efficient native rendering surface; Cleetus does not need to emulate UIKit or SwiftUI in a webview.

Use dedicated preview configuration and fixed launch arguments. Keep normal application startup and Release behavior intact. Build logs and Simulator state help diagnose failures. A discovered Swift file is not proof that a native story compiled or rendered. Native build steps execute real local project code.

## Platform coverage

Keep web desktop/mobile breakpoints, iOS, watchOS and future platforms explicit in their systems and contracts. Share visual intent and token semantics while retaining appropriate platform implementations. Android source discovery is available; native Android rendering is not yet implemented.

[Design workflow](DESIGN.md) · [Product libraries](LIBRARIES.md) · [Troubleshooting](TROUBLESHOOTING.md)
