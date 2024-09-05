Return-Path: <linux-nfs+bounces-6248-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7AB96DE67
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 17:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A16C9B27927
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C29B19D890;
	Thu,  5 Sep 2024 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B43p5Gvk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665877F7FC;
	Thu,  5 Sep 2024 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550296; cv=none; b=oGFIhFMsGlC6AGPLJa6avhiQciRudIKSHYL4DcWnDLgHtsErBmTmlIrdJE0BrbjBVBsKtRhwOcAsXC+2BtZYO39WGPtzhNGEkixOoE6ldIEQB+3d8JVVg7tP+GP86iSQqA/2khz0XHO9m3PYZlkKR/c/XFQIIhN0ORQEWJkSB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550296; c=relaxed/simple;
	bh=qeo6ewdnKU5DP0IlzPjd35vqcu4NHaXv9jGfiyMCywM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZlmwqVRmUWwkeAxBNNYxCss3H4LMqaPs0McHrmVdIKqi/+GLW1LtiX+kKMCNxE4bKBbwmwzPFMzOZPCY4sKjh5YvF02L+YbIAmtWoNVuAFXFMWqeyHLfSOlbbWdm68gPbGoCv//i9dvJgbSCRzKyQFdCZBRi189OLlMnVW3fdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B43p5Gvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381E2C4CECB;
	Thu,  5 Sep 2024 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725550296;
	bh=qeo6ewdnKU5DP0IlzPjd35vqcu4NHaXv9jGfiyMCywM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B43p5GvkV3o6jm9fFqoYOkv//Arf/1M+RwVgwOBgFsFQW+IbqSoIqqAuqIfk5vYaA
	 aVTNGwWbw8pUJ0r1NFVr+TUrSO1GL1jsmpL24gy3dPEz18eqiAs9BattUYm2sun3DL
	 H2v9s9zG7dyRdmdMhC9flSPES8TgU5Jc+axtHCyN1WG+Fu4+v2Z5l+Ncb99vkA3EK2
	 cPPKcyf8t4nrDlWTsMLtqeJcAy647WJboUM35Y0Bg2hSxwv6mIks5yt8vpeABtjUz1
	 XQtMP055/95c5jWTbrQLsayTMYFKsRWHXj0QXML34I+OzHDgcsmwXjBg5e8YVs0Tzr
	 67T0m86DxeKFw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Petr Vorel <pvorel@suse.cz>,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.10.y 19/19] nfsd: make svc_stat per-network namespace instead of global
Date: Thu,  5 Sep 2024 11:31:01 -0400
Message-ID: <20240905153101.59927-20-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240905153101.59927-1-cel@kernel.org>
References: <20240905153101.59927-1-cel@kernel.org>
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
index e7fa64834d7d..2feaa49fb9fe 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1461,6 +1461,8 @@ static __net_init int nfsd_init_net(struct net *net)
 	retval = nfsd_stat_counters_init(nn);
 	if (retval)
 		goto out_repcache_error;
+	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
+	nn->nfsd_svcstats.program = &nfsd_program;
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 3f02a9a44c6b..29eb9861684e 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -664,7 +664,7 @@ int nfsd_create_serv(struct net *net)
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-	serv = svc_create_pooled(&nfsd_program, &nfsd_svcstats,
+	serv = svc_create_pooled(&nfsd_program, &nn->nfsd_svcstats,
 				 nfsd_max_blksize, nfsd);
 	if (serv == NULL)
 		return -ENOMEM;
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 6b2135bfb509..7a58dba0045c 100644
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
 	struct net *net = PDE_DATA(file_inode(seq->file));
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


