# Stream Deck Profiles — Complete Documentation

> Source: https://docs.elgato.com/stream-deck/profiles/getting-started/ and related sub-pages
> Compiled: 2026-06-04

---

## Table of Contents

1. [Getting Started](#1-getting-started)
2. [Packaging](#2-packaging)
3. [Profile Guidelines](#3-profile-guidelines)
4. [Icons — Getting Started](#4-icons--getting-started)
5. [Icons — API Glossary](#5-icons--api-glossary)
6. [Icon Guidelines](#6-icon-guidelines)
7. [Become a Maker](#7-become-a-maker)
8. [Maker Console — Getting Started](#8-maker-console--getting-started)
9. [Review Process](#9-review-process)
10. [Product Guidelines](#10-product-guidelines)

---

## 1. Getting Started

> Source: https://docs.elgato.com/stream-deck/profiles/getting-started/

A Stream Deck profile is a pre-configured layout of actions and functions designed around a specific software, tool, or game. These configurations enable users to bypass setup and begin working immediately with ready-made arrangements.

Profiles support diverse action types including hotkeys, multi-action keys, dial actions, text actions, and plugin actions. They incorporate page navigation and folder structures for organized layouts.

### Profile Capabilities

Profiles enable creators to:

- Customize and distribute Stream Deck action layouts
- Control games, home automation, hardware, software, and audio setups
- Provide pre-configured actions saving user setup time
- Map keys to software-specific hotkeys and shortcuts
- Integrate plugin actions directly into key and dial controls
- Share expert workflows with the broader community

### Device Compatibility

Profiles require specification for both operating system (macOS/Windows) and Stream Deck hardware model to ensure compatibility before download.

#### Supported Devices

**Primary Models:**

| Device | Keys | Layout |
|---|---|---|
| Stream Deck | 15 keys | 3×5 |
| Stream Deck Mini | 6 keys | 2×3 |
| Stream Deck Neo | 8 keys | 2×4 |
| Stream Deck + | 8 keys + 4 dials | 2×4 |
| Stream Deck XL | 32 keys | 4×8 |
| Stream Deck + XL | 38 keys + 6 dials | 4×9 |
| Galleon 100 SD | 12 keys + 2 dials | 3×4 |

**Additional Support:**

- Stream Deck Pedal (3 keys)
- Corsair Scimitar Elite (12 G Keys)
- Corsair K100 (1 G Key)

> **Note:** Stream Deck Studio operates via Companion and does not currently support app profiles.

### Third-Party Plugin Integration

Makers may feature other creators' plugins within profiles. However, plugin changes—including pricing, publishing status, or deprecation—directly impact profile users. Mutual agreement between makers is essential when cross-promoting plugins or icon packs.

### Key Limitations

| Limitation | Details |
|---|---|
| Compatibility Issues | Profiles may malfunction across different platforms or software versions, especially with platform-specific plugins |
| Hardware Scaling | Profiles don't auto-adjust for smaller devices; layouts may fail on incompatible hardware |
| Manual Updates Required | Users must manually re-download updated profile versions |
| Third-Party Dependencies | Software updates external to profiles can break integrated functionality |
| Plugin Requirements | Plugins used within a Profile are not transferred when the profile is shared |
| Environmental Variables | Firewall settings, permissions, and other installed software may affect performance |

---

## 2. Packaging

> Source: https://docs.elgato.com/stream-deck/profiles/packaging

Before sharing or submitting a Stream Deck profile to the Elgato Marketplace, creators must export and bundle it as a `.ZIP` file. Profile names should clearly indicate the device type (e.g., `MIDI Controller — Stream Deck XL`) to help users identify compatible versions.

### Exporting and Bundling Process

The packaging workflow involves four main steps:

1. **Edit Profile** — Right-click your device profile in the Stream Deck app and select "Edit Profile"
2. **Verify Information** — Confirm the profile name and details are accurate before exporting
3. **Export File** — Right-click the profile and choose "Export," preserving the `.streamDeckProfile` file extension
4. **Create ZIP Bundle** — Combine the `.streamDeckProfile` file with any supplementary materials into a single `.ZIP` file for Marketplace submission

### Supplementary Content Options

Creators can include additional files without limitations:

- Icon packs and graphics (`.streamDeckIconPack` format)
- Documentation files (README, licensing information)
- Setup guides and support materials
- Script files
- Installation executables and dependencies

#### Icon Pack Considerations

Exported icons are included automatically. When bundling separate icon packs, ensure each uses a unique UUID if also published separately on the Marketplace to prevent ownership conflicts.

### Update Distribution Model

Profiles require manual user re-downloads for updates; automatic updates are intentionally disabled to preserve any customizations users have made locally.

---

## 3. Profile Guidelines

> Source: https://docs.elgato.com/guidelines/stream-deck/profiles

This resource outlines standards for creating and submitting Stream Deck profiles to the Elgato Marketplace. Makers must ensure profiles are properly labeled for device types and operating systems, with complete and accurate information in the Maker Console.

### Icons

#### Requirements

- Incorporate custom icons to enhance your profile
- Avoid using icons or icon packs from other Makers without permission
- Do not feature icons in media images unless included in the actual profile
- Do not mention unavailable actions or features in descriptions

#### Recommendations

- Label folders with icons when organizing content through pagination
- Avoid leaving text actions empty without accompanying icons or buttons

### Supported Devices & OS

#### Requirements

- Label profiles by device, e.g. `World of Warcraft, Stream Deck XL.streamDeckProfile`
- Label profiles indicating OS-specific keys (Win or Cmd), e.g. `Star Citizen Profile, macOS.streamDeckProfile`
- Accurately list supported devices based on available profiles
- Do not claim device support for unsupported profiles
- Do not list operating systems without testing on them

#### Recommendations

- Use Virtual Stream Deck or Stream Deck Mobile canvas sizes for broader device compatibility
- Clearly specify OS support in titles, descriptions, and gallery images

### Additional Files

#### Requirements

- Include necessary files like shortcut configurations
- Document dependencies in product descriptions
- Provide links to dependencies on your product page

#### Prohibitions

- Do not bundle files you lack distribution rights for
- Do not include malicious files
- Do not advertise third-party websites or marketplaces

### General Guidelines

#### Requirements

- Use custom icons to complement profiles
- Label profiles by device type
- Indicate OS-specific commands in labeling
- List dependencies clearly

#### Prohibitions

- Do not use copyrighted materials or software screenshots
- Do not use other Makers' icons without permission
- Do not include unlicensed files in bundles

---

## 4. Icons — Getting Started

> Source: https://docs.elgato.com/stream-deck/icons/getting-started

Icon packs provide a method for distributing icons—both static and animated images—for Stream Deck keys and dials. Distributed as `.streamDeckIconPack` files, they can be shared independently or via Marketplace, becoming accessible through Stream Deck's Icon Library after installation.

### Formats

Icon pack images must meet these specifications:

| Property | Requirement |
|---|---|
| Dimensions | 144 × 144 px |
| Static formats | SVG, PNG, JPEG |
| Animated formats | GIF, WEBP |
| Filename length | ≤ 80 characters |

**Recommendations:**

- Use a frame rate of 10–20 fps for animated icons
- Keep animated icons ≤ 5 seconds

> **Note:** Stream Deck automatically scales images for different devices; separate sizes are unnecessary.

> **Warning:** Large animated icons can degrade performance. Maintain small file sizes (preferably ≤ 1 MB) for optimal user experience.

### Testing

#### Pre-packaging

Test icons before packaging by assigning them to Stream Deck actions:

1. Open Stream Deck app
2. Add any action from the action list to the canvas
3. Select the down chevron and choose **Set from file**
4. Select your icon

#### Post-packaging

Package icon packs using [Icon Pack Man](https://iconpackman.elgato.com/). Install the `.streamDeckIconPack` file by double-clicking:

1. Open Stream Deck app
2. Add any action from the action list to the canvas
3. Select the down chevron and choose **Open Stream Deck Icon Library**
4. Select your icon

Your icon pack should appear in the Icon Library alongside other installed packs.

### Publishing

Submit icon packs to Marketplace through Maker Console after review:

- Review [product guidelines](https://docs.elgato.com/guidelines/products) and [branding guidelines](https://docs.elgato.com/guidelines/branding)
- Explore [Maker Console](https://docs.elgato.com/maker-console/getting-started) and submit your icon pack

---

## 5. Icons — API Glossary

> Source: https://docs.elgato.com/stream-deck/icons/api

This reference document outlines the structure and metadata requirements for creating Stream Deck icon packs. The official tool for creation is [Icon Pack Man](https://iconpackman.elgato.com/).

### File Structure

Icon packs follow this directory layout:

```
.
├── icons/
│   └── ...
├── icon.svg
├── icons.json
├── license.txt
└── manifest.json
```

### Manifest Configuration

The `manifest.json` file defines the icon pack's properties and metadata:

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

#### Manifest Fields

| Field | Required | Purpose |
|---|---|---|
| Author | Yes | Maker name displayed in Stream Deck |
| Name | Yes | Pack name shown in Stream Deck |
| Description | No | Brief overview within the application |
| Version | Yes | Semantic versioning (e.g., `1.0.2`) |
| Icon | Yes | Path to 56×56 px pack thumbnail |
| URL | No | Information link about the pack |
| Licence | No | Path to license text file |

### Icons Folder

Contains all icon files in these formats: SVG, PNG, JPG, GIF, or WEBP. Recommended size is 144×144 px.

### Icons Metadata (icons.json)

Metadata file structure with searchable information:

```json
[
    { "path": "icon_1.svg", "name": "Train", "tags": ["travel"] },
    { "path": "icon_2.svg", "name": "Salad", "tags": ["food"] },
    { "path": "icon_3.svg", "name": "Bike",  "tags": ["travel", "sport"] }
]
```

#### Metadata Fields

| Field | Required | Purpose |
|---|---|---|
| path | Yes | Relative file path from icons folder |
| name | Yes | Display name for the icon |
| tags | Yes | Searchable keyword categories |

---

## 6. Icon Guidelines

> Source: https://docs.elgato.com/guidelines/stream-deck/icons

This guide covers creating, exporting, and submitting Stream Deck icons to the Elgato Marketplace, with emphasis on testing and ensuring accurate Maker Console information.

### Files and Packaging

#### Requirements

- Images must be 144 × 144 pixels
- Supported formats: SVG, PNG, JPEG (static); GIF, WEBP (animated)
- Filenames limited to 80 characters maximum
- Use reverse DNS format for identification (e.g., `com.iconpack.elgato`)

#### What to Avoid

- Low resolution images or screenshots
- Copyrighted materials or replica images without ownership rights
- Imagery that is hateful, violent, or explicit, or that may violate the Terms of Service

### Product Description

#### Recommendations

- Document actions, features, and icon categories (audio, smart home, streaming, etc.)
- Include total icon count with color variant breakdowns
- Specify whether icons are static, animated, or include blank variants
- Create showcase images displaying icon pack range

#### What to Avoid

- Featuring non-pack icons in thumbnails and galleries
- Selecting irrelevant or inappropriate tags

---

## 7. Become a Maker

> Source: https://docs.elgato.com/marketplace/become-a-maker

Got an idea? Share it with the Elgato community and reach millions of new customers. Set your own price, build your brand, and earn cash across the globe.

A Maker represents anyone creating for Marketplace, with the belief that everyone has the potential to become one.

### Publishing — Submission

Products are submitted through [Maker Console](https://maker.elgato.com/), a dedicated platform enabling creators to submit, manage, and update products.

**Getting Started Steps:**

1. Visit [Maker Console](https://maker.elgato.com/)
2. Create your organization
3. Sign the Maker Agreement

After setup, submit your first product for review.

> **Note:** Organization creation and Maker Agreement signature are required before product submission.

### Supported Products

| Category | Products |
|---|---|
| Stream Deck | Plugins, Profiles, Icons, Screensavers* |
| Wave Link | Audio effects (VSTs)*, EQ presets* |
| Camera Hub | LUTs*, Backgrounds* |
| Other | OBS scene collections (Marketplace Connect), 3D print files* |

*Requires email submission to maker@elgato.com

#### Submitting Unsupported Product Types

For unlisted product types, email [maker@elgato.com](mailto:maker@elgato.com) with subject line "New Product Submission" including:

**Required:**
- Product name
- Description (few sentences, up to 1,500 characters)
- Price (free or specific amount with currency)
- Media (1 thumbnail + minimum 3 gallery images)
- Product files

**Optional:**
- Additional links (website, support, setup guide, demo, privacy policy)
- Video (1920×1080 MP4, ≤50 MB with 1920×960 thumbnail)

### Country Limitations

Marketplace processes payouts via Stripe Connect. The following countries cannot list paid products but may list free ones:

- Bahrain
- Cuba
- Donetsk People's Republic
- Iran
- Jordan
- Kuwait
- Luhansk People's Republic
- North Korea
- Oman
- Russia
- Syria
- Tunisia

### FAQ

**What is the payout split with Elgato?**
Marketplace operates on a 70/30 payment split, wherein the product owner takes 70% and Elgato takes 30%.

**Does Elgato own my intellectual property after listing?**
No. Creators retain full ownership of all intellectual property published on Marketplace.

**Can I list products elsewhere simultaneously?**
Yes. Products may appear on other platforms, though consistent pricing across all stores is requested.

**How do I contact Elgato support?**
Join the [Marketplace Makers Discord Server](https://discord.gg/4rTB7cYzyj) or email [maker@elgato.com](mailto:maker@elgato.com).

---

## 8. Maker Console — Getting Started

> Source: https://docs.elgato.com/maker-console/getting-started

Maker Console is your central hub for managing your presence on Marketplace. This platform enables creators to oversee their Marketplace operations through a single dashboard.

### Key Capabilities

The console allows makers to:

- Establish and manage their organization
- Add and oversee team members
- Launch new products to Marketplace
- Release version updates for existing offerings
- Customize and maintain product listings
- Access performance metrics via analytics

### Getting Started Process

First-time users are asked to create an organization upon their initial login. This organizational structure represents how creators present themselves as marketplace vendors.

### For Returning Creators

Those who previously published items but lack current access should reach out to the support team at [maker@elgato.com](mailto:maker@elgato.com) with product ownership documentation and their associated account email address.

### Support Resources

For Maker Console questions or submission assistance, contact [maker@elgato.com](mailto:maker@elgato.com) or visit the community Discord server. General marketplace inquiries about accounts or refunds should go through Elgato Customer Support instead.

---

## 9. Review Process

> Source: https://docs.elgato.com/maker-console/review-process

All products submitted to Marketplace undergo a review process to ensure they meet quality and compliance standards.

### Key Timeline and Expectations

Makers should anticipate a **4–10 business day** review window for their submissions. The process evaluates multiple dimensions:

- Product quality and functionality
- Listing accuracy (names, descriptions, release notes)
- Media assets (images, videos) for legality and quality
- Device and operating system compatibility

> **Important:** All product submissions, including name, description, and any associated media, must be provided in English.

For hardware-dependent or paid-service-integrated products, creators must submit demonstration videos proving full functionality.

### Product Statuses

After review, submissions receive one of three designations:

| Status | Meaning |
|---|---|
| Published | Live on Marketplace (automatic unless opted out) |
| Approved | Ready for creator-initiated release |
| Rejected | Requires revisions and resubmission |

### Revision Process

Rejected submissions can be revised through the Maker Console by:

1. Navigating to **Products** → specific product → **Versions** tab
2. Selecting the rejected version
3. Uploading the revised file and resubmitting

Creators should review product-specific guidelines for Stream Deck plugins, profiles, and icons before submission to maximize approval likelihood.

---

## 10. Product Guidelines

> Source: https://docs.elgato.com/guidelines/products

This page establishes standards for products listed on Elgato Marketplace, covering names, descriptions, media, and metadata. Makers must review these guidelines before submitting products through Maker Console.

### Legal Obligations

Makers must own all rights to content posted, including names, descriptions, imagery, and product files. The Maker Agreement (available in organization Settings within Maker Console) contains additional legal requirements.

Elgato reserves the right to request guideline-compliant changes. Failure to comply may result in submission rejection or product removal.

### Name Requirements

**Must:**
- Be unique and ideally ≤ 30 characters
- Follow branding guidelines for Elgato product references
- Capitalize first letters and proper nouns
- Be in English (except branded/trademarked names)

**Cannot:**
- Infringe trademarks or copyrights
- Impersonate similar products
- Include maker name, price, or product category
- Use promotional language ("Top Quality," "Best Seller")
- Include special characters, emojis, plus signs (+), or multiple exclamation points

**Recommendations:**
- Use language like "inspired by" for trademarked content
- Choose relevant, distinct, creative, simple, and memorable names

### Description Requirements

Descriptions serve as secondary search identifiers. The first 250 characters carry the most weight.

**Must:**
- Contain minimum 250 characters (~2–4 sentences)
- Include keywords, features, actions, and requirements
- Use unformatted text in first 250 characters (used for search engines)
- Be in English

**Cannot:**
- Link to external paywalls
- Include random keywords at the end

**Recommendations:**
- Mention compatible software (Adobe Photoshop, Zoom)
- Use bullet points for features
- Provide setup tips

### App Icon Requirements

App icons display in marketplace searches and product detail pages.

**Must:**
- Use PNG format
- Be 288 × 288 pixels
- Feature product name/logo as primary focus
- Use bold, readable fonts

**Cannot:**
- Be animated
- Use copyrighted images without permission
- Include "Official" unless you are the IP owner
- Contain external website or social media links

### Thumbnail Requirements

Thumbnails appear throughout Marketplace and should be eye-catching and descriptive.

**Must:**
- Use PNG format
- Be 1920 × 960 pixels
- Accurately depict product and functionality
- Have clear, legible text
- Represent Elgato devices accurately
- Use English for text

**Cannot:**
- Use unowned imagery
- Feature low-quality screenshots

### Gallery Requirements

Products require 3 gallery items (up to 10 maximum).

**Must:**
- Include minimum 3 items
- Use PNG format (1920 × 960 px) for images
- Use MP4 format (1920 × 1080, < 250 MB) for videos
- Accurately depict product functionality
- Ensure text is legible
- Verify Elgato device accuracy
- Confirm AI-generated images are high-quality
- Use English text

**Cannot:**
- Use unowned imagery
- Include low-quality screenshots
- Overuse text (minimal text only)
- Copy other makers' images

**Recommendations:**
- Display customization options and color variations
- Show detailed feature images
- Include user interface screenshots
- Present product in real-world scenarios

### Pricing Requirements

Products may be free or paid, listed in local currency with automatic conversion at purchase.

**Must:**
- Match prices across platforms when applicable

**Cannot:**
- Use external paywalls (though external services may integrate)
- Redirect to third-party payment methods

**Recommendations:**
- Use standardized pricing ($3.99, $9.00)
- Consider free and paid variants

### Content Appropriateness

- Products should suit broad audiences
- Content unsuitable for certain audiences must be clearly labeled
- Products should be accessibility-friendly
- Content must not be inappropriate, offensive, or discriminatory
- Listings must respect all users and cultures
- Products must not cause user discomfort

### Data & Security

Your product must not compromise user safety or device integrity, including preventing overheating, unauthorized shutdowns, or harmful software. Products collecting data require explicit user consent and must provide privacy policies with data deletion options.

### Legal Compliance

Products must:

- Comply with all legal requirements and Elgato policies
- Be owned intellectual property of the maker
- Not infringe third-party protected material
- Meet local intellectual property laws

DMCA takedown requests are available for infringement claims.

---

## Reference Links

| Resource | URL |
|---|---|
| Profiles — Getting Started | https://docs.elgato.com/stream-deck/profiles/getting-started/ |
| Profiles — Packaging | https://docs.elgato.com/stream-deck/profiles/packaging |
| Profile Guidelines | https://docs.elgato.com/guidelines/stream-deck/profiles |
| Icons — Getting Started | https://docs.elgato.com/stream-deck/icons/getting-started |
| Icons — API Glossary | https://docs.elgato.com/stream-deck/icons/api |
| Icon Guidelines | https://docs.elgato.com/guidelines/stream-deck/icons |
| Become a Maker | https://docs.elgato.com/marketplace/become-a-maker |
| Maker Console — Getting Started | https://docs.elgato.com/maker-console/getting-started |
| Review Process | https://docs.elgato.com/maker-console/review-process |
| Product Guidelines | https://docs.elgato.com/guidelines/products |
| Icon Pack Man (tool) | https://iconpackman.elgato.com/ |
| Marketplace — Profiles | https://marketplace.elgato.com/stream-deck/profiles |
| Maker Console (portal) | https://maker.elgato.com/ |
