# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'K. Jarrod Millman'
SITENAME = u"UC Berkeley's Statistics 133 (summer 2014)"
SITEURL = ''

TIMEZONE = 'US/Pacific'

DEFAULT_LANG = u'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True

THEME = '_theme/'

## Title menu options (this isn't necessary, but I wanted to have more control)
DISPLAY_CATEGORIES_ON_MENU = False
DISPLAY_PAGES_ON_MENU = True

DISPLAY_TAGS_ON_SIDEBAR = False

# Blogroll
LINKS =  (('Command line', 'http://www.jarrodmillman.com/commandline'),
          ('R home', 'http://www.r-project.org/'),
          ('R docs', 'http://cran.r-project.org/manuals.html'),
          ('R seek', 'http://rseek.org/'),
          ('Software Carpentry', 'http://software-carpentry.org'),)

PLUGIN_PATH = '_plugins/'
PLUGINS = ['latex']


CC_LICENSE = "CC-BY-NC-SA"
