Return-Path: <linux-nfs+bounces-16728-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE57C88331
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Nov 2025 07:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3811A4E25A9
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Nov 2025 06:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AEF318141;
	Wed, 26 Nov 2025 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMaLXh66"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49825782D
	for <linux-nfs@vger.kernel.org>; Wed, 26 Nov 2025 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764136890; cv=none; b=ACysvu3noejOlol20RMLnOlC96PY7DNUMB7JFQBLJY1IWp6z4woNkPowNUHJth0UlwDBgkrhFsr4okukFufpIJwRWVxFuDOve2TaKx6cqVP00VueSQz91ie7N/HMom5w3MOl8OXqANIbI2//aEiB+aRssYEeS1uEaX+d/pEjvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764136890; c=relaxed/simple;
	bh=evs7rumEIvhg26JnZQFwaLWhNtgE0U571ebP7yhMESM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDBqCft3HbsK/ygC2HZnJBxcc0VIzQX9COD16187Q2gIh6TlHgkRxRjfcSDjfoB4jN7u2d4uL9zNYeJ4t3OI3pPHY01cKMnuU2jcpuxOmnxfbZG6K8Km8FQ59J/1KSs/GwDMbomm+G86kBaB3B5syNboZaeXkeD8arDjkvyd0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMaLXh66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D389C116B1;
	Wed, 26 Nov 2025 06:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764136890;
	bh=evs7rumEIvhg26JnZQFwaLWhNtgE0U571ebP7yhMESM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nMaLXh66XowdMEzXONfrNw5FtIBpFrJFj51BsFRPapTr40134qoZrlabGbj5TWOV4
	 LqhlOCkK8sHV1Mwh6lOhEyjEg+XKhQmDf/ZUIZGDE6nJsPTx17W+2NOuLvvyf/2gr0
	 cgWE5dYeItqUiVpSAFkqUxSYVTjwku0pISZjEBM5Fl3HnqUSrYcuXc3pjcH7SctMJm
	 tW2sXTj8lkydBNZFZ+tNDCFgmPFPjr2vgZqdQJqhpF6Q0kj/UopLHKO0V0wy3DQXkY
	 aMrf4SJ077jp2R2gS4kP+CUyQUx2sf+cRSOpKfBx5X4GRsV9eoORrj0zl6PyfklUgC
	 j+f8uxWgqbNiA==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org,
	zlang@redhat.com
Subject: [PATCH v2 1/3] nfs/localio: fix regression due to out-of-order __put_cred
Date: Wed, 26 Nov 2025 01:01:25 -0500
Message-ID: <20251126060127.67773-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20251126060127.67773-1-snitzer@kernel.org>
References: <20251126060127.67773-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 86855311c117 ("nfs/localio: add refcounting for each iocb IO
associated with NFS pgio header") inadvertantly reintroduced the same
potential for __put_cred() triggering BUG_ON(cred == current->cred)
that commit 992203a1fba5 ("nfs/localio: restore creds before releasing
pageio data") fixed.

Fix this by saving and restoring the cred around each {read,write}_iter
call within the respective for loop of nfs_local_call_{read,write}.

Reported-by: Zorro Lang <zlang@redhat.com>
Fixes: 86855311c117 ("nfs/localio: add refcounting for each iocb IO associated with NFS pgio header")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 36c7d91014c7d..e30ea1c54c616 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -625,8 +625,6 @@ static void nfs_local_call_read(struct work_struct *work)
 	ssize_t status;
 	int n_iters;
 
-	save_cred = override_creds(filp->f_cred);
-
 	n_iters = atomic_read(&iocb->n_iters);
 	for (int i = 0; i < n_iters ; i++) {
 		if (iocb->iter_is_dio_aligned[i]) {
@@ -639,7 +637,10 @@ static void nfs_local_call_read(struct work_struct *work)
 		} else
 			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
 
+		save_cred = override_creds(filp->f_cred);
 		status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
+		revert_creds(save_cred);
+
 		if (status != -EIOCBQUEUED) {
 			if (unlikely(status >= 0 && status < iocb->iters[i].count))
 				force_done = true; /* Partial read */
@@ -649,8 +650,6 @@ static void nfs_local_call_read(struct work_struct *work)
 			}
 		}
 	}
-
-	revert_creds(save_cred);
 }
 
 static int
@@ -832,7 +831,6 @@ static void nfs_local_call_write(struct work_struct *work)
 	int n_iters;
 
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
-	save_cred = override_creds(filp->f_cred);
 
 	file_start_write(filp);
 	n_iters = atomic_read(&iocb->n_iters);
@@ -847,7 +845,10 @@ static void nfs_local_call_write(struct work_struct *work)
 		} else
 			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
 
+		save_cred = override_creds(filp->f_cred);
 		status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iters[i]);
+		revert_creds(save_cred);
+
 		if (status != -EIOCBQUEUED) {
 			if (unlikely(status >= 0 && status < iocb->iters[i].count))
 				force_done = true; /* Partial write */
@@ -859,7 +860,6 @@ static void nfs_local_call_write(struct work_struct *work)
 	}
 	file_end_write(filp);
 
-	revert_creds(save_cred);
 	current->flags = old_flags;
 }
 
-- 
2.44.0


