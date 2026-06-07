# Stream Deck Icon Packs — Complete Documentation

> Source: https://docs.elgato.com/stream-deck/icons/getting-started/ and all sub-pages.
> Compiled: 2026-06-04

---

## Table of Contents

1. [Overview](#overview)
2. [Image Format Specifications](#image-format-specifications)
3. [Animated Icon Specifications](#animated-icon-specifications)
4. [File & Folder Structure (API Glossary)](#file--folder-structure-api-glossary)
5. [manifest.json Reference](#manifestjson-reference)
6. [icons.json Reference](#iconsjson-reference)
7. [Packaging & Testing](#packaging--testing)
8. [Icon Pack Guidelines](#icon-pack-guidelines)
9. [Submission Requirements](#submission-requirements)
10. [Review Process](#review-process)
11. [Managing Products](#managing-products)
12. [Maker Console](#maker-console)
13. [Organization & Members](#organization--members)
14. [Product Guidelines](#product-guidelines)
15. [Branding Guidelines](#branding-guidelines)
16. [Badges](#badges)
17. [Elgato Icons Resource](#elgato-icons-resource)
18. [Key Links](#key-links)

---

## Overview

Icon packs are an easy way to share icons, represented as static and animated images, for Stream Deck keys and dials. They are distributed as `.streamDeckIconPack` files and can be published standalone or through the Elgato Marketplace.

---

## Image Format Specifications

### Supported Formats

| Type | Formats |
|------|---------|
| Static | SVG, PNG, JPEG |
| Animated | GIF, WEBP |

### Dimensions

- **Required:** 144 × 144 pixels for all icon files
- Stream Deck will automatically scale images where necessary — you do not need to provide different sized images for different Stream Deck devices.

### Filename Rules

- Maximum filename length: **80 characters**
- Recommended naming convention: reverse DNS format (e.g., `com.iconpack.elgato`)

### File Size

- Preferred maximum: **1 MB** per icon file

### Prohibited Content

- Low-resolution images or screenshots
- Copyrighted materials or replica images without ownership rights
- Hateful, violent, explicit imagery, or content violating Elgato Terms of Service

---

## Animated Icon Specifications

| Property | Recommendation |
|----------|---------------|
| Frame rate | 10–20 fps |
| Duration | 5 seconds maximum |
| File size | 1 MB preferred |
| Formats | GIF, WEBP |

> **Warning:** Large animated icons can impact system performance. Keep file sizes as small as possible.

---

## File & Folder Structure (API Glossary)

> Source: https://docs.elgato.com/stream-deck/icons/api

Use [Icon Pack Man](https://iconpackman.elgato.com/) for actual pack creation rather than manual file assembly.

Recommended project directory layout:

```
.
├── icons/
│   └── (all icon files go here)
├── icon.svg
├── icons.json
├── license.txt
└── manifest.json
```

### File Descriptions

| File/Folder | Description |
|-------------|-------------|
| `icons/` | Directory containing all icon asset files |
| `icon.svg` | Pack thumbnail image (56 × 56 px) |
| `icons.json` | Metadata file providing name and tag information for each icon |
| `license.txt` | Licensing information for the pack |
| `manifest.json` | Pack definition and metadata |

---

## manifest.json Reference

The manifest JSON establishes the icon pack's identity and metadata.

### Example

```json
{
    "Name": "Awesome Icons",
    "Version": "1.0.0",
    "Description": "Awesome icons for making your Stream Deck look... awesome!",
    "Author": "John Doe",
    "URL": "https://www.elgato.com",
    "Icon": "icon.svg",
    "License": "license.txt"
}
```

### Field Definitions

| Field | Required | Description |
|-------|----------|-------------|
| `Author` | Yes | Maker's name; displayed in Stream Deck |
| `Name` | Yes | Pack name visible to users in Stream Deck |
| `Description` | No | Brief pack description shown in Stream Deck (may differ from Marketplace copy) |
| `Version` | Yes | Three numerical digits (e.g., `1.0.2`); semantic versioning recommended |
| `Icon` | Yes | Relative path to the 56 × 56 px pack representative image |
| `URL` | No | Link to an information resource |
| `Licence` | No | Relative path to a text file with licensing details |

---

## icons.json Reference

The `icons.json` file provides searchable metadata for each icon in the pack.

### Example

```json
[
    { "path": "icon_1.svg", "name": "Train",  "tags": ["travel"] },
    { "path": "icon_2.svg", "name": "Salad",  "tags": ["food"] },
    { "path": "icon_3.svg", "name": "Bike",   "tags": ["travel", "sport"] }
]
```

### Field Definitions

| Field | Required | Description |
|-------|----------|-------------|
| `path` | Yes | File location relative to the `icons/` folder |
| `name` | Yes | Display name of the icon |
| `tags` | Yes | Array of searchable category keywords |

---

## Packaging & Testing

### Tooling

Use **Icon Pack Man** (https://iconpackman.elgato.com/) to create `.streamDeckIconPack` files from your icon project directory.

### Pre-Packaging Test (individual icons)

Test icons directly in Stream Deck before packaging:

1. Open the Stream Deck app.
2. Add any action to the canvas.
3. Select the down chevron on the action and choose **Set from file**.
4. Select your icon file.

### Post-Packaging Test (full icon pack)

After creating the `.streamDeckIconPack` file with Icon Pack Man:

1. Double-click the `.streamDeckIconPack` file to install it.
2. Open the Stream Deck app.
3. Add any action to the canvas.
4. Select the down chevron on the action and choose **Open Stream Deck Icon Library**.
5. Locate and select your icon from the library.

---

## Icon Pack Guidelines

> Source: https://docs.elgato.com/guidelines/stream-deck/icons

### Files and Packaging Requirements

- Image dimensions: **144 × 144 px**
- Supported formats: SVG, PNG, JPEG (static); GIF, WEBP (animated)
- Filenames: maximum **80 characters**
- Naming convention: reverse DNS format (e.g., `com.iconpack.elgato`)

### Product Description Recommendations

- List actions, features, and icon types included in the pack
- State the total icon count with color variant breakdowns
- Specify whether icons are static, animated, or include blank/transparent variants
- Create showcase images that display the full range and diversity of the icon pack

### Avoid

- Featuring icons not included in the pack in thumbnails or gallery images
- Selecting irrelevant product tags
- Misrepresenting icon pack content in any way

---

## Submission Requirements

> Source: https://docs.elgato.com/maker-console/submitting-products

### Marketplace Accepts Icon Pack Submissions For

- Stream Deck icon packs (submitted directly through Maker Console)

### Required Materials for Submission

| Asset | Specification |
|-------|--------------|
| Product file | Packaged `.streamDeckIconPack` file |
| Name | Max 30 characters |
| Description | 250–1,500 characters |
| Thumbnail | PNG, 1920 × 960 px |
| Gallery items | Minimum 3 items; PNG 1920 × 960 px or MP4 1920 × 1080 px (under 250 MB) |
| Release notes | Required for each version submission |
| Additional links | Optional but recommended (e.g., support URL) |

### Step-by-Step Submission Process

1. Log into [Maker Console](https://maker.elgato.com).
2. Select **Create product**.
3. **Step 1 - Files:** Choose product type and upload the `.streamDeckIconPack` file.
4. **Step 2 - Details:** Confirm name, description, tags, pricing, and links.
5. **Step 3 - Media:** Upload thumbnail, gallery items, and release notes.
6. Submit for review.

> **Warning:** A product's name and monetization options cannot be changed in Maker Console after creation. Contact maker@elgato.com for modifications.

### Pricing Guidelines

- Products may be listed as free or paid.
- Pricing appears in local currency with automatic conversion at purchase.
- Use standardized pricing (e.g., $3.99, $9.00) — avoid irregular amounts.
- Prices must match across platforms if the product is available elsewhere.
- No external paywalls or third-party payment redirects.

---

## Review Process

> Source: https://docs.elgato.com/maker-console/review-process

### Timeline

Allow **4–10 working days** for a review. During peak periods, the full timeframe may apply.

### What Gets Reviewed

- Product quality and functionality
- Accuracy and legality of name, description, and release notes
- Associated media files (thumbnail, gallery images)
- Device compatibility and OS support listings
- Language compliance (all submissions must be in English)

### Language Requirement

All product submissions — including name, description, and any associated media (thumbnail, gallery images) — must be provided in **English**.

### Special Requirements

Products that require hardware or paid service integrations must include a **demonstration video** proving full functionality.

### Product Statuses After Review

| Status | Meaning |
|--------|---------|
| **Published** | Live on Marketplace (automatic unless opted out) |
| **Approved** | Ready for maker-initiated manual release |
| **Rejected** | Requires revisions and resubmission |

### Revision Process

Makers can address review feedback by either:
- Creating a **new version**, or
- Submitting a **revision of the rejected version** through the Versions tab in Maker Console.

---

## Managing Products

> Source: https://docs.elgato.com/maker-console/managing-products

Products are managed through [Maker Console](https://maker.elgato.com).

> **Note:** Changes made in Maker Console may take a few hours to reflect on Marketplace.

### Accessing Products

Log into Maker Console and navigate to **Products** to view all items (draft, published, unpublished). Select a product to update details or submit a new version.

- **Card View:** Visual list showing name, extension type, and publish status.
- **List View:** Table format showing name, extension type, publish status, and last published date.

### Editable Details

- Description
- Language (supported languages list)
- Type (category: Audio, Development, etc.)
- Additional Links (support resources)

### Media Management

Managed via the **Media** tab on the product page. Editable items:

- Thumbnail
- Icon previews (icon packs only)
- Gallery images

> **Note:** It is not currently possible to re-arrange or sort gallery items. To change order, remove and re-add them in the preferred order.

### Version Management

The **Versions** tab shows all past and present versions. Capabilities:

- Submit a new version
- View version status
- Download previous versions
- View release notes from previous versions

> **Note:** Only the most recent approved version of a product is available to users on Marketplace.

#### Creating a New Version

1. In the **Versions** tab, select **Create version**.
2. Upload the new product file.
3. Add release notes.
4. Configure automatic publication preference.

#### Scheduling a Go-Live Date

For a specific release date (e.g., for a marketing campaign):

1. Uncheck **Automatically publish after being approved**.
2. After approval, manually release via the **Release** button in the Versions tab.
3. Allow sufficient review time — up to 4–10 business days during busy periods.

---

## Maker Console

> Source: https://docs.elgato.com/maker-console/getting-started

Maker Console is the management dashboard for Marketplace, designed for Makers to submit and manage their products.

### Capabilities

- Establish and oversee Maker organizations
- Add or remove team members
- Launch new Marketplace listings
- Release product version updates
- Edit existing listings
- Monitor analytics on product performance

### Getting Started

New users must create an organization upon initial login. This organization represents their creator identity within the Marketplace.

### Account Recovery

Creators who have lost account access should contact maker@elgato.com with:
- Proof of product ownership
- Associated email address

### Support Channels

- Email: maker@elgato.com (for Maker-specific matters)
- Community Discord server for peer support
- General Marketplace inquiries route to Elgato Customer Support

---

## Organization & Members

> Source: https://docs.elgato.com/maker-console/organization

Organizations (also called Makers) represent you as a creator or business on Marketplace. Public profiles are created automatically and are accessible via a unique handle (e.g., `https://marketplace.elgato.com/@elgato`).

### Profile Settings

Manage via **Settings** in Maker Console navigation:

- Update profile picture and description
- Manage social links
- Choose preferred support method (link or email)
- Access Stripe Connect account
- View the latest Maker Agreement

### Member Management

Organizations support multiple members. Manage via **Members** in Maker Console navigation:

- View current members
- Invite new members (invitation links expire after 24 hours)
- Update member roles
- Remove members

### Role Permissions

#### Products

| Permission | Leader | Admin | Member |
|------------|--------|-------|--------|
| Create new products | Yes | Yes | Yes |
| Manage existing products | Yes | Yes | Yes |
| View product analytics | Yes | Yes | Yes |

#### Organization

| Permission | Leader | Admin | Member |
|------------|--------|-------|--------|
| Edit organization profile | Yes | Yes | No |
| Delete organization | Yes | No | No |

#### Members

| Permission | Leader | Admin | Member |
|------------|--------|-------|--------|
| Invite members | Yes | Yes | No |
| Remove members | Yes | Yes | No* |
| Change member roles | Yes | Yes | No |
| View invite activity | Yes | Yes | No |

*Members can remove themselves from an organization.

#### Stripe and Monetization

| Permission | Leader | Admin | Member |
|------------|--------|-------|--------|
| View financial reports | Yes | Yes | No |
| Manage Stripe Connect settings | Yes | No | No |

### Assistance

For organization changes (Stripe support, access, membership, display name change), contact maker@elgato.com.

---

## Product Guidelines

> Source: https://docs.elgato.com/guidelines/products

### Legal Obligations

Makers must own all content rights — names, descriptions, imagery, and product files. Elgato reserves the right to request changes; non-compliance may result in submission rejection or product removal.

### Name Requirements

| Rule | Detail |
|------|--------|
| Uniqueness | Must be unique |
| Max length | 30 characters |
| Language | English (except brand/trademark names) |
| Capitalization | Capitalize first letter and proper nouns |

**Name Prohibitions:**

- No trademark infringement or copyright violations
- No impersonation of existing products
- No maker names included in product name
- No pricing references or category labels
- No promotional language ("Best Seller," "Top Quality")
- No special characters, emojis, or plus signs
- Maximum one exclamation point

**Name Recommendations:**

- Use "inspired by" or "from the world of" for trademark references
- Ensure name is relevant to product function
- Prioritize distinctiveness and creativity
- Use simple, memorable language
- Contact maker@elgato.com for name changes post-creation

### Description Guidelines

| Rule | Detail |
|------|--------|
| Minimum | 250 characters (~2–4 sentences) |
| Maximum | 1,500 characters |
| SEO | First 250 characters carry the most SEO weight |
| Language | English |

**Description Requirements:**

- Include keywords, features, actions, and requirements
- Use unformatted text in the first 250 characters
- No external paywall links
- No random keyword stuffing

**Description Recommendations:**

- Mention software names the product integrates with (e.g., Adobe Photoshop, Zoom)
- Use bullet points for features and actions
- Provide setup tips
- Avoid filler text, lengthy explanations, or AI-generated inaccurate content

### App Icon Specifications

| Property | Value |
|----------|-------|
| Dimensions | 288 × 288 px |
| Format | PNG (static only — no animations) |

**App Icon Requirements:**

- Make the product name or logo the focal point
- Use bold, readable fonts
- No copyrighted images without ownership
- No "Official" terminology (unless IP owner)
- No external website or social media links

### Thumbnail Specifications

| Property | Value |
|----------|-------|
| Dimensions | 1920 × 960 px |
| Format | PNG |

**Thumbnail Requirements:**

- Accurately depict product and functionality
- Ensure legible text throughout the image
- Represent Elgato devices accurately
- Use English for text content
- No non-owned imagery
- No low-quality screenshots

### Gallery Requirements

| Property | Value |
|----------|-------|
| Minimum items | 3 |
| Maximum items | 10 |
| Image format | PNG, 1920 × 960 px |
| Video format | MP4, 1920 × 1080 px, under 250 MB |

**Gallery Requirements:**

- Accurately depict product and functionality
- Ensure legible text and clear imagery
- Represent Elgato devices accurately
- AI-generated images must be high-quality and fully legible
- Use English for text content
- No non-owned imagery
- No low-quality screenshots
- No excessive text (use the description field instead)
- No copying other makers' images

**Gallery Recommendations:**

- Display customization options (colors, variations)
- Highlight unique features in separate images
- Include UI/UX screenshots for software products
- Show products in real-world usage scenarios

### Content Appropriateness

- Products must be suitable for broad audiences with child safety prioritized
- Clear labeling required for age-inappropriate content
- Accessibility-friendly design required
- No inappropriate, offensive, or discriminatory content
- Not designed to cause user discomfort

### Data & Security Requirements

- Products must not compromise user safety or device integrity
- No overheating, unauthorized shutdowns, or harmful software
- Explicit user consent required for data collection
- Necessary security measures to prevent unauthorized access
- Privacy policy required when collecting personally identifiable data
- Must provide an easy way for users to request data deletion

### Legal Requirements

- Compliance with all legal requirements and Elgato policies
- Full ownership of product intellectual property
- No third-party intellectual property infringement
- Responsibility for local IP law compliance

**IP Dispute Resolution:**

1. Contact the maker directly to resolve.
2. If unsuccessful, file a DMCA takedown request.

---

## Branding Guidelines

> Source: https://docs.elgato.com/guidelines/branding

Use the correct terminology when referring to Elgato products in submissions and documentation.

### Brand Name Spellings

| Correct | Incorrect |
|---------|-----------|
| Elgato | ElGato, El gato |
| Marketplace | marketplace (generic) |
| Maker Console | maker console |
| Stream Deck | StreamDeck |
| Stream Deck + | Stream Deck+, Stream Deck Plus |
| Stream Deck Mobile | Streamdeck Mobile |
| Stream Deck MK.2 | Stream Deck MK2 |
| plugin | plug-in |

### Hardware Component Terminology

| Term | Definition |
|------|-----------|
| Keys | Physical buttons on Stream Deck |
| Dial | Physical rotating components on Stream Deck + |
| Touch strip | Stream Deck + specific touch-sensitive strip |

---

## Badges

> Source: https://docs.elgato.com/resources/badges

Badges are provided for linking to Marketplace products and may be embedded on external websites or in documentation.

### Marketplace Badges

Available in the following variants:

- **Format:** SVG (light/dark) and PNG (light/dark)
- **Languages:** 13 localized versions — Deutsch (DE), English (EN), Español (ES), Français (FR), Italiano (IT), 日本語 (JP), 한국어 (KO), Nederlands (NL), Polski (PL), Português (PT), Русский (RU), Svenska (SV), 中文 (ZH)
- All variants available as a single ZIP download

### Stream Deck Badges

- Available in SVG (light/dark) and PNG (light/dark)
- Link to the Stream Deck homepage on elgato.com

### Usage Standards

Per Elgato graphic standards:

- Minimum clear space equals one-quarter the badge height; avoid placing graphics or text inside this space
- Minimum onscreen height: **40 pixels**
- Size should maintain legibility without dominating the layout

### Implementation Example

```html
<a href="https://marketplace.elgato.com/product/your-product" target="_blank" rel="noopener noreferrer">
  <img src="badge-light.svg" alt="Available on Elgato Marketplace" />
</a>
```

---

## Elgato Icons Resource

> Source: https://docs.elgato.com/resources/icons

Elgato provides an official icon library via the npm package `@elgato/icons`. This library uses the same design language as Elgato's own products.

### Package

```
@elgato/icons
```

### Features

- Importable JavaScript variables
- React components
- Mix, match, and curate custom icon packs based on Elgato's design language
- Used throughout the Elgato ecosystem: Stream Deck, Wave Link, Camera Hub, Capture, and Marketplace

### Icon Categories (partial list)

- Accessibility icons
- Action and action-wheel icons
- Navigation elements (arrows, chevrons, directional indicators)
- UI controls (buttons, checkmarks, toggles, sliders)
- Media and content (camera, video, audio, image icons)
- Application logos (Adobe suite, Google products, Discord, GitHub, etc.)
- Device icons (keyboard, headphones, displays, laptops)
- Hardware product icons (Key Light, Light Strip, Facecam variants)

---

## Key Links

| Resource | URL |
|----------|-----|
| Getting Started | https://docs.elgato.com/stream-deck/icons/getting-started |
| API Glossary | https://docs.elgato.com/stream-deck/icons/api |
| Icon Pack Man (packaging tool) | https://iconpackman.elgato.com/ |
| Maker Console | https://maker.elgato.com |
| Marketplace — Icon Packs | https://marketplace.elgato.com/stream-deck/icons |
| Guidelines — Products | https://docs.elgato.com/guidelines/products |
| Guidelines — Branding | https://docs.elgato.com/guidelines/branding |
| Guidelines — Stream Deck Icons | https://docs.elgato.com/guidelines/stream-deck/icons |
| Review Process | https://docs.elgato.com/maker-console/review-process |
| Submitting Products | https://docs.elgato.com/maker-console/submitting-products |
| Managing Products | https://docs.elgato.com/maker-console/managing-products |
| Organization | https://docs.elgato.com/maker-console/organization |
| Elgato Icons npm package | https://docs.elgato.com/resources/icons |
| Badges | https://docs.elgato.com/resources/badges |
| Contact Elgato Maker Support | mailto:maker@elgato.com |
