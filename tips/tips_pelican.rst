
Run the pelican command to generate your site:: 

    pelican content


launch Pelican’s web server::: 

    pelican content

launch Pelican’s web server::: 

    pelican --listen

Preview your site by navigating to http://localhost:8000/ in your browser.



+-------------+-----------------------------------------------------------------+
| *Metadata*  | 	*Description*                                               |
+-------------+-----------------------------------------------------------------+
| title       | Title of the article or page                                    |
+-------------+-----------------------------------------------------------------+
| date        | Publication date (e.g., YYYY-MM-DD HH:SS)                       |
+-------------+-----------------------------------------------------------------+
| modified    | Modification date (e.g., YYYY-MM-DD HH:SS)                      |
+-------------+-----------------------------------------------------------------+
| tags        | Content tags, separated by commas                               |
+-------------+-----------------------------------------------------------------+
| keywords    | Content keywords, separated by commas (HTML content only)       |
+-------------+-----------------------------------------------------------------+
| category    | Content category (one only — not multiple)                      |
+-------------+-----------------------------------------------------------------+
| slug        | Identifier used in URLs and translations                        |
+-------------+-----------------------------------------------------------------+
| author      | Content author, when there is only one                          |
+-------------+-----------------------------------------------------------------+
| authors     | Content authors, when there are multiple                        |
+-------------+-----------------------------------------------------------------+
| summary     | Brief description of content for index pages                    |
+-------------+-----------------------------------------------------------------+
| lang        | Content language ID (en, fr, etc.)                              |
+-------------+-----------------------------------------------------------------+
| translation | If content is a translation of another (true or false)          |
+-------------+-----------------------------------------------------------------+
| status      | Content status: draft, hidden, or published                     |
+-------------+-----------------------------------------------------------------+
| template    | Name of template to use to generate content (without extension) |
+-------------+-----------------------------------------------------------------+
| save_as     | Save content to this relative file path                         |
+-------------+-----------------------------------------------------------------+
| url         | URL to use for this article/page                                |
+-------------+-----------------------------------------------------------------+

