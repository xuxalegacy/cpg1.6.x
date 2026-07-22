##  ********************************************
##  Coppermine Photo Gallery
##  ************************
##  v1.0 originally written by Gregory Demar
##
##  @copyright  Copyright (c) 2003-2024 Coppermine Dev Team
##  @license    GNU General Public License version 3 or later; see LICENSE
##
##  ********************************************
##  sql/schema.sql
##  @since  1.6.27
##  ********************************************

#
# Table structure for table CPG_albums
#
CREATE TABLE CPG_albums (
  aid int(11) NOT NULL auto_increment,
  title varchar(255) NOT NULL default '',
  description text NOT NULL,
  visibility int(11) NOT NULL default '0',
  uploads enum('YES','NO') NOT NULL default 'NO',
  comments enum('YES','NO') NOT NULL default 'YES',
  votes enum('YES','NO') NOT NULL default 'YES',
  pos int(11) NOT NULL default '0',
  category int(11) NOT NULL default '0',
  owner int(11) NOT NULL DEFAULT '1',
  thumb int(11) NOT NULL default '0',
  keyword VARCHAR( 50 ),
  alb_password VARCHAR( 32 ),
  alb_password_hint TEXT,
  moderator_group INT NOT NULL default 0,
  alb_hits INT( 10 ) NOT NULL default 0,
  PRIMARY KEY  (aid),
  KEY alb_category (category),
  KEY `moderator_group` (`moderator_group`),
  KEY `visibility` (`visibility`)
)  COMMENT='Used to store albums';
# --------------------------------------------------------

#
# Table structure for table CPG_banned
#
CREATE TABLE CPG_banned (
        ban_id int(11) NOT NULL auto_increment,
        user_id int(11) DEFAULT NULL,
        user_name varchar(255) NOT NULL default '',
        email varchar(255) NOT NULL default '',
        ip_addr tinytext,
        expiry datetime DEFAULT NULL,
        brute_force tinyint(5) NOT NULL default '0',
        PRIMARY KEY  (ban_id)
)  COMMENT='Data about banned users';
#---------------------------------------------------------


#
# Table structure for table CPG_bridge
#
CREATE TABLE CPG_bridge (
  name varchar(40) NOT NULL default '0',
  value varchar(255) NOT NULL default '',
  UNIQUE KEY name (name)
)  COMMENT='Stores the bridging data, not used when unbridged';
# --------------------------------------------------------

#
# Table structure for table CPG_categories
#
CREATE TABLE CPG_categories (
  cid int(11) NOT NULL auto_increment,
  owner_id int(11) NOT NULL default '0',
  name varchar(255) NOT NULL default '',
  description text NOT NULL,
  pos int(11) NOT NULL default '0',
  parent int(11) NOT NULL default '0',
  thumb int(11) NOT NULL default '0',
  lft mediumint(8) unsigned NOT NULL default '0',
  rgt mediumint(8) unsigned NOT NULL default '0',
  depth tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (cid),
  KEY cat_parent (parent),
  KEY cat_pos (pos),
  KEY cat_owner_id (owner_id),
  KEY `depth_cid` (`depth`,`cid`),
  KEY `lft_depth` (`lft`,`depth`)
)  COMMENT='Used to store categories';
# --------------------------------------------------------

#
# Table structure for table CPG_categorymap
#
CREATE TABLE IF NOT EXISTS `CPG_categorymap` (
  cid int(11) NOT NULL,
  group_id int(11) NOT NULL,
  PRIMARY KEY  (cid,group_id)
)  COMMENT='Holds the categories where groups can create albums';
# --------------------------------------------------------

#
# Table structure for table CPG_comments
#
CREATE TABLE CPG_comments (
  pid mediumint(10) NOT NULL default '0',
  msg_id mediumint(10) NOT NULL auto_increment,
  msg_author varchar(25) NOT NULL default '',
  msg_body text NOT NULL,
  msg_date datetime NOT NULL default '1000-01-01 00:00:00',
  msg_raw_ip tinytext,
  msg_hdr_ip tinytext,
  author_md5_id varchar(32) NOT NULL default '',
  author_id int(11) NOT NULL default '0',
  approval enum('YES','NO') NOT NULL default 'YES',
  spam enum('YES','NO') NOT NULL default 'NO',
  PRIMARY KEY  (msg_id),
  KEY com_pic_id (pid),
  KEY author_id (author_id)
)  COMMENT='Used to store comments made on pics';
# --------------------------------------------------------

#
# Table structure for table CPG_config
#
CREATE TABLE CPG_config (
  name varchar(40) NOT NULL default '',
  value varchar(255) NOT NULL default '',
  PRIMARY KEY  (name)
  )  COMMENT='Used to store the configuration options';
# --------------------------------------------------------


#
# Table structure for table CPG_dict
#
CREATE TABLE CPG_dict (
  keyId bigint(20) NOT NULL auto_increment,
  keyword varchar(60) NOT NULL,
  PRIMARY KEY  (keyId),
  UNIQUE KEY (keyword)
)  COMMENT='Holds the keyword dictionary';
# --------------------------------------------------------

#
# Table structure for table CPG_ecards
#
CREATE TABLE CPG_ecards (
  eid int(11) NOT NULL auto_increment,
  sender_name varchar(50) NOT NULL default '',
  sender_email text NOT NULL,
  recipient_name varchar(50) NOT NULL default '',
  recipient_email text NOT NULL,
  link text NOT NULL,
  date tinytext NOT NULL,
  sender_ip tinytext NOT NULL,
  PRIMARY KEY  (eid)
)  COMMENT='Used to log ecards';
# --------------------------------------------------------

#
# Table structure for table CPG_exif
#
CREATE TABLE CPG_exif (
  `pid` int(11) NOT NULL,
  `exifData` text NOT NULL,
  PRIMARY KEY (`pid`)
)  COMMENT='Stores EXIF data from individual pics';
# --------------------------------------------------------

