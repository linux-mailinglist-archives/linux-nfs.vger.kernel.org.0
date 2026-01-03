Return-Path: <linux-nfs+bounces-17415-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FA5CF032F
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 18:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3D743027D98
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEECA30C348;
	Sat,  3 Jan 2026 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DK2t6R7O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B7123E33D
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767460504; cv=none; b=Bm3zGkSyyFQi6BkxdP+mkBR193EjGkCC47omqUIyZe8VLZmSe1pPeifOUtNVErL0T1cYPlBJ8b2bycx4uZACquWkt+UvzR1eciljoVRcWlysUGmOcBlVUhIWYYl5ViJH0AvWZR513YaVp4DUK58KT2gRLzJLXEYgNrYLUl9kB6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767460504; c=relaxed/simple;
	bh=yhC5I2CFN2j0GMWjY5CdBMs4D6DVYWrl4n/DFWnNBBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4eqyq3bW9nI8Uk3TG7SnLpysjO6dAMBZioSDEoXfZw4KrVjnf3L6sersoPj+679siKFdKZl0Ps0INz2lM0ayEDPaf5NQUjbQbuNkqLQ2CRV6f2QLAnqzZR5tPn9b5GfdhZwSWIS5Ya/0lR2GY3C21oCtHVkFNflRKUOlx5OJzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK2t6R7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279B0C19422;
	Sat,  3 Jan 2026 17:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767460504;
	bh=yhC5I2CFN2j0GMWjY5CdBMs4D6DVYWrl4n/DFWnNBBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DK2t6R7OIqh1kYmIXQRaGaoTGGb1Pi6tgQKbKI+4ahbwiByE/79z0ubuVM3ctaArC
	 OtGcD+8CPqX99g/5y93a4Fap1M2GVoUfOT4iuLPS10ZBUNMsWano+6HwHI0ZuCOV27
	 X2cuoLZK/yPBQBdciqPe325bdHt3wgDdzCMcXdJdPRFC0rkSaFtCuaKs6JKTHSDFwM
	 l6/+IhsR9y6jq9jatt+CYXOyeGqAfd8Bn8jd6iTmjx2a1V7BP4cTa3e5IUApwwkw5R
	 xAuewl3KyOJAjIgBBx3d6m8RaXvmXi678axwUvtUwzZ5sKatbeAMraH47hazPGQfsc
	 U7m5kbDR1nxzg==
From: Trond Myklebust <trondmy@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] NFS/localio: Cleanup the nfs_local_pgio_done() parameters
Date: Sat,  3 Jan 2026 12:15:00 -0500
Message-ID: <bf5a9581839ebeebbd3bd004a174fea9afa19dcb.1767459435.git.trond.myklebust@hammerspace.com>
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

Remove the redundant 'force' parameter.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/localio.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 87abebbedbab..8caf2ffc7e43 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -517,8 +517,7 @@ nfs_local_pgio_init(struct nfs_pgio_header *hdr,
 		hdr->task.tk_start = ktime_get();
 }
 
-static bool
-nfs_local_pgio_done(struct nfs_local_kiocb *iocb, long status, bool force)
+static bool nfs_local_pgio_done(struct nfs_local_kiocb *iocb, long status)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
 
@@ -533,9 +532,6 @@ nfs_local_pgio_done(struct nfs_local_kiocb *iocb, long status, bool force)
 		hdr->task.tk_status = status;
 	}
 
-	if (force)
-		return true;
-
 	BUG_ON(atomic_read(&iocb->n_iters) <= 0);
 	return atomic_dec_and_test(&iocb->n_iters);
 }
@@ -651,7 +647,7 @@ static void nfs_local_read_aio_complete(struct kiocb *kiocb, long ret)
 		container_of(kiocb, struct nfs_local_kiocb, kiocb);
 
 	/* AIO completion of DIO read should always be last to complete */
-	if (unlikely(!nfs_local_pgio_done(iocb, ret, false)))
+	if (unlikely(!nfs_local_pgio_done(iocb, ret)))
 		return;
 
 	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_read_aio_complete_work */
@@ -684,7 +680,7 @@ static void nfs_local_call_read(struct work_struct *work)
 		if (status == -EIOCBQUEUED)
 			continue;
 		/* Break on completion, errors, or short reads */
-		if (nfs_local_pgio_done(iocb, status, false) || status < 0 ||
+		if (nfs_local_pgio_done(iocb, status) || status < 0 ||
 		    (size_t)status < iov_iter_count(&iocb->iters[i])) {
 			nfs_local_read_iocb_done(iocb);
 			break;
@@ -843,7 +839,7 @@ static void nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
 		container_of(kiocb, struct nfs_local_kiocb, kiocb);
 
 	/* AIO completion of DIO write should always be last to complete */
-	if (unlikely(!nfs_local_pgio_done(iocb, ret, false)))
+	if (unlikely(!nfs_local_pgio_done(iocb, ret)))
 		return;
 
 	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_write_aio_complete_work */
@@ -879,7 +875,7 @@ static void nfs_local_call_write(struct work_struct *work)
 		if (status == -EIOCBQUEUED)
 			continue;
 		/* Break on completion, errors, or short writes */
-		if (nfs_local_pgio_done(iocb, status, false) || status < 0 ||
+		if (nfs_local_pgio_done(iocb, status) || status < 0 ||
 		    (size_t)status < iov_iter_count(&iocb->iters[i])) {
 			nfs_local_write_iocb_done(iocb);
 			break;
-- 
2.52.0


