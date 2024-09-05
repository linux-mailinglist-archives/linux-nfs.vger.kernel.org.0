Return-Path: <linux-nfs+bounces-6280-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ED996E2DA
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 21:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C821C20E68
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 19:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E03318D621;
	Thu,  5 Sep 2024 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVIV5xGs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779DC18C354
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563441; cv=none; b=Zh+ZSjC1SO0du4RWZR5szvqiHKnK5S8rMGihHa2uhBAJMg6BNfTBTKroM8fIpHNtaJLGFIiv+CCVOY49arTm0m7SId+WFTna1OHgoytXYmDQFzDi1+mL7d/n2GdFxraKDXXvGXMMx8NfGnSXyiY4DhNA2OjpzAxMpz1wgDqNvCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563441; c=relaxed/simple;
	bh=cS5JVl9T6EMY/AcowMDHIItv25eQDfBccEJRgueJGUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnM2Q5KDAd63oz6kejdRJll+8mQz7TPAEVKhlCPIBTPQNGYZR/ombfiHrm1NAZnzJUS8tCdsHZdN2V6OVN1YGDwBycawWxWQE7a34cuBVMns6ipMUydX4BME4rrPeqEGuee6qXyqZXTXpNn48Tzd8qdBoRx4CRE/TFdqTEfAAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVIV5xGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F590C4CEC3;
	Thu,  5 Sep 2024 19:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563441;
	bh=cS5JVl9T6EMY/AcowMDHIItv25eQDfBccEJRgueJGUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVIV5xGsOfY2n1TYotar1uoFREVrEPkroBEu0eWuOvTmBH79KxIrqNS14cqJyFptE
	 OqEmSNPKqL0nnJHeFcl9EYyX/MmcHFI5SZOaQ3T2jvEEAmr/QQZrLCqccmb19HaLvI
	 gbqAujPYJtLsNiyTDl02QC1oIGt82OMUwYZuMsBDy47m7iToU4Rrl6oQ6VD2mjYMKl
	 mN7zmWUrOwa1CwE9UxfOZr9/juB5mOrTpj5Ef/fsqxe1VO2TT+mffj5+kDe+D3FReJ
	 K/wSdT+00fFHObIjZ18T3fnX0IkC6hYmfiqnwFKCduNsMfn5SXTk5HaT6ISydQqRXF
	 4yk7vFqPi46zQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH v16 21/26] pnfs/flexfiles: enable localio support
Date: Thu,  5 Sep 2024 15:09:55 -0400
Message-ID: <20240905191011.41650-22-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240905191011.41650-1-snitzer@kernel.org>
References: <20240905191011.41650-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the DS is local to this client use localio to write the data.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c    | 50 +++++++++++++++++++++--
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |  6 +++
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 01ee52551a63..f78115c6c2c1 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -11,6 +11,7 @@
 #include <linux/nfs_mount.h>
 #include <linux/nfs_page.h>
 #include <linux/module.h>
+#include <linux/file.h>
 #include <linux/sched/mm.h>
 
 #include <linux/sunrpc/metrics.h>
@@ -162,6 +163,21 @@ decode_name(struct xdr_stream *xdr, u32 *id)
 	return 0;
 }
 
