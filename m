Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6542C9165
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 23:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgK3WrB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 17:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgK3WrB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 17:47:01 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E646C0613D2
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:46:20 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2D3E22012; Mon, 30 Nov 2020 17:46:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2D3E22012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606776380;
        bh=Tr4sCnrAn2+kfwdd8J+wF5M4PttWXLQJkcHSHSZ9RPE=;
        h=From:To:Cc:Subject:Date:From;
        b=tjVlomQrGUEQL66A+mxJ9DWULfPwwJ11SGbfsJzbPcryaDnYMcn0ELh7cDgJi3BCc
         GYfj1Tzh16Buv2Rq8L2YZhQLn6Ck4MfAvj+sCmqv8C7+mq0C9ubZrLPF+9IsyKNQqP
         7F3KpxumdI+j2uvHYedq98fxnMExU03V+Hc0X2fE=
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/5] nfsd: only call inode_query_iversion in the I_VERSION case
Date:   Mon, 30 Nov 2020 17:46:14 -0500
Message-Id: <1606776378-22381-1-git-send-email-bfields@fieldses.org>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

inode_query_iversion() can modify i_version.  Depending on the exported
filesystem, that may not be safe.  For example, if you're re-exporting
NFS, NFS stores the server's change attribute in i_version and does not
expect it to be modified locally.  This has been observed causing
unnecessary cache invalidations.

The way a filesystem indicates that it's OK to call
inode_query_iverson() is by setting SB_I_VERSION.

So, move the I_VERSION check out of encode_change(), where it's used
only in FATTR responses, to nfsd4_changeattr(), which is also called for
pre- and post- operation attributes.

(Note we could also pull the NFSEXP_V4ROOT case into
nfsd4_change_attribute as well.  That would actually be a no-op, since
pre/post attrs are only used for metadata-modifying operations, and
V4ROOT exports are read-only.  But we might make the change in the
future just for simplicity.)

Reported-by: Daire Byrne <daire@dneg.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs3xdr.c |  5 ++---
 fs/nfsd/nfs4xdr.c |  6 +-----
 fs/nfsd/nfsfh.h   | 14 ++++++++++----
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 2277f83da250..dfbf390ff40c 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -291,14 +291,13 @@ void fill_post_wcc(struct svc_fh *fhp)
 		printk("nfsd: inode locked twice during operation.\n");
 
 	err = fh_getattr(fhp, &fhp->fh_post_attr);
-	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
-						     d_inode(fhp->fh_dentry));
 	if (err) {
 		fhp->fh_post_saved = false;
-		/* Grab the ctime anyway - set_change_info might use it */
 		fhp->fh_post_attr.ctime = d_inode(fhp->fh_dentry)->i_ctime;
 	} else
 		fhp->fh_post_saved = true;
+	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
+						     d_inode(fhp->fh_dentry));
 }
 
 /*
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 833a2c64dfe8..56fd5f6d5c44 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2298,12 +2298,8 @@ static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
 	if (exp->ex_flags & NFSEXP_V4ROOT) {
 		*p++ = cpu_to_be32(convert_to_wallclock(exp->cd->flush_time));
 		*p++ = 0;
-	} else if (IS_I_VERSION(inode)) {
+	} else
 		p = xdr_encode_hyper(p, nfsd4_change_attribute(stat, inode));
-	} else {
-		*p++ = cpu_to_be32(stat->ctime.tv_sec);
-		*p++ = cpu_to_be32(stat->ctime.tv_nsec);
-	}
 	return p;
 }
 
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 56cfbc361561..39d764b129fa 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -261,10 +261,16 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
 {
 	u64 chattr;
 
-	chattr =  stat->ctime.tv_sec;
-	chattr <<= 30;
-	chattr += stat->ctime.tv_nsec;
-	chattr += inode_query_iversion(inode);
+	if (IS_I_VERSION(inode)) {
+		chattr =  stat->ctime.tv_sec;
+		chattr <<= 30;
+		chattr += stat->ctime.tv_nsec;
+		chattr += inode_query_iversion(inode);
+	} else {
+		chattr = stat->ctime.tv_sec;
+		chattr <<= 32;
+		chattr += stat->ctime.tv_nsec;
+	}
 	return chattr;
 }
 
-- 
2.28.0

