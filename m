Return-Path: <linux-nfs+bounces-12891-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB350AF893A
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 09:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520891C418C5
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 07:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3B927E1A1;
	Fri,  4 Jul 2025 07:25:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46E027F16A
	for <linux-nfs@vger.kernel.org>; Fri,  4 Jul 2025 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751613903; cv=none; b=NJ+RA+4JVffarFmgh64iWaQxh2UHbQdaZVocNQ4ffoTjlaFBjT0n9HI30UoyS/luuu2VMzJPhhLoees98a03gO53bk31k6AigV1gavSJLcnGJBaWy0P+ZFRe45gxpdJAFiuVu/3HEmAZx3NqEqCGvSUSgGocCNEBEgGIuULokeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751613903; c=relaxed/simple;
	bh=lQ+OJS+1Zl/TKI721KE/ey50D95WriOlp/TqBFoM/UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMfVIvCSQb9pgtdUTutKoumTaJDcUHBl883q7+a5SYCYsx1NTmPVmzuzM6Nxq/0SGXr/WE6uo8ic9zRfP/sNTWpk2b2aOvHyyfGgNBAGOPgwksOSuP+jEzNlX8lXXk57tF1EQReiQU442f0OL6gwUYkv03eET6JkZF6+lEye5SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uXam2-001jlt-3T;
	Fri, 04 Jul 2025 07:23:54 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH 2/2] nfsd: discard client_tracking_active and instead disable laundromat_work
Date: Fri,  4 Jul 2025 17:20:18 +1000
Message-ID: <20250704072332.3278129-3-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704072332.3278129-1-neil@brown.name>
References: <20250704072332.3278129-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently set client_tracking_active precisely when it is safe for
laundromat_work to be scheduled.  It is possible to enable/disable
laundromat_work, so we can do that instead of having a separate flag.

Doing this avoids overloading ->state_lock with a use that is only
tangentially related to the other uses.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/netns.h     |  1 -
 fs/nfsd/nfs4state.c | 24 ++++++++++--------------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index fe8338735e7c..d83c68872c4c 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -67,7 +67,6 @@ struct nfsd_net {
 	struct lock_manager nfsd4_manager;
 	bool grace_ended;
 	bool grace_end_forced;
-	bool client_tracking_active;
 	time64_t boot_time;
 
 	struct dentry *nfsd_client_dir;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 124fe4f669aa..db292ac473c6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6512,12 +6512,12 @@ nfsd4_force_end_grace(struct nfsd_net *nn)
 {
 	if (!nn->client_tracking_ops)
 		return false;
-	spin_lock(&nn->client_lock);
-	if (nn->client_tracking_active) {
-		nn->grace_end_forced = true;
-		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
-	}
-	spin_unlock(&nn->client_lock);
+	/* laundromat_work must be initialised now, though it might be disabled */
+	nn->grace_end_forced = true;
+	/* This is a no-op after nfs4_state_shutdown_net() has called
+	 * disable_delayed_work_sync()
+	 */
+	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
 	return true;
 }
 
@@ -8840,7 +8840,6 @@ static int nfs4_state_create_net(struct net *net)
 	nn->boot_time = ktime_get_real_seconds();
 	nn->grace_ended = false;
 	nn->grace_end_forced = false;
-	nn->client_tracking_active = false;
 	nn->nfsd4_manager.block_opens = true;
 	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
 	INIT_LIST_HEAD(&nn->client_lru);
@@ -8855,6 +8854,8 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
 
 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
+	/* Make sure his cannot run until client tracking is initialised */
+	disable_delayed_work(&nn->laundromat_work);
 	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
 	get_net(net);
 
@@ -8922,9 +8923,7 @@ nfs4_state_start_net(struct net *net)
 	locks_start_grace(net, &nn->nfsd4_manager);
 	nfsd4_client_tracking_init(net);
 	/* safe for laundromat to run now */
-	spin_lock(&nn->client_lock);
-	nn->client_tracking_active = true;
-	spin_unlock(&nn->client_lock);
+	enable_delayed_work(&nn->laundromat_work);
 	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size == 0)
 		goto skip_grace;
 	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
@@ -8973,10 +8972,7 @@ nfs4_state_shutdown_net(struct net *net)
 
 	shrinker_free(nn->nfsd_client_shrinker);
 	cancel_work_sync(&nn->nfsd_shrinker_work);
-	spin_lock(&nn->client_lock);
-	nn->client_tracking_active = false;
-	spin_unlock(&nn->client_lock);
-	cancel_delayed_work_sync(&nn->laundromat_work);
+	disable_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
 
 	INIT_LIST_HEAD(&reaplist);
-- 
2.49.0


