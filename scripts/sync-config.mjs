/**
 * Propagates changes from project.config.json to all files that reference the plugin UUID.
 * Run with: npm run sync
 */
import { readFileSync, writeFileSync, readdirSync, renameSync, existsSync } from "node:fs";
import { createRequire } from "node:module";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const root = join(dirname(fileURLToPath(import.meta.url)), "..");
const cfg = createRequire(import.meta.url)("../project.config.json");

// ── Detect current UUID from manifest.json ───────────────────────────────────
const sdPluginDirs = readdirSync(root).filter((f) => f.endsWith(".sdPlugin"));
if (sdPluginDirs.length === 0) {
	console.error("No .sdPlugin directory found in project root.");
	process.exit(1);
}
const currentPluginDir = sdPluginDirs[0];
const currentUUID = currentPluginDir.replace(".sdPlugin", "");

if (currentUUID === cfg.uuid) {
	// UUID unchanged — only sync name/author/description in manifest
	syncManifestMeta();
	console.log("✓ Synced metadata (name, author, description, version) from project.config.json");
	process.exit(0);
}

// ── UUID changed — update all references ────────────────────────────────────
console.log(`Syncing UUID: ${currentUUID} → ${cfg.uuid}`);

/** Replace all occurrences of currentUUID with cfg.uuid in a file */
function replaceInFile(filePath) {
	if (!existsSync(filePath)) return;
	const original = readFileSync(filePath, "utf8");
	const updated = original
		.replaceAll(currentUUID, cfg.uuid)
		.replaceAll("Pomodoro Minimalist", cfg.name)
		.replaceAll("Abraham Orihuela", cfg.author)
		.replaceAll("A minimalist pomodoro for Stream Deck", cfg.description);
	if (updated !== original) {
		writeFileSync(filePath, updated, "utf8");
		console.log(`  updated: ${filePath.replace(root + "/", "")}`);
	}
}

// Update TypeScript source files
const srcDir = join(root, "src");
function walkAndReplace(dir) {
	for (const entry of readdirSync(dir, { withFileTypes: true })) {
		const full = join(dir, entry.name);
		if (entry.isDirectory()) walkAndReplace(full);
		else if (entry.name.endsWith(".ts")) replaceInFile(full);
	}
}
walkAndReplace(srcDir);

// Update manifest.json
replaceInFile(join(root, `${currentPluginDir}/manifest.json`));

// Update rollup.config.mjs (project.config.json handles it, but keep in sync)
replaceInFile(join(root, "rollup.config.mjs"));

// Rename .sdPlugin directory
const oldDir = join(root, currentPluginDir);
const newDir = join(root, `${cfg.uuid}.sdPlugin`);
renameSync(oldDir, newDir);
console.log(`  renamed: ${currentPluginDir} → ${cfg.uuid}.sdPlugin`);

console.log("✓ UUID sync complete. Run 'npm run build' to recompile.");

function syncManifestMeta() {
	const manifestPath = join(root, `${currentPluginDir}/manifest.json`);
	if (!existsSync(manifestPath)) return;
	const manifest = JSON.parse(readFileSync(manifestPath, "utf8"));
	manifest.Name = cfg.name;
	manifest.Author = cfg.author;
	manifest.Description = cfg.description;
	manifest.Version = cfg.version;
	writeFileSync(manifestPath, JSON.stringify(manifest, null, "\t") + "\n", "utf8");
}
