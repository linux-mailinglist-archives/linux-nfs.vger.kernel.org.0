Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 805FDBAD48
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2019 06:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406614AbfIWE1e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Sep 2019 00:27:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:47318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405826AbfIWE1e (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 23 Sep 2019 00:27:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0241DAFA4;
        Mon, 23 Sep 2019 04:27:33 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Mon, 23 Sep 2019 14:26:58 +1000
Subject: [PATCH 1/3] mountd: Initialize logging early.
Cc:     linux-nfs@vger.kernel.org
Message-ID: <156921281804.27519.8558488144520627125.stgit@noble.brown>
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

Reading the config file can generate log messages,
so we should initialize logging before reading the
config file.

If any log message are generated, syslog will leave
a file descriptor open (a socket), so calling
closeall(3) after this can cause problem.
Before this we initialize login we don't know if
Foreground (-F) has been selected, so closeall()
cannot be conditional on that.

closeall() isn't needed - daemon are almost always run
from a management daemon like systemd, and they are given
a clean environment.  It is really best if they just take
what they are given.

So remove the closeall() call.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/mountd/mountd.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index 33571ecbd401..5a12d0bcd19e 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -681,6 +681,9 @@ main(int argc, char **argv)
 	else
 		progname = argv[0];
 
+	/* Initialize logging. */
+	xlog_open(progname);
+
 	conf_init_file(NFS_CONFFILE);
 	xlog_from_conffile("mountd");
 	manage_gids = conf_get_bool("mountd", "manage-gids", manage_gids);
@@ -820,9 +823,7 @@ main(int argc, char **argv)
 			}
 		}
 	}
-	/* Initialize logging. */
 	if (!foreground) xlog_stderr(0);
-	xlog_open(progname);
 
 	sa.sa_handler = SIG_IGN;
 	sa.sa_flags = 0;
@@ -834,10 +835,6 @@ main(int argc, char **argv)
 	/* WARNING: the following works on Linux and SysV, but not BSD! */
 	sigaction(SIGCHLD, &sa, NULL);
 
-	/* Daemons should close all extra filehandles ... *before* RPC init. */
-	if (!foreground)
-		closeall(3);
-
 	unregister_services();
 	if (version2()) {
 		listeners += nfs_svc_create("mountd", MOUNTPROG,


