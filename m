Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7921961E1
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 00:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgC0X1e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 19:27:34 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:51393 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgC0X1c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 19:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585351652; x=1616887652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mWoLMZMD6wKtikQfIoaSogOJZTV/zTDexHSbMMAjozY=;
  b=SPQ1qULZPgWZzJlmSP8lztVtCeu8R4+OlHu34X3AMmQW/XrUU73sRJ30
   oBFQWb0qbW8ckyL7QTw94l51wOz77COBTJAPFBycsm+314F+fhx9T8euG
   IRmEKQ2UKt/OndrrOvyjfepodJ3TRhgZqqJJvDLWDgWmXvqV2ENF6PLTK
   w=;
IronPort-SDR: 7AOi3Nvag9xYPCTD24VPnbC20WJlA/cMg0oYjRWjtR8Z77Dl5Fji9DNbUo2+CTGCtYy/gGEH6N
 Gq40+j0/UcCw==
X-IronPort-AV: E=Sophos;i="5.72,314,1580774400"; 
   d="scan'208";a="23086499"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 27 Mar 2020 23:27:19 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id 2DA98A224F;
        Fri, 27 Mar 2020 23:27:19 +0000 (UTC)
Received: from EX13D13UWA003.ant.amazon.com (10.43.160.181) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 27 Mar 2020 23:27:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13UWA003.ant.amazon.com (10.43.160.181) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Mar 2020 23:27:18 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Fri, 27 Mar 2020 23:27:17 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 430DFDEFB3; Fri, 27 Mar 2020 23:27:17 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 06/11] nfsd: define xattr functions to call in to their vfs counterparts
Date:   Fri, 27 Mar 2020 23:27:12 +0000
Message-ID: <20200327232717.15331-7-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200327232717.15331-1-fllinden@amazon.com>
References: <20200327232717.15331-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This adds the filehandle based functions for the xattr operations
that call in to the vfs layer to do the actual work.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/vfs.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.h |  10 ++++
 2 files changed, 140 insertions(+)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0aa02eb18bd3..115449009bc0 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2058,6 +2058,136 @@ static int exp_rdonly(struct svc_rqst *rqstp, struct svc_export *exp)
 	return nfsexp_flags(rqstp, exp) & NFSEXP_READONLY;
 }
 
+#ifdef CONFIG_NFSD_V4
+/*
+ * Helper function to translate error numbers. In the case of xattr operations,
+ * some error codes need to be translated outside of the standard translations.
+ *
+ * ENODATA needs to be translated to nfserr_noxattr.
+ * E2BIG to nfserr_xattr2big.
+ *
+ * Additionally, vfs_listxattr can return -ERANGE. This means that the
+ * file has too many extended attributes to retrieve inside an
+ * XATTR_LIST_MAX sized buffer. This is a bug in the xattr implementation:
+ * filesystems will allow the adding of extended attributes until they hit
+ * their own internal limit. This limit may be larger than XATTR_LIST_MAX.
+ * So, at that point, the attributes are present and valid, but can't
+ * be retrieved using listxattr, since the upper level xattr code enforces
+ * the XATTR_LIST_MAX limit.
+ *
+ * This bug means that we need to deal with listxattr returning -ERANGE. The
+ * best mapping is to return TOOSMALL.
+ */
+static __be32
+nfsd_xattr_errno(int err)
+{
+	switch (err) {
+	case -ENODATA:
+		return nfserr_noxattr;
+	case -E2BIG:
+		return nfserr_xattr2big;
+	case -ERANGE:
+		return nfserr_toosmall;
+	}
+	return nfserrno(err);
+}
+
+__be32
+nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
+	      void *buf, int *lenp)
+{
+	ssize_t lerr;
+	int err;
+
+	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_READ);
+	if (err)
+		return err;
+
+	lerr = vfs_getxattr(fhp->fh_dentry, name, buf, *lenp);
+	if (lerr < 0)
+		err = nfsd_xattr_errno(lerr);
+	else
+		*lenp = lerr;
+
+	return err;
+}
+
+__be32
+nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, void *buf, int *lenp)
+{
+	ssize_t lerr;
+	int err;
+
+	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_READ);
+	if (err)
+		return err;
+
+	lerr = vfs_listxattr(fhp->fh_dentry, buf, *lenp);
+
+	if (lerr < 0)
+		err = nfsd_xattr_errno(lerr);
+	else
+		*lenp = lerr;
+
+	return err;
+}
+
+/*
+ * Removexattr and setxattr need to call fh_lock to both lock the inode
+ * and set the change attribute. Since the top-level vfs_removexattr
+ * and vfs_setxattr calls already do their own inode_lock calls, call
+ * the _locked variant. Pass in a NULL pointer for delegated_inode,
+ * and let the client deal with NFS4ERR_DELAY (same as with e.g.
+ * setattr and remove).
+ */
+__be32
+nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
+{
+	int err, ret;
+
+	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_WRITE);
+	if (err)
+		return err;
+
+	ret = fh_want_write(fhp);
+	if (ret)
+		return nfserrno(ret);
+
+	fh_lock(fhp);
+
+	ret = __vfs_removexattr_locked(fhp->fh_dentry, name, NULL);
+
+	fh_unlock(fhp);
+	fh_drop_write(fhp);
+
+	return nfsd_xattr_errno(ret);
+}
+
+__be32
+nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
+	      void *buf, u32 len, u32 flags)
+{
+	int err, ret;
+
+	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_WRITE);
+	if (err)
+		return err;
+
+	ret = fh_want_write(fhp);
+	if (ret)
+		return nfserrno(ret);
+	fh_lock(fhp);
+
+	ret = __vfs_setxattr_locked(fhp->fh_dentry, name, buf, len, flags,
+				    NULL);
+
+	fh_unlock(fhp);
+	fh_drop_write(fhp);
+
+	return nfsd_xattr_errno(ret);
+}
+#endif
+
 /*
  * Check for a user's access permissions to this inode.
  */
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 3eb660ad80d1..2d2cf5b0543b 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -76,6 +76,16 @@ __be32		do_nfsd_create(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_commit(struct svc_rqst *, struct svc_fh *,
 				loff_t, unsigned long, __be32 *verf);
 #endif /* CONFIG_NFSD_V3 */
+#ifdef CONFIG_NFSD_V4
+__be32		nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
+			    char *name, void *buf, int *lenp);
+__be32		nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
+			    void *buf, int *lenp);
+__be32		nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
+			    char *name);
+__be32		nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
+			    char *name, void *buf, u32 len, u32 flags);
+#endif
 int 		nfsd_open_break_lease(struct inode *, int);
 __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
 				int, struct file **);
-- 
2.17.2

