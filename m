Return-Path: <linux-nfs+bounces-11173-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1848CA94249
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 10:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2402A8A2D6B
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 08:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE781B6CF1;
	Sat, 19 Apr 2025 08:34:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18CE1FB3;
	Sat, 19 Apr 2025 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745051683; cv=none; b=mAix36zCRzgIjMQSk/Xbc3oXo8wRjjDOKuO23YK0OyC/nxQQPeGq+VxFgs3IQtymJtxvE+uRSRJf/VDPo0/W9A7F7iRoBNqHf2Xufrgb/V+i+z5xWgkYYk8lFhVs4J+3QLEtMIyVlK7BFnlQ/cqwm8V1XsLowi3AWmuAK9+mqpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745051683; c=relaxed/simple;
	bh=6vfBMEHNRiWKyVQ0+nDbh3AS6ETSW3sPRcK39Li++r8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/Jh52JdB+A3vpPyDtnSkpsN/00xBqHbpbxxwJI5WVroiRR4XMPb9Cb9BL7paW0FiSm9kaeUj8YgpY8HrUE1iwp7im4LiCUBNxCg1TvckXgDrTf5IZ9aa903hxjchqxgSmEh1WA+nCt5UpuX810+P4ELeZfI2dLYBJXgIjgIRTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZflK46xpzz13KbK;
	Sat, 19 Apr 2025 16:33:44 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id B03D71402E9;
	Sat, 19 Apr 2025 16:34:38 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 19 Apr
 2025 16:34:37 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <jlayton@kernel.org>,
	<bcodding@redhat.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH 2/2] nfs: handle failure of get_nfs_open_context
Date: Sat, 19 Apr 2025 16:53:55 +0800
Message-ID: <20250419085355.1451457-3-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250419085355.1451457-1-lilingfeng3@huawei.com>
References: <20250419085355.1451457-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500017.china.huawei.com (7.202.181.81)

During initialization of unlockdata or lockdata structures, if acquiring
the nfs_open_context fails, the current operation must be aborted to
ensure the nfs_open_context remains valid after initialization completes.
This is critical because both lock and unlock release callbacks
dereference the nfs_open_context - an invalid context could lead to null
pointer dereference.

Fixes: faf5f49c2d9c ("NFSv4: Make NFS clean up byte range locks asynchronously")
Fixes: a5d16a4d090b ("NFSv4: Convert LOCK rpc call into an asynchronous RPC call")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfs/nfs4proc.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9f5689c43a50..d76cf0f79f9c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7075,24 +7075,27 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
 	struct nfs4_state *state = lsp->ls_state;
 	struct inode *inode = state->inode;
 	struct nfs_lock_context *l_ctx;
+	struct nfs_open_context *open_ctx;
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (p == NULL)
 		return NULL;
 	l_ctx = nfs_get_lock_context(ctx);
-	if (!IS_ERR(l_ctx)) {
+	if (!IS_ERR(l_ctx))
 		p->l_ctx = l_ctx;
-	} else {
-		kfree(p);
-		return NULL;
-	}
+	else
+		goto out_free;
+	/* Ensure we don't close file until we're done freeing locks! */
+	open_ctx = get_nfs_open_context(ctx);
+	if (open_ctx)
+		p->ctx = open_ctx;
+	else
+		goto out_free;
 	p->arg.fh = NFS_FH(inode);
 	p->arg.fl = &p->fl;
 	p->arg.seqid = seqid;
 	p->res.seqid = seqid;
 	p->lsp = lsp;
-	/* Ensure we don't close file until we're done freeing locks! */
-	p->ctx = get_nfs_open_context(ctx);
 	locks_init_lock(&p->fl);
 	locks_copy_lock(&p->fl, fl);
 	p->server = NFS_SERVER(inode);
@@ -7100,6 +7103,9 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
 	nfs4_stateid_copy(&p->arg.stateid, &lsp->ls_stateid);
 	spin_unlock(&state->state_lock);
 	return p;
+out_free:
+	kfree(p);
+	return NULL;
 }
 
 static void nfs4_locku_release_calldata(void *data)
@@ -7327,6 +7333,8 @@ static struct nfs4_lockdata *nfs4_alloc_lockdata(struct file_lock *fl,
 	p->lsp = lsp;
 	p->server = server;
 	p->ctx = get_nfs_open_context(ctx);
+	if (!p->ctx)
+		goto out_free_seqid;
 	locks_init_lock(&p->fl);
 	locks_copy_lock(&p->fl, fl);
 	return p;
-- 
2.31.1


