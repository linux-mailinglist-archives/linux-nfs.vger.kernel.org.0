Return-Path: <linux-nfs+bounces-5503-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9081D95A07D
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09163B22D82
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912581B1D66;
	Wed, 21 Aug 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7/s4XuV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653521D12EB;
	Wed, 21 Aug 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252162; cv=none; b=J34M4F05Qns/aJ5h6LTambxPt4336kpmB3LiYLSG6EWJBbYYG+0+HBtxBr74qecMrm0QNL45cMnT5PgU673oTxEfpiD/PKLMpDzg4o57f1THgta1TqWQZkqAsA3D8v1BYdWv1is5/N13QaS/OD4iK0dF2E3WakLsG5U52USuMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252162; c=relaxed/simple;
	bh=P9xJz/yyV/r0iv+pRTmtoLORNxxf9bQ+XhhNLDd/3MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VT/4ifGfGfTCD5TmfD0rBy14qHoutz8cw+1EzWvyCrrLnCQp/DZmt4nu36gjeW/iEqB6gTAEJO48HfUg0TGlKMSEDQd2gYTTBOXbNsBUfl7Y5FOqtMNz0dDHY5/hNDiD8pz5zpg2awWpy+0fJWwbaCAocXO8lF8c5u9tiywJH8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7/s4XuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2965EC32781;
	Wed, 21 Aug 2024 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252161;
	bh=P9xJz/yyV/r0iv+pRTmtoLORNxxf9bQ+XhhNLDd/3MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7/s4XuVuy75oee75/vVaPkWVxSR9fboElOG1ZUQLjYqS1nvEX3mAhv9wE2v8Cvu7
	 jEYlIJumnX+C0glimM1R47bTDME0PJSuNda3Tx4XRJD0SzNPKdbqw++kJT07Xtodju
	 EVq2JK7gyRU0QMG3kvJtEfFeVkEqDM1UFvr1GGPd5wYSeUP6iaLQ1FkAvaaDURTLA2
	 nHIx+oAOiJRS+aWQGGUwkIx2RhNaxGGAtSy8NmszZX7C+tfzq9Djh/F5pQuW61jhCr
	 CNlSM+t8ciDWud0opUXUai3zTYeofW3YPul6hEsBmW1FB5Bg9ibxUYgMFlj/cRhq5W
	 5ctCH6OMelKnQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Jeff Layton <jlayton@kernel.org>,
	Dai Ngo <dai.ngo@oracle.com>
Subject: [PATCH 5.15.y 01/18] nfsd: move reply cache initialization into nfsd startup
Date: Wed, 21 Aug 2024 10:55:31 -0400
Message-ID: <20240821145548.25700-2-cel@kernel.org>
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


