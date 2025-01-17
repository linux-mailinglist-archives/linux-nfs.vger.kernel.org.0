Return-Path: <linux-nfs+bounces-9328-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA24A1474E
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 02:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE5316AF86
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 01:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A6C25A65A;
	Fri, 17 Jan 2025 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAwZe9u/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610B225A64F
	for <linux-nfs@vger.kernel.org>; Fri, 17 Jan 2025 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737075941; cv=none; b=ojCyxZZ7Lwlg4eac52xFhN71/Zp++Ma8ImUMrvtMCDpqvIXo57kHDluqOSaSAygo7wtzVoSLw/E775AX6FvE2hTvR3rYuO44x+viKwOTDLkB+EcaUEnRLERsVR6B5RMnC7lEotKqy7M/Qw06TSeJCtCbVc9gmdiR7QyiWKSe9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737075941; c=relaxed/simple;
	bh=KCNMQSVke6SiBw6lexz+wq24zELhxAPPfr2JKgC/Rhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IKhsrKHB4s65MewJNWAANwuu2kkkDPgLSDfACi77GM1Vye59C7V8Lou6vp75LLc3+RTDZvzkLK1f876UT8DPpQ3VMUnLL40QTHwPMHerkTOupVyqoeBpP+/7hu9rSErKBT7QcxF6qnhcx80Nm5UumvKBLUGY7cQKM5mdbtdEpwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAwZe9u/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE40CC4CED6;
	Fri, 17 Jan 2025 01:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737075940;
	bh=KCNMQSVke6SiBw6lexz+wq24zELhxAPPfr2JKgC/Rhw=;
	h=From:To:Cc:Subject:Date:From;
	b=OAwZe9u/2O6eVMgu48bZujdxgsNuNRWUijs3FmO/PnSZNw20F0cvO7nKWD15HdV3p
	 YXmWrxsiUEE+CPLCjqwC6gLOpfFapL0D1mpwZVsAkSQuvZdtdp4EzCM/R33Dmk4YOK
	 yQx/K9X2fUINijNAZ9yFpTSd5uJb/SWf19h89zpmNuzQ5IIa8lrCuSY5p4ywfLKcXJ
	 QkLm7gAGh/0sPXAP8yLGmyuU9QgZuJRJpCklGLJgAU/hDubQrb7xUvNY4gRpkN9ZgE
	 x3N3S1Y1bIxJCohjTIfdk9SBNt+1nP2lUL4432r4Z3x89H/NW6r50HIVCoa9NasE7M
	 pPXr+YFulCKEQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH] pnfs/flexfiles: retry getting layout segment for reads
Date: Thu, 16 Jan 2025 20:05:39 -0500
Message-ID: <20250117010539.16393-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ff_layout_pg_get_read()'s attempt to get a layout segment results
in -EAGAIN have ff_layout_pg_init_read() retry it after sleeping.

If "softerr" mount is used, use 'io_maxretrans' to limit the number of
attempts to get a layout segment.

This fixes a long-standing issue of O_DIRECT reads failing with
-EAGAIN (11) when using flexfiles Client Side Mirroring (CSM).

Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 27 ++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index ce61bf1ada6c..98b45b636be3 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -848,6 +848,9 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	struct nfs4_pnfs_ds *ds;
 	u32 ds_idx;
 
+	if (NFS_SERVER(pgio->pg_inode)->flags &
+			(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR))
+		pgio->pg_maxretrans = io_maxretrans;
 retry:
 	pnfs_generic_pg_check_layout(pgio, req);
 	/* Use full layout for now */
@@ -861,6 +864,8 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 		if (!pgio->pg_lseg)
 			goto out_nolseg;
 	}
+	/* Reset wb_nio, since getting layout segment was successful */
+	req->wb_nio = 0;
 
 	ds = ff_layout_get_ds_for_read(pgio, &ds_idx);
 	if (!ds) {
@@ -877,14 +882,24 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	pgm->pg_bsize = mirror->mirror_ds->ds_versions[0].rsize;
 
 	pgio->pg_mirror_idx = ds_idx;
-
-	if (NFS_SERVER(pgio->pg_inode)->flags &
-			(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR))
-		pgio->pg_maxretrans = io_maxretrans;
 	return;
 out_nolseg:
-	if (pgio->pg_error < 0)
-		return;
+	if (pgio->pg_error < 0) {
+		if (pgio->pg_error != -EAGAIN)
+			return;
+		/* Retry getting layout segment if lower layer returned -EAGAIN */
+		if (pgio->pg_maxretrans && req->wb_nio++ > pgio->pg_maxretrans) {
+			if (NFS_SERVER(pgio->pg_inode)->flags & NFS_MOUNT_SOFTERR)
+				pgio->pg_error = -ETIMEDOUT;
+			else
+				pgio->pg_error = -EIO;
+			return;
+		}
+		pgio->pg_error = 0;
+		/* Sleep for 1 second before retrying */
+		ssleep(1);
+		goto retry;
+	}
 out_mds:
 	trace_pnfs_mds_fallback_pg_init_read(pgio->pg_inode,
 			0, NFS4_MAX_UINT64, IOMODE_READ,
-- 
2.44.0


