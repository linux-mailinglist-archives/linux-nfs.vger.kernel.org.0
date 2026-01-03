Return-Path: <linux-nfs+bounces-17413-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2369BCF0329
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 18:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F344301E595
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 17:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122D72D0C85;
	Sat,  3 Jan 2026 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4NsGDZH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB81D298CD5
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767460503; cv=none; b=CrftmqH6mGWW/gc7D4LaoqdrRPDfhTkABttoLOyF8nqlvKFUxMB4B7w/VtQku9FHKCnmlKa3xNt/FUFbNvHF4OGMvrSgyU1IJiAXKv0tF8t8HtyOejHFw3UdS5mOzbgYaeAOjeCb8DCUKUyX88VFlDY3RtteX7zcyV7J9yQ89Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767460503; c=relaxed/simple;
	bh=onjI7bzroPdpAL+Tbd/wgTzfO28XYgzDkgfIc/sy+3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmD5ufx4f4yKUuw5eF+7scTfLuKL5STxNhUtZdhUAN4zannLEVym5E5M2ZIi7/33iGgF7zbBEr27PGueUng3HE6fXU7VYvL+Up4bEHrctiMk3fn7pDJz9AOroeSApHQbrXyKu+gevSWTe477hhJOd50YlXhDrFrQRDforZkAMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4NsGDZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF355C19423;
	Sat,  3 Jan 2026 17:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767460503;
	bh=onjI7bzroPdpAL+Tbd/wgTzfO28XYgzDkgfIc/sy+3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4NsGDZHgHpkz45O5hTubxDoKyLQtb1zpu2h+DV2exy4fN4BeSmXFuc1NQFpcrpdx
	 EXAo/LqtYSgzGoPMaPZK3UHRzj2elJrMabCS51M9GTrLOptj1j/hbHFHtWSZHo0uoh
	 Kro5IgQGS65xK8dntAyIAJlj2+0lj0CABG0kQKFMdm8S2NE8FlQpndGmSWrZexqY7L
	 Qh920Hnbogvh5ZniOhGRoKIVsTXhnb/Q04CyrcYpejv/AN1F8m9IVutLTLbbHU9ry1
	 nGhmgq9DJ1voT3j9lob/t7nez4TS8KUpTypmwUj01KAruLALmB/KUXyiouIOS1XZu0
	 SFA09en+w7lJw==
From: Trond Myklebust <trondmy@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] NFS/localio: Stop further I/O upon hitting an error
Date: Sat,  3 Jan 2026 12:14:57 -0500
Message-ID: <d0d1748668398cd6adfb079fed60409b29167ff2.1767459435.git.trond.myklebust@hammerspace.com>
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

If the call into the filesystem results in an I/O error, then the next
chunk of data won't be contiguous with the end of the last successful
chunk. So break out of the I/O loop and report the results.
Currently the localio code will do this for a short read/write, but not
for an error.

Fixes: 6a218b9c3183 ("nfs/localio: do not issue misaligned DIO out-of-order")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/localio.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index b98bb292fef0..611088ec5a99 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -619,7 +619,6 @@ static void nfs_local_call_read(struct work_struct *work)
 		container_of(work, struct nfs_local_kiocb, work);
 	struct file *filp = iocb->kiocb.ki_filp;
 	const struct cred *save_cred;
-	bool force_done = false;
 	ssize_t status;
 	int n_iters;
 
@@ -638,13 +637,13 @@ static void nfs_local_call_read(struct work_struct *work)
 			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
 
 		status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
-		if (status != -EIOCBQUEUED) {
-			if (unlikely(status >= 0 && status < iocb->iters[i].count))
-				force_done = true; /* Partial read */
-			if (nfs_local_pgio_done(iocb, status, force_done)) {
-				nfs_local_read_iocb_done(iocb);
-				break;
-			}
+		if (status == -EIOCBQUEUED)
+			continue;
+		/* Break on completion, errors, or short reads */
+		if (nfs_local_pgio_done(iocb, status, false) || status < 0 ||
+		    (size_t)status < iov_iter_count(&iocb->iters[i])) {
+			nfs_local_read_iocb_done(iocb);
+			break;
 		}
 	}
 
@@ -825,7 +824,6 @@ static void nfs_local_call_write(struct work_struct *work)
 	struct file *filp = iocb->kiocb.ki_filp;
 	unsigned long old_flags = current->flags;
 	const struct cred *save_cred;
-	bool force_done = false;
 	ssize_t status;
 	int n_iters;
 
@@ -846,13 +844,13 @@ static void nfs_local_call_write(struct work_struct *work)
 			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
 
 		status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iters[i]);
-		if (status != -EIOCBQUEUED) {
-			if (unlikely(status >= 0 && status < iocb->iters[i].count))
-				force_done = true; /* Partial write */
-			if (nfs_local_pgio_done(iocb, status, force_done)) {
-				nfs_local_write_iocb_done(iocb);
-				break;
-			}
+		if (status == -EIOCBQUEUED)
+			continue;
+		/* Break on completion, errors, or short writes */
+		if (nfs_local_pgio_done(iocb, status, false) || status < 0 ||
+		    (size_t)status < iov_iter_count(&iocb->iters[i])) {
+			nfs_local_write_iocb_done(iocb);
+			break;
 		}
 	}
 	file_end_write(filp);
-- 
2.52.0