#
# Table structure for table CPG_favpics
#
CREATE TABLE CPG_favpics (
`user_id` INT( 11 ) NOT NULL ,
`user_favpics` TEXT NOT NULL ,
PRIMARY KEY ( `user_id` )
)  COMMENT = 'Stores the server side favourites';
# --------------------------------------------------------

#
# Table structure for table CPG_filetypes
#
CREATE TABLE IF NOT EXISTS CPG_filetypes (
  extension char(7) NOT NULL default '',
  mime char(254) default NULL,
  content char(15) default NULL,
  player varchar(5) default NULL,
  PRIMARY KEY (extension)
)  COMMENT='Used to store the file extensions';
# --------------------------------------------------------

#
# Table structure for table CPG_hit_stats
#
CREATE TABLE CPG_hit_stats (
  `sid` int(11) NOT NULL auto_increment,
  `pid` varchar(100) NOT NULL default '',
  `ip` varchar(40) NOT NULL default '',
  `search_phrase` varchar(255) NOT NULL default '',
  `sdate` bigint(20) NOT NULL default '0',
  `referer` text NOT NULL,
  `browser` varchar(255) NOT NULL default '',
  `os` varchar(50) NOT NULL default '',
  `uid` INT(11) NOT NULL default '0',
  PRIMARY KEY  (`sid`)
)  COMMENT='Detailed stats about hits, only used when enabled';
# --------------------------------------------------------

#
# Table structure for table CPG_languages
#
CREATE TABLE CPG_languages (
  lang_id  varchar(40) NOT NULL default '',
  english_name varchar(70) default NULL,
  native_name varchar(70) default NULL,
  custom_name varchar(70) default NULL,
  flag varchar(15) default NULL,
  abbr varchar(15) NOT NULL default '',
  available enum('YES','NO') NOT NULL default 'NO',
  enabled enum('YES','NO') NOT NULL default 'NO',
  complete enum('YES','NO') NOT NULL default 'NO',
  PRIMARY KEY (lang_id)
)  COMMENT='Contains the language file definitions';
# --------------------------------------------------------

#
# Table structure for table CPG_pictures
#
CREATE TABLE CPG_pictures (
  pid int(11) NOT NULL auto_increment,
  aid int(11) NOT NULL default '0',
  filepath varchar(255) NOT NULL default '',
  filename varchar(255) NOT NULL default '',
  filesize int(11) NOT NULL default '0',
  total_filesize int(11) NOT NULL default '0',
  pwidth smallint(6) NOT NULL default '0',
  pheight smallint(6) NOT NULL default '0',
  hits int(10) NOT NULL default '0',
  mtime datetime NOT NULL default '1000-01-01 00:00:00' ,
  ctime int(11) NOT NULL default '0',
  owner_id int(11) NOT NULL default '0',
  pic_rating int(11) NOT NULL default '0',
  votes int(11) NOT NULL default '0',
  title varchar(255) NOT NULL default '',
  caption text NOT NULL,
  keywords varchar(255) NOT NULL default '',
  approved enum('YES','NO') NOT NULL default 'NO',
  galleryicon int(11) NOT NULL default '0',
  user1 varchar(255) NOT NULL default '',
  user2 varchar(255) NOT NULL default '',
  user3 varchar(255) NOT NULL default '',
  user4 varchar(255) NOT NULL default '',
  url_prefix tinyint(4) NOT NULL default '0',
  pic_raw_ip tinytext,
  pic_hdr_ip tinytext,
  lasthit_ip tinytext,
  position INT(11) NOT NULL default '0',
  PRIMARY KEY  (pid),
  KEY owner_id (owner_id),
  KEY pic_hits (hits),
  KEY pic_rate (pic_rating),
  KEY aid_approved (aid, approved),
  KEY pic_aid (aid, pid),
  guest_token varchar(32) default ''
)  COMMENT='Used to store data about individual pics';
# --------------------------------------------------------

#
# Table structure for table CPG_plugins
#
CREATE TABLE CPG_plugins (
  plugin_id int(10) unsigned NOT NULL auto_increment,
  name varchar(64) NOT NULL default '',
  enabled tinyint(1) NOT NULL DEFAULT '1',
  path varchar(128) NOT NULL default '',
  priority int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (plugin_id),
  UNIQUE KEY name (name),
  UNIQUE KEY path (path)
)  COMMENT='Stores the plugins';
# --------------------------------------------------------

#
# Table structure for table CPG_sessions
#
CREATE TABLE CPG_sessions (
  session_id char(32) NOT NULL default '',
  user_id int(11) default '0',
  time int(11) default NULL,
  remember int(1) default '0',
  PRIMARY KEY (session_id)
)  COMMENT='Used to store sessions';
# --------------------------------------------------------

#
# Table structure for table CPG_temp_messages
#
CREATE TABLE CPG_temp_messages (
  message_id varchar(80) NOT NULL default '',
  user_id int(11) default '0',
  time int(11) default NULL,
  message text NOT NULL,
  PRIMARY KEY (message_id)
)  COMMENT='Used to store messages from one page to the other';
# --------------------------------------------------------


#
# Table structure for table CPG_usergroups
#
CREATE TABLE CPG_usergroups (
  group_id int(11) NOT NULL auto_increment,
  group_name varchar(255) NOT NULL default '',
  group_quota int(11) NOT NULL default '0',
  has_admin_access tinyint(4) NOT NULL default '0',
  can_rate_pictures tinyint(4) NOT NULL default '0',
  can_send_ecards tinyint(4) NOT NULL default '0',
  can_post_comments tinyint(4) NOT NULL default '0',
  can_upload_pictures tinyint(4) NOT NULL default '0',
  can_create_albums tinyint(4) NOT NULL default '0',
  pub_upl_need_approval tinyint(4) NOT NULL default '1',
  priv_upl_need_approval tinyint(4) NOT NULL default '1',
  access_level tinyint(4) NOT NULL default '3',
  PRIMARY KEY  (group_id)
) ;
# --------------------------------------------------------

