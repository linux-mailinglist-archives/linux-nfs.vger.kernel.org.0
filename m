Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F74BAD4A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2019 06:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406652AbfIWE1q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Sep 2019 00:27:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:47352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405826AbfIWE1q (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 23 Sep 2019 00:27:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A6E7B024;
        Mon, 23 Sep 2019 04:27:44 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Mon, 23 Sep 2019 14:26:58 +1000
Subject: [PATCH 3/3] statd: take user-id from /var/lib/nfs/sm
Cc:     linux-nfs@vger.kernel.org
Message-ID: <156921281809.27519.10997149063922425666.stgit@noble.brown>
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

Having /var/lib/nfs writeable by statd is not ideal
as there are files in there that statd doesn't need
to access.
After dropping privs, statd and sm-notify only need to
access files in the directories sm and sm.bak.
So take the uid for these deamons from 'sm'.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/nsm/file.c        |   16 +++++-----------
 utils/statd/sm-notify.man |   10 +++++++++-
 utils/statd/statd.man     |   10 +++++++++-
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/support/nsm/file.c b/support/nsm/file.c
index 0b66f123165e..f5b448015751 100644
--- a/support/nsm/file.c
+++ b/support/nsm/file.c
@@ -388,23 +388,17 @@ nsm_drop_privileges(const int pidfd)
 
 	(void)umask(S_IRWXO);
 
-	/*
-	 * XXX: If we can't stat dirname, or if dirname is owned by
-	 *      root, we should use "statduser" instead, which is set up
-	 *      by configure.ac.  Nothing in nfs-utils seems to use
-	 *      "statduser," though.
-	 */
-	if (lstat(nsm_base_dirname, &st) == -1) {
-		xlog(L_ERROR, "Failed to stat %s: %m", nsm_base_dirname);
-		return false;
-	}
-
 	if (chdir(nsm_base_dirname) == -1) {
 		xlog(L_ERROR, "Failed to change working directory to %s: %m",
 				nsm_base_dirname);
 		return false;
 	}
 
+	if (lstat(NSM_MONITOR_DIR, &st) == -1) {
+		xlog(L_ERROR, "Failed to stat %s/%s: %m", nsm_base_dirname, NSM_MONITOR_DIR);
+		return false;
+	}
+
 	if (!prune_bounding_set())
 		return false;
 
diff --git a/utils/statd/sm-notify.man b/utils/statd/sm-notify.man
index cfe1e4b1dac8..addf5d3c028e 100644
--- a/utils/statd/sm-notify.man
+++ b/utils/statd/sm-notify.man
@@ -190,7 +190,15 @@ by default.
 After starting,
 .B sm-notify
 attempts to set its effective UID and GID to the owner
-and group of this directory.
+and group of the subdirectory
+.B sm
+of this directory.  After changing the effective ids,
+.B sm-notify
+only needs to access files in
+.B sm
+and
+.B sm.bak
+within the state-directory-path.
 .TP
 .BI -v " ipaddr " | " hostname
 Specifies the network address from which to send reboot notifications,
diff --git a/utils/statd/statd.man b/utils/statd/statd.man
index 71d58461b5ea..6222701e38a8 100644
--- a/utils/statd/statd.man
+++ b/utils/statd/statd.man
@@ -259,7 +259,15 @@ by default.
 After starting,
 .B rpc.statd
 attempts to set its effective UID and GID to the owner
-and group of this directory.
+and group of the subdirectory
+.B sm
+of this directory.  After changing the effective ids,
+.B rpc.statd
+only needs to access files in
+.B sm
+and
+.B sm.bak
+within the state-directory-path.
 .TP
 .BR -v ", " -V ", " --version
 Causes


