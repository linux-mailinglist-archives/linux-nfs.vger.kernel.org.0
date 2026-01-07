Return-Path: <linux-nfs+bounces-17577-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D173CCFEF8B
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 17:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63FF733C3E2B
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 16:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737A9339870;
	Wed,  7 Jan 2026 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4VPWBvP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DC5390CC3
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802147; cv=none; b=B449DkLxuC6zN1MtVSSSD0FBPAdMaGtvoL47glyJ1ttIooe6E8hSsjGPF7e/An/B4SOIy+2QZ+s6hlZh0tE/bykNTH5ct9TnPqgqoV1VUZPI51vuZ4U1CBWGVEQJ+GMZ9fRUzZW+dxfNTqVjanUvuShPlHZ/Oj8soTavXzH16yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802147; c=relaxed/simple;
	bh=XWRHw6QNxHph4/hkD9eoJecKN7xNR+UVkNcQnaBGIzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYbEbqLdKVMuXesr9M8tu4Gi5Vmalr6GMGAUJie2aYEEes8ZA+Qolxh6MZ/owmeFG8Oat5Eqkp/5NOjaLS3lxQkh9FDphAP2Ecbb0TZbJDaaaglWwUHh9fM8DUQwayOHJVnbXXMkR0w9SLuMosPYlZZk8vn6XnGUTn34pQLigN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4VPWBvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E95C4CEF1;
	Wed,  7 Jan 2026 16:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767802145;
	bh=XWRHw6QNxHph4/hkD9eoJecKN7xNR+UVkNcQnaBGIzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4VPWBvP/B2MGA25vFphO4tvkdytqz9W77ahOxiU2Z5W/G5dOSSzbPYK+jzP1WY8f
	 +sAttUq8lP6v/P8/ecPcQFNRQ/PE0MS6okXHhKk4kzXJiPR9nU0U3akUOE9X9R4OJ0
	 Aw1IkjugL+Hb0YKT1ay7XKEqxVeCE8Nh2Z9KON9txkB8oZVOvDnKfTWnOblsDr5wve
	 oXjyh8OAcbjeYRUBWYj9eixY9JWu1HU6xF2VRh0Ws1vxHNJE9cggJOQErZUH7OhOrj
	 8sKTN363rFUyxoSthc8hheCkjyYm9pdFpIDT/CeLrebkVGAqfEJtd2e7e+zFAThXXY
	 we9zOr3FumbIQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] NFS/localio: switch nfs_local_do_read and nfs_local_do_write to return void
Date: Wed,  7 Jan 2026 11:08:58 -0500
Message-ID: <20260107160858.6847-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260107160858.6847-1-snitzer@kernel.org>
References: <20260107160858.6847-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both nfs_local_do_read and nfs_local_do_write only return 0 at the
end, so switch them to returning void.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index fa37425c5784b..fa9c0bc0be9d0 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -58,10 +58,10 @@ struct nfs_local_fsync_ctx {
 static bool localio_enabled __read_mostly = true;
 module_param(localio_enabled, bool, 0644);
 
-static int nfs_local_do_read(struct nfs_local_kiocb *iocb,
-			     const struct rpc_call_ops *call_ops);
-static int nfs_local_do_write(struct nfs_local_kiocb *iocb,
+static void nfs_local_do_read(struct nfs_local_kiocb *iocb,
 			      const struct rpc_call_ops *call_ops);
+static void nfs_local_do_write(struct nfs_local_kiocb *iocb,
+			       const struct rpc_call_ops *call_ops);
 
 static inline bool nfs_client_is_local(const struct nfs_client *clp)
 {
@@ -570,17 +570,17 @@ static void nfs_local_pgio_restart(struct nfs_local_kiocb *iocb,
 	switch (hdr->rw_mode) {
 	case FMODE_READ:
 		nfs_local_iters_init(iocb, ITER_DEST);
-		status = nfs_local_do_read(iocb, hdr->task.tk_ops);
+		nfs_local_do_read(iocb, hdr->task.tk_ops);
 		break;
 	case FMODE_WRITE:
 		nfs_local_iters_init(iocb, ITER_SOURCE);
-		status = nfs_local_do_write(iocb, hdr->task.tk_ops);
+		nfs_local_do_write(iocb, hdr->task.tk_ops);
 		break;
 	default:
 		status = -EOPNOTSUPP;
 	}
 
-	if (status != 0) {
+	if (unlikely(status != 0)) {
 		nfs_local_iocb_release(iocb);
 		hdr->task.tk_status = status;
 		nfs_local_hdr_release(hdr, hdr->task.tk_ops);
@@ -702,9 +702,8 @@ static void nfs_local_call_read(struct work_struct *work)
 	}
 }
 
-static int
-nfs_local_do_read(struct nfs_local_kiocb *iocb,
-		  const struct rpc_call_ops *call_ops)
+static void nfs_local_do_read(struct nfs_local_kiocb *iocb,
+			      const struct rpc_call_ops *call_ops)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
 
@@ -716,8 +715,6 @@ nfs_local_do_read(struct nfs_local_kiocb *iocb,
 
 	INIT_WORK(&iocb->work, nfs_local_call_read);
 	queue_work(nfslocaliod_workqueue, &iocb->work);
-
-	return 0;
 }
 
 static void
@@ -900,9 +897,8 @@ static void nfs_local_call_write(struct work_struct *work)
 	current->flags = old_flags;
 }
 
-static int
-nfs_local_do_write(struct nfs_local_kiocb *iocb,
-		   const struct rpc_call_ops *call_ops)
+static void nfs_local_do_write(struct nfs_local_kiocb *iocb,
+			       const struct rpc_call_ops *call_ops)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
 
@@ -926,8 +922,6 @@ nfs_local_do_write(struct nfs_local_kiocb *iocb,
 
 	INIT_WORK(&iocb->work, nfs_local_call_write);
 	queue_work(nfslocaliod_workqueue, &iocb->work);
-
-	return 0;
 }
 
 static struct nfs_local_kiocb *
@@ -977,10 +971,10 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
 
 	switch (hdr->rw_mode) {
 	case FMODE_READ:
-		status = nfs_local_do_read(iocb, call_ops);
+		nfs_local_do_read(iocb, call_ops);
 		break;
 	case FMODE_WRITE:
-		status = nfs_local_do_write(iocb, call_ops);
+		nfs_local_do_write(iocb, call_ops);
 		break;
 	default:
 		dprintk("%s: invalid mode: %d\n", __func__,
@@ -988,7 +982,7 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
 		status = -EOPNOTSUPP;
 	}
 
-	if (status != 0) {
+	if (unlikely(status != 0)) {
 		nfs_local_iocb_release(iocb);
 		hdr->task.tk_status = status;
 		nfs_local_hdr_release(hdr, call_ops);
-- 
2.44.0


