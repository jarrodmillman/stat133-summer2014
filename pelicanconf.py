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
#MENUITEMS = [('Course Information', 'http://berkeley-stat133.github.io/pages/info.html'),
#             ('Syllabus',
#             'http://berkeley-stat133.github.io/pages/syllabus.html'),
#             ('Lectures',
#             'http://berkeley-stat133.github.io/pages/lectures.html'),
#             ('Labs', 'http://berkeley-stat133.github.io/pages/labs.html'),
#             ('Cloud', 'http://berkeley-stat133.github.io/pages/cloud.html'),
#             ('Assignments',
#             'http://berkeley-stat133.github.io/pages/assignments.html'),]

DISPLAY_TAGS_ON_SIDEBAR = False

# Blogroll
LINKS =  (('Command line', 'http://jarrodmillman.github.io/cli-guide'),
          ('Python', 'http://docs.python.org/2/'),
          ('NumPy & SciPy', 'http://docs.scipy.org/'),
          ('matplotlib', 'http://matplotlib.org/'),
          ('Software Carpentry', 'http://software-carpentry.org'),)


CC_LICENSE = "CC-BY-NC-SA"
