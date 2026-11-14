# Cleetus Host model endpoints

Generated from the Cleetus provider catalogue; do not edit by hand. Regenerate with `node scripts/generate-llm-endpoints.cjs`.

A Cleetus Host contacts a model endpoint only when you create a credit pool for it and enter a key. This list lets a security team
allowlist these hosts and tell Cleetus traffic apart from other LLM traffic. Requests use HTTPS on port 443 unless noted.

| Provider id | Provider | Host | Purpose |
| --- | --- | --- | --- |
| `gemini` | Google Gemini (AI Studio) | `generativelanguage.googleapis.com` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `groq` | Groq | `api.groq.com` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `cerebras` | Cerebras | `api.cerebras.ai` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `openrouter` | OpenRouter | `openrouter.ai` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `github_models` | GitHub Models | `models.github.ai` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `mistral` | Mistral (La Plateforme) | `api.mistral.ai` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `huggingface` | Hugging Face Inference Providers | `router.huggingface.co` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `nvidia_nim` | NVIDIA NIM (build.nvidia.com) | `integrate.api.nvidia.com` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `sambanova` | SambaNova Cloud | `api.sambanova.ai` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `cloudflare_workers_ai` | Cloudflare Workers AI | `api.cloudflare.com` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `cohere` | Cohere (compatibility API) | `api.cohere.ai` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `openai` | OpenAI (chat-completions compatible) | `api.openai.com` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `deepseek` | DeepSeek | `api.deepseek.com` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `xai` | xAI | `api.x.ai` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `together` | Together AI | `api.together.xyz` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `fireworks` | Fireworks AI | `api.fireworks.ai` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `perplexity` | Perplexity | `api.perplexity.ai` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `moonshot` | Moonshot AI (Kimi) | `api.moonshot.ai` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `qwen_dashscope` | Alibaba Qwen (DashScope, international) | `dashscope-intl.aliyuncs.com` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `zai` | Z.ai (GLM) | `api.z.ai` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `azure_openai` | Azure OpenAI | `<your-resource>.openai.azure.com (account-chosen name under a fixed Azure suffix)` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `ollama` | Ollama (local) | `127.0.0.1 (this computer)` port 11434 | Local model server; traffic stays on this computer. |
| `lm_studio` | LM Studio (local) | `127.0.0.1 (this computer)` port 1234 | Local model server; traffic stays on this computer. |
| `llama_cpp` | llama.cpp server (local) | `127.0.0.1 (this computer)` port 8080 | Local model server; traffic stays on this computer. |
| `vllm` | vLLM server (local) | `127.0.0.1 (this computer)` port 8000 | Local model server; traffic stays on this computer. |
| `anthropic` | Anthropic API | `api.anthropic.com` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |
| `openai_responses` | OpenAI Responses API | `api.openai.com` | Model requests (prompts, project content you allowed) and model listing, sent with the key you stored for the pool. |

## Vendor CLI engines

These engines run the vendor's own program, which chooses its own hosts. Cleetus does not list them; consult the vendor.

- `claude`: Claude (Claude Code CLI/SDK). Hosts: unknown to Cleetus.
- `codex`: Codex (Codex CLI). Hosts: unknown to Cleetus.
- `copilot`: GitHub Copilot (Copilot CLI over ACP). Hosts: unknown to Cleetus.

## Custom endpoints

A credit pool may point at a host that is not in this list. Cleetus labels it "unverified gateway", refuses IP addresses and names that
resolve to non-public addresses, and requires you to type the host name before saving it. Such hosts are not covered by this document.