#
# Table structure for table CPG_users
#
CREATE TABLE CPG_users (
  user_id int(11) NOT NULL auto_increment,
  user_group int(11) NOT NULL default '2',
  user_active enum('YES','NO') NOT NULL default 'NO',
  user_name varchar(25) NOT NULL default '',
  user_password varchar(255) NOT NULL default '',
  user_password_salt varchar(255) NOT NULL default '',
  user_password_hash_algorithm varchar(25) NOT NULL default '',
  user_password_iterations varchar(25) NOT NULL default '',
  user_lastvisit datetime NOT NULL default '1000-01-01 00:00:00',
  user_regdate datetime NOT NULL default '1000-01-01 00:00:00',
  user_group_list varchar(255) NOT NULL default '',
  user_email varchar(255) NOT NULL default '',
  user_email_valid enum('YES','') NOT NULL default '',
  user_profile1 varchar(255) NOT NULL default '',
  user_profile2 varchar(255) NOT NULL default '',
  user_profile3 varchar(255) NOT NULL default '',
  user_profile4 varchar(255) NOT NULL default '',
  user_profile5 varchar(255) NOT NULL default '',
  user_profile6 text NOT NULL,
  user_actkey varchar(32) NOT NULL default '',
  user_language varchar(40) NOT NULL default '',
  PRIMARY KEY  (user_id),
  UNIQUE KEY user_name (user_name),
  KEY user_group (user_group)
)  COMMENT='Used to store users, not used when bridged';
# --------------------------------------------------------

#
# Table structure for table CPG_votes
#
CREATE TABLE CPG_votes (
  pic_id mediumint(9) NOT NULL default '0',
  user_md5_id varchar(32) NOT NULL default '',
  vote_time int(11) NOT NULL default '0',
  PRIMARY KEY  (pic_id,user_md5_id)
)  COMMENT='Stores votes for individual pics';
#---------------------------------------------------------

#
# Table structure for table CPG_vote_stats
#
CREATE TABLE CPG_vote_stats (
  `sid` int(11) NOT NULL auto_increment,
  `pid` varchar(100) NOT NULL default '',
  `rating` smallint(6) NOT NULL default '0',
  `ip` varchar(40) NOT NULL default '',
  `sdate` bigint(20) NOT NULL default '0',
  `referer` text NOT NULL,
  `browser` varchar(255) NOT NULL default '',
  `os` varchar(50) NOT NULL default '',
  `uid` INT(11) NOT NULL default '0',
  PRIMARY KEY  (`sid`)
)  COMMENT='Detailed stats about votes, only used when enabled';
# --------------------------------------------------------

##  ********************************************
##  Coppermine Photo Gallery
##  ************************
##  v1.0 originally written by Gregory Demar
##
##  @copyright  Copyright (c) 2003-2018 Coppermine Dev Team
##  @license    GNU General Public License version 3 or later; see LICENSE
##
##  ********************************************
##  sql/basic.sql
##  @since  1.6.05
##  ********************************************

START TRANSACTION;

#
# Dumping data for table `CPG_config`
#

