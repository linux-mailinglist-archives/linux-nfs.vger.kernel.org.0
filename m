Return-Path: <linux-nfs+bounces-11114-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324F4A86052
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 16:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA0C7BA46C
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F861F8751;
	Fri, 11 Apr 2025 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp6sLDKP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE461F3BBE;
	Fri, 11 Apr 2025 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380976; cv=none; b=aGF0kNuF/WNOB8buTof+1WdH9+rRRnEnEOsdv83K6SejEWKlVImHpnRfh9TTz4LYCHnHcuh60jGpNtuKHDEyNsLJn40tIdQAJ5yQcer5WU19WS9ZfmwWlzZLypKsXxlEHSFEnrI5ZzmK01z2ljoV9YD9yfpC/TjcSGKSW7IUSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380976; c=relaxed/simple;
	bh=eeycAu5NMGHcZIH3iNC4x4DQf8akT1Yx3tBBEzJbMwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YImw52QE1sNHjjg9Ne4t7p44QFPWboVHOswehFYcDsl77MnOUJK54J9YDGYPF9OjctKBsVvWGNm4nAyjjmiGPi9AEWC5B+U/oCU4RAshRnp1QQeFQtRfFDCD7hlDjO5HCbFYyew5IWOlpT/9NGPIV9fMXLredaDCiFGpZK8rwYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp6sLDKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AC8C4CEEB;
	Fri, 11 Apr 2025 14:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744380976;
	bh=eeycAu5NMGHcZIH3iNC4x4DQf8akT1Yx3tBBEzJbMwo=;
	h=From:To:Cc:Subject:Date:From;
	b=cp6sLDKPycZXAGpis7r4ESaeYytQPhegsA9qYSLcaRspPT9JjcUZochLPgxr911PQ
	 TD+gP5Yg+gMUpC4Z/MsN4MtshXPvlwVsZsMIqp//1TSkQ2vMwy4BGFsI/qMZSjhiT+
	 Smd8IdNyK5DASwPric1f8hlKJWgoQBtKq/z2H+1TsPGtEAE8XaN5fBj9Q09brmC3So
	 jq0QNWRgLmPwhZhXb4BX5Dr+LE5ySvp+eRI7sNrxrG8T5bcF+LsadgAa3G3NwfGLd2
	 Ddp4bIyFQJHclbeFOmVK7nAQM47Tf3IF79ux4CrAXjPfvv2/NZ8DWtgqbvgqz27vTt
	 8Ppdx1CoGKzfQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
Subject: [PATCH v6.12] nfsd: don't ignore the return code of svc_proc_register()
Date: Fri, 11 Apr 2025 10:16:11 -0400
Message-ID: <20250411141611.27150-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 930b64ca0c511521f0abdd1d57ce52b2a6e3476b ]

Currently, nfsd_proc_stat_init() ignores the return value of
svc_proc_register(). If the procfile creation fails, then the kernel
will WARN when it tries to remove the entry later.

Fix nfsd_proc_stat_init() to return the same type of pointer as
svc_proc_register(), and fix up nfsd_net_init() to check that and fail
the nfsd_net construction if it occurs.

svc_proc_register() can fail if the dentry can't be allocated, or if an
identical dentry already exists. The second case is pretty unlikely in
the nfsd_net construction codepath, so if this happens, return -ENOMEM.

Reported-by: syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-nfs/67a47501.050a0220.19061f.05f9.GAE@google.com/
Cc: stable@vger.kernel.org # v6.9
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c | 9 ++++++++-
 fs/nfsd/stats.c  | 4 ++--
 fs/nfsd/stats.h  | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

I did not have any problem cherry-picking 930b64 onto v6.12.23. This            
built and ran some simple NFSD tests in my lab. 

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index e83629f39604..2e835e7c107e 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2244,8 +2244,14 @@ static __net_init int nfsd_net_init(struct net *net)
 					  NFSD_STATS_COUNTERS_NUM);
 	if (retval)
 		goto out_repcache_error;
+
 	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
 	nn->nfsd_svcstats.program = &nfsd_programs[0];
+	if (!nfsd_proc_stat_init(net)) {
+		retval = -ENOMEM;
+		goto out_proc_error;
+	}
+
 	for (i = 0; i < sizeof(nn->nfsd_versions); i++)
 		nn->nfsd_versions[i] = nfsd_support_version(i);
 	for (i = 0; i < sizeof(nn->nfsd4_minorversions); i++)
@@ -2255,12 +2261,13 @@ static __net_init int nfsd_net_init(struct net *net)
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
-	nfsd_proc_stat_init(net);
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	INIT_LIST_HEAD(&nn->local_clients);
 #endif
 	return 0;
 
+out_proc_error:
+	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 out_repcache_error:
 	nfsd_idmap_shutdown(net);
 out_idmap_error:
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index bb22893f1157..f7eaf95e20fc 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -73,11 +73,11 @@ static int nfsd_show(struct seq_file *seq, void *v)
 
 DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
 
-void nfsd_proc_stat_init(struct net *net)
+struct proc_dir_entry *nfsd_proc_stat_init(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
+	return svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
 }
 
 void nfsd_proc_stat_shutdown(struct net *net)
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 04aacb6c36e2..e4efb0e4e56d 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -10,7 +10,7 @@
 #include <uapi/linux/nfsd/stats.h>
 #include <linux/percpu_counter.h>
 
-void nfsd_proc_stat_init(struct net *net);
+struct proc_dir_entry *nfsd_proc_stat_init(struct net *net);
 void nfsd_proc_stat_shutdown(struct net *net);
 
 static inline void nfsd_stats_rc_hits_inc(struct nfsd_net *nn)
-- 
2.47.0


