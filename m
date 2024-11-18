Return-Path: <linux-nfs+bounces-8074-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B18E39D1A71
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F7E1B229D6
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486211C07FB;
	Mon, 18 Nov 2024 21:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pr8ynek4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EF1188CDC;
	Mon, 18 Nov 2024 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964848; cv=none; b=aD2lEftrsWxHocOjek+lVXOWqWrk2SrirW+01hJRlzCMMpCe+blBBkDoUkCmE6Ldi/p29y0+OBKfQf5RV7tD1YBLfOjdegUxmEcMni783SR9SayKQm9FBC6aMWfm9S5ZhV7zxWiyakg3KT+g1Jd5Nh0IykfBTX+x81kI7UjZ0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964848; c=relaxed/simple;
	bh=f+YpxPLnF9Xk5hDE0PdJZ8o3fVAOOkTSQ3hANFDcgIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMcfhF0Lmq71eoCuOy4x3ntL89M8kT6F5N9ffW0Fwg/DBLmOIVz5sfqxgw+cx2uEKSuIeFckZgfnl5mElmes08+e7JWf1thVOcSAXf9RjLi2R8/xm1Pm3YjFPYVRt3Xyyv+2ffeEoj3UFM9IAHIPWx9xB31CmrjMTucZqFIcBsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pr8ynek4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17899C4CED9;
	Mon, 18 Nov 2024 21:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964847;
	bh=f+YpxPLnF9Xk5hDE0PdJZ8o3fVAOOkTSQ3hANFDcgIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pr8ynek4VG71bFBsSh8t6iZTq+3ovcYFjPu+0O4wRNGwkN8qhwpYgwXpaZFAD85Nb
	 ZtoibG90T40jdF7SYRQMNLTpMx7FYJwptKZ5euw8UiFriLp9AweMkAt6qIo8K9LyjM
	 z+FTKNnMEKitOAy0yj2Ta3VbBKgiinN9jEWnq/jHlGgZZP0CMnGiDBrXN+VH8JH1eK
	 AxWajjgsCY7UkUedYuPye3PBDyCcY/G/REN2iC78JGExr9fZvYMxpq0faafxm6/WLR
	 DerBNMCUqbc/rxr11jun64rVBnpnqgRpoGmEaKdqjHapHmjriPStsgpaqnBwSV/Atd
	 J+vQHPpkYEm1w==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel test robot <lkp@intel.com>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 5.15.y 08/18] NFSD: Fix frame size warning in svc_export_parse()
Date: Mon, 18 Nov 2024 16:20:25 -0500
Message-ID: <20241118212035.3848-14-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212035.3848-1-cel@kernel.org>
References: <20241118212035.3848-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 6939ace1f22681fface7841cdbf34d3204cc94b5 ]

fs/nfsd/export.c: In function 'svc_export_parse':
fs/nfsd/export.c:737:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    737 | }

On my systems, svc_export_parse() has a stack frame of over 800
bytes, not 1040, but nonetheless, it could do with some reduction.

When a struct svc_export is on the stack, it's a temporary structure
used as an argument, and not visible as an actual exported FS. No
need to reserve space for export_stats in such cases.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310012359.YEw5IrK6-lkp@intel.com/
Cc: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Stable-dep-of: 4b14885411f7 ("nfsd: make all of the nfsd stats per-network namespace")
[ cel: adjusted to apply to v5.15.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/export.c | 32 +++++++++++++++++++++++---------
 fs/nfsd/export.h |  4 ++--
 fs/nfsd/stats.h  | 12 ++++++------
 3 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 668c7527b17e..16fadade86cc 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -339,12 +339,16 @@ static int export_stats_init(struct export_stats *stats)
 
 static void export_stats_reset(struct export_stats *stats)
 {
-	nfsd_percpu_counters_reset(stats->counter, EXP_STATS_COUNTERS_NUM);
+	if (stats)
+		nfsd_percpu_counters_reset(stats->counter,
+					   EXP_STATS_COUNTERS_NUM);
 }
 
 static void export_stats_destroy(struct export_stats *stats)
 {
-	nfsd_percpu_counters_destroy(stats->counter, EXP_STATS_COUNTERS_NUM);
+	if (stats)
+		nfsd_percpu_counters_destroy(stats->counter,
+					     EXP_STATS_COUNTERS_NUM);
 }
 
 static void svc_export_put(struct kref *ref)
@@ -353,7 +357,8 @@ static void svc_export_put(struct kref *ref)
 	path_put(&exp->ex_path);
 	auth_domain_put(exp->ex_client);
 	nfsd4_fslocs_free(&exp->ex_fslocs);
-	export_stats_destroy(&exp->ex_stats);
+	export_stats_destroy(exp->ex_stats);
+	kfree(exp->ex_stats);
 	kfree(exp->ex_uuid);
 	kfree_rcu(exp, ex_rcu);
 }
