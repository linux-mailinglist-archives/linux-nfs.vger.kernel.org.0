Return-Path: <linux-nfs+bounces-5291-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1D694DE68
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 22:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6791F21A19
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 20:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59A747A62;
	Sat, 10 Aug 2024 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhR1d/VB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E763200A3;
	Sat, 10 Aug 2024 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320072; cv=none; b=O7qOTqZFSotmQfpRaGrss8HF8YeRmiZBFZwLm48mwI7iNpa94R9yNCv9w8wgA/ZQhcZuvpXuqyYBD5APvPrL7I6nixKFCdVB5drbohPxXK9KnmsOmZ73to2KqB3xQiFBgT+iAO90WwIA2E4wEwGg1jq8SMOMDxh0kFTwvsOMh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320072; c=relaxed/simple;
	bh=tOT5mmEIpuJJFHkMTBmFbjBjEyyWUNbGT2SCPe7LUaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klW6dMYz3JmXUgQlrz1p0/0nSB+WQFUbeOaocs9y3K8Yd5fWpP0GiFSjuVTNe6bp42aIKth8tgnvJ1dE0WS6tgqU8fnVRdBZJzgNiLjaa7UtKb4GgOmqUvxtcwMEe9aw5YqV9uFUj4SyvdlozODYwrY1hzn37PSDsY8LORKcV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhR1d/VB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A98AC4AF0E;
	Sat, 10 Aug 2024 20:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723320072;
	bh=tOT5mmEIpuJJFHkMTBmFbjBjEyyWUNbGT2SCPe7LUaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhR1d/VBGdh9U0agnMGc6QxnlOXZdCFU3EetLxJqNfgsXFUexUfadqBaX43eA62LX
	 f8pnmTfEukwqdr/aR8m45YSEpQbViuK1qzoVq4FVoiEiTz4pL+K6keIEUWb3hIk5BT
	 apy0a5A5zFu2NeblJpsVf/lWRIVEyw8YP8NFFXIzebVqtWYFCqjoPMgAfzngvtXgp3
	 gKjLm0RL+cGIC2eTA1wmZLR/oRNgEeB+Zb3iTgibhRzmsH50ezigGQiPo4+Iyd3V3j
	 tfoLErUsUUGi2CaELSdAPRE0M9k+gFFaK91f+vLQaAjh/S+OAMXo7tdNGNWCth+UQw
	 vsST2K0czvMNw==
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
Subject: [PATCH 6.1.y 11/18] sunrpc: pass in the sv_stats struct through svc_create_pooled
Date: Sat, 10 Aug 2024 16:00:02 -0400
Message-ID: <20240810200009.9882-12-cel@kernel.org>
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

[ Upstream commit f094323867668d50124886ad884b665de7319537 ]

Since only one service actually reports the rpc stats there's not much
of a reason to have a pointer to it in the svc_program struct.  Adjust
the svc_create_pooled function to take the sv_stats as an argument and
pass the struct through there as desired instead of getting it from the
svc_program->pg_stats.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
[ cel: adjusted to apply to v6.1.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c           |  3 ++-
 include/linux/sunrpc/svc.h |  4 +++-
 net/sunrpc/svc.c           | 12 +++++++-----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index e1a07cfdab23..34d5906b844b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -657,7 +657,8 @@ int nfsd_create_serv(struct net *net)
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-	serv = svc_create_pooled(&nfsd_program, nfsd_max_blksize, nfsd);
+	serv = svc_create_pooled(&nfsd_program, &nfsd_svcstats,
+				 nfsd_max_blksize, nfsd);
 	if (serv == NULL)
 		return -ENOMEM;
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 88de45491376..3290b805f749 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -493,7 +493,9 @@ void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
 void		   svc_rqst_free(struct svc_rqst *);
 void		   svc_exit_thread(struct svc_rqst *);
-struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
+struct svc_serv *  svc_create_pooled(struct svc_program *prog,
+				     struct svc_stat *stats,
+				     unsigned int bufsize,
 				     int (*threadfn)(void *data));
 int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
 int		   svc_pool_stats_open(struct svc_serv *serv, struct file *file);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 35c0651cc002..9ae85347ab39 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -453,8 +453,8 @@ __svc_init_bc(struct svc_serv *serv)
  * Create an RPC service
  */
 static struct svc_serv *
-__svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
-	     int (*threadfn)(void *data))
+__svc_create(struct svc_program *prog, struct svc_stat *stats,
+	     unsigned int bufsize, int npools, int (*threadfn)(void *data))
 {
 	struct svc_serv	*serv;
 	unsigned int vers;
@@ -466,7 +466,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 	serv->sv_name      = prog->pg_name;
 	serv->sv_program   = prog;
 	kref_init(&serv->sv_refcnt);
-	serv->sv_stats     = prog->pg_stats;
+	serv->sv_stats     = stats;
 	if (bufsize > RPCSVC_MAXPAYLOAD)
 		bufsize = RPCSVC_MAXPAYLOAD;
 	serv->sv_max_payload = bufsize? bufsize : 4096;
@@ -528,26 +528,28 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 struct svc_serv *svc_create(struct svc_program *prog, unsigned int bufsize,
 			    int (*threadfn)(void *data))
 {
-	return __svc_create(prog, bufsize, 1, threadfn);
+	return __svc_create(prog, NULL, bufsize, 1, threadfn);
 }
 EXPORT_SYMBOL_GPL(svc_create);
 
 /**
  * svc_create_pooled - Create an RPC service with pooled threads
  * @prog: the RPC program the new service will handle
+ * @stats: the stats struct if desired
  * @bufsize: maximum message size for @prog
  * @threadfn: a function to service RPC requests for @prog
  *
  * Returns an instantiated struct svc_serv object or NULL.
  */
 struct svc_serv *svc_create_pooled(struct svc_program *prog,
+				   struct svc_stat *stats,
 				   unsigned int bufsize,
 				   int (*threadfn)(void *data))
 {
 	struct svc_serv *serv;
 	unsigned int npools = svc_pool_map_get();
 
-	serv = __svc_create(prog, bufsize, npools, threadfn);
+	serv = __svc_create(prog, stats, bufsize, npools, threadfn);
 	if (!serv)
 		goto out_err;
 	return serv;
-- 
2.45.1