INSERT INTO CPG_config VALUES ('admin_activation', '0');
INSERT INTO CPG_config VALUES ('alb_desc_thumb', '1');
INSERT INTO CPG_config VALUES ('alb_list_thumb_size', '50');
INSERT INTO CPG_config VALUES ('album_list_cols', '2');
INSERT INTO CPG_config VALUES ('album_sort_order', 'pa');
INSERT INTO CPG_config VALUES ('album_uploads_default', 'NO');
INSERT INTO CPG_config VALUES ('albums_per_page', '12');
INSERT INTO CPG_config VALUES ('allow_duplicate_emails_addr', '0');
INSERT INTO CPG_config VALUES ('allow_guests_enter_file_details', '0');
INSERT INTO CPG_config VALUES ('allowed_doc_types', 'doc/txt/rtf/pdf/xls/pps/ppt/zip/gz/mdb');
INSERT INTO CPG_config VALUES ('allowed_img_types', 'jpeg/jpg/png/gif');
INSERT INTO CPG_config VALUES ('allowed_mov_types', 'asf/asx/mpg/mpeg/wmv/swf/avi/mov/m4v');
INSERT INTO CPG_config VALUES ('allowed_snd_types', 'mp3/midi/mid/wma/wav/ogg');
INSERT INTO CPG_config VALUES ('allow_email_change', '0');
INSERT INTO CPG_config VALUES ('allow_memberlist', '0');
INSERT INTO CPG_config VALUES ('allow_private_albums', '1');
INSERT INTO CPG_config VALUES ('allow_unlogged_access', '3');
INSERT INTO CPG_config VALUES ('allow_user_account_delete', '0');
INSERT INTO CPG_config VALUES ('allow_user_album_keyword', '0');
INSERT INTO CPG_config VALUES ('allow_user_edit_after_cat_close', '0');
INSERT INTO CPG_config VALUES ('allow_user_move_album', '0');
INSERT INTO CPG_config VALUES ('allow_user_registration', '0');
INSERT INTO CPG_config VALUES ('allow_user_upload_choice', '1');
INSERT INTO CPG_config VALUES ('auto_orient_checked', '1');
INSERT INTO CPG_config VALUES ('auto_resize', '1');
INSERT INTO CPG_config VALUES ('batch_add_hide_existing_files', '0');
INSERT INTO CPG_config VALUES ('batch_proc_limit', '2');
INSERT INTO CPG_config VALUES ('bridge_enable', '0');
INSERT INTO CPG_config VALUES ('browse_batch_add', '1');
INSERT INTO CPG_config VALUES ('browse_by_date', '0');
INSERT INTO CPG_config VALUES ('caption_in_thumbview', '1');
INSERT INTO CPG_config VALUES ('categories_alpha_sort', '0');
INSERT INTO CPG_config VALUES ('charset', 'utf-8');
INSERT INTO CPG_config VALUES ('clickable_keyword_search', '1');
INSERT INTO CPG_config VALUES ('comment_akismet_api_key', '');
INSERT INTO CPG_config VALUES ('comment_akismet_counter', '0');
INSERT INTO CPG_config VALUES ('comment_akismet_enable', '0');
INSERT INTO CPG_config VALUES ('comment_akismet_group', '0');
INSERT INTO CPG_config VALUES ('comment_approval', '0');
INSERT INTO CPG_config VALUES ('comment_captcha', '1');
#INSERT INTO CPG_config VALUES ('comment_email_notification', '0');
INSERT INTO CPG_config VALUES ('comment_placeholder', '1');
INSERT INTO CPG_config VALUES ('comment_promote_registration', '0');
INSERT INTO CPG_config VALUES ('comments_anon_pfx', 'Guest_');
INSERT INTO CPG_config VALUES ('comments_per_page', '20');
INSERT INTO CPG_config VALUES ('comments_sort_descending', '0');
INSERT INTO CPG_config VALUES ('comment_user_edit', '1');
INSERT INTO CPG_config VALUES ('contact_form_guest_email_field', '2');
INSERT INTO CPG_config VALUES ('contact_form_guest_enable', '0');
INSERT INTO CPG_config VALUES ('contact_form_guest_name_field', '2');
INSERT INTO CPG_config VALUES ('contact_form_registered_enable', '1');
INSERT INTO CPG_config VALUES ('contact_form_sender_email', '1');
INSERT INTO CPG_config VALUES ('contact_form_subject_content', 'Coppermine gallery contact form');
INSERT INTO CPG_config VALUES ('contact_form_subject_field', '0');
INSERT INTO CPG_config VALUES ('cookie_name', 'cpg16x');
INSERT INTO CPG_config VALUES ('cookie_path', '/');
INSERT INTO CPG_config VALUES ('cookies_need_consent', '0');
INSERT INTO CPG_config VALUES ('count_admin_hits', '0');
INSERT INTO CPG_config VALUES ('count_album_hits', '1');
INSERT INTO CPG_config VALUES ('count_file_hits', '1');
INSERT INTO CPG_config VALUES ('custom_footer_path', '');
INSERT INTO CPG_config VALUES ('custom_header_path', '');
INSERT INTO CPG_config VALUES ('custom_lnk_name', '');
INSERT INTO CPG_config VALUES ('custom_lnk_url', '');
INSERT INTO CPG_config VALUES ('custom_sortorder_thumbs', '1');
INSERT INTO CPG_config VALUES ('debug_mode', '0');
INSERT INTO CPG_config VALUES ('debug_notice', '0');
INSERT INTO CPG_config VALUES ('default_dir_mode', '0755');
INSERT INTO CPG_config VALUES ('default_file_mode', '0644');
INSERT INTO CPG_config VALUES ('default_sort_order', 'na');
INSERT INTO CPG_config VALUES ('disable_comment_flood_protect', '0');
# INSERT INTO CPG_config VALUES ('display_admin_uploader','0');
INSERT INTO CPG_config VALUES ('display_comment_approval_only', '0');
INSERT INTO CPG_config VALUES ('display_comment_count', '0');
INSERT INTO CPG_config VALUES ('display_coppermine_news', '1');
INSERT INTO CPG_config VALUES ('display_filename','0');
INSERT INTO CPG_config VALUES ('display_film_strip', '1');
INSERT INTO CPG_config VALUES ('display_pic_info', '0');
INSERT INTO CPG_config VALUES ('display_redirection_page', '0');
INSERT INTO CPG_config VALUES ('display_reset_boxes_in_config', '0');
INSERT INTO CPG_config VALUES ('display_sidebar_guest', '1');
INSERT INTO CPG_config VALUES ('display_sidebar_user', '1');
INSERT INTO CPG_config VALUES ('display_stats_on_index', '1');
INSERT INTO CPG_config VALUES ('display_thumbnail_rating', '0');
INSERT INTO CPG_config VALUES ('display_thumbs_batch_add', '1');
INSERT INTO CPG_config VALUES ('display_uploader', '0');
INSERT INTO CPG_config VALUES ('ecard_captcha', '1');
INSERT INTO CPG_config VALUES ('ecard_flash', '0');
INSERT INTO CPG_config VALUES ('ecards_more_pic_target', 'http://yoursite.tld/your_coppermine_folder/');
INSERT INTO CPG_config VALUES ('editpics_ignore_newer_than', '0');
INSERT INTO CPG_config VALUES ('email_comment_notification', '0');
INSERT INTO CPG_config VALUES ('enable_encrypted_passwords', '1'); # Do not remove - this record IS needed to make sure that there is no double-encryption when updating
INSERT INTO CPG_config VALUES ('enable_help', '1');
INSERT INTO CPG_config VALUES ('enable_menu_icons', '2');
INSERT INTO CPG_config VALUES ('enable_plugins', '1');
INSERT INTO CPG_config VALUES ('enable_smilies', '1');
INSERT INTO CPG_config VALUES ('enable_thumb_watermark', '1');
INSERT INTO CPG_config VALUES ('enable_unsharp', '0');
INSERT INTO CPG_config VALUES ('enable_watermark', '0');
INSERT INTO CPG_config VALUES ('enable_zipdownload', '0');
INSERT INTO CPG_config VALUES ('filter_bad_words', '0');
INSERT INTO CPG_config VALUES ('first_level', '1');
INSERT INTO CPG_config VALUES ('forbiden_fname_char', '$/\\\\:*?&quot;&#039;&lt;&gt;|` &amp;#@');
INSERT INTO CPG_config VALUES ('fullpath', 'albums/');
INSERT INTO CPG_config VALUES ('fullsize_padding_x', '5');
INSERT INTO CPG_config VALUES ('fullsize_padding_y', '3');
INSERT INTO CPG_config VALUES ('gallery_admin_email', 'you@somewhere.com');
INSERT INTO CPG_config VALUES ('gallery_description', 'Your gallery description here');
INSERT INTO CPG_config VALUES ('gallery_name', 'Your gallery name here');
INSERT INTO CPG_config VALUES ('global_registration_pw', '');
INSERT INTO CPG_config VALUES ('guest_token_cleanup', '0');
INSERT INTO CPG_config VALUES ('hit_details', '0');
INSERT INTO CPG_config VALUES ('home_target', 'index.php');
INSERT INTO CPG_config VALUES ('im_options', '-antialias');
INSERT INTO CPG_config VALUES ('impath', '/usr/bin/');
INSERT INTO CPG_config VALUES ('jpeg_qual', '80');
INSERT INTO CPG_config VALUES ('keep_votes_time', '30');
INSERT INTO CPG_config VALUES ('keyword_separator', ';');
INSERT INTO CPG_config VALUES ('lang', 'english');
INSERT INTO CPG_config VALUES ('language_autodetect', '1');
INSERT INTO CPG_config VALUES ('last_updates_check', '1');
INSERT INTO CPG_config VALUES ('link_pic_count', '1');
INSERT INTO CPG_config VALUES ('link_last_upload', '0');
INSERT INTO CPG_config VALUES ('log_ecards', '0');
INSERT INTO CPG_config VALUES ('login_expiry', '10');
INSERT INTO CPG_config VALUES ('login_method', 'username');
INSERT INTO CPG_config VALUES ('login_threshold', '5');
INSERT INTO CPG_config VALUES ('log_mode', '0');
INSERT INTO CPG_config VALUES ('main_page_layout', 'breadcrumb/catlist/alblist/random,2/lastup,2');
INSERT INTO CPG_config VALUES ('main_table_width', '100%');
INSERT INTO CPG_config VALUES ('make_intermediate', '1');
INSERT INTO CPG_config VALUES ('max_com_lines', '10');
INSERT INTO CPG_config VALUES ('max_com_size', '512');
INSERT INTO CPG_config VALUES ('max_com_wlength', '38');
INSERT INTO CPG_config VALUES ('max_film_strip_items', '5');
INSERT INTO CPG_config VALUES ('max_img_desc_length', '512');
INSERT INTO CPG_config VALUES ('max_tabs', '12');
INSERT INTO CPG_config VALUES ('max_upl_size', '1024');
INSERT INTO CPG_config VALUES ('max_upl_width_height', '2048');
INSERT INTO CPG_config VALUES ('media_autostart', '1');
INSERT INTO CPG_config VALUES ('min_votes_for_rating', '1');
INSERT INTO CPG_config VALUES ('normal_pfx', 'normal_');
INSERT INTO CPG_config VALUES ('offline', '0');
INSERT INTO CPG_config VALUES ('only_empty_albums', '0');
INSERT INTO CPG_config VALUES ('old_style_rating', '0');
INSERT INTO CPG_config VALUES ('orig_pfx', 'orig_');
INSERT INTO CPG_config VALUES ('performance_page_generation_time', '0');
INSERT INTO CPG_config VALUES ('performance_page_query_count', '0');
INSERT INTO CPG_config VALUES ('performance_page_query_time', '0');
INSERT INTO CPG_config VALUES ('performance_timestamp', '0');
INSERT INTO CPG_config VALUES ('personal_album_on_registration', '0');
INSERT INTO CPG_config VALUES ('picinfo_movie_download_link', '1');
INSERT INTO CPG_config VALUES ('picture_table_width', '100%');
INSERT INTO CPG_config VALUES ('picture_use', 'thumb');
INSERT INTO CPG_config VALUES ('picture_width', '400');
INSERT INTO CPG_config VALUES ('purge_expired_bans', '1');
# INSERT INTO CPG_config VALUES ('randpos_interval', '1063623637');
INSERT INTO CPG_config VALUES ('rate_own_files', '0');
INSERT INTO CPG_config VALUES ('rating_stars_amount', '5');
INSERT INTO CPG_config VALUES ('read_exif_data', '0');
INSERT INTO CPG_config VALUES ('read_iptc_data', '0');
INSERT INTO CPG_config VALUES ('reduce_watermark', '0');
INSERT INTO CPG_config VALUES ('registration_captcha', '0');
INSERT INTO CPG_config VALUES ('reg_notify_admin_email', '0');
INSERT INTO CPG_config VALUES ('reg_requires_valid_email', '1');
INSERT INTO CPG_config VALUES ('report_post', '0');
INSERT INTO CPG_config VALUES ('session_cleanup', '0');
INSERT INTO CPG_config VALUES ('show_bbcode_help', '1');
INSERT INTO CPG_config VALUES ('show_private', '0');
INSERT INTO CPG_config VALUES ('show_which_exif', '|0|0|0|0|0|0|0|0|1|0|1|1|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|1|0|0|0|1|1|0|0|0|0|1|0|0|0|1|0|0|1|1|0|0|0|0|0|1|0|1|1');
INSERT INTO CPG_config VALUES ('silly_safe_mode', '0');
INSERT INTO CPG_config VALUES ('site_token', MD5(RAND()));
INSERT INTO CPG_config VALUES ('form_token_lifetime', '3600');
INSERT INTO CPG_config VALUES ('slideshow_hits', '1');
INSERT INTO CPG_config VALUES ('slideshow_interval', '5000');
INSERT INTO CPG_config VALUES ('smtp_host', '');
INSERT INTO CPG_config VALUES ('smtp_password', '');
INSERT INTO CPG_config VALUES ('smtp_username', '');
INSERT INTO CPG_config VALUES ('subcat_level', '2');
INSERT INTO CPG_config VALUES ('tabs_dropdown', '1');
INSERT INTO CPG_config VALUES ('theme', 'curve');
INSERT INTO CPG_config VALUES ('theme_list', '0');
INSERT INTO CPG_config VALUES ('thumbcols', '4');
INSERT INTO CPG_config VALUES ('thumb_height', '128');
INSERT INTO CPG_config VALUES ('thumb_method', 'im');
INSERT INTO CPG_config VALUES ('thumbnail_to_fullsize', '0');
INSERT INTO CPG_config VALUES ('thumb_pfx', 'thumb_');
INSERT INTO CPG_config VALUES ('thumbrows', '3');
INSERT INTO CPG_config VALUES ('thumb_use', 'any');
INSERT INTO CPG_config VALUES ('thumb_width', '128');
INSERT INTO CPG_config VALUES ('time_offset', '0');
INSERT INTO CPG_config VALUES ('transparent_overlay', '0');
INSERT INTO CPG_config VALUES ('unsharp_amount', '120');
INSERT INTO CPG_config VALUES ('unsharp_radius', '0.5');
INSERT INTO CPG_config VALUES ('unsharp_threshold', '3');
INSERT INTO CPG_config VALUES ('upl_notify_admin_email', '0');
INSERT INTO CPG_config VALUES ('upload_create_album_directory', '1');
INSERT INTO CPG_config VALUES ('upload_mechanism', 'upload_h5a');
INSERT INTO CPG_config VALUES ('user_field1_name', '');
INSERT INTO CPG_config VALUES ('user_field2_name', '');
INSERT INTO CPG_config VALUES ('user_field3_name', '');
INSERT INTO CPG_config VALUES ('user_field4_name', '');
INSERT INTO CPG_config VALUES ('user_manager_hide_file_stats', '0');
INSERT INTO CPG_config VALUES ('userpics', 'userpics/');
INSERT INTO CPG_config VALUES ('user_profile1_name', 'Location');
INSERT INTO CPG_config VALUES ('user_profile2_name', 'Interests');
INSERT INTO CPG_config VALUES ('user_profile3_name', 'Website');
INSERT INTO CPG_config VALUES ('user_profile4_name', 'Occupation');
INSERT INTO CPG_config VALUES ('user_profile5_name', '');
INSERT INTO CPG_config VALUES ('user_profile6_name', 'Biography');
INSERT INTO CPG_config VALUES ('user_registration_disclaimer', '1');
INSERT INTO CPG_config VALUES ('users_can_edit_pics', '0');
INSERT INTO CPG_config VALUES ('views_in_thumbview', '1');
INSERT INTO CPG_config VALUES ('vote_details', '0');
INSERT INTO CPG_config VALUES ('watermark_file', 'images/watermark.png');
INSERT INTO CPG_config VALUES ('watermark_transparency', '40');
INSERT INTO CPG_config VALUES ('watermark_transparency_featherx', '0');
INSERT INTO CPG_config VALUES ('watermark_transparency_feathery', '0');
INSERT INTO CPG_config VALUES ('where_put_watermark', 'southeast');
INSERT INTO CPG_config VALUES ('which_files_to_watermark', 'both');
# file upload plugins
INSERT INTO CPG_config VALUES ('upload_h5a', 'a:11:{s:10:"concurrent";i:3;s:8:"upldsize";i:0;s:8:"autoedit";i:1;s:8:"acptmime";s:7:"image/*";s:8:"enabtitl";i:0;s:8:"enabdesc";i:0;s:8:"enabkeys";i:1;s:8:"enabusr1";i:0;s:8:"enabusr2";i:0;s:8:"enabusr3";i:0;s:8:"enabusr4";i:0;}');

