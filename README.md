# Swift HTML -> Markdown
This package allows you to quicly convert HTML code into Markdown. Normally you want to go from Markdown -> HTML and there are a thousand packages and parsers to do that. However, what if the service you are using (like Mastodon) provides everything in HTML but you want to parse it in Markdown? Well you need to convert it. This package allows you to do just that!

## Supported Flavors of HTML
| Flavor               | Support                                             |
| -------------------- | --------------------------------------------------- |
| Mastodon Status HTML | ✅                                                  |
| Basic HTML           | ⚠️ (Almost fully supported, tables are not) |
