Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D52A8DB4
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 04:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgKFDsG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 22:48:06 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35608 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgKFDsG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 22:48:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UEO33AN_1604634469;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEO33AN_1604634469)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Nov 2020 11:48:01 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/nfsd: remove unused NFSDDBG_FACILITY to tame gcc
Date:   Fri,  6 Nov 2020 11:47:37 +0800
Message-Id: <1604634457-3954-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604634457-3954-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1604634457-3954-1-git-send-email-alex.shi@linux.alibaba.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There are lots of NFSDDBG_FACILITY defined in many files
but it isn't used anywhere. so remove it to tame the gcc warning:

fs/nfsd/nfsxdr.c:12:0: warning: macro "NFSDDBG_FACILITY" is not used
[-Wunused-macros]
fs/nfsd/filecache.c:23:0: warning: macro "NFSDDBG_FACILITY" is not used
[-Wunused-macros]
fs/nfsd/nfs3xdr.c:17:0: warning: macro "NFSDDBG_FACILITY" is not used
[-Wunused-macros]
fs/nfsd/flexfilelayoutxdr.c:11:0: warning: macro "NFSDDBG_FACILITY" is
not used [-Wunused-macros]
fs/nfsd/nfsxdr.c:12:0: warning: macro "NFSDDBG_FACILITY" is not used
[-Wunused-macros]
fs/nfsd/filecache.c:23:0: warning: macro "NFSDDBG_FACILITY" is not used
[-Wunused-macros]
fs/nfsd/nfs3xdr.c:17:0: warning: macro "NFSDDBG_FACILITY" is not used
[-Wunused-macros]
fs/nfsd/flexfilelayoutxdr.c:11:0: warning: macro "NFSDDBG_FACILITY" is
not used [-Wunused-macros]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org> 
Cc: Chuck Lever <chuck.lever@oracle.com> 
Cc: linux-nfs@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/nfsd/blocklayout.c       | 3 ---
 fs/nfsd/blocklayoutxdr.c    | 3 ---
 fs/nfsd/export.c            | 2 --
 fs/nfsd/filecache.c         | 2 --
 fs/nfsd/flexfilelayout.c    | 2 --
 fs/nfsd/flexfilelayoutxdr.c | 2 --
 fs/nfsd/lockd.c             | 2 --
 fs/nfsd/nfs2acl.c           | 2 --
 fs/nfsd/nfs3proc.c          | 2 --
 fs/nfsd/nfs3xdr.c           | 2 --
 fs/nfsd/nfs4callback.c      | 2 --
 fs/nfsd/nfs4layouts.c       | 2 --
 fs/nfsd/nfs4proc.c          | 2 --
 fs/nfsd/nfs4recover.c       | 2 --
 fs/nfsd/nfs4state.c         | 2 --
 fs/nfsd/nfs4xdr.c           | 2 --
 fs/nfsd/nfsfh.c             | 2 --
 fs/nfsd/nfsproc.c           | 2 --
 fs/nfsd/nfssvc.c            | 2 --
 fs/nfsd/nfsxdr.c            | 2 --
 fs/nfsd/vfs.c               | 2 --
 21 files changed, 44 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index a07c39c94bbd..81790fabae45 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -17,9 +17,6 @@
 #include "pnfs.h"
 #include "filecache.h"
 
-#define NFSDDBG_FACILITY	NFSDDBG_PNFS
-
-
 static __be32
 nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
 		struct nfsd4_layoutget *args)
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 442543304930..9a03ce88f9f2 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -10,9 +10,6 @@
 #include "nfsd.h"
 #include "blocklayoutxdr.h"
 
-#define NFSDDBG_FACILITY	NFSDDBG_PNFS
-
-
 __be32
 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 		struct nfsd4_layoutget *lgp)
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 21e404e7cb68..cf8b50f16d05 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -25,8 +25,6 @@
 #include "filecache.h"
 #include "trace.h"
 
-#define NFSDDBG_FACILITY	NFSDDBG_EXPORT
-
 /*
  * We have two caches.
  * One maps client+vfsmnt+dentry to export options - the export map
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 3c6c2f7d1688..8e5942648fef 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -20,8 +20,6 @@
 #include "filecache.h"
 #include "trace.h"
 
-#define NFSDDBG_FACILITY	NFSDDBG_FH
-
 /* FIXME: dynamically size this for the machine somehow? */
 #define NFSD_FILE_HASH_BITS                   12
 #define NFSD_FILE_HASH_SIZE                  (1 << NFSD_FILE_HASH_BITS)
diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index db7ef07ae50c..c764051eb22e 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -16,8 +16,6 @@
 #include "flexfilelayoutxdr.h"
 #include "pnfs.h"
 
-#define NFSDDBG_FACILITY	NFSDDBG_PNFS
-
 static __be32
 nfsd4_ff_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
 		struct nfsd4_layoutget *args)
diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index e81d2a5cf381..8a2e8bc05d4d 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -8,8 +8,6 @@
 #include "nfsd.h"
 #include "flexfilelayoutxdr.h"
 
