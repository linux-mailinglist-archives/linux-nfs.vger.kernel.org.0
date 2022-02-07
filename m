Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD514AC727
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 18:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiBGRTW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 12:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358152AbiBGREk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 12:04:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9586AC0401D1
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 09:04:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 089EDB81625
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 17:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A19C004E1
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 17:04:36 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC] NFSD: Remove CONFIG_NFSD_V3
Date:   Mon,  7 Feb 2022 12:04:35 -0500
Message-Id:  <164425347004.187955.6630130018785430850.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.35.0
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=7410; h=from:subject:message-id; bh=1WdQ6X3Bl98gFyPdRgf8jiqiHyf0CYMBXVJXiNt6tdI=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiAVEex08Zr+S6/iyQtY7C1kXSDgKpwwnPsUQptvJ9 riQPP0uJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYgFRHgAKCRAzarMzb2Z/l473EA CyxFiy8LQ5nNpus896ZIOGpQ8S2cd9QLE5CqLHRtwXB3bcSCWskZ9fz9kRcavAdtDgF+plOaDl3+Im XemtoGiFUWhtKPXSdBr0AJR79kuv0XPM/IjsMsLgj55HYH77CxaTexCSEXomSN29C5ITlix53mUGTv o2Bafgt1vAG7afB6ONRR8AJpvr9vLtRUtAIXXT1IkeDW/nW04fZhoZpEs4yn8cxOFoUD2sNyldatll TuJPUuPz8I+ZpqCBhovZHDTB1wvnxLSl9NvTv47f+YrOdVC4lk0+y5I+NxgTjxHkhrX6CT6tuVIlMc wPGsUgsMak8XDC5hUsC/KCdkqWaE0O6h3xhLa5cNrn1X7n9jg+jRCnll9gvT9HAeIfSGuepUff4ge8 wW0vYtSqc+OPNF4uHBFVftEYHaS5igkUM25CMvGjnLXb+Aiz2ql790a9MOrxbsjxEKywW8btar/AzY vna2zPoSHBMZnfcF5WfkE1RBLaaGe2QfqAKbX9QYduKLSkATzHC3nlGrnqbe6mQJw6REvS7fln3Q/X v3abEUUQEnVDT0PE1kYZONYxS9sSkRe4MHU38HD4Vb9Ycz1Ek1WoAsFsnZpa42xg2/Sj3QcLEOAABm Efh8Up2DP5IrexbDvEjmMC2HB/q01dBIWuvWsZslnA9e2LMt3YJWFy8pSiKg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Eventually support for NFSv2 in the Linux NFS server is to be
deprecated and then removed.

However, NFSv2 is the "always supported" version that is available
as soon as CONFIG_NFSD is set.  Before NFSv2 support can be removed,
we need to choose a different "always supported" version.

This patch removes CONFIG_NFSD_V3 so that NFSv3 is always supported,
as NFSv2 is today. When NFSv2 support is removed, NFSv3 will become
the only "always supported" NFS version.

The defconfigs still need to be updated to remove CONFIG_NFSD_V3=y.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/Kconfig  |   11 -----------
 fs/nfsd/Makefile |    3 +--
 fs/nfsd/nfsfh.c  |    4 ----
 fs/nfsd/nfsfh.h  |   20 --------------------
 fs/nfsd/nfssvc.c |    2 --
 fs/nfsd/vfs.c    |    9 ---------
 fs/nfsd/vfs.h    |    2 --
 7 files changed, 1 insertion(+), 50 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 3d1d17256a91..c8446663109c 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -35,18 +35,8 @@ config NFSD_V2_ACL
 	bool
 	depends on NFSD
 
-config NFSD_V3
-	bool "NFS server support for NFS version 3"
-	depends on NFSD
-	help
-	  This option enables support in your system's NFS server for
-	  version 3 of the NFS protocol (RFC 1813).
-
-	  If unsure, say Y.
-
 config NFSD_V3_ACL
 	bool "NFS server support for the NFSv3 ACL protocol extension"
-	depends on NFSD_V3
 	select NFSD_V2_ACL
 	help
 	  Solaris NFS servers support an auxiliary NFSv3 ACL protocol that
@@ -70,7 +60,6 @@ config NFSD_V3_ACL
 config NFSD_V4
 	bool "NFS server support for NFS version 4"
 	depends on NFSD && PROC_FS
-	select NFSD_V3
 	select FS_POSIX_ACL
 	select SUNRPC_GSS
 	select CRYPTO
diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index 3f0983e93a99..805c06d5f1b4 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -12,9 +12,8 @@ nfsd-y			+= trace.o
 
 nfsd-y 			+= nfssvc.o nfsctl.o nfsproc.o nfsfh.o vfs.o \
 			   export.o auth.o lockd.o nfscache.o nfsxdr.o \
-			   stats.o filecache.o
+			   stats.o filecache.o nfs3proc.o nfs3xdr.o
 nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
-nfsd-$(CONFIG_NFSD_V3)	+= nfs3proc.o nfs3xdr.o
 nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
 nfsd-$(CONFIG_NFSD_V4)	+= nfs4proc.o nfs4xdr.o nfs4state.o nfs4idmap.o \
 			   nfs4acl.o nfs4callback.o nfs4recover.o
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 145208bcb9bd..c29baa03dfaf 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -611,8 +611,6 @@ fh_update(struct svc_fh *fhp)
 	return nfserr_serverfault;
 }
 
