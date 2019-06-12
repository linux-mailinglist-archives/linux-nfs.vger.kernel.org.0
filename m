Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16DD5429BB
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 16:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfFLOpY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jun 2019 10:45:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728707AbfFLOpT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Jun 2019 10:45:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10A19772F9;
        Wed, 12 Jun 2019 14:45:14 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-3.rdu2.redhat.com [10.10.66.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA67E2FC43;
        Wed, 12 Jun 2019 14:45:13 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 165F8109C550; Wed, 12 Jun 2019 10:45:13 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Don't skip lookup when holding a delegation
Date:   Wed, 12 Jun 2019 10:45:13 -0400
Message-Id: <bcb2d38fe9c9bb15aeb9baa811aeb9a8697ea141.1560348835.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 12 Jun 2019 14:45:19 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If we skip lookup revalidation while holding a delegation, we might miss
that the file has changed directories on the server.  The directory's
change attribute should still be checked against the dentry's d_time to
perform a complete revalidation.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a71d0b42d160..10cc684dc082 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1269,12 +1269,13 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 		goto out_bad;
 	}
 
-	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
-		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
-
 	/* Force a full look up iff the parent directory has changed */
 	if (!(flags & (LOOKUP_EXCL | LOOKUP_REVAL)) &&
 	    nfs_check_verifier(dir, dentry, flags & LOOKUP_RCU)) {
+
+		if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
+			return nfs_lookup_revalidate_delegated(dir, dentry, inode);
+
 		error = nfs_lookup_verify_inode(inode, flags);
 		if (error) {
 			if (error == -ESTALE)
@@ -1707,9 +1708,6 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
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

