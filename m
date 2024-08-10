Return-Path: <linux-nfs+bounces-5297-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F4A94DE73
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 22:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021751C210C1
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 20:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B581247A62;
	Sat, 10 Aug 2024 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIUiWLZ2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4813D523;
	Sat, 10 Aug 2024 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320085; cv=none; b=A9x8bFTNEbv3igTx6f9TK1AAfMkss3RbZRix6NLRk/kiCbGhED13vgscZiC7ThTEazwFpjBdgZuNN1SmH38rcu5aPtdC47ZQlNu82N+Fr8sVmCc+gEg/J7Q9DtHNSzDkgGHPGKpI/EK+ncAyQIkGrvbhWyB2MvOH7r7GX02pzsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320085; c=relaxed/simple;
	bh=u+IH9tsTVs/bHPSST6zrsf9bpXULsn1VNiF0CZSuli4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gc0h0fur4TWk0G/QU08kgauGOpb7TafGJ3OUqbEVNLBQvnTUcj3Mkz1UaXhgJ1AEt8lPRkOic7tHp8fRjxQryC2sFmDVrKy4eoVzdLgjQgy2lmvGOYzCFj9uVCJUC7eIIUQkuihvC6VSbaj4IMoj11MrgncQZOa/gdcX5+/lZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIUiWLZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D93C4AF0E;
	Sat, 10 Aug 2024 20:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723320085;
	bh=u+IH9tsTVs/bHPSST6zrsf9bpXULsn1VNiF0CZSuli4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rIUiWLZ2Q1AX4hfG8hfJJ/GBTgqGJXX7xLTvR3L3oUUamiwYvi7WxcoLe8JnxS7R2
	 4HtUjKuV7o+dx9H4gxqA+3souUlgrD3N7mq/J9u0dVB6If5nfR//afQdzKnO9qZf6x
	 yQma7cB/3vFHh76Ir8bvfy/yItZvuxwlp9s2PYZbd2Pr1idc2Edxjx8PPOxtq3GbIY
	 l33B1ulgn5d3evBmVhKszKZG9GPrOD4I9VTXerYwWpnez71Zb9IEZjy+h6M5SeQhTi
	 6ULULDD2ji7ipHFvUVVsrd4TgHNNAbV9VFyu7eybMDrrdNhZqPpdmAOTgcZT7bYLwh
	 C42cg+Maes7fg==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	ltp@lists.linux.it,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.1.y 17/18] nfsd: remove nfsd_stats, make th_cnt a global counter
Date: Sat, 10 Aug 2024 16:00:08 -0400
Message-ID: <20240810200009.9882-18-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>
References: <20240810200009.9882-1-cel@kernel.org>
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
index fa0144a74267..0e557fb60a0e 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -69,6 +69,7 @@ extern struct mutex		nfsd_mutex;
 extern spinlock_t		nfsd_drc_lock;
 extern unsigned long		nfsd_drc_max_mem;
 extern unsigned long		nfsd_drc_mem_used;
+extern atomic_t			nfsd_th_cnt;		/* number of available threads */
 
 extern const struct seq_operations nfs_exports_op;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 5ddb1f36f82e..8b944620d798 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -34,6 +34,7 @@
 
 #define NFSDDBG_FACILITY	NFSDDBG_SVC
 
+atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
 extern struct svc_program	nfsd_program;
 static int			nfsd(void *vrqstp);
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
@@ -955,7 +956,7 @@ nfsd(void *vrqstp)
 
 	current->fs->umask = 0;
 
-	atomic_inc(&nfsdstats.th_cnt);
+	atomic_inc(&nfsd_th_cnt);
 
 	set_freezable();
 
@@ -979,7 +980,7 @@ nfsd(void *vrqstp)
 		validate_process_creds();
 	}
 
-	atomic_dec(&nfsdstats.th_cnt);
+	atomic_dec(&nfsd_th_cnt);
 
 out:
 	/* Take an extra ref so that the svc_put in svc_exit_thread()
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index fdc090284c8d..cd5e48382fba 100644
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


