Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91C438BBC4
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 03:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbhEUBlz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 May 2021 21:41:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:43892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237378AbhEUBly (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 May 2021 21:41:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7297ABD0;
        Fri, 21 May 2021 01:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Steve Dickson" <SteveD@RedHat.com>
Cc:     "Petr Vorel" <pvorel@suse.cz>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
        "Alexey Kodanev" <alexey.kodanev@oracle.com>
Subject: [PATCH nfs-utils 1/2] Remove 'force' arg from cache_flush()
In-reply-to: <162156113063.19062.9406037279407040033@noble.neil.brown.name>
References: <20210422191803.31511-1-pvorel@suse.cz>,
 <20210422202334.GB25415@fieldses.org>, <YILQip3nAxhpXP9+@pevik>,
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>,
 <162122673178.19062.96081788305923933@noble.neil.brown.name>,
 <289c5819-917a-39a7-9aa4-2a27ae7248c0@RedHat.com>,
 <162156113063.19062.9406037279407040033@noble.neil.brown.name>
Date:   Fri, 21 May 2021 11:40:22 +1000
Message-id: <162156122215.19062.11710239266795260824@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Since v4.17 the timestamp written to 'flush' is ignored,
so there isn't much point choosing too precisely.

For kernels since v4.3-rc3-13-g778620364ef5 it is safe
to write 1 second beyond the current time.

For earlier kernels, nothing is really safe (even the current
behaviour), but writing one second beyond the current time isn't too bad
in the unlikely case the people use a new nfs-utils on a 5 year old
kernel.

This remove a dependency for libnfs.a on 'etab' being declare,
so svcgssd no longer needs to declare it.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/export/auth.c     |  2 +-
 support/include/nfslib.h  |  2 +-
 support/nfs/cacheio.c     | 17 ++++++++---------
 utils/exportfs/exportfs.c |  4 ++--
 utils/gssd/svcgssd.c      |  1 -
 5 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/support/export/auth.c b/support/export/auth.c
index cea376300d01..17bdfc83748e 100644
--- a/support/export/auth.c
+++ b/support/export/auth.c
@@ -80,7 +80,7 @@ check_useipaddr(void)
 		use_ipaddr = 0;
 
 	if (use_ipaddr != old_use_ipaddr)
-		cache_flush(1);
+		cache_flush();
 }
 
 unsigned int
diff --git a/support/include/nfslib.h b/support/include/nfslib.h
index 84d8270b330f..58eeb3382fcc 100644
--- a/support/include/nfslib.h
+++ b/support/include/nfslib.h
@@ -132,7 +132,7 @@ int			wildmat(char *text, char *pattern);
 
 int qword_get(char **bpp, char *dest, int bufsize);
 int qword_get_int(char **bpp, int *anint);
-void cache_flush(int force);
+void cache_flush(void);
 void qword_add(char **bpp, int *lp, char *str);
 void qword_addhex(char **bpp, int *lp, char *buf, int blen);
 void qword_addint(char **bpp, int *lp, int n);
diff --git a/support/nfs/cacheio.c b/support/nfs/cacheio.c
index 70ead94d64f0..73f4be4af9f9 100644
--- a/support/nfs/cacheio.c
+++ b/support/nfs/cacheio.c
@@ -32,8 +32,6 @@
 #include <time.h>
 #include <errno.h>
 
-extern struct state_paths etab;
-
 void qword_add(char **bpp, int *lp, char *str)
 {
 	char *bp = *bpp;
@@ -213,7 +211,7 @@ int qword_get_uint(char **bpp, unsigned int *anint)
  */
 
 void
-cache_flush(int force)
+cache_flush(void)
 {
 	struct stat stb;
 	int c;
@@ -234,12 +232,13 @@ cache_flush(int force)
 		NULL
 	};
 	now = time(0);
-	if (force ||
-	    stat(etab.statefn, &stb) != 0 ||
-	    stb.st_mtime > now)
-		stb.st_mtime = time(0);
-	
-	sprintf(stime, "%" PRId64 "\n", (int64_t)stb.st_mtime);
+
+	/* Since v4.16-rc2-3-g3b68e6ee3cbd the timestamp written is ignored.
+	 * It is safest always to flush caches if there is any doubt.
+	 * For earlier kernels, writing the next second from now is
+	 * the best we can do.
+	 */
+	sprintf(stime, "%" PRId64 "\n", (int64_t)now+1);
 	for (c=0; cachelist[c]; c++) {
 		int fd;
 		sprintf(path, "/proc/net/rpc/%s/flush", cachelist[c]);
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index bc76aaaf8714..d586296796a9 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -188,7 +188,7 @@ main(int argc, char **argv)
 
 	if (optind == argc && ! f_all) {
 		if (force_flush) {
-			cache_flush(1);
+			cache_flush();
 			free_state_path_names(&etab);
 			return 0;
 		} else {
@@ -235,7 +235,7 @@ main(int argc, char **argv)
 				unexportfs(argv[i], f_verbose);
 	}
 	xtab_export_write();
-	cache_flush(force_flush);
+	cache_flush();
 	free_state_path_names(&etab);
 	export_freeall();
 
diff --git a/utils/gssd/svcgssd.c b/utils/gssd/svcgssd.c
index 3ab2100b66bb..881207b3e8a2 100644
--- a/utils/gssd/svcgssd.c
+++ b/utils/gssd/svcgssd.c
@@ -67,7 +67,6 @@
 #include "misc.h"
 #include "svcgssd_krb5.h"
 
-struct state_paths etab; /* from cacheio.c */
 static bool signal_received = false;
 static struct event_base *evbase = NULL;
 static int nullrpc_fd = -1;
-- 
2.31.1

