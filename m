Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1455138BBC5
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 03:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbhEUBmo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 20 May 2021 21:42:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:44052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237319AbhEUBmn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 May 2021 21:42:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6BAAAB6D;
        Fri, 21 May 2021 01:41:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Steve Dickson" <SteveD@RedHat.com>
Cc:     "Petr Vorel" <pvorel@suse.cz>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
        "Alexey Kodanev" <alexey.kodanev@oracle.com>
Subject: [PATCH nfs-utils 2/2] Move declaration of etab and rmtab into libraries
In-reply-to: <162156122215.19062.11710239266795260824@noble.neil.brown.name>
References: <20210422191803.31511-1-pvorel@suse.cz>,
 <20210422202334.GB25415@fieldses.org>, <YILQip3nAxhpXP9+@pevik>,
 <162035212343.24322.12361160756597283121@noble.neil.brown.name>,
 <162122673178.19062.96081788305923933@noble.neil.brown.name>,
 <289c5819-917a-39a7-9aa4-2a27ae7248c0@RedHat.com>,
 <162156113063.19062.9406037279407040033@noble.neil.brown.name>,
 <162156122215.19062.11710239266795260824@noble.neil.brown.name>
Date:   Fri, 21 May 2021 11:41:12 +1000
Message-id: <162156127225.19062.3275458295434454950@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


There are two global "struct stat_paths" structures: etab and rmtab.
They are currently needed by some library code so any program which is
linked with that library code needs to declare the structures even if it
doesn't use the functionality.  This is clumsy and error-prone.

Instead: have the library declare the structure and put the definition
in a header file.  Now programs only need to know about these structures
if they use the functionality.

'rmtab' is now declared in libnfs.a (rmtab.c).  'etab' is declared in
export.a (xtab.c).

Signed-off-by: NeilBrown <neilb@suse.de>
---
 support/export/auth.c      | 2 --
 support/export/xtab.c      | 2 +-
 support/include/exportfs.h | 1 +
 support/include/nfslib.h   | 1 +
 support/nfs/rmtab.c        | 2 +-
 utils/exportd/exportd.c    | 2 --
 utils/exportfs/exportfs.c  | 2 --
 utils/mountd/mountd.c      | 3 ---
 utils/mountd/rmtab.c       | 2 --
 9 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/support/export/auth.c b/support/export/auth.c
index 17bdfc83748e..03ce4b8a0e1e 100644
--- a/support/export/auth.c
+++ b/support/export/auth.c
@@ -41,8 +41,6 @@ static nfs_client my_client;
 
 extern int use_ipaddr;
 
-extern struct state_paths etab;
-
 /*
 void
 auth_init(void)
diff --git a/support/export/xtab.c b/support/export/xtab.c
index 00b25eaac07d..c888a80aa741 100644
--- a/support/export/xtab.c
+++ b/support/export/xtab.c
@@ -27,7 +27,7 @@
 #include "misc.h"
 
 static char state_base_dirname[PATH_MAX] = NFS_STATEDIR;
-extern struct state_paths etab;
+struct state_paths etab;
 
 int v4root_needed;
 static void cond_rename(char *newfile, char *oldfile);
diff --git a/support/include/exportfs.h b/support/include/exportfs.h
index 7c1b74537186..9edf0d04732f 100644
--- a/support/include/exportfs.h
+++ b/support/include/exportfs.h
@@ -145,6 +145,7 @@ nfs_export *			export_create(struct exportent *, int canonical);
 void				exportent_release(struct exportent *);
 void				export_freeall(void);
 
+extern struct state_paths etab;
 int				xtab_export_read(void);
 int				xtab_export_write(void);
 
diff --git a/support/include/nfslib.h b/support/include/nfslib.h
index 58eeb3382fcc..6faba71bf0cd 100644
--- a/support/include/nfslib.h
+++ b/support/include/nfslib.h
@@ -106,6 +106,7 @@ void			dupexportent(struct exportent *dst,
 					struct exportent *src);
 int			updateexportent(struct exportent *eep, char *options);
 
+extern struct state_paths rmtab;
 int			setrmtabent(char *type);
 struct rmtabent *	getrmtabent(int log, long *pos);
 void			putrmtabent(struct rmtabent *xep, long *pos);
diff --git a/support/nfs/rmtab.c b/support/nfs/rmtab.c
index 9f03167ddbe1..154b26fa3402 100644
--- a/support/nfs/rmtab.c
+++ b/support/nfs/rmtab.c
@@ -33,7 +33,7 @@
 
 static FILE	*rmfp = NULL;
 
-extern struct state_paths rmtab;
+struct state_paths rmtab;
 
 int
 setrmtabent(char *type)
diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
index f36f51d215b5..2dd12cb6015b 100644
--- a/utils/exportd/exportd.c
+++ b/utils/exportd/exportd.c
@@ -25,8 +25,6 @@
 
 extern void my_svc_run(void);
 
-struct state_paths etab;
-
 /* Number of mountd threads to start.   Default is 1 and
  * that's probably enough unless you need hundreds of
  * clients to be able to mount at once.  */
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index d586296796a9..6ba615d1443d 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -52,8 +52,6 @@ static void release_lockfile(void);
 static const char *lockfile = EXP_LOCKFILE;
 static int _lockfd = -1;
 
-struct state_paths etab;
-
 /*
  * If we aren't careful, changes made by exportfs can be lost
  * when multiple exports process run at once:
diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index 39e85fd53a87..bcf749fabbb3 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -43,9 +43,6 @@ int reverse_resolve = 0;
 int manage_gids;
 int use_ipaddr = -1;
 
-struct state_paths etab;
-struct state_paths rmtab;
-
 /* PRC: a high-availability callout program can be specified with -H
  * When this is done, the program will receive callouts whenever clients
  * send mount or unmount requests -- the callout is not needed for 2.6 kernel */
diff --git a/utils/mountd/rmtab.c b/utils/mountd/rmtab.c
index c8962439ddd2..2da97615ca0f 100644
--- a/utils/mountd/rmtab.c
+++ b/utils/mountd/rmtab.c
@@ -28,8 +28,6 @@
 
 extern int reverse_resolve;
 
-extern struct state_paths rmtab;
-
 /* If new path is a link do not destroy it but place the
  * file where the link points.
  */
-- 
2.31.1