#
# Dumping data for table `CPG_plugins`
#

INSERT INTO CPG_plugins (name, path, priority) VALUES ('HTML5 Upload', 'upload_h5a', 0), ('Flash Upload', 'upload_swf', 1), ('Single File Upload', 'upload_sgl', 2);


#
# Dumping data for table `CPG_filetypes`
#

INSERT INTO CPG_filetypes VALUES ('jpg', 'image/jpg', 'image', '');
INSERT INTO CPG_filetypes VALUES ('jpeg', 'image/jpeg', 'image', '');
INSERT INTO CPG_filetypes VALUES ('jpe', 'image/jpe', 'image', '');
INSERT INTO CPG_filetypes VALUES ('gif', 'image/gif', 'image', '');
INSERT INTO CPG_filetypes VALUES ('png', 'image/png', 'image', '');
INSERT INTO CPG_filetypes VALUES ('bmp', 'image/bmp', 'image', '');
INSERT INTO CPG_filetypes VALUES ('jpc', 'image/jpc', 'image', '');
INSERT INTO CPG_filetypes VALUES ('jp2', 'image/jp2', 'image', '');
INSERT INTO CPG_filetypes VALUES ('jpx', 'image/jpx', 'image', '');
INSERT INTO CPG_filetypes VALUES ('jb2', 'image/jb2', 'image', '');
INSERT INTO CPG_filetypes VALUES ('swc', 'image/swc', 'image', '');
INSERT INTO CPG_filetypes VALUES ('iff', 'image/iff', 'image', '');
INSERT INTO CPG_filetypes VALUES ('psd', 'image/psd', 'image', '');