-#ifdef CONFIG_NFSD_V3
-
 /**
  * fh_fill_pre_attrs - Fill in pre-op attributes
  * @fhp: file handle to be updated
@@ -673,8 +671,6 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
 			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
 }
 
-#endif /* CONFIG_NFSD_V3 */
-
 /*
  * Release a file handle.
  */
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 434930d8a946..fb9d358a267e 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -90,7 +90,6 @@ typedef struct svc_fh {
 						 * operation
 						 */
 	int			fh_flags;	/* FH flags */
-#ifdef CONFIG_NFSD_V3
 	bool			fh_post_saved;	/* post-op attrs saved */
 	bool			fh_pre_saved;	/* pre-op attrs saved */
 
@@ -107,7 +106,6 @@ typedef struct svc_fh {
 	/* Post-op attributes saved in fh_unlock */
 	struct kstat		fh_post_attr;	/* full attrs after operation */
 	u64			fh_post_change; /* nfsv4 change; see above */
-#endif /* CONFIG_NFSD_V3 */
 } svc_fh;
 #define NFSD4_FH_FOREIGN (1<<0)
 #define SET_FH_FLAG(c, f) ((c)->fh_flags |= (f))
@@ -283,8 +281,6 @@ static inline u32 knfsd_fh_hash(const struct knfsd_fh *fh)
 }
 #endif
 
-#ifdef CONFIG_NFSD_V3
-
 /**
  * fh_clear_pre_post_attrs - Reset pre/post attributes
  * @fhp: file handle to be updated
@@ -327,22 +323,6 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
 extern void fh_fill_pre_attrs(struct svc_fh *fhp);
 extern void fh_fill_post_attrs(struct svc_fh *fhp);
 
-#else /* !CONFIG_NFSD_V3 */
-
-static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
-{
-}
-
-static inline void fh_fill_pre_attrs(struct svc_fh *fhp)
-{
-}
-
-static inline void fh_fill_post_attrs(struct svc_fh *fhp)
-{
-}
-
-#endif /* !CONFIG_NFSD_V3 */
-
 
 /*
  * Lock a file handle/inode
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index b92d272f4ba6..e48d5135a81c 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -117,9 +117,7 @@ static struct svc_stat	nfsd_acl_svcstats = {
 
 static const struct svc_version *nfsd_version[] = {
 	[2] = &nfsd_version2,
-#if defined(CONFIG_NFSD_V3)
 	[3] = &nfsd_version3,
-#endif
 #if defined(CONFIG_NFSD_V4)
 	[4] = &nfsd_version4,
 #endif
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 99c2b9dfbb10..761a99c0dff3 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -32,9 +32,7 @@
 #include <linux/writeback.h>
 #include <linux/security.h>
 
-#ifdef CONFIG_NFSD_V3
 #include "xdr3.h"
-#endif /* CONFIG_NFSD_V3 */
 
 #ifdef CONFIG_NFSD_V4
 #include "../internal.h"
@@ -604,7 +602,6 @@ __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fhp,
 }
 #endif /* defined(CONFIG_NFSD_V4) */
 
-#ifdef CONFIG_NFSD_V3
 /*
  * Check server access rights to a file system object
  */
@@ -716,7 +713,6 @@ nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *access, u32 *suppor
  out:
 	return error;
 }
-#endif /* CONFIG_NFSD_V3 */
 
 int nfsd_open_break_lease(struct inode *inode, int access)
 {
@@ -1109,7 +1105,6 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 	return err;
 }
 
-#ifdef CONFIG_NFSD_V3
 /*
  * Commit all pending writes to stable storage.
  *
@@ -1167,7 +1162,6 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
 out:
 	return err;
 }
-#endif /* CONFIG_NFSD_V3 */
 
 static __be32
 nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *resfhp,
@@ -1357,8 +1351,6 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 					rdev, resfhp);
 }
 
-#ifdef CONFIG_NFSD_V3
-
 /*
  * NFSv3 and NFSv4 version of nfsd_create
  */
@@ -1524,7 +1516,6 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	err = nfserrno(host_err);
 	goto out;
 }
-#endif /* CONFIG_NFSD_V3 */
 
 /*
  * Read a symlink. On entry, *lenp must contain the maximum path length that
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 9f56dcb22ff7..ffb540bb6d58 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -68,7 +68,6 @@ __be32		nfsd_create_locked(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_create(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct iattr *attrs,
 				int type, dev_t rdev, struct svc_fh *res);
-#ifdef CONFIG_NFSD_V3
 __be32		nfsd_access(struct svc_rqst *, struct svc_fh *, u32 *, u32 *);
 __be32		do_nfsd_create(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct iattr *attrs,
@@ -76,7 +75,6 @@ __be32		do_nfsd_create(struct svc_rqst *, struct svc_fh *,
 				u32 *verifier, bool *truncp, bool *created);
 __be32		nfsd_commit(struct svc_rqst *, struct svc_fh *,
 				loff_t, unsigned long, __be32 *verf);
-#endif /* CONFIG_NFSD_V3 */
 #ifdef CONFIG_NFSD_V4
 __be32		nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			    char *name, void **bufp, int *lenp);

