# Product libraries

_Read this guide on [cleetus.dev](https://cleetus.dev/docs/libraries/)._

A product library links the design systems of several repositories that make up one product, such as responsive web, iOS and watchOS. It lets you compare token semantics, component roles and platform differences side by side.

![A product library linking repository design systems](screenshots/design-library.png)

1. Extract and curate each repository's design system.
2. Register real previews for each deployment and platform.
3. Link the checkouts into a product library.
4. Review shared semantics and platform differences, then give agents the relevant contract before they adopt changes.
5. Commit the intended artifacts and update each affected repository explicitly.

Checkout links are local to your machine. Portable library snapshots can be committed without absolute paths; relink the checkouts after cloning. A library never synchronizes source, publishes packages or rewrites consumers on its own.

## Keep systems in the repository

Save each design system with the repository that owns its implementation. Tokens, components, pages, assets, contracts, fixtures and rules are reviewable project files in `design/`, not entries in a Cleetus database.

## Before changing a shared component

Check its usage and impact first: review its stories and every consuming page, then update and test each application that adopts the change. That's what keeps the library reliable context for agents rather than a stale inventory.

[Cleetus Design](DESIGN.md) · [Live previews](ADAPTERS.md)
