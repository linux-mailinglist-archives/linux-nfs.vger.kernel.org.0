Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8463760192D
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 22:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiJQUQj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 16:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiJQUQP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 16:16:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD66915709
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 13:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6A77BCE1870
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 20:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86454C433C1;
        Mon, 17 Oct 2022 20:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666037677;
        bh=9c0xpnUht33oRosGIVuIwIQAE+FcvhyvicsfYviaYwU=;
        h=From:To:Cc:Subject:Date:From;
        b=XrwoKgQZmDD5XC3W0pOD1DeQiBolmC568+Jae1QDqtKYoeDxPc0c63pQhmf+tFhxp
         YvoiOY1hwSyoryRtaKIwo0m7fAKwWPsdFbkoUQ0qI0Ykpfaszxdl5JRawi5VYCmrIy
         3PudhyPmxNu1hiAhvdfjPzgqMNedKjCZjy0yueiow5uP8Msm/FPqPwQ4L8FH7C6slJ
         TqJXba/Ds89vxKFeCZnF3/PpNT2kgvVp3Xvyt4S/jYnrb/HjJlD0MoVssdxoYaXNXt
         iCYIApH5LdYjI/Aim7fgdOPUfQe81cXqexPBLZnrBePtzhhzZbn5J9pItqUXOEcGel
         GOlTqHxhj/VBA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] nfsd: move nfserrno() to vfs.c
Date:   Mon, 17 Oct 2022 16:14:35 -0400
Message-Id: <20221017201436.487627-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfserrno() is common to all nfs versions, but nfsproc.c is specifically
for NFSv2. Move it to vfs.c, and the prototype to vfs.h.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/blocklayout.c    |  1 +
 fs/nfsd/blocklayoutxdr.c |  1 +
 fs/nfsd/export.h         |  1 -
 fs/nfsd/flexfilelayout.c |  1 +
 fs/nfsd/nfs4idmap.c      |  1 +
 fs/nfsd/nfsproc.c        | 62 --------------------------------------
 fs/nfsd/vfs.c            | 65 ++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.h            |  1 +
 8 files changed, 70 insertions(+), 63 deletions(-)

v2: move function to vfs.c
    move prototype to vfs.h and add includes in necessary .c files

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index b6d01d51a746..04697f8dc37d 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -12,6 +12,7 @@
 #include "blocklayoutxdr.h"
 #include "pnfs.h"
 #include "filecache.h"
+#include "vfs.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 442543304930..8e9c1a0f8d38 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -9,6 +9,7 @@
 
 #include "nfsd.h"
 #include "blocklayoutxdr.h"
+#include "vfs.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index ee0e3aba4a6e..d03f7f6a8642 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -115,7 +115,6 @@ struct svc_export *	rqst_find_fsidzero_export(struct svc_rqst *);
 int			exp_rootfh(struct net *, struct auth_domain *,
 					char *path, struct knfsd_fh *, int maxsize);
 __be32			exp_pseudoroot(struct svc_rqst *, struct svc_fh *);
