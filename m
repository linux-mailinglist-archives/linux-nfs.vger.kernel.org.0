Return-Path: <linux-nfs+bounces-10432-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EE5A4CA20
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 18:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0586518853B5
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786B722D4D1;
	Mon,  3 Mar 2025 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHc5s4wP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5482E226555
	for <linux-nfs@vger.kernel.org>; Mon,  3 Mar 2025 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023333; cv=none; b=t7DD0E79A6BQRsMqrElwd3rMwixceQwkdFLWNxigeUzsnfEYTBqGX79EoUpFnZZgiPZkRYpq/XQjqZyJ9TxVKXrOkNgVZDNDGzFfD3Hp+pAj1e6uASDyPB8+KIeW4UNAWECwK2VNh7G8zs3wSnxY0vXYexNnJrNVQ4IZpiN6YcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023333; c=relaxed/simple;
	bh=HWRPD8Jm2WXEs5QuG49E0Pus4tRr6d9oxCT/EDiMLxc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXh5QBq5v3OvYnrAWZCjlsEuPJ9nE6jac+jHyXysFE/1XHNbPcAAMDrr6iid3xc7kfrUwGUNBh1YxGaladpm8m+AXB5nyi2v9ym2jXIS9D9/E66C4lFwZbVYOUwgzmS9iAMNveE4FiSrokIS3R1+I9hMEbGeadkZ071s3PWCXVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHc5s4wP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C779C4CED6
	for <linux-nfs@vger.kernel.org>; Mon,  3 Mar 2025 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741023333;
	bh=HWRPD8Jm2WXEs5QuG49E0Pus4tRr6d9oxCT/EDiMLxc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CHc5s4wPZ6jj6YVLnR3eEPBdt69uwYSmYTpUit26wnUp2nns3rsLskphzjWvYSM24
	 81QL3Xq4qG496q+BHzK087VTmkg5Dxuj4Xa96AiQlWxQYQFrXf6aV87xCR81uQCDYu
	 3PFIbF1tlQoNGpFp7aVxl/MfmNzalP/1pwyr8bIv7m5TYNhL1xTI1qOP2WgMmtlNmF
	 AGc1IC3shZr3oPYhdVZAyfTUGbJerG6LLXPyKHlk/YHCL0pnxDx+b561JFpWKRI3uS
	 cTNL4YX43pjp8YTiB5PG/CGDLa93MG7L/bc8Va1Ae+/NjKwNLvdBJuaxVUdZWuLkWr
	 fmG6Mr/IBzhmw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] NFSv4: Avoid unnecessary scans of filesystems for delayed delegations
Date: Mon,  3 Mar 2025 12:35:29 -0500
Message-ID: <c019512d31c03612a2693db2d339fad077149fab.1741023037.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741023037.git.trond.myklebust@hammerspace.com>
References: <cover.1741023037.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The amount of looping through the list of delegations is occasionally
leading to soft lockups. If the state manager was asked to manage the
delayed return of delegations, then only scan those filesystems
containing delegations that were marked as being delayed.

Fixes: be20037725d1 ("NFSv4: Fix delegation return in cases where we have to retry")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c       | 18 ++++++++++++------
 include/linux/nfs_fs_sb.h |  1 +
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index abd952cc47e4..325ba0663a6d 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -331,14 +331,16 @@ nfs_start_delegation_return(struct nfs_inode *nfsi)
 }
 
 static void nfs_abort_delegation_return(struct nfs_delegation *delegation,
-					struct nfs_client *clp, int err)
+					struct nfs_server *server, int err)
 {
-
 	spin_lock(&delegation->lock);
 	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
 	if (err == -EAGAIN) {
 		set_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
-		set_bit(NFS4CLNT_DELEGRETURN_DELAYED, &clp->cl_state);
+		set_bit(NFS4SERV_DELEGRETURN_DELAYED,
+			&server->delegation_flags);
+		set_bit(NFS4CLNT_DELEGRETURN_DELAYED,
+			&server->nfs_client->cl_state);
 	}
 	spin_unlock(&delegation->lock);
 }
@@ -548,7 +550,7 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
  */
 static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation *delegation, int issync)
 {
-	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
+	struct nfs_server *server = NFS_SERVER(inode);
 	unsigned int mode = O_WRONLY | O_RDWR;
 	int err = 0;
 
@@ -570,11 +572,11 @@ static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation
 		/*
 		 * Guard against state recovery
 		 */
-		err = nfs4_wait_clnt_recover(clp);
+		err = nfs4_wait_clnt_recover(server->nfs_client);
 	}
 
 	if (err) {
-		nfs_abort_delegation_return(delegation, clp, err);
+		nfs_abort_delegation_return(delegation, server, err);
 		goto out;
 	}
 
@@ -678,6 +680,9 @@ static bool nfs_server_clear_delayed_delegations(struct nfs_server *server)
 	struct nfs_delegation *d;
 	bool ret = false;
 
+	if (!test_and_clear_bit(NFS4SERV_DELEGRETURN_DELAYED,
+				&server->delegation_flags))
+		goto out;
 	list_for_each_entry_rcu (d, &server->delegations, super_list) {
 		if (!test_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags))
 			continue;
@@ -685,6 +690,7 @@ static bool nfs_server_clear_delayed_delegations(struct nfs_server *server)
 		clear_bit(NFS_DELEGATION_RETURN_DELAYED, &d->flags);
 		ret = true;
 	}
+out:
 	return ret;
 }
 
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 7d6f164036fa..108862d81b57 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -253,6 +253,7 @@ struct nfs_server {
 	unsigned long		delegation_flags;
 #define NFS4SERV_DELEGRETURN		(1)
 #define NFS4SERV_DELEGATION_EXPIRED	(2)
+#define NFS4SERV_DELEGRETURN_DELAYED	(3)
 	unsigned long		delegation_gen;
 	unsigned long		mig_gen;
 	unsigned long		mig_status;
-- 
2.48.1


