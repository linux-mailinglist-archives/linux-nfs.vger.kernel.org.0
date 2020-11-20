Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E422BB92B
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 23:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgKTWjY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 17:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbgKTWjX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 17:39:23 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A52C061A47
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 14:39:22 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id F083941A3; Fri, 20 Nov 2020 17:39:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org F083941A3
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/8] nfsd: simplify nfsd4_change_info
Date:   Fri, 20 Nov 2020 17:39:14 -0500
Message-Id: <1605911960-12516-2-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605911960-12516-1-git-send-email-bfields@redhat.com>
References: <20201120223831.GB7705@fieldses.org>
 <1605911960-12516-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

It doesn't make sense to carry all these extra fields around.  Just
make everything into change attribute from the start.

This is just cleanup, there should be no change in behavior.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4xdr.c        | 11 ++---------
 fs/nfsd/xdr4.h           | 22 +++++++++-------------
 include/linux/iversion.h | 13 +++++++++++++
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 56fd5f6d5c44..18c912930947 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2331,15 +2331,8 @@ static __be32 *encode_time_delta(__be32 *p, struct inode *inode)
 static __be32 *encode_cinfo(__be32 *p, struct nfsd4_change_info *c)
 {
 	*p++ = cpu_to_be32(c->atomic);
-	if (c->change_supported) {
-		p = xdr_encode_hyper(p, c->before_change);
-		p = xdr_encode_hyper(p, c->after_change);
-	} else {
-		*p++ = cpu_to_be32(c->before_ctime_sec);
-		*p++ = cpu_to_be32(c->before_ctime_nsec);
-		*p++ = cpu_to_be32(c->after_ctime_sec);
-		*p++ = cpu_to_be32(c->after_ctime_nsec);
-	}
+	p = xdr_encode_hyper(p, c->before_change);
+	p = xdr_encode_hyper(p, c->after_change);
 	return p;
 }
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 679d40af1bbb..9c2d942d055d 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -76,12 +76,7 @@ static inline bool nfsd4_has_session(struct nfsd4_compound_state *cs)
 
 struct nfsd4_change_info {
 	u32		atomic;
-	bool		change_supported;
-	u32		before_ctime_sec;
-	u32		before_ctime_nsec;
 	u64		before_change;
-	u32		after_ctime_sec;
-	u32		after_ctime_nsec;
 	u64		after_change;
 };
 
@@ -768,15 +763,16 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 {
 	BUG_ON(!fhp->fh_pre_saved);
 	cinfo->atomic = (u32)fhp->fh_post_saved;
-	cinfo->change_supported = IS_I_VERSION(d_inode(fhp->fh_dentry));
-
-	cinfo->before_change = fhp->fh_pre_change;
-	cinfo->after_change = fhp->fh_post_change;
-	cinfo->before_ctime_sec = fhp->fh_pre_ctime.tv_sec;
-	cinfo->before_ctime_nsec = fhp->fh_pre_ctime.tv_nsec;
-	cinfo->after_ctime_sec = fhp->fh_post_attr.ctime.tv_sec;
-	cinfo->after_ctime_nsec = fhp->fh_post_attr.ctime.tv_nsec;
 
+	if (IS_I_VERSION(d_inode(fhp->fh_dentry))) {
+		cinfo->before_change = fhp->fh_pre_change;
+		cinfo->after_change = fhp->fh_post_change;
+	} else {
+		cinfo->before_change =
+			time_to_chattr(&fhp->fh_pre_ctime);
+		cinfo->after_change =
+			time_to_chattr(&fhp->fh_post_attr.ctime);
+	}
 }
 
 
diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index 2917ef990d43..3bfebde5a1a6 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -328,6 +328,19 @@ inode_query_iversion(struct inode *inode)
 	return cur >> I_VERSION_QUERIED_SHIFT;
 }
 
+/*
+ * For filesystems without any sort of change attribute, the best we can
+ * do is fake one up from the ctime:
+ */
+static inline u64 time_to_chattr(struct timespec64 *t)
+{
+	u64 chattr = t->tv_sec;
+
+	chattr <<= 32;
+	chattr += t->tv_nsec;
+	return chattr;
+}
+
 /**
  * inode_eq_iversion_raw - check whether the raw i_version counter has changed
  * @inode: inode to check
-- 
2.28.0

