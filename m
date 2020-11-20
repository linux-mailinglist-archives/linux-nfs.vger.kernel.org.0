Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9251D2BB92A
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 23:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgKTWjX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 17:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgKTWjX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 17:39:23 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC36CC061A48
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 14:39:22 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2422E6E9C; Fri, 20 Nov 2020 17:39:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2422E6E9C
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 7/8] nfsd: skip some unnecessary stats in the v4 case
Date:   Fri, 20 Nov 2020 17:39:19 -0500
Message-Id: <1605911960-12516-7-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605911960-12516-1-git-send-email-bfields@redhat.com>
References: <20201120223831.GB7705@fieldses.org>
 <1605911960-12516-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

In the typical case of v4 and a i_version-supporting filesystem, we can
skip a stat which is only required to fake up a change attribute from
ctime.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs3xdr.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 2732b04d3878..8502a493be6d 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -265,19 +265,21 @@ void fill_pre_wcc(struct svc_fh *fhp)
 	if (fhp->fh_pre_saved)
 		return;
 	inode = d_inode(fhp->fh_dentry);
-	err = fh_getattr(fhp, &stat);
-	if (err) {
-		/* Grab the times from inode anyway */
-		stat.mtime = inode->i_mtime;
-		stat.ctime = inode->i_ctime;
-		stat.size  = inode->i_size;
+	if (!v4 || !inode->i_sb->s_export_op->fetch_iversion) {
+		err = fh_getattr(fhp, &stat);
+		if (err) {
+			/* Grab the times from inode anyway */
+			stat.mtime = inode->i_mtime;
+			stat.ctime = inode->i_ctime;
+			stat.size  = inode->i_size;
+		}
+		fhp->fh_pre_mtime = stat.mtime;
+		fhp->fh_pre_ctime = stat.ctime;
+		fhp->fh_pre_size  = stat.size;
 	}
 	if (v4)
 		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
 
-	fhp->fh_pre_mtime = stat.mtime;
-	fhp->fh_pre_ctime = stat.ctime;
-	fhp->fh_pre_size  = stat.size;
 	fhp->fh_pre_saved = true;
 }
 
@@ -293,7 +295,9 @@ void fill_post_wcc(struct svc_fh *fhp)
 	if (fhp->fh_post_saved)
 		printk("nfsd: inode locked twice during operation.\n");
 
-	err = fh_getattr(fhp, &fhp->fh_post_attr);
+
+	if (!v4 || !inode->i_sb->s_export_op->fetch_iversion)
+		err = fh_getattr(fhp, &fhp->fh_post_attr);
 	if (v4)
 		fhp->fh_post_change =
 			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
-- 
2.28.0