+static struct nfsd_file *
+ff_local_open_fh(struct nfs_client *clp, const struct cred *cred,
+		 struct nfs_fh *fh, fmode_t mode)
+{
+	if (mode & FMODE_WRITE) {
+		/*
+		 * Always request read and write access since this corresponds
+		 * to a rw layout.
+		 */
+		mode |= FMODE_READ;
+	}
+
+	return nfs_local_open_fh(clp, cred, fh, mode);
+}
+
 static bool ff_mirror_match_fh(const struct nfs4_ff_layout_mirror *m1,
 		const struct nfs4_ff_layout_mirror *m2)
 {
@@ -237,7 +253,7 @@ static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(gfp_t gfp_flags)
 
 static void ff_layout_free_mirror(struct nfs4_ff_layout_mirror *mirror)
 {
-	const struct cred	*cred;
+	const struct cred *cred;
 
 	ff_layout_remove_mirror(mirror);
 	kfree(mirror->fh_versions);
@@ -1756,6 +1772,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	struct pnfs_layout_segment *lseg = hdr->lseg;
 	struct nfs4_pnfs_ds *ds;
 	struct rpc_clnt *ds_clnt;
+	struct nfsd_file *localio;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
 	loff_t offset = hdr->args.offset;
@@ -1802,11 +1819,18 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	hdr->args.offset = offset;
 	hdr->mds_offset = offset;
 
+	/* Start IO accounting for local read */
+	localio = ff_local_open_fh(ds->ds_clp, ds_cred, fh, FMODE_READ);
+	if (localio) {
+		hdr->task.tk_start = ktime_get();
+		ff_layout_read_record_layoutstats_start(&hdr->task, hdr);
+	}
+
 	/* Perform an asynchronous read to ds */
 	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_read_call_ops_v3 :
 				      &ff_layout_read_call_ops_v4,
-			  0, RPC_TASK_SOFTCONN, NULL);
+			  0, RPC_TASK_SOFTCONN, localio);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1826,6 +1850,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	struct pnfs_layout_segment *lseg = hdr->lseg;
 	struct nfs4_pnfs_ds *ds;
 	struct rpc_clnt *ds_clnt;
+	struct nfsd_file *localio;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
 	loff_t offset = hdr->args.offset;
@@ -1870,11 +1895,19 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	 */
 	hdr->args.offset = offset;
 
+	/* Start IO accounting for local write */
+	localio = ff_local_open_fh(ds->ds_clp, ds_cred, fh,
+				   FMODE_READ|FMODE_WRITE);
+	if (localio) {
+		hdr->task.tk_start = ktime_get();
+		ff_layout_write_record_layoutstats_start(&hdr->task, hdr);
+	}
+
 	/* Perform an asynchronous write */
 	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_write_call_ops_v3 :
 				      &ff_layout_write_call_ops_v4,
-			  sync, RPC_TASK_SOFTCONN, NULL);
+			  sync, RPC_TASK_SOFTCONN, localio);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1908,6 +1941,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	struct pnfs_layout_segment *lseg = data->lseg;
 	struct nfs4_pnfs_ds *ds;
 	struct rpc_clnt *ds_clnt;
+	struct nfsd_file *localio;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
 	u32 idx;
@@ -1946,10 +1980,18 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	if (fh)
 		data->args.fh = fh;
 
+	/* Start IO accounting for local commit */
+	localio = ff_local_open_fh(ds->ds_clp, ds_cred, fh,
+				   FMODE_READ|FMODE_WRITE);
+	if (localio) {
+		data->task.tk_start = ktime_get();
+		ff_layout_commit_record_layoutstats_start(&data->task, data);
+	}
+
 	ret = nfs_initiate_commit(ds_clnt, data, ds->ds_clp->rpc_ops,
 				   vers == 3 ? &ff_layout_commit_call_ops_v3 :
 					       &ff_layout_commit_call_ops_v4,
-				   how, RPC_TASK_SOFTCONN, NULL);
+				   how, RPC_TASK_SOFTCONN, localio);
 	put_cred(ds_cred);
 	return ret;
 out_err:
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index e028f5a0ef5f..e58bedfb1dcc 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -395,6 +395,12 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 
 	/* connect success, check rsize/wsize limit */
 	if (!status) {
+		/*
+		 * ds_clp is put in destroy_ds().
+		 * keep ds_clp even if DS is local, so that if local IO cannot
+		 * proceed somehow, we can fall back to NFS whenever we want.
+		 */
+		nfs_local_probe(ds->ds_clp);
 		max_payload =
 			nfs_block_size(rpc_max_payload(ds->ds_clp->cl_rpcclient),
 				       NULL);
-- 
2.44.0


