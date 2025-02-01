Return-Path: <linux-nfs+bounces-9827-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC56A24BB9
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 21:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E193A5F05
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 20:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D171CBE94;
	Sat,  1 Feb 2025 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfxDITZP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AFA7DA84
	for <linux-nfs@vger.kernel.org>; Sat,  1 Feb 2025 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738440011; cv=none; b=lmg+JNwkLxsDy75q7Qr8733FCcGA5cGP03Nq3pcokAIg5+sJjy2nQww7lpjS1v7UvGzf8ZhP/ogMPNlmdywUSpKR6OhsMcpo/R2xO6P+MFpNGrZGOOsXaj6MogXsxg60T0xDK1tIKf1YOV+ilqRbuZWpyYOYyakwX6Z9xfRrEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738440011; c=relaxed/simple;
	bh=1r+SDg/AG87quBMkIRyVzxwV4LfA8RS5XipSyS2E1kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=umha7RrozbJzen5/JAlZKKJ3oOn3xB2v1Nyc9z5xzI2LM4R3EQHnNE8ZesMt7jhT0eSbXmuk2FnQc7+u4AVEB3SQp3NjF35HoisbF5SmjFeVzgXZ+/faSqzVyfQHXH4XSTHApK5tSBY+5WbNKGhh2bYlMeQI7SGTXb6OQmOjiko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfxDITZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D4FC4CED3;
	Sat,  1 Feb 2025 20:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738440010;
	bh=1r+SDg/AG87quBMkIRyVzxwV4LfA8RS5XipSyS2E1kk=;
	h=From:To:Cc:Subject:Date:From;
	b=RfxDITZPjs4LFA/AZTLLD9Zzo4KUiPd3qRHWkw2DQAwJZPJYksxtMahLCy3d/kO/W
	 clg1mlFg9P1pKLsWoKFSAxx9lLCzBJ/dpuV1R5urAkA+Z0RzN4aeXC7Aig6OIGDYzb
	 JkAoCGtRaEUQCBexilsyWpVBHM0awkQVrgeoBJLdhtvB898z6n6ODJEyr4NBLaGXNA
	 QaocqA4/YpfkDUW7vumOOIZLh/sMahgr8d2UNbX+bl96TnewRMpDEPTySZUYXde5tl
	 q6Q2SSlkgck5L6eSt9oZ0tGIpGj/6RSIG4edTrd2zomKCxAjsEeLzOISBsZrF5Uy0f
	 oSQqiQi/rjmlg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH] NFSv4: Fix a deadlock when recovering state on a sillyrenamed file
Date: Sat,  1 Feb 2025 15:00:09 -0500
Message-ID: <859589e08b72ae716e0ea2b54de43abc20782b5b.1738439884.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the file is sillyrenamed, and slated for delete on close, it is
possible for a server reboot to triggeer an open reclaim, with can again
race with the application call to close(). When that happens, the call
to put_nfs_open_context() can trigger a synchronous delegreturn call
which deadlocks because it is not marked as privileged.

Instead, ensure that the call to nfs4_inode_return_delegation_on_close()
catches the delegreturn, and schedules it asynchronously.

Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
Fixes: adb4b42d19ae ("Return the delegation when deleting sillyrenamed files")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 37 +++++++++++++++++++++++++++++++++++++
 fs/nfs/delegation.h |  1 +
 fs/nfs/nfs4proc.c   |  3 +++
 3 files changed, 41 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 035ba52742a5..4db912f56230 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -780,6 +780,43 @@ int nfs4_inode_return_delegation(struct inode *inode)
 	return 0;
 }
 
+/**
+ * nfs4_inode_set_return_delegation_on_close - asynchronously return a delegation
+ * @inode: inode to process
+ *
+ * This routine is called to request that the delegation be returned as soon
+ * as the file is closed. If the file is already closed, the delegation is
+ * immediately returned.
+ */
+void nfs4_inode_set_return_delegation_on_close(struct inode *inode)
+{
+	struct nfs_delegation *delegation;
+	struct nfs_delegation *ret = NULL;
+
+	if (!inode)
+		return;
+	rcu_read_lock();
+	delegation = nfs4_get_valid_delegation(inode);
+	if (!delegation)
+		goto out;
+	spin_lock(&delegation->lock);
+	if (!delegation->inode)
+		goto out_unlock;
+	if (list_empty(&NFS_I(inode)->open_files) &&
+	    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
+		/* Refcount matched in nfs_end_delegation_return() */
+		ret = nfs_get_delegation(delegation);
+	} else
+		set_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags);
+out_unlock:
+	spin_unlock(&delegation->lock);
+	if (ret)
+		nfs_clear_verifier_delegated(inode);
+out:
+	rcu_read_unlock();
+	nfs_end_delegation_return(inode, ret, 0);
+}
+
 /**
  * nfs4_inode_return_delegation_on_close - asynchronously return a delegation
  * @inode: inode to process
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 71524d34ed20..8ff5ab9c5c25 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -49,6 +49,7 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 				  unsigned long pagemod_limit, u32 deleg_type);
 int nfs4_inode_return_delegation(struct inode *inode);
 void nfs4_inode_return_delegation_on_close(struct inode *inode);
+void nfs4_inode_set_return_delegation_on_close(struct inode *inode);
 int nfs_async_inode_return_delegation(struct inode *inode, const nfs4_stateid *stateid);
 void nfs_inode_evict_delegation(struct inode *inode);
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index df9669d4ded7..c25ecdb76d30 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3906,8 +3906,11 @@ nfs4_atomic_open(struct inode *dir, struct nfs_open_context *ctx,
 
 static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 {
+	struct dentry *dentry = ctx->dentry;
 	if (ctx->state == NULL)
 		return;
+	if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
+		nfs4_inode_set_return_delegation_on_close(d_inode(dentry));
 	if (is_sync)
 		nfs4_close_sync(ctx->state, _nfs4_ctx_to_openmode(ctx));
 	else
-- 
2.48.1


