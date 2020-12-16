Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120AB2DBA31
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Dec 2020 05:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgLPEof (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Dec 2020 23:44:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:58756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgLPEof (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 15 Dec 2020 23:44:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8170AD87;
        Wed, 16 Dec 2020 04:43:54 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Date:   Wed, 16 Dec 2020 15:43:03 +1100
Subject: [PATCH 5/7] mount: options in config file shouldn't over-ride
 command-line options.
Cc:     Justin Mitchell <jumitche@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Message-ID: <160809378308.7232.5025347167008614005.stgit@noble>
In-Reply-To: <160809318571.7232.10427700322834760606.stgit@noble>
References: <160809318571.7232.10427700322834760606.stgit@noble>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When reading from the config file, we already ignore options that exist
on the command line, or that were already found earlier in the config
file.  However this only works for exact matches of options.

e.g. if "noac" is on the command line and "ac=true" is in the config file,
then "ac" will be added, and this will be used.

Add tests for the "no" prefix, and also for "fg" vs "bg", so that if
"fg" is set on the command line, a "bg" or "background" setting in the
config file does not over-ride it.

Note that this *doesn't* handle the different protocol version
specifiers.  That will come later.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/mount/configfile.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/utils/mount/configfile.c b/utils/mount/configfile.c
index 8c68ff2c1323..40378ab247fc 100644
--- a/utils/mount/configfile.c
+++ b/utils/mount/configfile.c
@@ -204,6 +204,27 @@ conf_parse_mntopts(char *section, char *arg, struct mount_options *options)
 		field = mountopts_alias(node->field, &argtype);
 		if (po_contains(options, field) == PO_FOUND)
 			continue;
+		/* Some options can be inverted by a "no" prefix.
+		 * Check for these.
+		 * "no" prefixes are unlikely in the config file as
+		 * "option=false" is preferred, but still possible.
+		 */
+		if (strncmp(field, "no", 2) == 0 &&
+		    po_contains(options, field+2) == PO_FOUND)
+			continue;
+		if (strlen(field) < BUFSIZ-3) {
+			strcat(strcpy(buf, "no"), field);
+			if (po_contains(options, buf) == PO_FOUND)
+				continue;
+		}
+
+		/* If fg or bg already present, ignore bg or fg */
+		if (strcmp(field, "fg") == 0 &&
+		    po_contains(options, "bg") == PO_FOUND)
+			continue;
+		if (strcmp(field, "bg") == 0 &&
+		    po_contains(options, "fg") == PO_FOUND)
+			continue;
 
 		buf[0] = '\0';
 		value = conf_get_section(section, arg, node->field);


