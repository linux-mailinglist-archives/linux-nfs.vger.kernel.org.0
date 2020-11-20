Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27452BB92D
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 23:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgKTWjY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 17:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgKTWjX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 17:39:23 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E33DC061A4C
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 14:39:23 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6D67E6E9F; Fri, 20 Nov 2020 17:39:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6D67E6E9F
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4/8] nfsd4: don't query change attribute in v2/v3 case
Date:   Fri, 20 Nov 2020 17:39:16 -0500
Message-Id: <1605911960-12516-4-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605911960-12516-1-git-send-email-bfields@redhat.com>
References: <20201120223831.GB7705@fieldses.org>
 <1605911960-12516-1-git-send-email-bfields@redhat.com>
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
index 2277f83da250..2732b04d3878 100644
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
 
@@ -285,18 +286,21 @@ void fill_pre_wcc(struct svc_fh *fhp)
  */
 void fill_post_wcc(struct svc_fh *fhp)
 {
+	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
+	struct inode *inode = d_inode(fhp->fh_dentry);
 	__be32 err;
 
 	if (fhp->fh_post_saved)
 		printk("nfsd: inode locked twice during operation.\n");
 
 	err = fh_getattr(fhp, &fhp->fh_post_attr);
-	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
-						     d_inode(fhp->fh_dentry));
+	if (v4)
+		fhp->fh_post_change =
+			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
 	if (err) {
 		fhp->fh_post_saved = false;
 		/* Grab the ctime anyway - set_change_info might use it */
-		fhp->fh_post_attr.ctime = d_inode(fhp->fh_dentry)->i_ctime;
+		fhp->fh_post_attr.ctime = inode->i_ctime;
 	} else
 		fhp->fh_post_saved = true;
 }
-- 
2.28.0

