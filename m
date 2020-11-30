Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B81C2C8E38
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 20:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgK3Tjk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 14:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgK3Tjk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 14:39:40 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7E8C0613D2
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 11:38:59 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 776776EAD; Mon, 30 Nov 2020 14:38:58 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 776776EAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606765138;
        bh=ZYD/zXHzIp8z2OpD1H0rkLMDIPS99GW8XcZxoCXi5vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYjpgKP+SOfLt2IiWMH2bAVje8yLKAV846aoerR+E44CEyyNCk4oRwp20HvIsoEQc
         0SMrUSgTzD4X8l+sQVP1e57L6TQc/OS7zq8/AbaRefXJZd+LqHnCJqGdfOnb390Jpm
         015xnRnHdJmEoLqy/0oa1mKv1Z0ipz70Xc2xLOhs=
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4/5] nfsd4: don't query change attribute in v2/v3 case
Date:   Mon, 30 Nov 2020 14:38:56 -0500
Message-Id: <1606765137-17257-4-git-send-email-bfields@fieldses.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1606765137-17257-1-git-send-email-bfields@fieldses.org>
References: <1606765137-17257-1-git-send-email-bfields@fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

inode_query_iversion() has side effects, and there's no point calling it
when we're not even going to use it.

We check whether we're currently processing a v4 request by checking
fh_maxsize, which is arguably a little hacky; we could add a flag to
svc_fh instead.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs3xdr.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index dfbf390ff40c..f4fd54dc6965 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -259,11 +259,11 @@ void fill_pre_wcc(struct svc_fh *fhp)
 {
 	struct inode    *inode;
 	struct kstat	stat;
+	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
 	__be32 err;
 
 	if (fhp->fh_pre_saved)
 		return;
-
 	inode = d_inode(fhp->fh_dentry);
 	err = fh_getattr(fhp, &stat);
 	if (err) {
@@ -272,11 +272,12 @@ void fill_pre_wcc(struct svc_fh *fhp)
 		stat.ctime = inode->i_ctime;
 		stat.size  = inode->i_size;
 	}
+	if (v4)
+		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
 
 	fhp->fh_pre_mtime = stat.mtime;
 	fhp->fh_pre_ctime = stat.ctime;
 	fhp->fh_pre_size  = stat.size;
-	fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
 	fhp->fh_pre_saved = true;
 }
 
@@ -285,6 +286,8 @@ void fill_pre_wcc(struct svc_fh *fhp)
  */
 void fill_post_wcc(struct svc_fh *fhp)
 {
+	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
+	struct inode *inode = d_inode(fhp->fh_dentry);
 	__be32 err;
 
 	if (fhp->fh_post_saved)
@@ -293,11 +296,12 @@ void fill_post_wcc(struct svc_fh *fhp)
 	err = fh_getattr(fhp, &fhp->fh_post_attr);
 	if (err) {
 		fhp->fh_post_saved = false;
-		fhp->fh_post_attr.ctime = d_inode(fhp->fh_dentry)->i_ctime;
+		fhp->fh_post_attr.ctime = inode->i_ctime;
 	} else
 		fhp->fh_post_saved = true;
-	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
-						     d_inode(fhp->fh_dentry));
+	if (v4)
+		fhp->fh_post_change =
+			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
 }
 
 /*
-- 
2.28.0

