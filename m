Return-Path: <linux-nfs+bounces-3583-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FF6900455
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 15:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778E9285485
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030E71940A1;
	Fri,  7 Jun 2024 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmxXjMfc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE33C194093;
	Fri,  7 Jun 2024 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717765859; cv=none; b=X8c3OwEzvXRPnio1xcOAaup/BNMOVFwFE6Wg6fa3Q8qC4PEztl53r4bTM+rJ0ZSgtaq4P1VtU0FxujQ4g+TbnJH9wCsrVzwdQj0j4smlCq90srEg0QJsQOav1CHO8RouDYAC3Zd7TOMMWemKOzOeVAv16O3AgFejmUyvn+9lkxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717765859; c=relaxed/simple;
	bh=eAWSEXfpFedKdLSYjNdGwwpLGaF9xjNrz0UsBiHpu9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RC1NsIJHsjZnkzysGy3tB0V0TPKVN7y9+iCOmTIH/NrxGpFynVyuDMMaZwOxh9PUUxRg15fbrDGbs9IvbfVmF1w9MOv3+6ZD7biLFizbxtkwbs4mb4AeX5u/4Ikx+P6G7fq8sRwA7SqAKlZ20tKfAEZswJZQFPkMsXVXrMtREXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmxXjMfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFE2C2BBFC;
	Fri,  7 Jun 2024 13:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717765859;
	bh=eAWSEXfpFedKdLSYjNdGwwpLGaF9xjNrz0UsBiHpu9A=;
	h=From:To:Cc:Subject:Date:From;
	b=mmxXjMfcLZfBGffaen+tETp8eDcjNkhtdchr2LOkjlfBsPxNf7x0xQz4H1WId6EEi
	 0DDSPNdfJX4rYqeZJOYIgZA9r9P40FxGnMky6O8uyIZVAK9lO3sZcxBuJw/E8W3NEk
	 kppAq3qS4czGauhSBeQ/2TDG0o910ccNulHc8fa1zLXjjjUAHVsnQezITWgFzJGRIF
	 qkpUu6POwOCrXKgIspE5aao8Mon3QlmAMb3APX3wAp8bR7y8fYtu1tXQk7ZaLtjAvn
	 zy/3TSwC6pG3STyzEzD4bytdcse3kfaLaoOASjWHwodHrWPwlFjZwx0ihvxDXQePcP
	 bXzDdOVMweWkA==
From: cel@kernel.org
To: <stable@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>
Cc: NeilBrown <neilb@suse.de>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 5.15] sunrpc: exclude from freezer when waiting for requests:
Date: Fri,  7 Jun 2024 09:10:48 -0400
Message-ID: <20240607131048.8795-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

Prior to v6.1, the freezer will only wake a kernel thread from an
uninterruptible sleep.  Since we changed svc_get_next_xprt() to use and
IDLE sleep the freezer cannot wake it.  We need to tell the freezer to
ignore it instead.

To make this work with only upstream commits, 5.15.y would need
commit f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
which allows non-interruptible sleeps to be woken by the freezer.

Fixes: 9b8a8e5e8129 ("nfsd: don't allow nfsd threads to be signalled.")
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/callback.c     | 2 +-
 fs/nfsd/nfs4proc.c    | 3 ++-
 net/sunrpc/svc_xprt.c | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 46a0a2d6962e..8fe143cad4a2 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -124,7 +124,7 @@ nfs41_callback_svc(void *vrqstp)
 		} else {
 			spin_unlock_bh(&serv->sv_cb_lock);
 			if (!kthread_should_stop())
-				schedule();
+				freezable_schedule();
 			finish_wait(&serv->sv_cb_waitq, &wq);
 		}
 	}
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6779291efca9..e0ff2212866a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -38,6 +38,7 @@
 #include <linux/slab.h>
 #include <linux/kthread.h>
 #include <linux/namei.h>
+#include <linux/freezer.h>
 
 #include <linux/sunrpc/addr.h>
 #include <linux/nfs_ssc.h>
@@ -1322,7 +1323,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 
 			/* allow 20secs for mount/unmount for now - revisit */
 			if (kthread_should_stop() ||
-					(schedule_timeout(20*HZ) == 0)) {
+					(freezable_schedule_timeout(20*HZ) == 0)) {
 				finish_wait(&nn->nfsd_ssc_waitq, &wait);
 				kfree(work);
 				return nfserr_eagain;
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index b19592673eef..3cf53e3140a5 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -705,7 +705,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 			set_current_state(TASK_RUNNING);
 			return -EINTR;
 		}
-		schedule_timeout(msecs_to_jiffies(500));
+		freezable_schedule_timeout(msecs_to_jiffies(500));
 	}
 	rqstp->rq_page_end = &rqstp->rq_pages[pages];
 	rqstp->rq_pages[pages] = NULL; /* this might be seen in nfsd_splice_actor() */
@@ -765,7 +765,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 	smp_mb__after_atomic();
 
 	if (likely(rqst_should_sleep(rqstp)))
-		time_left = schedule_timeout(timeout);
+		time_left = freezable_schedule_timeout(timeout);
 	else
 		__set_current_state(TASK_RUNNING);
 
-- 
2.45.1


