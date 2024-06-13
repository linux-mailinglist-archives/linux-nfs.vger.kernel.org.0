Return-Path: <linux-nfs+bounces-3737-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 688BC906348
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 07:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7841F23633
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 05:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C12613665A;
	Thu, 13 Jun 2024 05:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1olhVmH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C5913210A
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 05:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255232; cv=none; b=P5CScVu/Qyoxuoa04xYLUq4EFnkhWrOaxhY2nI9G96P5ppXyR2Pbpsx1YqVh/0hhDc4/aFa9va5D80QJLK2Sak8l/Io1hgsC3iQOHzWfhaorzEzriV7GXLsdOWrCYwLl+ZbPu8i0B2Ia+Tgk+/jZNiuKolQbbmBO46VomyCPtd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255232; c=relaxed/simple;
	bh=pCc6rlbod+O9ZWNvTMer6pP/iko2kam/3qbJqW80Ghc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPRCAe1EKm4iPYv0NI+ep6+nsQU5k5S8aqMTzUGeix05UXutcSaBWJOKMyzHoeaLuSZ7OW8ocZOIV1fvfQdGDxYfaYoi9TcLiwiMuQoJzp8CJtTwy5zZKGwHPvFWr0qj68scnW5FDP8IGlvPZfeyidd9pCiWayWZaq8rUL2YixI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1olhVmH; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-795569eedcaso31337385a.3
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 22:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718255229; x=1718860029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SG1mrRXIW79vbW1cM4s2VqfFgsAl+cVVKt3gnIv/h5k=;
        b=N1olhVmHAfiFrwMHqbl64tnAOO8R27sYybctp3NDVqIW4u87LuvWXvCW2XinSvDYjQ
         /aEZlmhTX8jMMJrWbvvJqRYRsSBXpT3CCbe67/WjML7uU8U0ydZKAz+4jV1MEMJZphBs
         mARDrNxIm/IVg8oo82P24rmzCwHFU3/CsVFX3xNVAvrAJomH8KvAjhJ367GBWdtyBGAk
         cY6coGMa1mRNCrqc0+gt3Jd0uDUwYDMFULNVkz+mcCxDzLmXWqc2LpF39x57CWl2xgXU
         paKJ7y1jUukdn9gEc5Cqs3KKNmMgo7d6gfGm6Ut/NWpB754cF1pKM4nC1xzH3lPg7fEc
         4pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718255229; x=1718860029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SG1mrRXIW79vbW1cM4s2VqfFgsAl+cVVKt3gnIv/h5k=;
        b=YPAp/kpByVHKGMsiFc3EY39B2j2ttJL6/FFwbzXw0YqfeZmFEEbMEUCKl4IjzfQiWr
         IPgtvBL5mGe22ILxfKiEjimm0ufKC4P6M7jivwSX7lkxOnj4YpsRPXGF//qd5pjOTrvE
         /MgpYmFRsY0RcRxNVummqrkYLQwkGMealwg/TYM1qQma1AkbiuZwQ610WOq4yPvZvg49
         3tI1nk4XgVg1qQtCv7iqZwrwvvF90kFSfvRW0RqbtFVYD8oRZSaETkgs+SpuBIhou3SO
         ixvMdTPof5e2OdAh2ANSTlwFADFnfiXTbbRXWD/9OwqiXMfdPdgSSfm2LWJfyDRs87BG
         HG5g==
X-Gm-Message-State: AOJu0YwL0J6NcmTKa//41QigS6eiIOBUjfeZGVWfdTliQ/Hx1r47f1zm
	EEfKXH+7rauQFZd/PQoK2HJH+UJLk4aRJE3ph9pe0TTx5/kOJD9S+p42
X-Google-Smtp-Source: AGHT+IHbzFwE19p1MdNb3VB/GmVgjv3RLrTgkY8f0PvBB+zosqnaT+Dl+LCf/KpYHZuWHO+2UMpoJg==
X-Received: by 2002:a05:6214:4801:b0:6b0:8fa9:6cac with SMTP id 6a1803df08f44-6b1a712f106mr46364466d6.57.1718255229550;
        Wed, 12 Jun 2024 22:07:09 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ed4527sm3079036d6.101.2024.06.12.22.07.08
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 22:07:08 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 08/11] NFSv4/pNFS: Retry the layout return later in case of a timeout or reboot
Date: Thu, 13 Jun 2024 01:00:52 -0400
Message-ID: <20240613050055.854323-9-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613050055.854323-8-trond.myklebust@hammerspace.com>
References: <20240613050055.854323-1-trond.myklebust@hammerspace.com>
 <20240613050055.854323-2-trond.myklebust@hammerspace.com>
 <20240613050055.854323-3-trond.myklebust@hammerspace.com>
 <20240613050055.854323-4-trond.myklebust@hammerspace.com>
 <20240613050055.854323-5-trond.myklebust@hammerspace.com>
 <20240613050055.854323-6-trond.myklebust@hammerspace.com>
 <20240613050055.854323-7-trond.myklebust@hammerspace.com>
 <20240613050055.854323-8-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the layout return failed due to a timeout or reboot, then leave the