-#define NFSDDBG_FACILITY	NFSDDBG_PNFS
-
 struct ff_idmap {
 	char buf[11];
 	int len;
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 3f5b3d7b62b7..7684e13b3813 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -12,8 +12,6 @@
 #include "nfsd.h"
 #include "vfs.h"
 
-#define NFSDDBG_FACILITY		NFSDDBG_LOCKD
-
 #ifdef CONFIG_LOCKD_V4
 #define nlm_stale_fh	nlm4_stale_fh
 #define nlm_failed	nlm4_failed
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 6a900f770dd2..09088c4b2d3d 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -13,8 +13,6 @@
 #include "xdr3.h"
 #include "vfs.h"
 
-#define NFSDDBG_FACILITY		NFSDDBG_PROC
-
 /*
  * NULL call.
  */
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index a633044b0dc1..781e265921aa 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -13,8 +13,6 @@
 #include "xdr3.h"
 #include "vfs.h"
 
-#define NFSDDBG_FACILITY		NFSDDBG_PROC
-
 static int	nfs3_ftypes[] = {
 	0,			/* NF3NON */
 	S_IFREG,		/* NF3REG */
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 1d30c21af01a..07c8e16ac189 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -14,8 +14,6 @@
 #include "netns.h"
 #include "vfs.h"
 
-#define NFSDDBG_FACILITY		NFSDDBG_XDR
-
 
 /*
  * Mapping of S_IF* types to NFS file types
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 052be5bf9ef5..642d6c1779da 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -42,8 +42,6 @@
 #include "xdr4cb.h"
 #include "xdr4.h"
 
-#define NFSDDBG_FACILITY                NFSDDBG_PROC
-
 static void nfsd4_mark_cb_fault(struct nfs4_client *, int reason);
 
 #define NFSPROC4_CB_NULL 0
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index a97873f2d22b..e77b05516707 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -13,8 +13,6 @@
 #include "netns.h"
 #include "trace.h"
 
-#define NFSDDBG_FACILITY                NFSDDBG_PNFS
-
 struct nfs4_layout {
 	struct list_head		lo_perstate;
 	struct nfs4_layout_stateid	*lo_state;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ad2fa1a8e7ad..fa6ed4ad7335 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -80,8 +80,6 @@
 { }
 #endif
 
-#define NFSDDBG_FACILITY		NFSDDBG_PROC
-
 static u32 nfsd_attrmask[] = {
 	NFSD_WRITEABLE_ATTRS_WORD0,
 	NFSD_WRITEABLE_ATTRS_WORD1,
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 186fa2c2c6ba..9c8738e32b74 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -49,8 +49,6 @@
 #include "vfs.h"
 #include "netns.h"
 
-#define NFSDDBG_FACILITY                NFSDDBG_PROC
-
 /* Declarations */
 struct nfsd4_client_tracking_ops {
 	int (*init)(struct net *);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d7f27ed6b794..79286c96f480 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -53,8 +53,6 @@
 #include "filecache.h"
 #include "trace.h"
 
-#define NFSDDBG_FACILITY                NFSDDBG_PROC
-
 #define all_ones {{~0,~0},~0}
 static const stateid_t one_stateid = {
 	.si_generation = ~0,
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e3c6bea83bd6..f318c12371ab 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -59,8 +59,6 @@
 #endif
 
 
-#define NFSDDBG_FACILITY		NFSDDBG_XDR
-
 const u32 nfsd_suppattrs[3][3] = {
 	{NFSD4_SUPPORTED_ATTRS_WORD0,
 	 NFSD4_SUPPORTED_ATTRS_WORD1,
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index c81dbbad8792..196ab411df77 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -16,8 +16,6 @@
 #include "auth.h"
 #include "trace.h"
 
-#define NFSDDBG_FACILITY		NFSDDBG_FH
-
 
 /*
  * our acceptability function.
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 0d71549f9d42..230da422bb43 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -11,8 +11,6 @@
 #include "xdr.h"
 #include "vfs.h"
 
-#define NFSDDBG_FACILITY		NFSDDBG_PROC
-
 static __be32
 nfsd_proc_null(struct svc_rqst *rqstp)
 {
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 27b1ad136150..b5c6f439086a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -29,8 +29,6 @@
 #include "netns.h"
 #include "filecache.h"
 
-#define NFSDDBG_FACILITY	NFSDDBG_SVC
-
 bool inter_copy_offload_enable;
 EXPORT_SYMBOL_GPL(inter_copy_offload_enable);
 module_param(inter_copy_offload_enable, bool, 0644);
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 9e00a902113e..0f797da50f78 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -9,8 +9,6 @@
 #include "xdr.h"
 #include "auth.h"
 
-#define NFSDDBG_FACILITY		NFSDDBG_XDR
-
 /*
  * Mapping of S_IF* types to NFS file types
  */
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 1ecaceebee13..4c31b9f4a54b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -47,8 +47,6 @@
 #include "filecache.h"
 #include "trace.h"
 
-#define NFSDDBG_FACILITY		NFSDDBG_FILEOP
-
 /* 
  * Called from nfsd_lookup and encode_dirent. Check if we have crossed 
  * a mount point.
-- 
1.8.3.1

