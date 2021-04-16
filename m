Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3A1362759
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 20:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbhDPSAs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Apr 2021 14:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbhDPSAr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Apr 2021 14:00:47 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968C2C061574
        for <linux-nfs@vger.kernel.org>; Fri, 16 Apr 2021 11:00:21 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E05F16D1C; Fri, 16 Apr 2021 14:00:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E05F16D1C
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/5] nfsd: ensure new clients break delegations
Date:   Fri, 16 Apr 2021 14:00:14 -0400
Message-Id: <1618596018-9899-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

If nfsd already has an open file that it plans to use for IO from
another, it may not need to do another vfs open, but it still may need
to break any delegations in case the existing opens are for another
client.

Symptoms are that we may incorrectly fail to break a delegation on a
write open from a different client, when the delegation-holding client
already has a write open.

Fixes: 28df3d1539de ("nfsd: clients don't need to break their own delegations")
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 97447a64bad0..886e50ed07c2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4869,6 +4869,11 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	if (nf)
 		nfsd_file_put(nf);
 
+	status = nfserrno(nfsd_open_break_lease(cur_fh->fh_dentry->d_inode,
+								access));
+	if (status)
+		goto out_put_access;
+
 	status = nfsd4_truncate(rqstp, cur_fh, open);
 	if (status)
 		goto out_put_access;
@@ -6849,11 +6854,20 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file_lock *lock)
 {
 	struct nfsd_file *nf;
-	__be32 err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
-	if (!err) {
-		err = nfserrno(vfs_test_lock(nf->nf_file, lock));
-		nfsd_file_put(nf);
-	}
+	__be32 err;
+
+	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
+	if (err)
+		return err;
+	fh_lock(fhp); /* to block new leases till after test_lock: */
+	err = nfserrno(nfsd_open_break_lease(fhp->fh_dentry->d_inode,
+							NFSD_MAY_READ));
+	if (err)
+		goto out;
+	err = nfserrno(vfs_test_lock(nf->nf_file, lock));
+out:
+	fh_unlock(fhp);
+	nfsd_file_put(nf);
 	return err;
 }
 
-- 
2.30.2

