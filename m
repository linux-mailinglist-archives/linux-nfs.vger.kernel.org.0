Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF0835F540
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351583AbhDNNol (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351618AbhDNNo0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2849B61222
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407845;
        bh=DJcl+hvkY98fQZstt8/wK2TNHjk7YybhDhUW208i9D8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hZp1kUpy7i850kCymIBM0W4aR1pAluHA2qswImjlHalluk6DhG3dCsHTB6AU9DUMV
         8xFW0g57B11zGSVCUHqe2h8ReEL1lprY1nRs9HThDf2EgjkPguMgMdeVDJzygG9ZnN
         1z8mpYl94IbRtIjMPXwlF9F/iwtygQbpIZEWy+H5rrQEHaVS2HZFXBT1ndnigUW6u7
         lmVuZT0L1G10wBGXjxhLz406gHRNHvteHJowcwn8g53IH6cppoDh6cXFD/fy8vbGfe
         XLA/5wbzaomws7pi3IrgJLNBgODEPifbZZH9fBOErw29+eDMVlt53QSqLSCDToZ6zu
         OAYFudAexFyTA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 23/26] NFSv4: nfs4_inc/dec_nlink_locked should also invalidate ctime
Date:   Wed, 14 Apr 2021 09:43:50 -0400
Message-Id: <20210414134353.11860-24-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-23-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
 <20210414134353.11860-4-trondmy@kernel.org>
 <20210414134353.11860-5-trondmy@kernel.org>
 <20210414134353.11860-6-trondmy@kernel.org>
 <20210414134353.11860-7-trondmy@kernel.org>
 <20210414134353.11860-8-trondmy@kernel.org>
 <20210414134353.11860-9-trondmy@kernel.org>
 <20210414134353.11860-10-trondmy@kernel.org>
 <20210414134353.11860-11-trondmy@kernel.org>
 <20210414134353.11860-12-trondmy@kernel.org>
 <20210414134353.11860-13-trondmy@kernel.org>
 <20210414134353.11860-14-trondmy@kernel.org>
 <20210414134353.11860-15-trondmy@kernel.org>
 <20210414134353.11860-16-trondmy@kernel.org>
 <20210414134353.11860-17-trondmy@kernel.org>
 <20210414134353.11860-18-trondmy@kernel.org>
 <20210414134353.11860-19-trondmy@kernel.org>
 <20210414134353.11860-20-trondmy@kernel.org>
 <20210414134353.11860-21-trondmy@kernel.org>
 <20210414134353.11860-22-trondmy@kernel.org>
 <20210414134353.11860-23-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the nlink changes, then so will the ctime.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 0b0a48d78299..d05f4ca5d9c0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1169,14 +1169,18 @@ int nfs4_call_sync(struct rpc_clnt *clnt,
 static void
 nfs4_inc_nlink_locked(struct inode *inode)
 {
-	nfs_set_cache_invalid(inode, NFS_INO_INVALID_NLINK);
+	nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE |
+					     NFS_INO_INVALID_CTIME |
+					     NFS_INO_INVALID_NLINK);
 	inc_nlink(inode);
 }
 
 static void
 nfs4_dec_nlink_locked(struct inode *inode)
 {
-	nfs_set_cache_invalid(inode, NFS_INO_INVALID_NLINK);
+	nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE |
+					     NFS_INO_INVALID_CTIME |
+					     NFS_INO_INVALID_NLINK);
 	drop_nlink(inode);
 }
 
@@ -4602,11 +4606,11 @@ _nfs4_proc_remove(struct inode *dir, const struct qstr *name, u32 ftype)
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 1);
 	if (status == 0) {
 		spin_lock(&dir->i_lock);
-		nfs4_update_changeattr_locked(dir, &res.cinfo, timestamp,
-					      NFS_INO_INVALID_DATA);
 		/* Removing a directory decrements nlink in the parent */
 		if (ftype == NF4DIR && dir->i_nlink > 2)
 			nfs4_dec_nlink_locked(dir);
+		nfs4_update_changeattr_locked(dir, &res.cinfo, timestamp,
+					      NFS_INO_INVALID_DATA);
 		spin_unlock(&dir->i_lock);
 	}
 	return status;
@@ -4864,12 +4868,12 @@ static int nfs4_do_create(struct inode *dir, struct dentry *dentry, struct nfs4_
 				    &data->arg.seq_args, &data->res.seq_res, 1);
 	if (status == 0) {
 		spin_lock(&dir->i_lock);
-		nfs4_update_changeattr_locked(dir, &data->res.dir_cinfo,
-				data->res.fattr->time_start,
-				NFS_INO_INVALID_DATA);
 		/* Creating a directory bumps nlink in the parent */
 		if (data->arg.ftype == NF4DIR)
 			nfs4_inc_nlink_locked(dir);
+		nfs4_update_changeattr_locked(dir, &data->res.dir_cinfo,
+					      data->res.fattr->time_start,
+					      NFS_INO_INVALID_DATA);
 		spin_unlock(&dir->i_lock);
 		status = nfs_instantiate(dentry, data->res.fh, data->res.fattr, data->res.label);
 	}
-- 
2.30.2

