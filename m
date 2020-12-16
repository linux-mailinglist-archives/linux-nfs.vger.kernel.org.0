Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999CA2DBA30
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Dec 2020 05:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgLPEoc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Dec 2020 23:44:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:58632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbgLPEoc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 15 Dec 2020 23:44:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5817AF00;
        Wed, 16 Dec 2020 04:43:49 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Date:   Wed, 16 Dec 2020 15:43:03 +1100
Subject: [PATCH 4/7] mount: convert configfile.c to use parse_opt.c
Cc:     Justin Mitchell <jumitche@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Message-ID: <160809378308.7232.4328930492073538669.stgit@noble>
In-Reply-To: <160809318571.7232.10427700322834760606.stgit@noble>
References: <160809318571.7232.10427700322834760606.stgit@noble>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

configfile.c contains some ad-hoc parsing of the comma-separated option
list, which uses a simple 'strstr' and can find options that don't
really match the searched-for option (the found options might have a
prefix).

It also has a list of options which duplicates the functionality in
parse_opt.

This can be simplified by using parse_opt directly.  We split the
original arguments, optionally append new arguments if they don't
already exist, then recombine.

"defaultfoo" config options require special handling.  The
default_value() call is now made as soon as the option has been parsed.
It is left on the options list so that new instances of the value are
ignored.  Then all "defaultfoo" options are remove from the list at the
end.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/mount/configfile.c |  183 ++++++----------------------------------------
 1 file changed, 25 insertions(+), 158 deletions(-)

diff --git a/utils/mount/configfile.c b/utils/mount/configfile.c
index e20aa73739fc..8c68ff2c1323 100644
--- a/utils/mount/configfile.c
+++ b/utils/mount/configfile.c
@@ -34,10 +34,7 @@
 #include "parse_opt.h"
 #include "network.h"
 #include "conffile.h"
-
-char *mountopts_convert(char *value);
-char *is_alias(char *opt);
-char *conf_get_mntopts(char *spec, char *mount_point, char *mount_opts);
+#include "mount_config.h"
 
 #define KBYTES(x)     ((x) * (1024))
 #define MEGABYTES(x)  ((x) * (1048576))
@@ -101,7 +98,7 @@ char *mountopts_alias(char *opt, int *argtype)
  * into numeric strings with the real value.
  * Meaning '8k' becomes '8094'.
  */
-char *mountopts_convert(char *value)
+static char *mountopts_convert(char *value)
 {
 	unsigned long long factor, num;
 	static char buf[64];
@@ -135,100 +132,6 @@ char *mountopts_convert(char *value)
 	return buf;
 }
 
-struct entry {
-	SLIST_ENTRY(entry) entries;
-	char *opt;
-};
-static SLIST_HEAD(shead, entry) head = SLIST_HEAD_INITIALIZER(head);
-static int list_size;
-
-/*
- * Add option to the link list
- */
-inline static void
-add_entry(char *opt)
-{
-	struct entry *entry;
-
-	entry = calloc(1, sizeof(struct entry));
-	if (entry == NULL) {
-		xlog_warn("Unable calloc memory for mount configs");
-		return;
-	}
-	entry->opt = strdup(opt);
-	if (entry->opt == NULL) {
-		xlog_warn("Unable calloc memory for mount opts");
-		free(entry);
-		return;
-	}
-	SLIST_INSERT_HEAD(&head, entry, entries);
-}
-/*
- * Check the alias list to see if the given
- * opt is a alias
- */
-char *is_alias(char *opt)
-{
-	int i;
-
-	for (i=0; i < mnt_alias_sz; i++) {
-		if (strcasecmp(opt, mnt_alias_tab[i].alias) == 0)
-			return mnt_alias_tab[i].opt;
-	}
-	return NULL;
-}
-/*
- * See if the given entry exists if the link list,
- * if so return that entry
- */
-inline static
-char *lookup_entry(char *opt)
-{
-	struct entry *entry;
-	char *alias = is_alias(opt);
-	char *ptr;
-
-	SLIST_FOREACH(entry, &head, entries) {
-		/*
-		 * Only check the left side or options that use '='
-		 */
-		if ((ptr = strchr(entry->opt, '=')) != 0) {
-			int len = (int) (ptr - entry->opt);
-
-			if (strncasecmp(entry->opt, opt, len) == 0)
-				return opt;
-		}
-		if (strcasecmp(entry->opt, opt) == 0)
-			return opt;
-		if (alias && strcasecmp(entry->opt, alias) == 0)
-			return opt;
-		if (alias && strcasecmp(alias, "fg") == 0) {
-			if (strcasecmp(entry->opt, "bg") == 0)
-				return opt;
-		}
-		if (alias && strcasecmp(alias, "bg") == 0) {
-			if (strcasecmp(entry->opt, "fg") == 0)
-				return opt;
-		}
-	}
-	return NULL;
-}
-/*
- * Free all entries on the link list
- */
-inline static
-void free_all(void)
-{
-	struct entry *entry;
-
-	while (!SLIST_EMPTY(&head)) {
-		entry = SLIST_FIRST(&head);
-		SLIST_REMOVE_HEAD(&head, entries);
-		free(entry->opt);
-		free(entry);
-	}
-}
-
 struct nfs_version config_default_vers;
 unsigned long config_default_proto;
 extern sa_family_t config_default_family;
