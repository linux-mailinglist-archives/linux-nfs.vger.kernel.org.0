Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D16A2C8E35
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 20:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgK3Tjk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 14:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbgK3Tjk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 14:39:40 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1094AC0613D6
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 11:39:00 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 608C336E1; Mon, 30 Nov 2020 14:38:58 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 608C336E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606765138;
        bh=DGjRdTTp0fC8+OwdGjwUTPlx6clpeTm7cPoicFPN7lE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUcuPYQAjQrgH2ASj3xd1BEAm0yEqQOsr+W1ry0vtYu0VP6YLI5x9Z2FMs01MHl+e
         tsppilB68KvpJEubVEUdzkjnH2b2L5Mwyo+yYosq3YCM2Mfg3nBSQzmlg7Fz35CuQp
         WdwWZlMAh8NzH346JcH8B4V64zvoMGcF8n/sp9jw=
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/5] nfsd: simplify nfsd4_change_info
Date:   Mon, 30 Nov 2020 14:38:54 -0500
Message-Id: <1606765137-17257-2-git-send-email-bfields@fieldses.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1606765137-17257-1-git-send-email-bfields@fieldses.org>
References: <1606765137-17257-1-git-send-email-bfields@fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

It doesn't make sense to carry all these extra fields around.  Just
make everything into change attribute from the start.

This is just cleanup, there should be no change in behavior.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4xdr.c | 11 ++---------
 fs/nfsd/xdr4.h    | 11 -----------
 2 files changed, 2 insertions(+), 20 deletions(-)

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
index 679d40af1bbb..3a59053084e6 100644
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
 
@@ -768,15 +763,9 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 {
 	BUG_ON(!fhp->fh_pre_saved);
 	cinfo->atomic = (u32)fhp->fh_post_saved;
-	cinfo->change_supported = IS_I_VERSION(d_inode(fhp->fh_dentry));
 
 	cinfo->before_change = fhp->fh_pre_change;
 	cinfo->after_change = fhp->fh_post_change;
-	cinfo->before_ctime_sec = fhp->fh_pre_ctime.tv_sec;
-	cinfo->before_ctime_nsec = fhp->fh_pre_ctime.tv_nsec;
-	cinfo->after_ctime_sec = fhp->fh_post_attr.ctime.tv_sec;
-	cinfo->after_ctime_nsec = fhp->fh_post_attr.ctime.tv_nsec;
-
 }
 
 
-- 
2.28.0