INSERT INTO CPG_filetypes VALUES ('asf', 'video/x-ms-asf', 'movie', 'WMP');
INSERT INTO CPG_filetypes VALUES ('asx', 'video/x-ms-asx', 'movie', 'WMP');
INSERT INTO CPG_filetypes VALUES ('mpg', 'video/mpeg', 'movie', 'WMP');
INSERT INTO CPG_filetypes VALUES ('mpeg', 'video/mpeg', 'movie', 'WMP');
INSERT INTO CPG_filetypes VALUES ('wmv', 'video/x-ms-wmv', 'movie', 'WMP');
INSERT INTO CPG_filetypes VALUES ('swf', 'application/x-shockwave-flash', 'movie', 'SWF');
INSERT INTO CPG_filetypes VALUES ('avi', 'video/avi', 'movie', 'WMP');
INSERT INTO CPG_filetypes VALUES ('mov', 'video/quicktime', 'movie', 'QT');
INSERT INTO CPG_filetypes VALUES ('mp4', 'video/mp4', 'movie', 'HTMLV');
INSERT INTO CPG_filetypes VALUES ('m4v', 'video/x-m4v', 'movie', 'HTMLV');

INSERT INTO CPG_filetypes VALUES ('mp3', 'audio/mpeg3', 'audio', 'WMP');
INSERT INTO CPG_filetypes VALUES ('midi', 'audio/midi', 'audio', 'WMP');
INSERT INTO CPG_filetypes VALUES ('mid', 'audio/midi', 'audio', 'WMP');
INSERT INTO CPG_filetypes VALUES ('wma', 'audio/x-ms-wma', 'audio', 'WMP');
INSERT INTO CPG_filetypes VALUES ('wav', 'audio/wav', 'audio', 'WMP');

