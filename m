Return-Path: <linux-nfs+bounces-5519-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBD695A0B5
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD86E1F21F03
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932B21B3B11;
	Wed, 21 Aug 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7YWnZRX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF901B253C;
	Wed, 21 Aug 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252219; cv=none; b=S4BwcgSfoDWAE25HqsLtbhNzzIYF/pIDgnXFRaRECX5QpckKe27pZCh34PCl/tNQ8k+pm8kSdTPN4b3c2m9rq+khp7KAlEMtco1SpMTbYI07H3weHsWJJkJKSuWgJ691B4TtOkbyAIhmqL0pQRW8YibugSmy9rcuwr97KdnVU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252219; c=relaxed/simple;
	bh=BhZ8qGrIWwtgL/WXyfTcCRnsOKEomz0WC8EIkL4QbT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtVn6sdjZtjs3XoHnvcVcLn2Nl5jppb9GV6MTnXKps5MLOxwggt5IUF9yUfn+eoU8YV39KtkUJC4UWXei1wOuN+aKF08yU80bJDe89xoEjDNi81GyAVodrOHeCg0/MUXJx17m9Jo2Ragg6UC/rfsMkf657WcZXtYiJpmHwdZLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7YWnZRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865F1C32786;
	Wed, 21 Aug 2024 14:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252219;
	bh=BhZ8qGrIWwtgL/WXyfTcCRnsOKEomz0WC8EIkL4QbT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B7YWnZRXRATNsrqotirt74ceIgYReKyTe/HUbcHmNbA0WKJA07F/gFlFkxj5FKCZL
	 4r2IsG9SjNENi4TXut79SghOiJ8IdjHNJU1YdCpXhaJodOsCjQZ5Bbpl8jPAFFl8Uk
	 Rwp8paSgpfdH5mm/dnmDbcJWHakoSM1HqtMLPgPZh9W0tx9DKgILIN//KTf67zO7G3
	 795JSKu9r2AgtJas/sCxCz27foMjRO+Vw5ESZ0k6hrg1o5y6rnm4AcVE/Y26gezltG
	 tUgBoSvuRCf62lnC/eVTPXbmbMst6RKSTqZj0O2b2kJIms3QlB0RlnIDDoJbuqtK2S
	 hH7ZobStHi5Zw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.15.y 17/18] nfsd: remove nfsd_stats, make th_cnt a global counter
Date: Wed, 21 Aug 2024 10:55:47 -0400
Message-ID: <20240821145548.25700-18-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821145548.25700-1-cel@kernel.org>
References: <20240821145548.25700-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit e41ee44cc6a473b1f414031782c3b4283d7f3e5f ]

This is the last global stat, take it out of the nfsd_stats struct and
make it a global part of nfsd, report it the same as always.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsd.h   | 1 +
 fs/nfsd/nfssvc.c | 5 +++--
 fs/nfsd/stats.c  | 3 +--
 fs/nfsd/stats.h  | 6 ------
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 013bfa24ced2..996f3f62335b 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -69,6 +69,7 @@ extern struct mutex		nfsd_mutex;
 extern spinlock_t		nfsd_drc_lock;
 extern unsigned long		nfsd_drc_max_mem;
 extern unsigned long		nfsd_drc_mem_used;
+extern atomic_t			nfsd_th_cnt;		/* number of available threads */
 
 extern const struct seq_operations nfs_exports_op;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 74d21d2c5396..caf293fc27d2 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -34,6 +34,7 @@
 
 #define NFSDDBG_FACILITY	NFSDDBG_SVC
 
+atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
 extern struct svc_program	nfsd_program;
 static int			nfsd(void *vrqstp);
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
@@ -941,7 +942,7 @@ nfsd(void *vrqstp)
 
 	current->fs->umask = 0;
 
-	atomic_inc(&nfsdstats.th_cnt);
+	atomic_inc(&nfsd_th_cnt);
 
 	set_freezable();
 
@@ -965,7 +966,7 @@ nfsd(void *vrqstp)
 		validate_process_creds();
 	}
 
-	atomic_dec(&nfsdstats.th_cnt);
+	atomic_dec(&nfsd_th_cnt);
 
 out:
 	/* Release the thread */
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index c21dbd7d0086..6b2135bfb509 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -27,7 +27,6 @@
 
 #include "nfsd.h"
 
-struct nfsd_stats	nfsdstats;
 struct svc_stat		nfsd_svcstats = {
 	.program	= &nfsd_program,
 };
@@ -47,7 +46,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
 		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_IO_WRITE]));
 
 	/* thread usage: */
-	seq_printf(seq, "th %u 0", atomic_read(&nfsdstats.th_cnt));
+	seq_printf(seq, "th %u 0", atomic_read(&nfsd_th_cnt));
 
 	/* deprecated thread usage histogram stats */
 	for (i = 0; i < 10; i++)
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 28f5c720e9b3..9b22b1ae929f 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -10,12 +10,6 @@
 #include <uapi/linux/nfsd/stats.h>
 #include <linux/percpu_counter.h>
 
-struct nfsd_stats {
-	atomic_t	th_cnt;		/* number of available threads */
-};
-
-extern struct nfsd_stats	nfsdstats;
-
 extern struct svc_stat		nfsd_svcstats;
 
 int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
-- 
2.45.2


