Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7EF2DBA2D
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Dec 2020 05:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgLPEoW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Dec 2020 23:44:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:58488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgLPEoV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 15 Dec 2020 23:44:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53860AD43;
        Wed, 16 Dec 2020 04:43:40 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Date:   Wed, 16 Dec 2020 15:43:03 +1100
Subject: [PATCH 2/7] mount: report error if multiple version specifiers are
 given.
Cc:     Justin Mitchell <jumitche@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Message-ID: <160809378307.7232.18431719700214956275.stgit@noble>
In-Reply-To: <160809318571.7232.10427700322834760606.stgit@noble>
References: <160809318571.7232.10427700322834760606.stgit@noble>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The NFS version can be requested with multiple different options:
  v2 v3 v4 v4.x vers=x nfsvers=

If multiple versions are given with different options, the choice of
which wins is quite ideosyncratic.  It certainly isn't simple "last one
wins" as with some other options.

Rather than providing a coherent rule, simply make multiple version
specifiers illegal.

This requires enhancing po_contains_prefix() to be able to look beyond
the first match, it see if there are multiple matches with the same
prefix, as well as checking all prefixes to see if more than one
matches.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/mount/network.c   |   36 ++++++++++++++++++++++--------------
 utils/mount/parse_opt.c |   12 +++++++++---
 utils/mount/parse_opt.h |    3 ++-
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/utils/mount/network.c b/utils/mount/network.c
index d9c0b513101d..e803dbbe5a2c 100644
--- a/utils/mount/network.c
+++ b/utils/mount/network.c
@@ -1269,27 +1269,31 @@ int
 nfs_nfs_version(char *type, struct mount_options *options, struct nfs_version *version)
 {
 	char *version_key, *version_val = NULL, *cptr;
-	int i, found = 0;
+	int i, found = -1;
 
 	version->v_mode = V_DEFAULT;
 
 	for (i = 0; nfs_version_opttbl[i]; i++) {
 		if (po_contains_prefix(options, nfs_version_opttbl[i],
-				       &version_key) == PO_FOUND) {
-			found++;
-			break;
+				       &version_key, 0) == PO_FOUND) {
+			if (found >= 0)
+				goto ret_error_multiple;
+			if (po_contains_prefix(options, nfs_version_opttbl[i],
+					       NULL, 1) == PO_FOUND)
+				goto ret_error_multiple;
+			found = i;
 		}
 	}
 
-	if (!found && strcmp(type, "nfs4") == 0)
+	if (found < 0 && strcmp(type, "nfs4") == 0)
 		version_val = type + 3;
-	else if (!found)
+	else if (found < 0)
 		return 1;
-	else if (i <= 2 ) {
+	else if (found <= 2 ) {
 		/* v2, v3, v4 */
 		version_val = version_key + 1;
 		version->v_mode = V_SPECIFIC;
-	} else if (i > 2 ) {
+	} else if (found > 2 ) {
 		/* vers=, nfsvers= */
 		version_val = po_get(options, version_key);
 	}
@@ -1303,7 +1307,7 @@ nfs_nfs_version(char *type, struct mount_options *options, struct nfs_version *v
 	if (version->major == 4 && *cptr != '.' &&
 	    (version_val = po_get(options, "minorversion")) != NULL) {
 		version->minor = strtol(version_val, &cptr, 10);
-		i = -1;
+		found = -1;
 		if (*cptr)
 			goto ret_error;
 		version->v_mode = V_SPECIFIC;
@@ -1319,7 +1323,7 @@ nfs_nfs_version(char *type, struct mount_options *options, struct nfs_version *v
 		if (version_val != NULL) {
 			version->minor = strtol(version_val, &cptr, 10);
 			version->v_mode = V_SPECIFIC;
-		} else 
+		} else
 			version->v_mode = V_GENERAL;
 	}
 	if (*cptr != '\0')
@@ -1327,17 +1331,21 @@ nfs_nfs_version(char *type, struct mount_options *options, struct nfs_version *v
 
 	return 1;
 
+ret_error_multiple:
+	nfs_error(_("%s: multiple version options not permitted"),
+		  progname);
+	found = 10; /* avoid other errors */
 ret_error:
-	if (i < 0) {
+	if (found < 0) {
 		nfs_error(_("%s: parsing error on 'minorversion=' option"),
 			progname);
-	} else if (i <= 2 ) {
+	} else if (found <= 2 ) {
 		nfs_error(_("%s: parsing error on 'v' option"),
 			progname);
-	} else if (i == 3 ) {
+	} else if (found == 3 ) {
 		nfs_error(_("%s: parsing error on 'vers=' option"),
 			progname);
-	} else if (i == 4) {
+	} else if (found == 4) {
 		nfs_error(_("%s: parsing error on 'nfsvers=' option"),
 			progname);
 	}
diff --git a/utils/mount/parse_opt.c b/utils/mount/parse_opt.c
index 7ba61c4e52d8..b6065cad2888 100644
--- a/utils/mount/parse_opt.c
+++ b/utils/mount/parse_opt.c
@@ -414,19 +414,25 @@ po_found_t po_contains(struct mount_options *options, char *keyword)
  * @options: pointer to mount options
  * @prefix: pointer to prefix to match against a keyword
  * @keyword: pointer to a C string containing the option keyword if found
+ * @n: number of instances to skip, so '0' returns the first.
  *
  * On success, *keyword contains the pointer of the matching option's keyword.
  */
 po_found_t po_contains_prefix(struct mount_options *options,
-								const char *prefix, char **keyword)
+			      const char *prefix, char **keyword, int n)
 {
 	struct mount_option *option;
 
 	if (options && prefix) {
 		for (option = options->head; option; option = option->next)
 			if (strncmp(option->keyword, prefix, strlen(prefix)) == 0) {
-				*keyword = option->keyword;
-				return PO_FOUND;
+				if (n > 0) {
+					n -= 1;
+				} else {
+					if (keyword)
+						*keyword = option->keyword;
+					return PO_FOUND;
+				}
 			}
 	}
 
diff --git a/utils/mount/parse_opt.h b/utils/mount/parse_opt.h
index 0745e0f0833e..0a153768d434 100644
--- a/utils/mount/parse_opt.h
+++ b/utils/mount/parse_opt.h
@@ -46,7 +46,8 @@ po_return_t		po_join(struct mount_options *, char **);
 po_return_t		po_append(struct mount_options *, char *);
 po_found_t		po_contains(struct mount_options *, char *);
 po_found_t		po_contains_prefix(struct mount_options *options,
-						const char *prefix, char **keyword);
+					   const char *prefix, char **keyword,
+					   int n);
 char *			po_get(struct mount_options *, char *);
 po_found_t		po_get_numeric(struct mount_options *,
 					char *, long *);


