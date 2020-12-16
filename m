Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094742DBA2F
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Dec 2020 05:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgLPEoS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Dec 2020 23:44:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:58432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgLPEoR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 15 Dec 2020 23:44:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 942AEAD4D;
        Wed, 16 Dec 2020 04:43:35 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Date:   Wed, 16 Dec 2020 15:43:03 +1100
Subject: [PATCH 1/7] mount: configfile: remove whitesspace from end of lines
Cc:     Justin Mitchell <jumitche@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Message-ID: <160809378305.7232.11988628657352067133.stgit@noble>
In-Reply-To: <160809318571.7232.10427700322834760606.stgit@noble>
References: <160809318571.7232.10427700322834760606.stgit@noble>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While space at end of line is ugly..  especially when your editor is
configured to show it in RED.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/mount/configfile.c |   67 +++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/utils/mount/configfile.c b/utils/mount/configfile.c
index 93fe500bc7a2..2470bc6a8bf6 100644
--- a/utils/mount/configfile.c
+++ b/utils/mount/configfile.c
@@ -1,5 +1,5 @@
 /*
- * configfile.c -- mount configuration file manipulation 
+ * configfile.c -- mount configuration file manipulation
  * Copyright (C) 2008 Red Hat, Inc <nfs@redhat.com>
  *
  * - Routines use to create mount options from the mount
@@ -77,10 +77,10 @@ int mnt_alias_sz = (sizeof(mnt_alias_tab)/sizeof(mnt_alias_tab[0]));
 static int strict;
 
 /*
- * See if the option is an alias, if so return the 
+ * See if the option is an alias, if so return the
  * real mount option along with the argument type.
  */
-inline static 
+inline static
 char *mountopts_alias(char *opt, int *argtype)
 {
 	int i;
@@ -99,7 +99,7 @@ char *mountopts_alias(char *opt, int *argtype)
 }
 /*
  * Convert numeric strings that end with 'k', 'm' or 'g'
- * into numeric strings with the real value. 
+ * into numeric strings with the real value.
  * Meaning '8k' becomes '8094'.
  */
 char *mountopts_convert(char *value)
@@ -146,26 +146,26 @@ static int list_size;
 /*
  * Add option to the link list
  */
-inline static void 
+inline static void
 add_entry(char *opt)
 {
 	struct entry *entry;
 
 	entry = calloc(1, sizeof(struct entry));
 	if (entry == NULL) {
-		xlog_warn("Unable calloc memory for mount configs"); 
+		xlog_warn("Unable calloc memory for mount configs");
 		return;
 	}
 	entry->opt = strdup(opt);
 	if (entry->opt == NULL) {
-		xlog_warn("Unable calloc memory for mount opts"); 
+		xlog_warn("Unable calloc memory for mount opts");
 		free(entry);
 		return;
 	}
 	SLIST_INSERT_HEAD(&head, entry, entries);
 }
 /*
- * Check the alias list to see if the given 
+ * Check the alias list to see if the given
  * opt is a alias
  */
 char *is_alias(char *opt)
@@ -174,7 +174,7 @@ char *is_alias(char *opt)
 
 	for (i=0; i < mnt_alias_sz; i++) {
 		if (strcasecmp(opt, mnt_alias_tab[i].alias) == 0)
-			return mnt_alias_tab[i].opt; 
+			return mnt_alias_tab[i].opt;
 	}
 	return NULL;
 }
@@ -182,7 +182,7 @@ char *is_alias(char *opt)
  * See if the given entry exists if the link list,
  * if so return that entry
  */
