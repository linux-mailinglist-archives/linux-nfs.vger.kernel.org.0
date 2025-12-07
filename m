Return-Path: <linux-nfs+bounces-16979-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6693ECAAFAA
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Dec 2025 01:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 349F03008D60
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Dec 2025 00:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F13E188713;
	Sun,  7 Dec 2025 00:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQjEUQCk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D457D098;
	Sun,  7 Dec 2025 00:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765067057; cv=none; b=MfrOVSFwyX2rMUUJYuFFFB58pW7anRwpdn8DYoEyTrXli6pSMu7l7R0QjcEWY3gE0Khl81jbS6ihmIfTm1uXBo5Fl8T45EV0ldT6LVKH8L+6JQ06cPgxjAfBDDNfB7ivfySCW13zQ3E9ULUhDaUUnmek6BB6fPr0Uk3yZYJkZT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765067057; c=relaxed/simple;
	bh=ngoJ01OrLo03riW15e6eEnHV0uXFd1ytJ5stpkHL5cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ovwnf+gxhBgueTJSMBO+26JWVW7QAV8kKAPIA2VxpJwgD6fE+3bU4gwslFn4jl719G1PMfZBSszNdMGm3XJjq93pvzdCFKSHargCag/bJGeXVW4592L1pe2CKJY/2W7Zizwx7kFYB0cM26ZdWdrVfyMMyOBn4dLoSEIZckFQnZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQjEUQCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FA8C4CEF5;
	Sun,  7 Dec 2025 00:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765067056;
	bh=ngoJ01OrLo03riW15e6eEnHV0uXFd1ytJ5stpkHL5cg=;
	h=From:To:Cc:Subject:Date:From;
	b=DQjEUQCkB0ek1qpTt+MbLD9yJroXNmAf0cGzuNwNlstzN0QSUIxZhPhM82YmE+wDQ
	 Umk2jlgyuYUCrpOwj5KLYR8R3A7kGxYasae5+wB9UPXAlxQT4+TdX127b7QXR8i4MX
	 3M5csrqUmwfLLpyMRV4noLKXrLm76RGa+IAb7nX4Nb0v57UmqNB37BdfEcQm/Z+2Qx
	 uh7Z46JU1Ri4FMve95YNP2NThIaSZcvD2KzQJmyPH2mlM6TYTq2xFcdnpv8bxJBoMX
	 gw83ntlqJUJB/3CMNGDbDVDGZLZlhepwKp9dmd5nURagaHoUx8LCNcBd8T2p5/ERrN
	 0gYIlZnfermGA==
From: Trond Myklebust <trondmy@kernel.org>
To: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Zorro Lang <zlang@redhat.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfs/localio: fix regression due to out-of-order __put_cred
Date: Sat,  6 Dec 2025 19:24:14 -0500
Message-ID: <30a4385509b4daa55512058c02685314adda85d7.1765066510.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@kernel.org>

commit 3af870aedbff10bfed220e280b57a405e972229f upstream.

Commit f2060bdc21d7 ("nfs/localio: add refcounting for each iocb IO
associated with NFS pgio header") inadvertantly reintroduced the same
potential for __put_cred() triggering BUG_ON(cred == current->cred)
that commit 992203a1fba5 ("nfs/localio: restore creds before releasing
pageio data") fixed.

Fix this by saving and restoring the cred around each {read,write}_iter
call within the respective for loop of nfs_local_call_{read,write}.

Reported-by: Zorro Lang <zlang@redhat.com>
Fixes: f2060bdc21d7 ("nfs/localio: add refcounting for each iocb IO associated with NFS pgio header")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/localio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 656976b4f42c..ee635172d68a 100644
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
2.52.0


