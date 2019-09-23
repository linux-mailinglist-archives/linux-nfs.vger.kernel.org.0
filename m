Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11051BAD49
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2019 06:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406625AbfIWE1k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Sep 2019 00:27:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:47328 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405826AbfIWE1j (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 23 Sep 2019 00:27:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B6ABAFA4;
        Mon, 23 Sep 2019 04:27:38 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Mon, 23 Sep 2019 14:26:58 +1000
Subject: [PATCH 2/3] conffile: allow optional include files.
Cc:     linux-nfs@vger.kernel.org
Message-ID: <156921281807.27519.17127755754207047423.stgit@noble.brown>
In-Reply-To: <156921267783.27519.2402857390317412450.stgit@noble.brown>
References: <156921267783.27519.2402857390317412450.stgit@noble.brown>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If nfs.conf contains, for example
  include = /etc/nfs.conf.local
and /etc/nfs.conf.local doesn't exist, then a warning is given.
Sometimes it is useful to have an optional include file which is
included if present, but for which an absence doesn't give a
warning.

Systemd has a convention that a hyphen at the start of
an include file name marks it as optional, so add this convention
to nfs-utils.
So
  include = -/etc/nfs.conf.local
will not give a warning if the file doesn't exist.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/nfs/conffile.c |   13 ++++++++++---
 systemd/nfs.conf.man   |    3 +++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index 6ba8a35ce7c6..d55bfe10120a 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -412,11 +412,18 @@ conf_parse_line(int trans, char *line, const char *filename, int lineno, char **
 
 	if (strcasecmp(line, "include")==0) {
 		/* load and parse subordinate config files */
+		_Bool optional = false;
+
+		if (val && *val == '-') {
+			optional = true;
+			val++;
+		}
+
 		relpath = relative_path(filename, val);
 		if (relpath == NULL) {
-			xlog_warn("config error at %s:%d: "
-				"error loading included config",
-				  filename, lineno);
+			if (!optional)
+				xlog_warn("config error at %s:%d: error loading included config",
+					  filename, lineno);
 			return;
 		}
 
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index d375bcc1d5a7..3f1c7261991d 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -65,6 +65,9 @@ section headers, then new sections will be created just as if the
 included file appeared in place of the
 .B include
 line.
+If the file name starts with a hyphen then that is stripped off
+before the file is opened, and if file doesn't exist no warning is
+given.  Normally a non-existent include file generates a warning.
 .PP
 Lookup of section and value names is case-insensitive.
 