-inline static 
+inline static
 char *lookup_entry(char *opt)
 {
 	struct entry *entry;
@@ -217,7 +217,7 @@ char *lookup_entry(char *opt)
 /*
  * Free all entries on the link list
  */
-inline static 
+inline static
 void free_all(void)
 {
 	struct entry *entry;
@@ -236,10 +236,10 @@ extern sa_family_t config_default_family;
 
 /*
  * Check to see if a default value is being set.
- * If so, set the appropriate global value which will 
+ * If so, set the appropriate global value which will
  * be used as the initial value in the server negation.
  */
-static int 
+static int
 default_value(char *mopt)
 {
 	struct mount_options *options = NULL;
@@ -253,11 +253,11 @@ default_value(char *mopt)
 	if (strncasecmp(field, "proto", strlen("proto")) == 0) {
 		if ((options = po_split(field)) != NULL) {
 			if (!nfs_nfs_protocol(options, &config_default_proto)) {
-				xlog_warn("Unable to set default protocol : %s", 
+				xlog_warn("Unable to set default protocol : %s",
 					strerror(errno));
 			}
 			if (!nfs_nfs_proto_family(options, &config_default_family)) {
-				xlog_warn("Unable to set default family : %s", 
+				xlog_warn("Unable to set default family : %s",
 					strerror(errno));
 			}
 		} else {
@@ -266,14 +266,13 @@ default_value(char *mopt)
 	} else if (strncasecmp(field, "vers", strlen("vers")) == 0) {
 		if ((options = po_split(field)) != NULL) {
 			if (!nfs_nfs_version("nfs", options, &config_default_vers)) {
-				xlog_warn("Unable to set default version: %s", 
+				xlog_warn("Unable to set default version: %s",
 					strerror(errno));
-				
 			}
 		} else {
 			xlog_warn("Unable to alloc memory for default version");
 		}
-	} else 
+	} else
 		xlog_warn("Invalid default setting: '%s'", mopt);
 
 	if (options)
@@ -282,11 +281,11 @@ default_value(char *mopt)
 	return 1;
 }
 /*
- * Parse the given section of the configuration 
+ * Parse the given section of the configuration
  * file to if there are any mount options set.
  * If so, added them to link list.
  */
-static void 
+static void
 conf_parse_mntopts(char *section, char *arg, char *opts)
 {
 	struct conf_list *list;
@@ -300,7 +299,7 @@ conf_parse_mntopts(char *section, char *arg, char *opts)
 		/* check first if this is an alias for another option */
 		field = mountopts_alias(node->field, &argtype);
 		/*
-		 * Do not overwrite options if already exists 
+		 * Do not overwrite options if already exists
 		 */
 		snprintf(buf, BUFSIZ, "%s=", field);
 		if (opts && strcasestr(opts, buf) != NULL)
@@ -333,8 +332,8 @@ conf_parse_mntopts(char *section, char *arg, char *opts)
 		}
 		if (buf[0] == '\0')
 			continue;
-		/* 
-		 * Keep a running tally of the list size adding 
+		/*
+		 * Keep a running tally of the list size adding
 		 * one for the ',' that will be appened later
 		 */
 		list_size += strlen(buf) + 1;
@@ -344,14 +343,14 @@ conf_parse_mntopts(char *section, char *arg, char *opts)
 }
 
 /*
- * Concatenate options from the configuration file with the 
+ * Concatenate options from the configuration file with the
  * given options by building a link list of options from the
- * different sections in the conf file. Options that exists 
- * in the either the given options or link list are not 
+ * different sections in the conf file. Options that exists
+ * in the either the given options or link list are not
  * overwritten so it matter which when each section is
- * parsed. 
+ * parsed.
  */
-char *conf_get_mntopts(char *spec, char *mount_point, 
+char *conf_get_mntopts(char *spec, char *mount_point,
 	char *mount_opts)
 {
 	struct entry *entry;
@@ -362,18 +361,18 @@ char *conf_get_mntopts(char *spec, char *mount_point,
 	SLIST_INIT(&head);
 	list_size = 0;
 	/*
-	 * First see if there are any mount options relative 
+	 * First see if there are any mount options relative
 	 * to the mount point.
 	 */
 	conf_parse_mntopts(NFSMOUNT_MOUNTPOINT, mount_point, mount_opts);
 
-	/* 
+	/*
 	 * Next, see if there are any mount options relative
 	 * to the server
 	 */
 	server = strdup(spec);
 	if (server == NULL) {
-		xlog_warn("conf_get_mountops: Unable calloc memory for server"); 
+		xlog_warn("conf_get_mountops: Unable calloc memory for server");
 		free_all();
 		return mount_opts;
 	}
@@ -383,7 +382,7 @@ char *conf_get_mntopts(char *spec, char *mount_point,
 	free(server);
 
 	/*
-	 * Finally process all the global mount options. 
+	 * Finally process all the global mount options.
 	 */
 	conf_parse_mntopts(NFSMOUNT_GLOBAL_OPTS, NULL, mount_opts);
 
@@ -396,7 +395,7 @@ char *conf_get_mntopts(char *spec, char *mount_point,
 
 	/*
 	 * Found options in the configuration file. So
-	 * concatenate the configuration options with the 
+	 * concatenate the configuration options with the
 	 * options that were passed in
 	 */
 	if (mount_opts)
@@ -405,7 +404,7 @@ char *conf_get_mntopts(char *spec, char *mount_point,
 	/* list_size + optlen + ',' + '\0' */
 	config_opts = calloc(1, (list_size+optlen+2));
 	if (config_opts == NULL) {
-		xlog_warn("conf_get_mountops: Unable calloc memory for config_opts"); 
+		xlog_warn("conf_get_mountops: Unable calloc memory for config_opts");
 		free_all();
 		return mount_opts;
 	}