-__be32			nfserrno(int errno);
 
 static inline void exp_put(struct svc_export *exp)
 {
diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index 070f90ed09b6..3ca5304440ff 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -15,6 +15,7 @@
 
 #include "flexfilelayoutxdr.h"
 #include "pnfs.h"
+#include "vfs.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index e70a1a2999b7..5e9809aff37e 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -41,6 +41,7 @@
 #include "idmap.h"
 #include "nfsd.h"
 #include "netns.h"
+#include "vfs.h"
 
 /*
  * Turn off idmapping when using AUTH_SYS.
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 82b3ddeacc33..52fc222c34f2 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -848,65 +848,3 @@ const struct svc_version nfsd_version2 = {
 	.vs_dispatch	= nfsd_dispatch,
 	.vs_xdrsize	= NFS2_SVC_XDRSIZE,
 };
-
-/*
- * Map errnos to NFS errnos.
- */
-__be32
-nfserrno (int errno)
-{
-	static struct {
-		__be32	nfserr;
-		int	syserr;
-	} nfs_errtbl[] = {
-		{ nfs_ok, 0 },
-		{ nfserr_perm, -EPERM },
-		{ nfserr_noent, -ENOENT },
-		{ nfserr_io, -EIO },
-		{ nfserr_nxio, -ENXIO },
-		{ nfserr_fbig, -E2BIG },
-		{ nfserr_stale, -EBADF },
-		{ nfserr_acces, -EACCES },
-		{ nfserr_exist, -EEXIST },
-		{ nfserr_xdev, -EXDEV },
-		{ nfserr_mlink, -EMLINK },
-		{ nfserr_nodev, -ENODEV },
-		{ nfserr_notdir, -ENOTDIR },
-		{ nfserr_isdir, -EISDIR },
-		{ nfserr_inval, -EINVAL },
-		{ nfserr_fbig, -EFBIG },
-		{ nfserr_nospc, -ENOSPC },
-		{ nfserr_rofs, -EROFS },
-		{ nfserr_mlink, -EMLINK },
-		{ nfserr_nametoolong, -ENAMETOOLONG },
-		{ nfserr_notempty, -ENOTEMPTY },
-#ifdef EDQUOT
-		{ nfserr_dquot, -EDQUOT },
-#endif
-		{ nfserr_stale, -ESTALE },
-		{ nfserr_jukebox, -ETIMEDOUT },
-		{ nfserr_jukebox, -ERESTARTSYS },
-		{ nfserr_jukebox, -EAGAIN },
-		{ nfserr_jukebox, -EWOULDBLOCK },
-		{ nfserr_jukebox, -ENOMEM },
-		{ nfserr_io, -ETXTBSY },
-		{ nfserr_notsupp, -EOPNOTSUPP },
-		{ nfserr_toosmall, -ETOOSMALL },
-		{ nfserr_serverfault, -ESERVERFAULT },
-		{ nfserr_serverfault, -ENFILE },
-		{ nfserr_io, -EREMOTEIO },
-		{ nfserr_stale, -EOPENSTALE },
-		{ nfserr_io, -EUCLEAN },
-		{ nfserr_perm, -ENOKEY },
-		{ nfserr_no_grace, -ENOGRACE},
-	};
-	int	i;
-
-	for (i = 0; i < ARRAY_SIZE(nfs_errtbl); i++) {
-		if (nfs_errtbl[i].syserr == errno)
-			return nfs_errtbl[i].nfserr;
-	}
-	WARN_ONCE(1, "nfsd: non-standard errno: %d\n", errno);
-	return nfserr_io;
-}
-
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 83be89905cbf..27dd9ac992ee 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -49,6 +49,71 @@
 
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
 
+/**
+ * nfserrno - Map Linux errnos to NFS errnos
+ * @errno: POSIX(-ish) error code to be mapped
+ *
+ * Returns the appropriate (net-endian) nfserr_* (or nfs_ok if errno is 0). If
+ * it's an error we don't expect, log it once and return nfserr_io.
+ */
+__be32
+nfserrno (int errno)
+{
+	static struct {
+		__be32	nfserr;
+		int	syserr;
+	} nfs_errtbl[] = {
+		{ nfs_ok, 0 },
+		{ nfserr_perm, -EPERM },
+		{ nfserr_noent, -ENOENT },
+		{ nfserr_io, -EIO },
+		{ nfserr_nxio, -ENXIO },
+		{ nfserr_fbig, -E2BIG },
+		{ nfserr_stale, -EBADF },
+		{ nfserr_acces, -EACCES },
+		{ nfserr_exist, -EEXIST },
+		{ nfserr_xdev, -EXDEV },
+		{ nfserr_mlink, -EMLINK },
+		{ nfserr_nodev, -ENODEV },
+		{ nfserr_notdir, -ENOTDIR },
+		{ nfserr_isdir, -EISDIR },
+		{ nfserr_inval, -EINVAL },
+		{ nfserr_fbig, -EFBIG },
+		{ nfserr_nospc, -ENOSPC },
+		{ nfserr_rofs, -EROFS },
+		{ nfserr_mlink, -EMLINK },
+		{ nfserr_nametoolong, -ENAMETOOLONG },
+		{ nfserr_notempty, -ENOTEMPTY },
+#ifdef EDQUOT
+		{ nfserr_dquot, -EDQUOT },
+#endif
+		{ nfserr_stale, -ESTALE },
+		{ nfserr_jukebox, -ETIMEDOUT },
+		{ nfserr_jukebox, -ERESTARTSYS },
+		{ nfserr_jukebox, -EAGAIN },
+		{ nfserr_jukebox, -EWOULDBLOCK },
+		{ nfserr_jukebox, -ENOMEM },
+		{ nfserr_io, -ETXTBSY },
+		{ nfserr_notsupp, -EOPNOTSUPP },
+		{ nfserr_toosmall, -ETOOSMALL },
+		{ nfserr_serverfault, -ESERVERFAULT },
+		{ nfserr_serverfault, -ENFILE },
+		{ nfserr_io, -EREMOTEIO },
+		{ nfserr_stale, -EOPENSTALE },
+		{ nfserr_io, -EUCLEAN },
+		{ nfserr_perm, -ENOKEY },
+		{ nfserr_no_grace, -ENOGRACE},
+	};
+	int	i;
+
+	for (i = 0; i < ARRAY_SIZE(nfs_errtbl); i++) {
+		if (nfs_errtbl[i].syserr == errno)
+			return nfs_errtbl[i].nfserr;
+	}
+	WARN_ONCE(1, "nfsd: non-standard errno: %d\n", errno);
+	return nfserr_io;
+}
+
 /* 
  * Called from nfsd_lookup and encode_dirent. Check if we have crossed 
  * a mount point.
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index c98e13ec37b2..b556e9307d37 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -60,6 +60,7 @@ static inline void nfsd_attrs_free(struct nfsd_attrs *attrs)
 	posix_acl_release(attrs->na_dpacl);
 }
 
+__be32		nfserrno (int errno);
 int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		                struct svc_export **expp);
 __be32		nfsd_lookup(struct svc_rqst *, struct svc_fh *,
-- 
2.37.3

