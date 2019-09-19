Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 350D5B7D2E
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 16:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389746AbfISOtB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 10:49:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389041AbfISOtB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Sep 2019 10:49:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAAD13023080;
        Thu, 19 Sep 2019 14:49:00 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7433660872;
        Thu, 19 Sep 2019 14:49:00 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 87A09109C550; Thu, 19 Sep 2019 10:49:00 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFS: Don't skip lookup when holding a delegation
Date:   Thu, 19 Sep 2019 10:49:00 -0400
Message-Id: <77be993185fa7f114f6856f74f2f7affb5bd411d.1568904510.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 19 Sep 2019 14:49:00 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If we skip lookup revalidation while holding a delegation, we might miss
that the file has changed directories on the server.  The directory's
change attribute should still be checked against the dentry's d_time to
perform a complete revalidation.

V2 - Add some commentary as suggested-by J. Bruce Fields.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 0adfd8840110..8723e82f5c9d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1197,12 +1197,20 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 		goto out_bad;
 	}
 
-	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
-		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
-
 	/* Force a full look up iff the parent directory has changed */
 	if (!(flags & (LOOKUP_EXCL | LOOKUP_REVAL)) &&
 	    nfs_check_verifier(dir, dentry, flags & LOOKUP_RCU)) {
+
+		/*
+		 * Note that the file can't move while we hold a
+		 * delegation.  But this dentry could have been cached
+		 * before we got a delegation.  So it's only safe to
+		 * skip revalidation when the parent directory is
+		 * unchanged:
+		 */
+		if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
+			return nfs_lookup_revalidate_delegated(dir, dentry, inode);
+
 		error = nfs_lookup_verify_inode(inode, flags);
 		if (error) {
 			if (error == -ESTALE)
@@ -1635,9 +1643,6 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 	if (inode == NULL)
 		goto full_reval;
 
-	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
-		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
-
 	/* NFS only supports OPEN on regular files */
 	if (!S_ISREG(inode->i_mode))
 		goto full_reval;
-- 
2.20.1