INSERT INTO CPG_filetypes VALUES ('ogg', 'audio/ogg', 'audio', 'HTMLA');
INSERT INTO CPG_filetypes VALUES ('oga', 'audio/ogg', 'audio', 'HTMLA');
INSERT INTO CPG_filetypes VALUES ('ogv', 'video/ogg', 'movie', 'HTMLV');

INSERT INTO CPG_filetypes VALUES ('ram', 'audio/x-pn-realaudio', 'document', 'RMP');
INSERT INTO CPG_filetypes VALUES ('ra', 'audio/x-realaudio', 'document', 'RMP');
INSERT INTO CPG_filetypes VALUES ('rm', 'audio/x-realmedia', 'document', 'RMP');
INSERT INTO CPG_filetypes VALUES ('tiff', 'image/tiff', 'document', '');
INSERT INTO CPG_filetypes VALUES ('tif', 'image/tif', 'document', '');
INSERT INTO CPG_filetypes VALUES ('doc', 'application/msword', 'document', '');
INSERT INTO CPG_filetypes VALUES ('xls', 'application/excel', 'document', '');
INSERT INTO CPG_filetypes VALUES ('pps', 'application/powerpoint', 'document', '');
INSERT INTO CPG_filetypes VALUES ('ppt', 'application/powerpoint', 'document', '');
INSERT INTO CPG_filetypes VALUES ('mdb', 'application/msaccess', 'document', '');
INSERT INTO CPG_filetypes VALUES ('txt', 'text/plain', 'document', '');
INSERT INTO CPG_filetypes VALUES ('rtf', 'text/richtext', 'document', '');
INSERT INTO CPG_filetypes VALUES ('pdf', 'application/pdf', 'document', '');
INSERT INTO CPG_filetypes VALUES ('zip', 'application/zip', 'document', '');
INSERT INTO CPG_filetypes VALUES ('rar', 'application/rar', 'document', '');
INSERT INTO CPG_filetypes VALUES ('gz', 'application/gz', 'document', '');
INSERT INTO CPG_filetypes VALUES ('001', 'application/001', 'document', '');
INSERT INTO CPG_filetypes VALUES ('7z', 'application/7z', 'document', '');
INSERT INTO CPG_filetypes VALUES ('arj', 'application/arj', 'document', '');
INSERT INTO CPG_filetypes VALUES ('bz2', 'application/bz2', 'document', '');
INSERT INTO CPG_filetypes VALUES ('cab', 'application/cab', 'document', '');
INSERT INTO CPG_filetypes VALUES ('lzh', 'application/lzh', 'document', '');
INSERT INTO CPG_filetypes VALUES ('rpm', 'application/rpm', 'document', '');
INSERT INTO CPG_filetypes VALUES ('tar', 'application/tar', 'document', '');
INSERT INTO CPG_filetypes VALUES ('z', 'application/z', 'document', '');
INSERT INTO CPG_filetypes VALUES ('odb', 'application/vnd.oasis.opendocument.database', 'document', '');
INSERT INTO CPG_filetypes VALUES ('odt', 'application/vnd.oasis.opendocument.text', 'document', '');
INSERT INTO CPG_filetypes VALUES ('ods', 'application/vnd.oasis.opendocument.spreadsheet', 'document', '');
INSERT INTO CPG_filetypes VALUES ('odp', 'application/vnd.oasis.opendocument.presentation', 'document', '');
INSERT INTO CPG_filetypes VALUES ('odg', 'application/vnd.oasis.opendocument.graphics', 'document', '');
INSERT INTO CPG_filetypes VALUES ('odc', 'application/vnd.oasis.opendocument.chart', 'document', '');
INSERT INTO CPG_filetypes VALUES ('odf', 'application/vnd.oasis.opendocument.formula', 'document', '');
INSERT INTO CPG_filetypes VALUES ('odi', 'application/vnd.oasis.opendocument.image', 'document', '');
INSERT INTO CPG_filetypes VALUES ('odm', 'application/vnd.oasis.opendocument.text-master', 'document', '');
INSERT INTO CPG_filetypes VALUES ('ott', 'application/vnd.oasis.opendocument.text-template', 'document', '');
INSERT INTO CPG_filetypes VALUES ('ots', 'application/vnd.oasis.opendocument.spreadsheet-template', 'document', '');
INSERT INTO CPG_filetypes VALUES ('otp', 'application/vnd.oasis.opendocument.presentation-template', 'document', '');
INSERT INTO CPG_filetypes VALUES ('otg', 'application/vnd.oasis.opendocument.graphics-template', 'document', '');
INSERT INTO CPG_filetypes VALUES ('otc', 'application/vnd.oasis.opendocument.chart-template', 'document', '');
INSERT INTO CPG_filetypes VALUES ('otf', 'application/vnd.oasis.opendocument.formula-template', 'document', '');
INSERT INTO CPG_filetypes VALUES ('oti', 'application/vnd.oasis.opendocument.image-template', 'document', '');
INSERT INTO CPG_filetypes VALUES ('oth', 'application/vnd.oasis.opendocument.text-web', 'document', '');
INSERT INTO CPG_filetypes VALUES ('sxw', 'application/vnd.sun.xml.writer', 'document', '');
INSERT INTO CPG_filetypes VALUES ('stw', 'application/vnd.sun.xml.writer.template', 'document', '');
INSERT INTO CPG_filetypes VALUES ('sxc', 'application/vnd.sun.xml.calc', 'document', '');
INSERT INTO CPG_filetypes VALUES ('stc', 'application/vnd.sun.xml.calc.template', 'document', '');
INSERT INTO CPG_filetypes VALUES ('sxd', 'application/vnd.sun.xml.draw', 'document', '');
INSERT INTO CPG_filetypes VALUES ('std', 'application/vnd.sun.xml.draw.template', 'document', '');
INSERT INTO CPG_filetypes VALUES ('sxi', 'application/vnd.sun.xml.impress', 'document', '');
INSERT INTO CPG_filetypes VALUES ('sti', 'application/vnd.sun.xml.impress.template', 'document', '');
INSERT INTO CPG_filetypes VALUES ('sxg', 'application/vnd.sun.xml.writer.global', 'document', '');
INSERT INTO CPG_filetypes VALUES ('sxm', 'application/vnd.sun.xml.math', 'document', '');
INSERT INTO CPG_filetypes VALUES ('docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'document', '');
INSERT INTO CPG_filetypes VALUES ('docm', 'application/vnd.ms-word.document.macroEnabled.12', 'document', '');
INSERT INTO CPG_filetypes VALUES ('dotx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.template', 'document', '');
INSERT INTO CPG_filetypes VALUES ('dotm', 'application/vnd.ms-word.template.macroEnabled.12', 'document', '');
INSERT INTO CPG_filetypes VALUES ('xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'document', '');
INSERT INTO CPG_filetypes VALUES ('xlsm', 'application/vnd.ms-excel.sheet.macroEnabled.12', 'document', '');
INSERT INTO CPG_filetypes VALUES ('xltx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.template', 'document', '');
INSERT INTO CPG_filetypes VALUES ('xltm', 'application/vnd.ms-excel.template.macroEnabled.12', 'document', '');
INSERT INTO CPG_filetypes VALUES ('xlsb', 'application/vnd.ms-excel.sheet.binary.macroEnabled.12', 'document', '');
INSERT INTO CPG_filetypes VALUES ('xlam', 'application/vnd.ms-excel.addin.macroEnabled.12', 'document', '');
INSERT INTO CPG_filetypes VALUES ('pptx', 'application/vnd.openxmlformats-officedocument.presentationml.presentation', 'document', '');
INSERT INTO CPG_filetypes VALUES ('pptm', 'application/vnd.ms-powerpoint.presentation.macroEnabled.12', 'document', '');
INSERT INTO CPG_filetypes VALUES ('ppsx', 'application/vnd.openxmlformats-officedocument.presentationml.slideshow', 'document', '');
INSERT INTO CPG_filetypes VALUES ('ppsm', 'application/vnd.ms-powerpoint.slideshow.macroEnabled.12', 'document', '');
INSERT INTO CPG_filetypes VALUES ('potx', 'application/vnd.openxmlformats-officedocument.presentationml.template', 'document', '');
INSERT INTO CPG_filetypes VALUES ('potm', 'application/vnd.ms-powerpoint.template.macroEnabled.12', 'document', '');
INSERT INTO CPG_filetypes VALUES ('ppam', 'application/vnd.ms-powerpoint.addin.macroEnabled.12', 'document', '');
INSERT INTO CPG_filetypes VALUES ('sldx', 'application/vnd.openxmlformats-officedocument.presentationml.slide', 'document', '');
INSERT INTO CPG_filetypes VALUES ('sldm', 'application/vnd.ms-powerpoint.slide.macroEnabled.12', 'document', '');
INSERT INTO CPG_filetypes VALUES ('thmx', 'application/vnd.ms-officetheme', 'document', '');
INSERT INTO CPG_filetypes VALUES ('onetoc', 'application/onenote', 'document', '');
INSERT INTO CPG_filetypes VALUES ('onetoc2', 'application/onenote', 'document', '');
INSERT INTO CPG_filetypes VALUES ('onetmp', 'application/onenote', 'document', '');
INSERT INTO CPG_filetypes VALUES ('onepkg', 'application/onenote', 'document', '');

#
# Dumping data for table `CPG_usergroups`
#

INSERT INTO CPG_usergroups VALUES (1, 'Administrators', 0, 1, 1, 1, 1, 1, 1, 0, 0, 3);
INSERT INTO CPG_usergroups VALUES (2, 'Registered', 1024, 0, 1, 1, 1, 1, 1, 1, 0, 3);
INSERT INTO CPG_usergroups VALUES (3, 'Anonymous', 0, 0, 1, 0, 0, 0, 0, 1, 1, 3);

#
# Dumping data for table `CPG_categories`
#

INSERT INTO CPG_categories (cid, name, description, lft, rgt, depth) VALUES (1, 'User galleries', 'This category contains albums that belong to Coppermine users.', 1, 2, 1);


#
# Data for table `CPG_bridge`
# Used for bridging by user interface
#

INSERT INTO CPG_bridge VALUES ('short_name', '');
INSERT INTO CPG_bridge VALUES ('full_forum_url', '');
INSERT INTO CPG_bridge VALUES ('relative_path_to_config_file', '');
INSERT INTO CPG_bridge VALUES ('use_post_based_groups', '');
INSERT INTO CPG_bridge VALUES ('cookie_prefix', '');
INSERT INTO CPG_bridge VALUES ('recovery_logon_failures', '0');
INSERT INTO CPG_bridge VALUES ('recovery_logon_timestamp', '');


#
# Data for the language table
#

INSERT INTO CPG_languages (lang_id, english_name, native_name, flag, abbr, available, enabled, complete) VALUES ('english', 'English (US)', 'English (US)', 'us','en', 'YES', 'YES', 'YES');
INSERT INTO CPG_languages (lang_id, english_name, native_name, flag, abbr, available, enabled, complete) VALUES ('french', 'French','Fran&ccedil;ais','fr','fr', 'YES', 'YES', 'YES');
INSERT INTO CPG_languages (lang_id, english_name, native_name, flag, abbr, available, enabled, complete) VALUES ('german', 'German (informal)', 'Deutsch (Du)', 'de','de', 'YES', 'YES', 'YES');


# Add new statements above this line
COMMIT;
