Return-Path: <linux-nfs+bounces-9904-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E483A2AFFC
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 19:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA08168957
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 18:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503681993B1;
	Thu,  6 Feb 2025 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtcOFGGj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CA0199254;
	Thu,  6 Feb 2025 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865546; cv=none; b=J9Xd4/eZ5dfkUKtOpD8vLnfcmfAOHchq/CTWquF6ZCwksi/sgi4Qi+DAW63Ej/cqq0DMTauzAmeYhRy2Yv9yQglRlCkqqvY0RJ5/qztkejoXxUwFRvENKt3yKabcbP+wwVU84wsrE8K4ojoU8ildhYACpbY/PFMEeUSr0oYICQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865546; c=relaxed/simple;
	bh=eotghPegvISqKU8cpLQF6imSf/cSxkWT1ARHgeqmNKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DxuVkrvLUEcKe8BbKB80lPEgNS5166n9L/z4ItDtIkEI/M8rSckoxRN1BK3pLcU//BJyBMB6Pq3jUAveemaczJj0lDoTa5OO7Bf9Xr7RBTz4bvjpEdzq5CkTIR03efAOaeBzCJRx8VBotznL+/jNPMDl8TN7n5oeXymd7UztQfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtcOFGGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34576C4CEDD;
	Thu,  6 Feb 2025 18:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738865546;
	bh=eotghPegvISqKU8cpLQF6imSf/cSxkWT1ARHgeqmNKY=;
	h=From:Date:Subject:To:Cc:From;
	b=UtcOFGGjSjoGnajY6js/+vJAoaoTgmj8jF0RwI60Y7OidY6VfIBJO8azfTH/pcHRg
	 MSUe7kPkFAJ6wC1zCp82GNwVP+2ow7bF4d1a7+DqeqEJQxW3X7lSxMWsymv7tHHkhs
	 3SWPOvpS7s4Nr1x2/gaefRNhCX2zVlymoKZ0S84vaBUUJB2svjoVvOBj65y0p9VxoN
	 MZxqQPNd39Z4OzL562VNQlcobt13mggj7eXPmYai6p3Ydg+KAmVsRin1GSSavhfkX6
	 nIrzaQiI9YBtxjH83Rd83UhBt4Myxzm8kyfD47tU8zdP2GFRORz3aiO3Jbzdy/5Gqp
	 XgbuBJM6rWEuQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 06 Feb 2025 13:12:13 -0500
Subject: [PATCH] nfsd: don't ignore the return code of svc_proc_register()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-nfsd-fixes-v1-1-c6647b92ca6f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHz7pGcC/x2LQQqAIBAAvyJ7TlAri74SHSrX2ouFCxGIf2/pO
 MxMAcZMyDCpAhkfYrqSgG0U7OeaDtQUhMEZ1xtnvE6Rg470IusRvd1C9L7tBpDhzvgL6eel1g+
 rPOruXAAAAA==
X-Change-ID: 20250206-nfsd-fixes-8e61bdf66347
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3964; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eotghPegvISqKU8cpLQF6imSf/cSxkWT1ARHgeqmNKY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnpPuF9CzAxhZftu/vThDq6LtT3x3LX4u5w/lZh
 1yeeY4hX8GJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6T7hQAKCRAADmhBGVaC
 FckqD/9iUzZj0EEPbAtU2++/EFnJDvugzuuPibQMULy4oNYeoPbgeqANCuCQ7o5VKnFLv1LWI7C
 lt7ylaBoz9pyGJHTFdnWeRwD6fOQATR1hT/MBeD6jNHTgV7us0bJgIOtmUxXyMmArJqOrs1ZzPw
 +9IWtZ+n1k3nY4d82hi9bzCj9/6O/Kpxe6g2LvKz4bQ2N90mRTPtRg02ommxpLq7ICddXwYabV6
 nFUD7ec1vHh7kQ3c1pCrKhlsGyjL9DyI3MDsgrMUA/IepoTmw0zZntkaRY3+cR51Sb7aiEAVluD
 5tsucwdCW+sRdb4XhTK0o4TqTJMEgro1Kj0PcQ2X0z6cL4tDQ2acq/xcqdoU6VxE+P4xQq7zdyD
 kv41vqFsBkdHh017OSKjt+tqQQSb6VnKbgs2/0kF4TAATqFY/xTwpD37DYvCCiwsy8/RXG8QcDV
 DAI7z1KeEzEJVH/j+6JHsuTz2WlnlVz5j67H8E78jxO3XHnyYi5BxZJTGx8GRLblnOTwfdHmV5r
 MQ6LrohA7KLJ4w9tg/G1r++IltrdTWFo4H73EQdN8nPF8mPymaSDt+7eWYQKkn9zBwWuuV7YL3V
 Hcwtj30oNr9qIQl1hszHs49xvpzGn1F1Q846l42pERByy1jVWHOd6Ndg7I1pEqjenAeHshm0UoE
 SRHHjS92SzgweWw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently, nfsd_proc_stat_init() ignores the return value of
svc_proc_register(). If the procfile creation fails, then the kernel
will WARN when it tries to remove the entry later.

Fix nfsd_proc_stat_init() to return the same type of pointer as
svc_proc_register(), and fix up nfsd_net_init() to check that and fail
the nfsd_net construction if it occurs.

svc_proc_register() can fail if the dentry can't be allocated, or if an
identical dentry already exists. The second case is pretty unlikely in
the nfsd_net construction codepath, so if this happens, return -ENOMEM.

Fixes: 93483ac5fec6 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
Reported-by: syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-nfs/67a47501.050a0220.19061f.05f9.GAE@google.com/
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I looked at the console log from the report, and syzkaller is doing
fault injection on allocations. You can see the stack where the "nfsd"
directory under /proc failed to be created due to one. This is a pretty
unlikely bug under normal circumstances, but it's simple to fix. The
problem predates the patch in Fixes:, but it's not worth the effort to
backport this to anything earlier.
---
 fs/nfsd/nfsctl.c | 9 ++++++++-
 fs/nfsd/stats.c  | 4 ++--
 fs/nfsd/stats.h  | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 95ea4393305bd38493b640fbaba2e8f57f5a501d..583eda0df54dca394de4bbe8d148be2892df39cb 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2204,8 +2204,14 @@ static __net_init int nfsd_net_init(struct net *net)
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
@@ -2215,12 +2221,13 @@ static __net_init int nfsd_net_init(struct net *net)
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
index bb22893f1157e4c159e123b6d8e25b8eab52e187..f7eaf95e20fc8758566f469c6c2de79119fea070 100644
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
index 04aacb6c36e2576ba231ee481e3a3e9e9f255a61..e4efb0e4e56d467c13eaa5a1dd312c85dadeb4b8 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -10,7 +10,7 @@
 #include <uapi/linux/nfsd/stats.h>
 #include <linux/percpu_counter.h>
 
-void nfsd_proc_stat_init(struct net *net);
+struct proc_dir_entry *nfsd_proc_stat_init(struct net *net);
 void nfsd_proc_stat_shutdown(struct net *net);
 
 static inline void nfsd_stats_rc_hits_inc(struct nfsd_net *nn)

---
base-commit: ebbdc9429c39336a406b191cfe84bca2c12c2f73
change-id: 20250206-nfsd-fixes-8e61bdf66347

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


