Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D865A2DBA32
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Dec 2020 05:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgLPEpA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Dec 2020 23:45:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:59144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgLPEo7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 15 Dec 2020 23:44:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69AB9AF0B;
        Wed, 16 Dec 2020 04:43:59 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Date:   Wed, 16 Dec 2020 15:43:03 +1100
Subject: [PATCH 6/7] mount: don't add config-file protcol version options when
 already present.
Cc:     Justin Mitchell <jumitche@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Message-ID: <160809378308.7232.14269291283808304181.stgit@noble>
In-Reply-To: <160809318571.7232.10427700322834760606.stgit@noble>
References: <160809318571.7232.10427700322834760606.stgit@noble>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If there is already an option specifying the protocol version, whether
from the command line or from an earlier config section, don't add new
version options.

There are multiple different version options, so they need to be handled
differently from other options.  There could in the future be more
options that start "v4.", e.g.  "v4.3" might happen one day.  So rather
than list possible "v4.x" options, handle "v4." separately.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/mount/configfile.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/utils/mount/configfile.c b/utils/mount/configfile.c
index 40378ab247fc..7934f4f625d9 100644
--- a/utils/mount/configfile.c
+++ b/utils/mount/configfile.c
@@ -70,8 +70,23 @@ struct mnt_alias {
 };
 int mnt_alias_sz = (sizeof(mnt_alias_tab)/sizeof(mnt_alias_tab[0]));
 
+static const char *version_keys[] = {
+	"v2", "v3", "v4", "vers", "nfsvers", "minorversion", NULL
+};
+
 static int strict;
 
+static int is_version(const char *field)
+{
+	int i;
+	for (i = 0; version_keys[i] ; i++)
+		if (strcmp(version_keys[i], field) == 0)
+			return 1;
+	if (strncmp(field, "v4.", 3) == 0)
+		return 1;
+	return 0;
+}
+
 /*
  * See if the option is an alias, if so return the
  * real mount option along with the argument type.
@@ -195,6 +210,11 @@ conf_parse_mntopts(char *section, char *arg, struct mount_options *options)
 	char buf[BUFSIZ], *value, *field;
 	char *nvalue, *ptr;
 	int argtype;
+	int have_version = 0;
+
+	if (po_rightmost(options, version_keys) >= 0 ||
+	    po_contains_prefix(options, "v4.", NULL, 0) == PO_FOUND)
+		have_version = 1;
 
 	list = conf_get_tag_list(section, arg);
 	TAILQ_FOREACH(node, &list->fields, link) {
@@ -226,6 +246,12 @@ conf_parse_mntopts(char *section, char *arg, struct mount_options *options)
 		    po_contains(options, "fg") == PO_FOUND)
 			continue;
 
+		if (is_version(field)) {
+			if (have_version)
+				continue;
+			have_version = 1;
+		}
+
 		buf[0] = '\0';
 		value = conf_get_section(section, arg, node->field);
 		if (value == NULL)


