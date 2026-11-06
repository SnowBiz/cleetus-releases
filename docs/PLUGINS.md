# Plugins and hooks

_Read this guide on [cleetus.dev](https://cleetus.dev/docs/plugins/)._

Cleetus is built around a small core that engines, tools, slash commands, panels and hooks plug into. Your own plugins use the same API as the built-in ones, and anything a plugin registers works for Claude and Codex alike.

## Concepts

| Concept     | What it is                                                                          |
| ----------- | ----------------------------------------------------------------------------------- |
| **Engine**  | An adapter that runs a coding agent and translates its protocol into Cleetus events |
| **Session** | One conversation with one engine: transcript, permissions and usage                 |
| **Tool**    | A function you register. Every engine sees it on one local MCP server               |
| **Command** | A slash command in the chat, such as `/words`                                       |
| **Panel**   | A small web page opened from the chat header                                        |
| **Hook**    | A function at a named point that can change or block behaviour                      |

The API is versioned. Plugins declare the major version they target (`apiVersion`, currently `1`) and are rejected with a clear message if it doesn't match.

## Write a plugin

A plugin is a folder in the installation directory reported by Plugins. Shared application hosts use `<profile>/core/plugins/<name>/`, with a manifest and entry file. Third-party plugins start **disabled**; enable them in the Plugins view.

`cleetus-plugin.json`:

```json
{
  "id": "acme.wordcount",
  "name": "Word count",
  "version": "1.0.0",
  "apiVersion": "^1",
  "main": "index.cjs",
  "description": "Adds a /words command and a word_count tool.",
  "permissions": ["commands", "tools"]
}
```

`index.cjs`:

```js
exports.activate = (api) => {
  api.tools.register({
    name: "word_count",
    description: "Counts the words in a piece of text.",
    inputSchema: {
      type: "object",
      properties: { text: { type: "string" } },
      required: ["text"],
    },
    handler: ({ text }) => String(text.split(/\s+/).filter(Boolean).length),
  });
  api.commands.register({
    id: "words",
    title: "Word count",
    description: "Count words: /words some text",
    run: (args) => `${args.split(/\s+/).filter(Boolean).length} words`,
  });
};
exports.deactivate = () => {};
```

## Permissions

| Permission | Grants                                                                      |
| ---------- | --------------------------------------------------------------------------- |
| `engines`  | `api.engines.register(adapter)`                                             |
| `tools`    | `api.tools.register(definition)`                                            |
| `commands` | `api.commands.register(definition)`                                         |
| `panels`   | `api.panels.register(definition)`, `api.renderers.register(definition)`     |
| `hooks`    | `api.hooks.tap(name, fn)`                                                   |
| `events`   | `api.events.on(type, fn)`                                                   |
| `sessions` | `api.sessions.list()`, `.get(id)`, `.send(id, text)`                        |
| `settings` | `api.settings.register(definition)`                                         |
| `workflows` | `api.workflows` action catalog, actions, deny hooks and bounded events |
| `storage`  | `api.storage.get(key, fallback)`, `.set(key, value)`, private to the plugin |

Everything a plugin registers is tracked under its ID and removed when it's disabled, and activation errors are caught and reported. Permissions gate the Cleetus API, **not** Node.js: a plugin runs in the host and can use any Node API, so only enable code you trust.

## Hooks

Hooks run in priority order. Each gets a context object it can change; set `stop = true` to end the chain.

| Hook                 | Context                                           | Use it to                                                                 |
| -------------------- | ------------------------------------------------- | ------------------------------------------------------------------------- |
| `session.beforeSend` | `{ sessionId, text, attachments, session, stop }` | Rewrite a prompt, add context or block it                                 |
| `permission.decide`  | `{ sessionId, tool, input, decision, message }`   | Answer a permission request with `'allow'` or `'deny'`, without asking    |
| `tool.beforeCall`    | `{ name, args, sessionId, owner, deny }`          | Change a Cleetus tool's arguments, or set `deny` to a message to block it |

For example, a policy plugin that never lets agents read `.env` files:

```js
// Tool input shapes are each engine's own; check the fields your engines send.
api.hooks.tap("permission.decide", (ctx) => {
  const path = String(ctx.input?.file_path ?? ctx.input?.path ?? "");
  if (/(^|\/)\.env(\.|$)/.test(path)) {
    ctx.decision = "deny";
    ctx.message = "Environment files are off limits.";
  }
});
```

## Events

`api.events.on(type, fn)` receives normalized events: `session.created`, `session.state`, `session.settings`, `message.user`, `message.assistant`, `message.assistant.delta`, `message.thinking`, `tool.use`, `tool.result`, `permission.request`, `permission.resolved`, `usage.updated`, `turn.result`, `turn.complete`, `session.rewound` and `error`. Use `'*'` for all of them. `engine.raw` carries each engine's untranslated message. Every event has `schema`, `type`, `sessionId` and `ts`.

## Write an engine

An engine adapter is an object, registered with `api.engines.register(adapter)` from a plugin with the `engines` permission:

```js
{
  id: "myengine",
  name: "My Engine",
  apiVersion: 1,
  capabilities: { models: true, efforts: ["low", "high"], permissionModes: ["default"], resume: true, usage: false, tools: true, images: false, rewind: false },
  async probe() { return { available: true }; },
  async createSession(ctx) { /* return an engine session */ },
}
```

`ctx` gives you `cwd`, `options` (`model`, `effort`, `permissionMode`, `systemPromptAppend`), `resume`, `emit(type, fields)`, `raw(message)`, `requestPermission({ tool, input, title, description, reason })`, `onEngineSession(id)`, `mcpServers()` (including the Cleetus tools), `addUsage(delta)` and `log(message)`.

The session you return implements `send(prompt, { attachments, messageId })`, `interrupt()` and `close()`, and optionally `setModel`, `setEffort`, `setPermissionMode` and `rewind`. Translate your engine's output into the events above with `ctx.emit`, and route every tool request through `ctx.requestPermission` so your engine gets the same approvals as Claude and Codex.

[Architecture](ARCHITECTURE.md) · [Security model](SECURITY_MODEL.md) · [Cleetus accounts](https://cleetus.dev/docs/accounts/)

## Workflow actions and hooks

Hosts with the shared workflow runtime expose `api.workflows`. Declare
`workflows` in the manifest, plus `tools`, `hooks` or `events` for those APIs.
The action catalog is available through **Workflows → Action catalog** and the
existing `workflows.capabilities` API (`actionCatalog`; `actions` retains IDs).

```js
api.workflows.registerAction({
  id: "summarize", title: "Summarize input", kind: "deterministic",
  retrySafe: false,
  inputSchema: {
    type: "object", properties: { text: { type: "string", maxLength: 1000 } },
    required: ["text"], additionalProperties: false
  },
  outputSchema: {
    type: "object", properties: { length: { type: "integer", minimum: 0 } },
    required: ["length"], additionalProperties: false
  },
  run: async ({ text }, context) => {
    context.authorize();
    return { summary: "Counted input", evidence: [], outputs: { length: text.length } };
  }
});
```

For plugin `acme.example`, this registers `acme.example:summarize`. Actions have
explicit input/output contracts: objects with declared properties, bounded
strings/arrays, primitive types, enums and numeric bounds. This is a constrained
contract language, not all of JSON Schema. Use `additionalProperties:false` and
an explicit `required` array for objects. Output data is bounded, retained with
its step and available to declared dependents.

- `context.callTool(name, args)` uses the existing Core tool hooks and execution
  guard. It requires `tools` and accepts only tools registered by this plugin.
  Ordinary host tools that require an agent session remain unavailable here.
- `api.workflows.hook("beforeStep", callback)` requires `hooks`. Its detached
  context cannot rewrite execution; return `{deny:true}` to deny. Exceptions
  fail closed. Prefer the built-in `agent-task` for owned provider execution.
- `api.workflows.onChange(callback)` requires `events`. Notifications are
  coalesced, carry status metadata and cannot recursively emit workflow events.
- `api.workflows.registerEvent("source-updated")` requires `events` and returns
  `{name, emit}`. Its name is `acme.example.source-updated`. Emit with an open
  project and optional UUID event ID. Only previously reviewed enabled triggers
  dispatch; event data never interpolates workflow inputs. Emission originating
  from workflow execution/hooks is rejected. The API limits each owner to ten
  emissions per minute and all owners to sixty per host process.

Registrations and event handles retire on unload. An admitted DAG retains its
original handler references; unloading or replacing a plugin never swaps new
code into that run. New dispatch also checks its pinned action revision.
Unknown plugin effects, invalid output and uncertain cleanup are not retried.
A declared retry-safe action can request a bounded retry only by throwing an
error with `code: "WORKFLOW_RETRYABLE"`; that declaration is a trusted-code
contract, not proof of idempotency.

The Plugins view reports the actual installation directory. Shared application
hosts use `<profile>/core/plugins`; native IDE and extension profiles remain
independent. Enabling a plugin runs native Node code. API permissions and typed
contracts **do not sandbox** its filesystem, network, child processes or imports.

Trusted launchers may pass an explicit `pluginPolicy` to the shared application:
`{mode:"personal"}` preserves the existing enabled-plugin flow. In
`{mode:"enterprise"}`, a missing allowlist denies user plugins before loading;
entries must match `id`, `version` and `entrySHA256`. The entry digest does not
pin every transitive import or make a plugin safe. Organization membership does
not automatically supply this policy: managed deployment enforcement requires
an authoritative host policy integration. No such remote integration or
untrusted-plugin isolation is claimed by this API.
