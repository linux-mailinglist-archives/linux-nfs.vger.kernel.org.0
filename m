Return-Path: <linux-nfs+bounces-5298-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE3B94DE76
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 22:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88471F214AC
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 20:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC59433DD;
	Sat, 10 Aug 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctTWWYCo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551B0125BA;
	Sat, 10 Aug 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320087; cv=none; b=Qn09YilnoFYNeSLCsSu6K/dG7UvAvL4qKVFN6Z4Z9ExTdGv9ZrudBsPBoH1B5d+vfx4c63lCoiNt5ylU7TuMGK0DyEeG9F+a6G4fsAm5YXiCwme398iKzd7k2yLta36X/btQqW2aarq6tHycijcvOcJDdBzdKiWNUOZDkGsP2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320087; c=relaxed/simple;
	bh=UVvGKjNkfbegLXzdyWRN4cGHbBWTIrLb9AIOOzEp/d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwnnDSzPvmPOTTVZhBpG9zRFI+ZBX9LgmXE4wiPq+m8PpyZ8Zq6RxWECamQ9iu7582OTvplLoQuQ9i/eFv43Jnkx8Rj6uKjOFXT4gAfLhy4Udccpj63cLUcT9Y2jGiSZDRLjdPdB6b7kvzyw/c146GsZQpmw8AGQFJdWU+/7v3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctTWWYCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F7BC4AF0D;
	Sat, 10 Aug 2024 20:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723320087;
	bh=UVvGKjNkfbegLXzdyWRN4cGHbBWTIrLb9AIOOzEp/d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctTWWYCow39Q1QirBTFEeg7hNPHRG5cME2PdJxqXlyUjbKJkM45kF4cQV6hBiF6fI
	 oZC/f0cRb1VfVWWDAcGSEHG41k1V1h43bQ9HQfHVNfQ2OhKVeM9yZEmtUCG0C8zRwv
	 Bm8dIwyCfHzkdaDUfA0nJpsaemnoJ2MMVo489McgsdwltNwN8ikyMQHLbi10zWVa3Y
	 wODWbKz7Je8W+fx0C0WmQ+pRX0WWKGvFF9VV7N7aywd4HCxNVUfEGGMZoYMiwH5eK+
	 dbsHX4nYdvCufVmnJrPJ5iNGwfwv/PQQIyuklsx4xtqRpU8897esTVLR4WB9BZiaQy
	 9IiJF0eneLYBA==
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
Subject: [PATCH 6.1.y 18/18] nfsd: make svc_stat per-network namespace instead of global
Date: Sat, 10 Aug 2024 16:00:09 -0400
Message-ID: <20240810200009.9882-19-cel@kernel.org>
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

[ Upstream commit 16fb9808ab2c99979f081987752abcbc5b092eac ]

The final bit of stats that is global is the rpc svc_stat.  Move this
into the nfsd_net struct and use that everywhere instead of the global
struct.  Remove the unused global struct.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/netns.h  |  4 ++++
 fs/nfsd/nfsctl.c |  2 ++
 fs/nfsd/nfssvc.c |  2 +-
 fs/nfsd/stats.c  | 10 ++++------
 fs/nfsd/stats.h  |  2 --
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 55ab92326384..548422b24a7d 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -13,6 +13,7 @@
 #include <linux/nfs4.h>
 #include <linux/percpu_counter.h>
 #include <linux/siphash.h>
+#include <linux/sunrpc/stats.h>
 
 /* Hash tables for nfs4_clientid state */
 #define CLIENT_HASH_BITS                 4
@@ -183,6 +184,9 @@ struct nfsd_net {
 	/* Per-netns stats counters */
 	struct percpu_counter    counter[NFSD_STATS_COUNTERS_NUM];
 
+	/* sunrpc svc stats */
+	struct svc_stat          nfsd_svcstats;
+
 	/* longest hash chain seen */
 	unsigned int             longest_chain;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index d7a481aa1dac..813ae75e7128 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1453,6 +1453,8 @@ static __net_init int nfsd_init_net(struct net *net)
 	retval = nfsd_stat_counters_init(nn);
 	if (retval)
 		goto out_repcache_error;
+	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
+	nn->nfsd_svcstats.program = &nfsd_program;
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 8b944620d798..9eb529969b22 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -657,7 +657,7 @@ int nfsd_create_serv(struct net *net)
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-	serv = svc_create_pooled(&nfsd_program, &nfsd_svcstats,
+	serv = svc_create_pooled(&nfsd_program, &nn->nfsd_svcstats,
 				 nfsd_max_blksize, nfsd);
 	if (serv == NULL)
 		return -ENOMEM;
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index cd5e48382fba..36f1373bbe3f 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -27,10 +27,6 @@
 
 #include "nfsd.h"
 
-struct svc_stat		nfsd_svcstats = {
-	.program	= &nfsd_program,
-};
-
 static int nfsd_show(struct seq_file *seq, void *v)
 {
 	struct net *net = pde_data(file_inode(seq->file));
@@ -56,7 +52,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
 	seq_puts(seq, "\nra 0 0 0 0 0 0 0 0 0 0 0 0\n");
 
 	/* show my rpc info */
-	svc_seq_show(seq, &nfsd_svcstats);
+	svc_seq_show(seq, &nn->nfsd_svcstats);
 
 #ifdef CONFIG_NFSD_V4
 	/* Show count for individual nfsv4 operations */
@@ -119,7 +115,9 @@ void nfsd_stat_counters_destroy(struct nfsd_net *nn)
 
 void nfsd_proc_stat_init(struct net *net)
 {
-	svc_proc_register(net, &nfsd_svcstats, &nfsd_proc_ops);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
 }
 
 void nfsd_proc_stat_shutdown(struct net *net)
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 9b22b1ae929f..14525e854cba 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -10,8 +10,6 @@
 #include <uapi/linux/nfsd/stats.h>
 #include <linux/percpu_counter.h>
 
-extern struct svc_stat		nfsd_svcstats;
-
 int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
-- 
2.45.1


