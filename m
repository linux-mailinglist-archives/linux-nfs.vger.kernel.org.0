Return-Path: <linux-nfs+bounces-5281-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D126B94DE53
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 22:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D45C282C85
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7CA200A3;
	Sat, 10 Aug 2024 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0dk5EpW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B2125BA;
	Sat, 10 Aug 2024 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320027; cv=none; b=suPCfLEVMwF14ptbMImkw0muXzvDtngjHQ+Y2kZe/kxmbQxx8DvrI7BhjzowLhAJlZ2Cad+Qc87PsL/Q9sMH7qHEPYWVKVD2FllTDvoH8oxFrwGsPruoJLFtPYtU6lrwBmBX91LyYrlIuzRQ3H1t7JVKhZbf0cTCc/9oNdKAvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320027; c=relaxed/simple;
	bh=Q3dqFd0Y6AQeyGpivTbPl4KuVEVT05lnQE8LKV5pVns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9DVBrmTku5LtdEdFvyZdZm/1zmbe98qYj7uFVvUhNyZLdcSFrgGd7ByAD/ygDeXtds1T1OrT/fuHLYcEjc2gNn7UMZhmZfOQlNFoOa23dsDWs/bclmFqlpeIgXLwHeMrXfaTdTl+cCN/WaKbm1N1Nj6NgsnNsxCmGT81JIQ3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0dk5EpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9168C32781;
	Sat, 10 Aug 2024 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723320026;
	bh=Q3dqFd0Y6AQeyGpivTbPl4KuVEVT05lnQE8LKV5pVns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F0dk5EpWb6IeH5nZN22SqpuAMFtsFpiMjOm7OpYoKd9rKXgs5mr/AugZvb9Ob8s5c
	 4O104m+dzTDfuirgJeTFj9dtynHmD0+uMjSIeik2y0X96bnugWVGLqyDEpgBisuGhA
	 sUBeacwEccc8Sgij81XGbvgXzwFZDwOC6q8v6FYl6fC/Hc447undapL96PquFPgW5h
	 TJW9LVCyDW67qXh5WUso4KZxZTvyy0xLHjOeLwwjCZjPkBXNvv0zV2lXAKOtYUfSEP
	 mzWWdenCztfmCtCWS9WPR7HxqwbXiDCPUcMwO/PUfy1gQo6h8sI+dGsjWHq1IPEwH2
	 Mvuca1r40iuDw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	ltp@lists.linux.it,
	Jeff Layton <jlayton@kernel.org>,
	Dai Ngo <dai.ngo@oracle.com>
Subject: [PATCH 6.1.y 01/18] nfsd: move reply cache initialization into nfsd startup
Date: Sat, 10 Aug 2024 15:59:52 -0400
Message-ID: <20240810200009.9882-2-cel@kernel.org>
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

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit f5f9d4a314da88c0a5faa6d168bf69081b7a25ae ]

There's no need to start the reply cache before nfsd is up and running,
and doing so means that we register a shrinker for every net namespace
instead of just the ones where nfsd is running.

Move it to the per-net nfsd startup instead.

Reported-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Stable-dep-of: ed9ab7346e90 ("nfsd: move init of percpu reply_cache_stats counters back to nfsd_init_net")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c |  8 --------
 fs/nfsd/nfssvc.c | 10 +++++++++-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 76a60e7a7509..f6637dbb9e18 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1453,16 +1453,11 @@ static __net_init int nfsd_init_net(struct net *net)
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
-	retval = nfsd_reply_cache_init(nn);
-	if (retval)
-		goto out_cache_error;
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
 
 	return 0;
 
-out_cache_error:
-	nfsd_idmap_shutdown(net);
 out_idmap_error:
 	nfsd_export_shutdown(net);
 out_export_error:
@@ -1471,9 +1466,6 @@ static __net_init int nfsd_init_net(struct net *net)
 
 static __net_exit void nfsd_exit_net(struct net *net)
 {
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	nfsd_reply_cache_shutdown(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
 	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index a8190caf77f1..d07ee284100f 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -427,16 +427,23 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	ret = nfsd_file_cache_start_net(net);
 	if (ret)
 		goto out_lockd;
-	ret = nfs4_state_start_net(net);
+
+	ret = nfsd_reply_cache_init(nn);
 	if (ret)
 		goto out_filecache;
 
+	ret = nfs4_state_start_net(net);
+	if (ret)
+		goto out_reply_cache;
+
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	nfsd4_ssc_init_umount_work(nn);
 #endif
 	nn->nfsd_net_up = true;
 	return 0;
 
+out_reply_cache:
+	nfsd_reply_cache_shutdown(nn);
 out_filecache:
 	nfsd_file_cache_shutdown_net(net);
 out_lockd:
@@ -454,6 +461,7 @@ static void nfsd_shutdown_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	nfs4_state_shutdown_net(net);
+	nfsd_reply_cache_shutdown(nn);
 	nfsd_file_cache_shutdown_net(net);
 	if (nn->lockd_up) {
 		lockd_down(net);
-- 
2.45.1