layout segments on the list so that the layout return gets replayed
later.
The exception would be if we're freeing the inode.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 21 ++++++++++++++++++++-
 fs/nfs/pnfs.c     | 12 ++++++++++++
 fs/nfs/pnfs.h     |  3 +++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ae835d14ac75..952d1e930185 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9944,6 +9944,11 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
 	if (!nfs41_sequence_process(task, &lrp->res.seq_res))
 		return;
 
+	if (task->tk_rpc_status == -ETIMEDOUT) {
+		lrp->rpc_status = -EAGAIN;
+		lrp->res.lrs_present = 0;
+		return;
+	}
 	/*
 	 * Was there an RPC level error? Assume the call succeeded,
 	 * and that we need to release the layout
@@ -9966,6 +9971,15 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
 		fallthrough;
 	case 0:
 		break;
+	case -NFS4ERR_BADSESSION:
+	case -NFS4ERR_DEADSESSION:
+	case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
+		nfs4_schedule_session_recovery(server->nfs_client->cl_session,
+					       task->tk_status);
+		lrp->res.lrs_present = 0;
+		lrp->rpc_status = -EAGAIN;
+		task->tk_status = 0;
+		break;
 	case -NFS4ERR_DELAY:
 		if (nfs4_async_handle_error(task, server, NULL, NULL) != -EAGAIN)
 			break;
@@ -9983,8 +9997,13 @@ static void nfs4_layoutreturn_release(void *calldata)
 	struct nfs4_layoutreturn *lrp = calldata;
 	struct pnfs_layout_hdr *lo = lrp->args.layout;
 
-	pnfs_layoutreturn_free_lsegs(lo, &lrp->args.stateid, &lrp->args.range,
+	if (lrp->rpc_status == 0 || !lrp->inode)
+		pnfs_layoutreturn_free_lsegs(
+			lo, &lrp->args.stateid, &lrp->args.range,
 			lrp->res.lrs_present ? &lrp->res.stateid : NULL);
+	else
+		pnfs_layoutreturn_retry_later(lo, &lrp->args.stateid,
+					      &lrp->args.range);
 	nfs4_sequence_free_slot(&lrp->res.seq_res);
 	if (lrp->ld_private.ops && lrp->ld_private.ops->free)
 		lrp->ld_private.ops->free(&lrp->ld_private);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index c8b1be1810e2..04a52fa3d28c 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1191,6 +1191,18 @@ pnfs_layoutreturn_retry_later_locked(struct pnfs_layout_hdr *lo,
 	}
 }
 
+void pnfs_layoutreturn_retry_later(struct pnfs_layout_hdr *lo,
+				   const nfs4_stateid *arg_stateid,
+				   const struct pnfs_layout_range *range)
+{
+	struct inode *inode = lo->plh_inode;
+
+	spin_lock(&inode->i_lock);
+	pnfs_layoutreturn_retry_later_locked(lo, arg_stateid, range);
+	pnfs_clear_layoutreturn_waitbit(lo);
+	spin_unlock(&inode->i_lock);
+}
+
 void pnfs_layoutreturn_free_lsegs(struct pnfs_layout_hdr *lo,
 		const nfs4_stateid *arg_stateid,
 		const struct pnfs_layout_range *range,
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 8fa0f152ed19..cd23a38eac75 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -328,6 +328,9 @@ struct pnfs_layout_segment *pnfs_update_layout(struct inode *ino,
 					       enum pnfs_iomode iomode,
 					       bool strict_iomode,
 					       gfp_t gfp_flags);
+void pnfs_layoutreturn_retry_later(struct pnfs_layout_hdr *lo,
+				   const nfs4_stateid *arg_stateid,
+				   const struct pnfs_layout_range *range);
 void pnfs_layoutreturn_free_lsegs(struct pnfs_layout_hdr *lo,
 		const nfs4_stateid *arg_stateid,
 		const struct pnfs_layout_range *range,
-- 
2.45.2


