Return-Path: <linux-nfs+bounces-6247-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0024896DE66
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 17:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 979F0B2779C
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F5F1A01D2;
	Thu,  5 Sep 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5ypKyko"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989F19C57F;
	Thu,  5 Sep 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550295; cv=none; b=VTARchvgWDI2qBysMSwicwOpxzmH0flZvkeL4PUgm2qoJh6RO2I6mrO2PH7NPrvzVPskR/jxqjvl53cepxLL1G2t5/13V4JaStVj6Y/14Mj7swkHdKkSvB/6+sYyHSaG81/XPVKgO4KypSBQMICTTppG0d+RB4PZvXDk4ilZuSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550295; c=relaxed/simple;
	bh=3wOXglN/LnzwHUOyS11fVZFif6INQinXcc0Hn0l6jVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWzuvzDDBpO2LX1tR74ZzxLQh5Bk0gx1D1+gcjBllfs4DoDZRyyD4gjAkvy6mTGrCuwFKlHlhytkSN+MchbJXKWNLej/9WqRPOsvCXkJHbm3WMDOr5JzvaXZy5Ve/SjG+FTOD0jHs5eQkRDyaoSk1Xx/GOk0noT9wVGXSTeZYtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5ypKyko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8D2C4CEC5;
	Thu,  5 Sep 2024 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725550295;
	bh=3wOXglN/LnzwHUOyS11fVZFif6INQinXcc0Hn0l6jVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D5ypKykoBguawpkJS6tFJ+sf5A/7n4ZFBZNgJjUW5wvosNwow0uTQOi+uq9pmghZ5
	 kqxddghB4kCfpx3UUXa+wHKABPWMhV7d8SXibTTEMOSN77Xw6ih/vcRVpJ2J6FjsSQ
	 zQhSFQ2IHKve6XtFwzUBwjPpQqB+L3P09JZCydhogbLQIHyUZNIovjMLlNJ+HzavFd
	 HXxBZPnbRF2oMSA/D1PTUXbNPl40ybYaOTfxS0D7sy6bPjHhPBo3nXjMvB9qplOA14
	 MidUI43s6ROYrb3L/3mvMzMQILQrrsIPDK7NBhJY3iNMKBpPfcWdaOYjM/82Rg1hao
	 MVesb1e11d4Kw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Petr Vorel <pvorel@suse.cz>,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.10.y 18/19] nfsd: remove nfsd_stats, make th_cnt a global counter
Date: Thu,  5 Sep 2024 11:31:00 -0400
Message-ID: <20240905153101.59927-19-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240905153101.59927-1-cel@kernel.org>
References: <20240905153101.59927-1-cel@kernel.org>
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
index a5f33089c7d9..3f02a9a44c6b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -34,6 +34,7 @@
 
 #define NFSDDBG_FACILITY	NFSDDBG_SVC
 
+atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
 extern struct svc_program	nfsd_program;
 static int			nfsd(void *vrqstp);
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
@@ -935,7 +936,7 @@ nfsd(void *vrqstp)
 
 	current->fs->umask = 0;
 
-	atomic_inc(&nfsdstats.th_cnt);
+	atomic_inc(&nfsd_th_cnt);
 
 	set_freezable();
 
@@ -959,7 +960,7 @@ nfsd(void *vrqstp)
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
2.45.1


