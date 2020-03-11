Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14947182303
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 21:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbgCKUAC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 16:00:02 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:63735 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387410AbgCKUAA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 16:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956801; x=1615492801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=lKNSkvesFNpZPEmw6V5MJ+I34oPWUtH7xUB1yfyP5bM=;
  b=UUQlf3+7NYruyWCK2rMz8z01ePEXPKWDnUsCujcKPj8IznBy8XJoc4z8
   q7SUCjN2N5m1DdKbmC3ZLLqraIr0yh+89wF2p+1D/fLflQi0AHm1/CHYb
   CuYNOUItlonHW7l3vfU7V7X8UOtJzWvGXV/0m15x8MHrucjm4xUFfP6lN
   E=;
IronPort-SDR: BCsJ+vOwtG/ehwm2R9ONbW2zpn9DG/22VCM4D3UJuONgzoiQIqKAHRHLtpTVevNgK5gqm25Ga8
 8nMrsqNRQ6TA==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="32054199"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 11 Mar 2020 20:00:00 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id BD035240AFA;
        Wed, 11 Mar 2020 19:59:58 +0000 (UTC)
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:59:56 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:59:55 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:59:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 13D75DEF44; Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 06/14] nfsd: define xattr functions to call in to their vfs counterparts
Date:   Wed, 11 Mar 2020 19:59:46 +0000
Message-ID: <20200311195954.27117-7-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195954.27117-1-fllinden@amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
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
 fs/nfsd/vfs.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.h |  10 +++++
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
2.16.6

