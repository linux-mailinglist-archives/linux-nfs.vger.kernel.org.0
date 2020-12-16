Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A662DBA2E
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Dec 2020 05:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgLPEo0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Dec 2020 23:44:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:58562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgLPEo0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 15 Dec 2020 23:44:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2EC92AD5A;
        Wed, 16 Dec 2020 04:43:45 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Date:   Wed, 16 Dec 2020 15:43:03 +1100
Subject: [PATCH 3/7] Revert "mount.nfs: merge in vers= and nfsvers= options"
Cc:     Justin Mitchell <jumitche@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Message-ID: <160809378307.7232.12486406696809312958.stgit@noble>
In-Reply-To: <160809318571.7232.10427700322834760606.stgit@noble>
References: <160809318571.7232.10427700322834760606.stgit@noble>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This reverts commit 8110103404b35d9e86057ef0764f8aa87585f455.

Using mnt_alias_tab[] to handle options which are synonyms isn't really
a good fit.  This sort-of works, but in part only because 'strstr()'
is used for matching so "vers=" is found when "nfsvers=" is present.
This doesn't handle other version-setting options like v2, v3, v4.x.

So remove this commit to make room for a better solution.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/mount/configfile.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/utils/mount/configfile.c b/utils/mount/configfile.c
index 2470bc6a8bf6..e20aa73739fc 100644
--- a/utils/mount/configfile.c
+++ b/utils/mount/configfile.c
@@ -70,7 +70,6 @@ struct mnt_alias {
 	{"background", "bg", MNT_NOARG},
 	{"foreground", "fg", MNT_NOARG},
 	{"sloppy", "sloppy", MNT_NOARG},
-	{"nfsvers", "vers", MNT_UNSET},
 };
 int mnt_alias_sz = (sizeof(mnt_alias_tab)/sizeof(mnt_alias_tab[0]));
 
@@ -296,21 +295,20 @@ conf_parse_mntopts(char *section, char *arg, char *opts)
 
 	list = conf_get_tag_list(section, arg);
 	TAILQ_FOREACH(node, &list->fields, link) {
-		/* check first if this is an alias for another option */
-		field = mountopts_alias(node->field, &argtype);
 		/*
 		 * Do not overwrite options if already exists
 		 */
-		snprintf(buf, BUFSIZ, "%s=", field);
+		snprintf(buf, BUFSIZ, "%s=", node->field);
 		if (opts && strcasestr(opts, buf) != NULL)
 			continue;
 
-		if (lookup_entry(field) != NULL)
+		if (lookup_entry(node->field) != NULL)
 			continue;
 		buf[0] = '\0';
 		value = conf_get_section(section, arg, node->field);
 		if (value == NULL)
 			continue;
+		field = mountopts_alias(node->field, &argtype);
 		if (strcasecmp(value, "false") == 0) {
 			if (argtype != MNT_NOARG)
 				snprintf(buf, BUFSIZ, "no%s", field);


