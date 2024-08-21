Return-Path: <linux-nfs+bounces-5539-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2348695A45F
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 20:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555EA1C2259B
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00291B3B06;
	Wed, 21 Aug 2024 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz59sbO6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE901B2EFE
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263634; cv=none; b=YwCnwOwhdZeUWtr3za6IMyLWMKreciUzPUMABK4l3Zlr5jLSoDNXqJLGbXkItIjdqmL+IGkfh0+iKcIwDz6XbFuqX/PVeKpAUZckDY27PgYW2yEDcKqLXXIcOjqET4lWdy/ZBN6T2ePSL9ItrewB7CXomaZUQFg3yQyACgpZ9Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263634; c=relaxed/simple;
	bh=ypAZ3CyKq507gWVKGe2b2IRjoQ6G3MNFB2klTRf/QBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuPXXW75b/EmPyLpJTuFEkFr7KfNc4ZQoW8LWL2CnLjZ0HyuXlFHqa3Qf4NzIteG4e2v2ZjnAhEMK8uULUxVxKjpO9ZS/FiA2/C6H27VzRWdLH8NoN8a0rdW3jODaYque5JkdMFH6KsxNPY+852eQaVSyjjuQ5OVGyWvT81QOkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz59sbO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3663BC4AF09;
	Wed, 21 Aug 2024 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724263634;
	bh=ypAZ3CyKq507gWVKGe2b2IRjoQ6G3MNFB2klTRf/QBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iz59sbO6m+KIAd+zI3JyKUo1g+mifTN9mxlvB/08i7uNbUxujCfZ8RQDPDV9jL/cq
	 nHK+d/zBHfy85RNA9Bx7C1qM81zBPqAhh2+mOlLEJMPP3jVdObDtkXzMcs9XfyGsuY
	 nWESVoXW07XTm5WUVTiKj8o4RVXM6hY6FVc5Z0I8Nj/ltlI7s+O3vlucEOaqo9CbKH
	 QlsOvHGsucOgcupsmUiSCLGK+L0fPxTsN4cPhvXVw5v2CVvVcYLgdg4RpPnUbjCQix
	 vWpEsNwG/2MIN8Mub5wNpRVZDpZsSo9qj6Vnnb5WdgPV3uJ2w4HnhYpr5/dyeebX0h
	 LvLQedKcFX+7w==
From: trondmy@kernel.org
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSv4: Fix clearing of layout segments in layoutreturn
Date: Wed, 21 Aug 2024 14:05:01 -0400
Message-ID: <219bcbc91166e476ef996901ae8f3ddb2278d166.1724263426.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <ae213806d1188320ec55b730582705133b51dd22.1724263426.git.trond.myklebust@hammerspace.com>
References: <ae213806d1188320ec55b730582705133b51dd22.1724263426.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Make sure that we clear the layout segments in cases where we see a
fatal error, and also in the case where the layout is invalid.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 9 ++++++---
 fs/nfs/pnfs.c     | 5 ++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 8883016c551c..daba7d89a0cf 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9997,6 +9997,7 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
 		fallthrough;
 	default:
 		task->tk_status = 0;
+		lrp->res.lrs_present = 0;
 		fallthrough;
 	case 0:
 		break;
@@ -10010,9 +10011,11 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
 		task->tk_status = 0;
 		break;
 	case -NFS4ERR_DELAY:
-		if (nfs4_async_handle_error(task, server, NULL, NULL) != -EAGAIN)
-			break;
-		goto out_restart;
+		if (nfs4_async_handle_error(task, server, NULL, NULL) ==
+		    -EAGAIN)
+			goto out_restart;
+		lrp->res.lrs_present = 0;
+		break;
 	}
 	return;
 out_restart:
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index aa698481bec8..0d16b383a452 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1284,10 +1284,9 @@ void pnfs_layoutreturn_free_lsegs(struct pnfs_layout_hdr *lo,
 	LIST_HEAD(freeme);
 
 	spin_lock(&inode->i_lock);
-	if (!pnfs_layout_is_valid(lo) ||
-	    !nfs4_stateid_match_other(&lo->plh_stateid, arg_stateid))
+	if (!nfs4_stateid_match_other(&lo->plh_stateid, arg_stateid))
 		goto out_unlock;
-	if (stateid) {
+	if (stateid && pnfs_layout_is_valid(lo)) {
 		u32 seq = be32_to_cpu(arg_stateid->seqid);
 
 		pnfs_mark_matching_lsegs_invalid(lo, &freeme, range, seq);
-- 
2.46.0


