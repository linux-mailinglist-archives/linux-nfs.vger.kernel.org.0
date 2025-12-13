Return-Path: <linux-nfs+bounces-17074-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B04CBB245
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 19:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 049C7300A350
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 18:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0162ED860;
	Sat, 13 Dec 2025 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA+5WqOC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783C02EC0A2
	for <linux-nfs@vger.kernel.org>; Sat, 13 Dec 2025 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765651333; cv=none; b=ckM0wDJPQKVt6ftgfKa9VbBC25+Kq4MiIYp+0v82RXjtzUYU3RtP5VLpne1UCjkgimbWhYS7ijGKHFPs7w+2kI4owlOFVD8JoTdafxKuhrr39T/nsartwLEC6ckUewsHqYUwjO1B47thCLw+oUVgI0fBZIyf9j+A7NfibT5gA/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765651333; c=relaxed/simple;
	bh=5TgVQM7q8UyqhymSAm5TFDQJvkw6s4k4lfnXRiLAWDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOf0thaw0kAFuYrsCYfNEX1F/rkL20KqLS8ihnUm6Doh1HZDgEJzYnCZFKpt2AZtgFvuqAlAYbj0A6fUcfemVi+T1xpKekO9e+D2APpaYMR7m5uSv9+Bpo/aZhjJ21QCj+xzg+kEXemyptbLBlIDuJGsnmRlUt+i9L85LGEFFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA+5WqOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E8CC4AF09;
	Sat, 13 Dec 2025 18:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765651332;
	bh=5TgVQM7q8UyqhymSAm5TFDQJvkw6s4k4lfnXRiLAWDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bA+5WqOCdWwyY44HQEOx1LwzweGzAGnmzWARksOFOBnqJEl20akSgpbrAgXUDKMLU
	 Q/2JdjtlTaljyrrA4Z1sJdx5GALXGKrDHND/Y/rMLymRujBGs2K8b1KvrsfV1BROXO
	 guvP5wBqwzYBDquhJ6pzf2vUUX5Tjd7AobYKuU0d1F7V4K91EVkK6O92iFza1OGy2D
	 iEbeGcpdM5NqqZgiUFFTZu53GSVj/Le7+Q7nS8tQZr2jleggZv0MWtpTBklJbqCuX5
	 9zzMvGkGZYT/YXWDh5lReVNlo790hbyMvTfRGH4o4utNF2gsA/sV6crgr9MGdmOT5z
	 tkXcmlToKj0sg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	lilingfeng3@huawei.com,
	yangerkun@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 2/2] nfsd: use workqueue enable/disable APIs for v4_end_grace sync
Date: Sat, 13 Dec 2025 13:42:00 -0500
Message-ID: <20251213184200.585652-3-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251213184200.585652-1-cel@kernel.org>
References: <20251213184200.585652-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

"nfsd: provide locking for v4_end_grace" introduced a
client_tracking_active flag protected by nn->client_lock to prevent
the laundromat from being scheduled before client tracking
initialization or after shutdown begins. That commit is suitable for
backporting to LTS kernels that predate commit 86898fa6b8cd
("workqueue: Implement disable/enable for (delayed) work items").

However, the workqueue subsystem in recent kernels provides
enable_delayed_work() and disable_delayed_work_sync() for this
purpose. Using this mechanism enable us to remove the
client_tracking_active flag and associated spinlock operations
while preserving the same synchronization guarantees, which is
a cleaner long-term approach.

Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/netns.h     |  1 -
 fs/nfsd/nfs4state.c | 22 +++++++++-------------
 2 files changed, 9 insertions(+), 14 deletions(-)

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
index 1d307cc533d9..c9be724c48d0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6619,14 +6619,14 @@ bool nfsd4_force_end_grace(struct nfsd_net *nn)
 {
 	if (!nn->client_tracking_ops)
 		return false;
-	spin_lock(&nn->client_lock);
-	if (nn->grace_ended || !nn->client_tracking_active) {
-		spin_unlock(&nn->client_lock);
+	if (READ_ONCE(nn->grace_ended))
 		return false;
-	}
+	/* laundromat_work must be initialised now, though it might be disabled */
 	WRITE_ONCE(nn->grace_end_forced, true);
+	/* mod_delayed_work() doesn't queue work after
+	 * nfs4_state_shutdown_net() has called disable_delayed_work_sync()
+	 */
 	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
-	spin_unlock(&nn->client_lock);
 	return true;
 }
 
@@ -8962,7 +8962,6 @@ static int nfs4_state_create_net(struct net *net)
 	nn->boot_time = ktime_get_real_seconds();
 	nn->grace_ended = false;
 	nn->grace_end_forced = false;
-	nn->client_tracking_active = false;
 	nn->nfsd4_manager.block_opens = true;
 	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
 	INIT_LIST_HEAD(&nn->client_lru);
@@ -8977,6 +8976,8 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
 
 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
+	/* Make sure this cannot run until client tracking is initialised */
+	disable_delayed_work(&nn->laundromat_work);
 	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
 	get_net(net);
 
@@ -9044,9 +9045,7 @@ nfs4_state_start_net(struct net *net)
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
@@ -9095,10 +9094,7 @@ nfs4_state_shutdown_net(struct net *net)
 
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
2.52.0