@@ -744,13 +749,15 @@ static int svc_export_show(struct seq_file *m,
 	seq_putc(m, '\t');
 	seq_escape(m, exp->ex_client->name, " \t\n\\");
 	if (export_stats) {
-		seq_printf(m, "\t%lld\n", exp->ex_stats.start_time);
+		struct percpu_counter *counter = exp->ex_stats->counter;
+
+		seq_printf(m, "\t%lld\n", exp->ex_stats->start_time);
 		seq_printf(m, "\tfh_stale: %lld\n",
-			   percpu_counter_sum_positive(&exp->ex_stats.counter[EXP_STATS_FH_STALE]));
+			   percpu_counter_sum_positive(&counter[EXP_STATS_FH_STALE]));
 		seq_printf(m, "\tio_read: %lld\n",
-			   percpu_counter_sum_positive(&exp->ex_stats.counter[EXP_STATS_IO_READ]));
+			   percpu_counter_sum_positive(&counter[EXP_STATS_IO_READ]));
 		seq_printf(m, "\tio_write: %lld\n",
-			   percpu_counter_sum_positive(&exp->ex_stats.counter[EXP_STATS_IO_WRITE]));
+			   percpu_counter_sum_positive(&counter[EXP_STATS_IO_WRITE]));
 		seq_putc(m, '\n');
 		return 0;
 	}
@@ -796,7 +803,7 @@ static void svc_export_init(struct cache_head *cnew, struct cache_head *citem)
 	new->ex_layout_types = 0;
 	new->ex_uuid = NULL;
 	new->cd = item->cd;
-	export_stats_reset(&new->ex_stats);
+	export_stats_reset(new->ex_stats);
 }
 
 static void export_update(struct cache_head *cnew, struct cache_head *citem)
@@ -832,7 +839,14 @@ static struct cache_head *svc_export_alloc(void)
 	if (!i)
 		return NULL;
 
-	if (export_stats_init(&i->ex_stats)) {
+	i->ex_stats = kmalloc(sizeof(*(i->ex_stats)), GFP_KERNEL);
+	if (!i->ex_stats) {
+		kfree(i);
+		return NULL;
+	}
+
+	if (export_stats_init(i->ex_stats)) {
+		kfree(i->ex_stats);
 		kfree(i);
 		return NULL;
 	}
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index d03f7f6a8642..f73e23bb24a1 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -64,10 +64,10 @@ struct svc_export {
 	struct cache_head	h;
 	struct auth_domain *	ex_client;
 	int			ex_flags;
+	int			ex_fsid;
 	struct path		ex_path;
 	kuid_t			ex_anon_uid;
 	kgid_t			ex_anon_gid;
-	int			ex_fsid;
 	unsigned char *		ex_uuid; /* 16 byte fsid */
 	struct nfsd4_fs_locations ex_fslocs;
 	uint32_t		ex_nflavors;
@@ -76,7 +76,7 @@ struct svc_export {
 	struct nfsd4_deviceid_map *ex_devid_map;
 	struct cache_detail	*cd;
 	struct rcu_head		ex_rcu;
-	struct export_stats	ex_stats;
+	struct export_stats	*ex_stats;
 };
 
 /* an "export key" (expkey) maps a filehandlefragement to an
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index c3abe1830da5..ac58c4b2ab70 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -60,22 +60,22 @@ static inline void nfsd_stats_rc_nocache_inc(void)
 static inline void nfsd_stats_fh_stale_inc(struct svc_export *exp)
 {
 	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_FH_STALE]);
-	if (exp)
-		percpu_counter_inc(&exp->ex_stats.counter[EXP_STATS_FH_STALE]);
+	if (exp && exp->ex_stats)
+		percpu_counter_inc(&exp->ex_stats->counter[EXP_STATS_FH_STALE]);
 }
 
 static inline void nfsd_stats_io_read_add(struct svc_export *exp, s64 amount)
 {
 	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_READ], amount);
-	if (exp)
-		percpu_counter_add(&exp->ex_stats.counter[EXP_STATS_IO_READ], amount);
+	if (exp && exp->ex_stats)
+		percpu_counter_add(&exp->ex_stats->counter[EXP_STATS_IO_READ], amount);
 }
 
 static inline void nfsd_stats_io_write_add(struct svc_export *exp, s64 amount)
 {
 	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_WRITE], amount);
-	if (exp)
-		percpu_counter_add(&exp->ex_stats.counter[EXP_STATS_IO_WRITE], amount);
+	if (exp && exp->ex_stats)
+		percpu_counter_add(&exp->ex_stats->counter[EXP_STATS_IO_WRITE], amount);
 }
 
 static inline void nfsd_stats_payload_misses_inc(struct nfsd_net *nn)
-- 
2.45.2