@@ -285,7 +188,7 @@ default_value(char *mopt)
  * If so, added them to link list.
  */
 static void
-conf_parse_mntopts(char *section, char *arg, char *opts)
+conf_parse_mntopts(char *section, char *arg, struct mount_options *options)
 {
 	struct conf_list *list;
 	struct conf_list_node *node;
@@ -298,17 +201,14 @@ conf_parse_mntopts(char *section, char *arg, char *opts)
 		/*
 		 * Do not overwrite options if already exists
 		 */
-		snprintf(buf, BUFSIZ, "%s=", node->field);
-		if (opts && strcasestr(opts, buf) != NULL)
+		field = mountopts_alias(node->field, &argtype);
+		if (po_contains(options, field) == PO_FOUND)
 			continue;
 
-		if (lookup_entry(node->field) != NULL)
-			continue;
 		buf[0] = '\0';
 		value = conf_get_section(section, arg, node->field);
 		if (value == NULL)
 			continue;
-		field = mountopts_alias(node->field, &argtype);
 		if (strcasecmp(value, "false") == 0) {
 			if (argtype != MNT_NOARG)
 				snprintf(buf, BUFSIZ, "no%s", field);
@@ -330,12 +230,8 @@ conf_parse_mntopts(char *section, char *arg, char *opts)
 		}
 		if (buf[0] == '\0')
 			continue;
-		/*
-		 * Keep a running tally of the list size adding
-		 * one for the ',' that will be appened later
-		 */
-		list_size += strlen(buf) + 1;
-		add_entry(buf);
+		po_append(options, buf);
+		default_value(buf);
 	}
 	conf_free_list(list);
 }
@@ -349,20 +245,22 @@ conf_parse_mntopts(char *section, char *arg, char *opts)
  * parsed.
  */
 char *conf_get_mntopts(char *spec, char *mount_point,
-	char *mount_opts)
+			      char *mount_opts)
 {
-	struct entry *entry;
-	char *ptr, *server, *config_opts;
-	int optlen = 0;
+	struct mount_options *options;
+	char *ptr, *server;
 
 	strict = 0;
-	SLIST_INIT(&head);
-	list_size = 0;
+	options = po_split(mount_opts);
+	if (!options) {
+		xlog_warn("conf_get_mountops: Unable calloc memory for options");
+		return mount_opts;
+	}
 	/*
 	 * First see if there are any mount options relative
 	 * to the mount point.
 	 */
-	conf_parse_mntopts(NFSMOUNT_MOUNTPOINT, mount_point, mount_opts);
+	conf_parse_mntopts(NFSMOUNT_MOUNTPOINT, mount_point, options);
 
 	/*
 	 * Next, see if there are any mount options relative
@@ -371,58 +269,27 @@ char *conf_get_mntopts(char *spec, char *mount_point,
 	server = strdup(spec);
 	if (server == NULL) {
 		xlog_warn("conf_get_mountops: Unable calloc memory for server");
-		free_all();
+		po_destroy(options);
 		return mount_opts;
 	}
 	if ((ptr = strchr(server, ':')) != NULL)
 		*ptr='\0';
-	conf_parse_mntopts(NFSMOUNT_SERVER, server, mount_opts);
+	conf_parse_mntopts(NFSMOUNT_SERVER, server, options);
 	free(server);
 
 	/*
 	 * Finally process all the global mount options.
 	 */
-	conf_parse_mntopts(NFSMOUNT_GLOBAL_OPTS, NULL, mount_opts);
-
-	/*
-	 * If no mount options were found in the configuration file
-	 * just return what was passed in .
-	 */
-	if (SLIST_EMPTY(&head))
-		return mount_opts;
+	conf_parse_mntopts(NFSMOUNT_GLOBAL_OPTS, NULL, options);
 
 	/*
-	 * Found options in the configuration file. So
-	 * concatenate the configuration options with the
-	 * options that were passed in
+	 * Strip out defaults, which have already been handled,
+	 * then join the rest and return.
 	 */
-	if (mount_opts)
-		optlen = strlen(mount_opts);
-
-	/* list_size + optlen + ',' + '\0' */
-	config_opts = calloc(1, (list_size+optlen+2));
-	if (config_opts == NULL) {
-		xlog_warn("conf_get_mountops: Unable calloc memory for config_opts");
-		free_all();
-		return mount_opts;
-	}
-
-	if (mount_opts) {
-		strcpy(config_opts, mount_opts);
-		strcat(config_opts, ",");
-	}
-	SLIST_FOREACH(entry, &head, entries) {
-		if (default_value(entry->opt))
-			continue;
-		strcat(config_opts, entry->opt);
-		strcat(config_opts, ",");
-	}
-	if ((ptr = strrchr(config_opts, ',')) != NULL)
-		*ptr = '\0';
+	po_remove_all(options, "default");
 
-	free_all();
-	if (mount_opts)
-		free(mount_opts);
+	po_join(options, &mount_opts);
+	po_destroy(options);
 
-	return config_opts;
+	return mount_opts;
 }


