const fs = require("node:fs");
const path = require("node:path");

const root = path.resolve(__dirname, "..");
const required = [
  "README.md",
  "LICENSE",
  "package.json",
  ".codex-plugin/plugin.json",
  ".claude-plugin/plugin.json",
  ".claude-plugin/marketplace.json",
  "commands/improve-codebase-health.md",
  "docs/SETUP.md",
  "evals/evals.json",
  "skills/improve-codebase-health/SKILL.md",
  "skills/improve-codebase-health/references/architecture-depth.md",
  "skills/improve-codebase-health/references/ambiguity-rubric.md",
  "skills/improve-codebase-health/references/risk-framework.md",
  "skills/improve-codebase-health/references/safety-tiers.md",
  "skills/improve-codebase-health/references/scope-and-modes.md"
];

let failed = false;

for (const rel of required) {
  if (!fs.existsSync(path.join(root, rel))) {
    console.error(`Missing required file: ${rel}`);
    failed = true;
  }
}

JSON.parse(fs.readFileSync(path.join(root, "package.json"), "utf8"));
JSON.parse(fs.readFileSync(path.join(root, ".codex-plugin/plugin.json"), "utf8"));
JSON.parse(fs.readFileSync(path.join(root, ".claude-plugin/plugin.json"), "utf8"));
JSON.parse(fs.readFileSync(path.join(root, ".claude-plugin/marketplace.json"), "utf8"));
JSON.parse(fs.readFileSync(path.join(root, "evals/evals.json"), "utf8"));

if (failed) {
  process.exit(1);
}

console.log("check passed");
