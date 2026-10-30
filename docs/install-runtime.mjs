// Install the release-pinned Claude SDK separately from the Cleetus extension.
import { readFile, mkdir, writeFile, access } from 'node:fs/promises';
import { constants } from 'node:fs';
import { dirname, join, resolve } from 'node:path';
import { homedir } from 'node:os';
import { fileURLToPath } from 'node:url';
import { execFileSync } from 'node:child_process';
const here = dirname(fileURLToPath(import.meta.url));
const directory = resolve(process.env.CLEETUS_RUNTIME_DIR || join(homedir(), '.cleetus', 'runtime'));
const manifest = JSON.parse(await readFile(join(here, 'runtime-package.json'), 'utf8'));
const version = manifest.dependencies?.['@anthropic-ai/claude-agent-sdk'];
if (!/^\d+\.\d+\.\d+$/.test(version || '')) throw new Error('The runtime package must specify an exact SDK version.');
const runtimePackage = { name: 'cleetus-local-runtime', private: true, dependencies: { '@anthropic-ai/claude-agent-sdk': version } };
await mkdir(directory, { recursive: true });
await writeFile(join(directory, 'package.json'), JSON.stringify(runtimePackage, null, 2) + '\n');
const installArgs = ['install', '--include=optional', '--omit=dev', '--no-audit', '--no-fund', '--registry=https://registry.npmjs.org', '--prefix', directory];
if (process.platform === 'win32') {
  const candidates = [process.env.npm_execpath, join(dirname(process.execPath), 'node_modules', 'npm', 'bin', 'npm-cli.js')].filter(Boolean);
  let npmCli;
  for (const candidate of candidates) { try { await access(candidate, constants.R_OK); npmCli = candidate; break; } catch {} }
  if (!npmCli) throw new Error('Cannot locate the Node.js npm CLI. Use the documented PowerShell npm install command instead.');
  execFileSync(process.execPath, [npmCli, ...installArgs], { stdio: 'inherit' });
} else {
  execFileSync('npm', installArgs, { stdio: 'inherit' });
}
console.log(`Claude runtime installed separately in ${directory}`);
