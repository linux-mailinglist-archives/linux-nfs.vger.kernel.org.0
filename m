Return-Path: <linux-nfs+bounces-13017-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A522B034DB
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 05:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 486E07A3D9C
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 03:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6417C1E1A17;
	Mon, 14 Jul 2025 03:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEG7U3WN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1918C332
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 03:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462850; cv=none; b=Lj/FnOg181/RA17onot5t2pfBUu1hcl3UV3NSE/cNWFnrC8uxm/Licao7C6ErhB2EpGNLOeLkJYjpTJ+GCE+hEqrK2NQH2KObUtM/uC/MeSKPfxSroxWt34rrOJGxJOXDqJKGPysUJWpaWb0DZPIbknMTskqdvMLfo3D59sa2so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462850; c=relaxed/simple;
	bh=Iiu3vKvZcqWaWnw8HaZ+6OOHNEIi3vvYgtGUnziVNeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdhUlteA2NSzU2GnBvUhGKTgOMkQlcsC/GY2IK2E+kjZd8QC/+YW0yA9eRhAqTS5C12p/rDm0zYIV1Zhxx3CaJbwReeBXMjRRw73t3bugEiEdXF1SMM3T2HJ+cWOHxQ7topyADLMx6l59SOyMy/bJX+1DK02ljJ1/K0doI2qGJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEG7U3WN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA530C4CEE3;
	Mon, 14 Jul 2025 03:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752462850;
	bh=Iiu3vKvZcqWaWnw8HaZ+6OOHNEIi3vvYgtGUnziVNeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NEG7U3WNhJInyMeGixH1/pX38mx6vnzIpcLjRESKDupNSl3X16hXQKSw9Kl8eSN+Z
	 oEh4FScaMN7WAngiQgNzgkNlS/VwFsviHlplvTpGV0GyYt5EBoh+ntZVshB08jE3Wf
	 IzIZ1Ngbsgl8R/+TTQfLVdaY6RdfAWK9K7FVqYkvJJuJa5uJJoM8/oconBdBByErE3
	 qp83DjnZcjmjhqmqpi+JOJiwGvX4nG0rR4JW5TgUU+c6WU00nQ8yFsYSEQIWNeppTN
	 nOvl5meLGFhrbVeQ0gLsE+4Gu38bwj2vfaraCwg7xr9LPVzMf0rx0x89l5+Lz+/2Ld
	 VY+MDTiWAILog==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org
Subject: [for-6.16-final PATCH 6/9] Revert "nfs_localio: always hold nfsd net ref with nfsd_file ref"
Date: Sun, 13 Jul 2025 23:13:56 -0400
Message-ID: <20250714031359.10192-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250714031359.10192-1-snitzer@kernel.org>
References: <20250714031359.10192-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 14c7e3db9a8663de3bda1d4efe6a98c7d84f5b57.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c           |  4 ++--
 fs/nfs_common/nfslocalio.c |  5 +++--
 fs/nfsd/filecache.c        | 21 ---------------------
 fs/nfsd/filecache.h        |  1 -
 fs/nfsd/localio.c          |  9 ++-------
 include/linux/nfslocalio.h |  3 ++-
 6 files changed, 9 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 86df8d2cd22e..7a33da477da3 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -211,12 +211,12 @@ EXPORT_SYMBOL_GPL(nfs_local_probe_async);
 
 static inline struct nfsd_file *nfs_local_file_get(struct nfsd_file *nf)
 {
-	return nfs_to->nfsd_file_get_local(nf);
+	return nfs_to->nfsd_file_get(nf);
 }
 
 static inline void nfs_local_file_put(struct nfsd_file *nf)
 {
-	nfs_to_nfsd_file_put_local(nf);
+	nfs_to->nfsd_file_put(nf);
 }
 
 /*
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index f6821b2c87a2..bdf251332b6b 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -262,8 +262,9 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	/* We have an implied reference to net thanks to nfsd_net_try_get */
 	localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
 					     cred, nfs_fh, fmode);
-	nfs_to_nfsd_net_put(net);
-	if (!IS_ERR(localio))
+	if (IS_ERR(localio))
+		nfs_to_nfsd_net_put(net);
+	else
 		nfs_uuid_add_file(uuid, nfl);
 
 	return localio;
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 06150dd171be..6d9d7c2430ba 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -389,27 +389,6 @@ nfsd_file_put_local(struct nfsd_file *nf)
 	return net;
 }
 
-/**
- * nfsd_file_get_local - get nfsd_file reference and reference to net
- * @nf: nfsd_file of which to put the reference
- *
- * Get reference to both the nfsd_file and nf->nf_net.
- */
-struct nfsd_file *
-nfsd_file_get_local(struct nfsd_file *nf)
-{
-	struct net *net = nf->nf_net;
-
-	if (nfsd_net_try_get(net)) {
-		nf = nfsd_file_get(nf);
-		if (!nf)
-			nfsd_net_put(net);
-	} else {
-		nf = NULL;
-	}
-	return nf;
-}
-
 /**
  * nfsd_file_file - get the backing file of an nfsd_file
  * @nf: nfsd_file of which to access the backing file.
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index d41428ce8a11..fa7638007fbd 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -67,7 +67,6 @@ int nfsd_file_cache_start_net(struct net *net);
 void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
 struct net *nfsd_file_put_local(struct nfsd_file *nf);
-struct nfsd_file *nfsd_file_get_local(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 struct file *nfsd_file_file(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 40998283b858..842366707eb1 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -56,9 +56,6 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 	if (nfs_fh->size > NFS4_FHSIZE)
 		return ERR_PTR(-EINVAL);
 
-	if (!nfsd_net_try_get(net))
-		return ERR_PTR(-ENXIO);
-
 	/* nfs_fh -> svc_fh */
 	fh_init(&fh, NFS4_FHSIZE);
 	fh.fh_handle.fh_size = nfs_fh->size;
@@ -80,9 +77,6 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 	if (rq_cred.cr_group_info)
 		put_group_info(rq_cred.cr_group_info);
 
-	if (IS_ERR(localio))
-		nfsd_net_put(net);
-
 	return localio;
 }
 EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
@@ -92,7 +86,8 @@ static const struct nfsd_localio_operations nfsd_localio_ops = {
 	.nfsd_net_put  = nfsd_net_put,
 	.nfsd_open_local_fh = nfsd_open_local_fh,
 	.nfsd_file_put_local = nfsd_file_put_local,
-	.nfsd_file_get_local = nfsd_file_get_local,
+	.nfsd_file_get = nfsd_file_get,
+	.nfsd_file_put = nfsd_file_put,
 	.nfsd_file_file = nfsd_file_file,
 };
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index c3f34bae60e1..9aa8a43843d7 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -66,7 +66,8 @@ struct nfsd_localio_operations {
 						const struct nfs_fh *,
 						const fmode_t);
 	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
-	struct nfsd_file *(*nfsd_file_get_local)(struct nfsd_file *);
+	struct nfsd_file *(*nfsd_file_get)(struct nfsd_file *);
+	void (*nfsd_file_put)(struct nfsd_file *);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
 } ____cacheline_aligned;
 
-- 
2.44.0


