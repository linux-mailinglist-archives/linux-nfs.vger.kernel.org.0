Return-Path: <linux-nfs+bounces-2463-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E85E88B46A
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 23:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2518BB22F73
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22201D69B;
	Mon, 25 Mar 2024 12:53:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A72446BA
	for <linux-nfs@vger.kernel.org>; Mon, 25 Mar 2024 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371215; cv=none; b=NSFQd4hYCF9MNJqz74RGSuyjVnYTfJYOJlZR8rKhWeZ949kAwr69Fx5pM0hTgai9Cg8O2Z8RD2cZw7GjnWtcgJpiq+KAqSI6JJpS04O7eKugp1dOGWAP8WZukukS49P+Qp4Y9jVsPPPUOTLMMrayoIEcwbQS4aZJCORqAZ539lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371215; c=relaxed/simple;
	bh=5Ya8eGmncDDcd8bO+gdp2qL5rPiYeQ+cfqHWR+nuclc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kGWmCiFCYTTT+p//OQrnQV+uoFS3+raDfzTFaQYSkaJqFYpnAL7Icnnn9m830r9XUo5gj8xn5EQKvdJuEbSwrU5GOPVre7lb6oq3/A9O2g2VErVxlOq8wgqKlGSg1TbaSlJkolNcNBnB9TrQ2DVZwmmI+u3LdgqUZiGW6ipEE1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V3CWv1jTwz1vxfy;
	Mon, 25 Mar 2024 20:52:43 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B37561A0172;
	Mon, 25 Mar 2024 20:53:31 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 20:53:31 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Dennis Zhou
	<dennis@kernel.org>
CC: <linux-nfs@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] fs: nfsd: use group allocation/free of per-cpu counters API
Date: Mon, 25 Mar 2024 21:21:39 +0800
Message-ID: <20240325132139.113933-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Use group allocation/free of per-cpu counters api to accelerate
nfsd percpu_counters init/destroy(), and also squash the
nfsd_percpu_counters_init/reset/destroy() and nfsd_counters_init/destroy()
into callers to simplify code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2:
- directly use percpu_counter_*_many helpers and drop wrappers,
  suggested by Jeff Layton

 fs/nfsd/export.c | 16 ++++++++++------
 fs/nfsd/nfsctl.c |  5 +++--
 fs/nfsd/stats.c  | 42 ------------------------------------------
 fs/nfsd/stats.h  |  5 -----
 4 files changed, 13 insertions(+), 55 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 7b641095a665..50b3135d07ac 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -334,21 +334,25 @@ static void nfsd4_fslocs_free(struct nfsd4_fs_locations *fsloc)
 static int export_stats_init(struct export_stats *stats)
 {
 	stats->start_time = ktime_get_seconds();
-	return nfsd_percpu_counters_init(stats->counter, EXP_STATS_COUNTERS_NUM);
+	return percpu_counter_init_many(stats->counter, 0, GFP_KERNEL,
+					EXP_STATS_COUNTERS_NUM);
 }
 
 static void export_stats_reset(struct export_stats *stats)
 {
-	if (stats)
-		nfsd_percpu_counters_reset(stats->counter,
-					   EXP_STATS_COUNTERS_NUM);
+	if (stats) {
+		int i;
+
+		for (i = 0; i < EXP_STATS_COUNTERS_NUM; i++)
+			percpu_counter_set(&stats->counter[i], 0);
+	}
 }
 
 static void export_stats_destroy(struct export_stats *stats)
 {
 	if (stats)
-		nfsd_percpu_counters_destroy(stats->counter,
-					     EXP_STATS_COUNTERS_NUM);
+		percpu_counter_destroy_many(stats->counter,
+					    EXP_STATS_COUNTERS_NUM);
 }
 
 static void svc_export_put(struct kref *ref)
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ecd18bffeebc..93c87587e646 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1672,7 +1672,8 @@ static __net_init int nfsd_net_init(struct net *net)
 	retval = nfsd_idmap_init(net);
 	if (retval)
 		goto out_idmap_error;
-	retval = nfsd_stat_counters_init(nn);
+	retval = percpu_counter_init_many(nn->counter, 0, GFP_KERNEL,
+					  NFSD_STATS_COUNTERS_NUM);
 	if (retval)
 		goto out_repcache_error;
 	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
@@ -1704,7 +1705,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	nfsd_proc_stat_shutdown(net);
-	nfsd_stat_counters_destroy(nn);
+	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
 	nfsd_netns_free_versions(nn);
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index be52fb1e928e..bb22893f1157 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -73,48 +73,6 @@ static int nfsd_show(struct seq_file *seq, void *v)
 
 DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
 
-int nfsd_percpu_counters_init(struct percpu_counter *counters, int num)
-{
-	int i, err = 0;
-
-	for (i = 0; !err && i < num; i++)
-		err = percpu_counter_init(&counters[i], 0, GFP_KERNEL);
-
-	if (!err)
-		return 0;
-
-	for (; i > 0; i--)
-		percpu_counter_destroy(&counters[i-1]);
-
-	return err;
-}
-
-void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num)
-{
-	int i;
-
-	for (i = 0; i < num; i++)
-		percpu_counter_set(&counters[i], 0);
-}
-
-void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
-{
-	int i;
-
-	for (i = 0; i < num; i++)
-		percpu_counter_destroy(&counters[i]);
-}
-
-int nfsd_stat_counters_init(struct nfsd_net *nn)
-{
-	return nfsd_percpu_counters_init(nn->counter, NFSD_STATS_COUNTERS_NUM);
-}
-
-void nfsd_stat_counters_destroy(struct nfsd_net *nn)
-{
-	nfsd_percpu_counters_destroy(nn->counter, NFSD_STATS_COUNTERS_NUM);
-}
-
 void nfsd_proc_stat_init(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index d2753e975dfd..04aacb6c36e2 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -10,11 +10,6 @@
 #include <uapi/linux/nfsd/stats.h>
 #include <linux/percpu_counter.h>
 
-int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
-void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
-void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
-int nfsd_stat_counters_init(struct nfsd_net *nn);
-void nfsd_stat_counters_destroy(struct nfsd_net *nn);
 void nfsd_proc_stat_init(struct net *net);
 void nfsd_proc_stat_shutdown(struct net *net);
 
-- 
2.41.0


