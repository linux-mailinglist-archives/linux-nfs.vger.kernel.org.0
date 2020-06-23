Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F50206760
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbgFWWoT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:19 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:14761 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387916AbgFWWoN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952251; x=1624488251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ORvRYyTPp6jlWv0S7OnPPAwzsBtrMSNsJYv8Oe8JM3I=;
  b=IbObUtrjNDE7hy+nHHnQN/+ckzCCrpi8989Oh/IZsNfvTRCAQ1PnRhyf
   m6P240urcnCfxMCBTCLp0aIHzeeNee7qGs80//yFPZ5DMq2wviL0lbFrc
   CgN7uf6gwAdKviLkMAlsEQ9K4EGFegA3yPVUIB5OeUMcmp9MeJPn9qML9
   c=;
IronPort-SDR: 5uxnEEpo/XzZ25ZQzP+js6OBLtX5qiOmY+un/cV3K4Q+ejXXwdaLjgbwtlp9HFlKv8i4DGEnMU
 qwT4pMFn/KaQ==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="53337284"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 23 Jun 2020 22:39:39 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id A5B78A0103;
        Tue, 23 Jun 2020 22:39:37 +0000 (UTC)
Received: from EX13D13UWB001.ant.amazon.com (10.43.161.156) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:29 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWB001.ant.amazon.com (10.43.161.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:29 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:28 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 18365CD360; Tue, 23 Jun 2020 22:39:28 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 06/10] nfsd: define xattr functions to call in to their vfs counterparts
Date:   Tue, 23 Jun 2020 22:39:23 +0000
Message-ID: <20200623223927.31795-7-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223927.31795-1-fllinden@amazon.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
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
 fs/nfsd/vfs.c | 227 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.h |  10 +++
 2 files changed, 237 insertions(+)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c3fbab1753ec..b1dd8690e25d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2059,6 +2059,233 @@ static int exp_rdonly(struct svc_rqst *rqstp, struct svc_export *exp)
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
+/*
+ * Retrieve the specified user extended attribute. To avoid always
+ * having to allocate the maximum size (since we are not getting
+ * a maximum size from the RPC), do a probe + alloc. Hold a reader
+ * lock on i_rwsem to prevent the extended attribute from changing
+ * size while we're doing this.
+ */
+__be32
+nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
+	      void **bufp, int *lenp)
+{
+	ssize_t len;
+	__be32 err;
+	char *buf;
+	struct inode *inode;
+	struct dentry *dentry;
+
+	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_READ);
+	if (err)
+		return err;
+
+	err = nfs_ok;
+	dentry = fhp->fh_dentry;
+	inode = d_inode(dentry);
+
+	inode_lock_shared(inode);
+
+	len = vfs_getxattr(dentry, name, NULL, 0);
+
+	/*
+	 * Zero-length attribute, just return.
+	 */
+	if (len == 0) {
+		*bufp = NULL;
+		*lenp = 0;
+		goto out;
+	}
+
+	if (len < 0) {
+		err = nfsd_xattr_errno(len);
+		goto out;
+	}
+
+	if (len > *lenp) {
+		err = nfserr_toosmall;
+		goto out;
+	}
+
+	buf = kvmalloc(len, GFP_KERNEL | GFP_NOFS);
+	if (buf == NULL) {
+		err = nfserr_jukebox;
+		goto out;
+	}
+
+	len = vfs_getxattr(dentry, name, buf, len);
+	if (len <= 0) {
+		kvfree(buf);
+		buf = NULL;
+		err = nfsd_xattr_errno(len);
+	}
+
+	*lenp = len;
+	*bufp = buf;
+
+out:
+	inode_unlock_shared(inode);
+
+	return err;
+}
+
+/*
+ * Retrieve the xattr names. Since we can't know how many are
+ * user extended attributes, we must get all attributes here,
+ * and have the XDR encode filter out the "user." ones.
+ *
+ * While this could always just allocate an XATTR_LIST_MAX
+ * buffer, that's a waste, so do a probe + allocate. To
+ * avoid any changes between the probe and allocate, wrap
+ * this in inode_lock.
+ */
+__be32
+nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char **bufp,
+	       int *lenp)
+{
+	ssize_t len;
+	__be32 err;
+	char *buf;
+	struct inode *inode;
+	struct dentry *dentry;
+
+	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_READ);
+	if (err)
+		return err;
+
+	dentry = fhp->fh_dentry;
+	inode = d_inode(dentry);
+	*lenp = 0;
+
+	inode_lock_shared(inode);
+
+	len = vfs_listxattr(dentry, NULL, 0);
+	if (len <= 0) {
+		err = nfsd_xattr_errno(len);
+		goto out;
+	}
+
+	if (len > XATTR_LIST_MAX) {
+		err = nfserr_xattr2big;
+		goto out;
+	}
+
+	/*
+	 * We're holding i_rwsem - use GFP_NOFS.
+	 */
+	buf = kvmalloc(len, GFP_KERNEL | GFP_NOFS);
+	if (buf == NULL) {
+		err= nfserr_jukebox;
+		goto out;
+	}
+
+	len = vfs_listxattr(dentry, buf, len);
+	if (len <= 0) {
+		kvfree(buf);
+		err = nfsd_xattr_errno(len);
+		goto out;
+	}
+
+	*lenp = len;
+	*bufp = buf;
+
+	err = nfs_ok;
+out:
+	inode_unlock_shared(inode);
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
index 3eb660ad80d1..a2442ebe5acf 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -76,6 +76,16 @@ __be32		do_nfsd_create(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_commit(struct svc_rqst *, struct svc_fh *,
 				loff_t, unsigned long, __be32 *verf);
 #endif /* CONFIG_NFSD_V3 */
+#ifdef CONFIG_NFSD_V4
+__be32		nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
+			    char *name, void **bufp, int *lenp);
+__be32		nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
+			    char **bufp, int *lenp);
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

