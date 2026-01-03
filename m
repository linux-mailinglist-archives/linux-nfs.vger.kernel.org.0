Return-Path: <linux-nfs+bounces-17414-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F15CF032C
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 18:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0378130213EE
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9D81F0994;
	Sat,  3 Jan 2026 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzJEm9Nj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681F2D1F5E
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767460504; cv=none; b=JdqLCy2Ag5FKIciebgtsSX83x+0nLgh1kRE9UZe11nfE4Ot6k8GuQvNOqSdSLyeTUVgrzihf4Of3rludIyyNWqTWMb94Je474UsTCJ+YtT4qG3WJksbIsMOpda4x2wqeD+2JPcHsiCbeir0CaUDQdV0nA1IWMIiilT92ZlN3riE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767460504; c=relaxed/simple;
	bh=xgVxyisgmK9mNwtHkpvWdmXxEeab3lRYukQ39+9TgGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9oXahY0y+m+/VX2g1/0uULFYqIVwxqy0Tt5yqsCRwUtEht60a2iXlfMlt/XM/ilIkv/FSOMWGVqLJY7rxFBgajaYR3pfsxg3UeQ2MJnNu8kvlu1YXushFTzZ00VjBUQvfEszHsVGMshuX2YXERhXZAhBdFTDmhERwjBKBUBP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzJEm9Nj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16F1C116C6;
	Sat,  3 Jan 2026 17:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767460503;
	bh=xgVxyisgmK9mNwtHkpvWdmXxEeab3lRYukQ39+9TgGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XzJEm9Nj2gg4XtKGRB6ry/bjMYXExrZzwdtGcK+tWE9w4cyotYUIuw5c0m9j4AvHp
	 siWqz9Yg+DGJoo7fgWwGYKU2gxfCjyrY9x9I7LobzQ7ELxOCiyRifVOi/gHpVuEAXu
	 JNNnzVqYbznAq0Obl6vOI4IswIeEzyHoGsF7lIHZXrca59q4pJ8QaS9omtTsi/MYlA
	 MKIukPKnKx845mNmmVtl3Py+AYuzIuFXSAI30D63FUhwTaNwXtibj0MllCfXvGJxqQ
	 e4auYRxlvFy8cBPfQamslIvQ/ldP8S7+wkEQjJ9d6rg4d6MhiP354dAJOAamEUKtCU
	 jwnLyeXHsYb6Q==
From: Trond Myklebust <trondmy@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] NFS/localio: Handle short writes by retrying
Date: Sat,  3 Jan 2026 12:14:59 -0500
Message-ID: <aad94ed780fd5ea5deee8967261e5cfeb17b4c04.1767459435.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767459435.git.trond.myklebust@hammerspace.com>
References: <cover.1767459435.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The current code for handling short writes in localio just truncates the
I/O and then sets an error. While that is close to how the ordinary NFS
code behaves, it does mean there is a chance the data that got written
is lost because it isn't persisted.
To fix this, change localio so that the upper layers can direct the
behaviour to persist any unstable data by rewriting it, and then
continuing writing until an ENOSPC is hit.

Fixes: 70ba381e1a43 ("nfs: add LOCALIO support")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/localio.c | 64 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index c5f975bb5a64..87abebbedbab 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -58,6 +58,11 @@ struct nfs_local_fsync_ctx {
 static bool localio_enabled __read_mostly = true;
 module_param(localio_enabled, bool, 0644);
 
+static int nfs_local_do_read(struct nfs_local_kiocb *iocb,
+			     const struct rpc_call_ops *call_ops);
+static int nfs_local_do_write(struct nfs_local_kiocb *iocb,
+			      const struct rpc_call_ops *call_ops);
+
 static inline bool nfs_client_is_local(const struct nfs_client *clp)
 {
 	return !!rcu_access_pointer(clp->cl_uuid.net);
@@ -542,13 +547,50 @@ nfs_local_iocb_release(struct nfs_local_kiocb *iocb)
 	nfs_local_iocb_free(iocb);
 }
 
-static void
-nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
+static void nfs_local_pgio_restart(struct nfs_local_kiocb *iocb,
+				   struct nfs_pgio_header *hdr)
+{
+	int status = 0;
+
+	iocb->kiocb.ki_pos = hdr->args.offset;
+	iocb->kiocb.ki_flags &= ~(IOCB_DSYNC | IOCB_SYNC | IOCB_DIRECT);
+	iocb->kiocb.ki_complete = NULL;
+	iocb->aio_complete_work = NULL;
+	iocb->end_iter_index = -1;
+
+	switch (hdr->rw_mode) {
+	case FMODE_READ:
+		nfs_local_iters_init(iocb, ITER_DEST);
+		status = nfs_local_do_read(iocb, hdr->task.tk_ops);
+		break;
+	case FMODE_WRITE:
+		nfs_local_iters_init(iocb, ITER_SOURCE);
+		status = nfs_local_do_write(iocb, hdr->task.tk_ops);
+		break;
+	default:
+		status = -EOPNOTSUPP;
+	}
+
+	if (status != 0) {
+		nfs_local_iocb_release(iocb);
+		hdr->task.tk_status = status;
+		nfs_local_hdr_release(hdr, hdr->task.tk_ops);
+	}
+}
+
+static void nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
+	struct rpc_task *task = &hdr->task;
+
+	task->tk_action = NULL;
+	task->tk_ops->rpc_call_done(task, hdr);
 
-	nfs_local_iocb_release(iocb);
-	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
+	if (task->tk_action == NULL) {
+		nfs_local_iocb_release(iocb);
+		task->tk_ops->rpc_release(hdr);
+	} else
+		nfs_local_pgio_restart(iocb, hdr);
 }
 
 /*
@@ -776,19 +818,7 @@ static void nfs_local_write_done(struct nfs_local_kiocb *iocb)
 		pr_info_ratelimited("nfs: Unexpected direct I/O write alignment failure\n");
 	}
 
-	/* Handle short writes as if they are ENOSPC */
-	status = hdr->res.count;
-	if (status > 0 && status < hdr->args.count) {
-		hdr->mds_offset += status;
-		hdr->args.offset += status;
-		hdr->args.pgbase += status;
-		hdr->args.count -= status;
-		nfs_set_pgio_error(hdr, -ENOSPC, hdr->args.offset);
-		status = -ENOSPC;
-		/* record -ENOSPC in terms of nfs_local_pgio_done */
-		(void) nfs_local_pgio_done(iocb, status, true);
-	}
-	if (hdr->task.tk_status < 0)
+	if (status < 0)
 		nfs_reset_boot_verifier(hdr->inode);
 }
 
-- 
2.52.0


