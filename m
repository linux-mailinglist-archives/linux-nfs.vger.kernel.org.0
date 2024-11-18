Return-Path: <linux-nfs+bounces-8063-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E706F9D1A5B
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB08628189E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6291F1E5739;
	Mon, 18 Nov 2024 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQalXkjL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF44155312;
	Mon, 18 Nov 2024 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964840; cv=none; b=ukA3UKdNBLEScWnw/Qyf3Z4Y0I3BYNy3YDAUTJZ/PYuZUgOMLT+DWYj6GYxza67dKicIz3jpWVHf/FvXLK0qV4PGLOfSfq9JHZJTqu0MxglJdgZnm2ofAre1OEAf4jzfZ0pvT98XvlRVosOSp84wOZtszm5upI4hgVOJYZ+FZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964840; c=relaxed/simple;
	bh=P9xJz/yyV/r0iv+pRTmtoLORNxxf9bQ+XhhNLDd/3MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGermEZ3chci4z5k6y80Z+g+Pcb7zCWOv7dHpUhaxbUc+jDyiUpsH5MG/utU0JBvS0h1q1WDTgVEIaC1xat6XIPJviDnrDNMCro3Yz9z6AG9xjOChMt4wRy0gDmJW4FXHfWpA2Bp4cLfrHy1tz7JetSzErcBBGKdw+qG5Y8DLh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQalXkjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60419C4CECC;
	Mon, 18 Nov 2024 21:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964839;
	bh=P9xJz/yyV/r0iv+pRTmtoLORNxxf9bQ+XhhNLDd/3MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQalXkjLmkZ2uG3gw6TgiFe6sl7tVVcT5C1F6s57pgqVjBddNcvvNNsDjou/ZeK4a
	 K94IkEFmrPB6mzfTgvtGB8TTjLApdKeJ0YgT2oODFqc4dMo5Igx8/WHLsSUo9aE6G7
	 floBYy5LfK4GE3Mv/HRJQ+7KSJTh5JdqE4OEUZMtQOZIAmTDDkdWq5iDRJle+NQlPB
	 lLX0/1lXqslQKJGvFJ5TZN2NaIVkDKobGI85bupcYmMNQBzar5GB/ZbQ1BOE1yxTlO
	 pfu1cZNNYsnCpiwNpfD1jiQNMLZqkjaGRzbp+LF+Nm0kGUfUGlh85ZjC0DMAEG7FaG
	 2sbERmpE9cMwA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dai Ngo <dai.ngo@oracle.com>
Subject: [PATCH 5.15.y 01/18] nfsd: move reply cache initialization into nfsd startup
Date: Mon, 18 Nov 2024 16:20:14 -0500
Message-ID: <20241118212035.3848-3-cel@kernel.org>
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
index f77f00c93172..1c39a4e6294d 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1461,16 +1461,11 @@ static __net_init int nfsd_init_net(struct net *net)
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
@@ -1479,9 +1474,6 @@ static __net_init int nfsd_init_net(struct net *net)
 
 static __net_exit void nfsd_exit_net(struct net *net)
 {
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	nfsd_reply_cache_shutdown(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
 	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 3d4fd40c987b..a68e9904224a 100644
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
2.45.2


