Return-Path: <linux-nfs+bounces-4098-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E55690F7A1
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 22:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175DE1C21CE3
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07C159204;
	Wed, 19 Jun 2024 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5gCLhKM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A315887D
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829646; cv=none; b=jSjAazbTzkxF2C0XWRu99ITXN8sQG7FXuWrSE8q4hrinSPvNvCcH4zcAi+RKqBw9v3rqnTOo7KCDmQCp5bNjV/lmXfTuuSzesM1MjMFiv3h8PvnCJpkNoDK7acbx04w+rYFV/XyIPUiV8NWJDKB01BHLw7QexQbXLhR3lDyn1iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829646; c=relaxed/simple;
	bh=Noogo8VEf449iO4uxp/t7QHEdzBDQXlb77KtF8kwk7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvGsP7FxH07zLZ1BT88uQnjV/P/a6NNwWqHrP5TJBfGWHe27htVvVAbuBEwPiBtCmhqfwUV9ZH8/oUrz6w5EP5zKYfk80LKoNKzH41H0szTUJqB9qidbFaT2JgDisElpNyhqFq/CiIm64R+U7nJT+C/w/CFBZJCK2k7XjkoKey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5gCLhKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047A3C2BBFC;
	Wed, 19 Jun 2024 20:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718829646;
	bh=Noogo8VEf449iO4uxp/t7QHEdzBDQXlb77KtF8kwk7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l5gCLhKMBr6uSQ6Q8fbT/L6rBK4+xryfjf0NpoAdiqZvZvSL55XM8tRracVKDLuTh
	 B6CBdRBhfou8F552aeBsHCjHJxt5HLT8FMbFp/dsOAAaJ6rf1mvxAyh5n8luljDhxJ
	 ffPsxvJCD4WnPl1nO1for8dL0Jj5XvMUaU+7Bp5MNtuclZZoqRsPcIL/4+G06N5avG
	 A5S3fT9S7VDOcqbs7IhDgU9Bu8s2d4cNqmYWJTaXCvi3E6hdeiFNIUKLpabJK70vXk
	 9YZnNEQTeQZAjhDC4dFvbN6FgZ3p7YqMpjQ3Dyn6J7zsCw74QO+aTjc95M/mXLbwID
	 4ND1Uz5S3XLqA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v6 09/18] pnfs/flexfiles: Enable localio for flexfiles I/O
Date: Wed, 19 Jun 2024 16:40:23 -0400
Message-ID: <20240619204032.93740-10-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240619204032.93740-1-snitzer@kernel.org>
References: <20240619204032.93740-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the DS is local to this client, then we should be able to use local
I/O to write the data.

Signed-off-by: Peng Tao <tao.peng@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c    | 113 ++++++++++++++++++++--
 fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 ++
 3 files changed, 112 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 3ea07446f05a..ec6aaa110a7b 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -11,6 +11,7 @@
 #include <linux/nfs_mount.h>
 #include <linux/nfs_page.h>
 #include <linux/module.h>
+#include <linux/file.h>
 #include <linux/sched/mm.h>
 
 #include <linux/sunrpc/metrics.h>
@@ -162,6 +163,52 @@ decode_name(struct xdr_stream *xdr, u32 *id)
 	return 0;
 }
 
+static struct file *
+ff_local_open_fh(struct pnfs_layout_segment *lseg,
+		 u32 ds_idx,
+		 struct nfs_client *clp,
+		 const struct cred *cred,
+		 struct nfs_fh *fh,
+		 fmode_t mode)
+{
+	struct nfs4_ff_layout_mirror *mirror = FF_LAYOUT_COMP(lseg, ds_idx);
+	struct file *filp, *new, __rcu **pfile;
+
+	if (!nfs_server_is_local(clp))
+		return NULL;
+	if (mode & FMODE_WRITE) {
+		/*
+		 * Always request read and write access since this corresponds
+		 * to a rw layout.
+		 */
+		mode |= FMODE_READ;
+		pfile = &mirror->rw_file;
+	} else
+		pfile = &mirror->ro_file;
+
+	new = NULL;
+	rcu_read_lock();
+	filp = rcu_dereference(*pfile);
+	if (!filp) {
+		rcu_read_unlock();
+		new = nfs_local_open_fh(clp, cred, fh, mode);
+		if (IS_ERR(new))
+			return NULL;
+		rcu_read_lock();
+		/* try to swap in the pointer */
+		filp = cmpxchg(pfile, NULL, new);
+		if (!filp) {
+			filp = new;
+			new = NULL;
+		}
+	}
+	filp = get_file_rcu(&filp);
+	rcu_read_unlock();
+	if (new)
+		fput(new);
+	return filp;
+}
+
 static bool ff_mirror_match_fh(const struct nfs4_ff_layout_mirror *m1,
 		const struct nfs4_ff_layout_mirror *m2)
 {
@@ -237,8 +284,15 @@ static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(gfp_t gfp_flags)
 
 static void ff_layout_free_mirror(struct nfs4_ff_layout_mirror *mirror)
 {
+	struct file *filp;
 	const struct cred	*cred;
 
+	filp = rcu_access_pointer(mirror->ro_file);
+	if (filp)
+		fput(filp);
+	filp = rcu_access_pointer(mirror->rw_file);
+	if (filp)
+		fput(filp);
 	ff_layout_remove_mirror(mirror);
 	kfree(mirror->fh_versions);
 	cred = rcu_access_pointer(mirror->ro_cred);
@@ -414,6 +468,7 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		struct nfs4_ff_layout_mirror *mirror;
 		struct cred *kcred;
 		const struct cred __rcu *cred;
+		const struct cred __rcu *old;
 		kuid_t uid;
 		kgid_t gid;
 		u32 ds_count, fh_count, id;
@@ -513,13 +568,26 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 
 		mirror = ff_layout_add_mirror(lh, fls->mirror_array[i]);
 		if (mirror != fls->mirror_array[i]) {
+			struct file *filp;
+
 			/* swap cred ptrs so free_mirror will clean up old */
 			if (lgr->range.iomode == IOMODE_READ) {
-				cred = xchg(&mirror->ro_cred, cred);
-				rcu_assign_pointer(fls->mirror_array[i]->ro_cred, cred);
+				old = xchg(&mirror->ro_cred, cred);
+				rcu_assign_pointer(fls->mirror_array[i]->ro_cred, old);
+				/* drop file if creds changed */
+				if (old != cred) {
+					filp = rcu_dereference_protected(xchg(&mirror->ro_file, NULL), 1);
+					if (filp)
+						fput(filp);
+				}
 			} else {
-				cred = xchg(&mirror->rw_cred, cred);
-				rcu_assign_pointer(fls->mirror_array[i]->rw_cred, cred);
+				old = xchg(&mirror->rw_cred, cred);
+				rcu_assign_pointer(fls->mirror_array[i]->rw_cred, old);
+				if (old != cred) {
+					filp = rcu_dereference_protected(xchg(&mirror->rw_file, NULL), 1);
+					if (filp)
+						fput(filp);
+				}
 			}
 			ff_layout_free_mirror(fls->mirror_array[i]);
 			fls->mirror_array[i] = mirror;
@@ -1757,6 +1825,7 @@ ff_layout_read_pagelist(struct nfs_pageio_descriptor *desc,
 	struct pnfs_layout_segment *lseg = hdr->lseg;
 	struct nfs4_pnfs_ds *ds;
 	struct rpc_clnt *ds_clnt;
+	struct file *filp;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
 	loff_t offset = hdr->args.offset;
@@ -1803,12 +1872,20 @@ ff_layout_read_pagelist(struct nfs_pageio_descriptor *desc,
 	hdr->args.offset = offset;
 	hdr->mds_offset = offset;
 
+	/* Start IO accounting for local read */
+	filp = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
+				FMODE_READ);
+	if (filp) {
+		hdr->task.tk_start = ktime_get();
+		ff_layout_read_record_layoutstats_start(&hdr->task, hdr);
+	}
+
 	/* Perform an asynchronous read to ds */
 	nfs_initiate_pgio(desc, ds->ds_clp, ds_clnt, hdr, ds_cred,
 			  ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_read_call_ops_v3 :
 				      &ff_layout_read_call_ops_v4,
-			  0, RPC_TASK_SOFTCONN, NULL);
+			  0, RPC_TASK_SOFTCONN, filp);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1829,6 +1906,7 @@ ff_layout_write_pagelist(struct nfs_pageio_descriptor *desc,
 	struct pnfs_layout_segment *lseg = hdr->lseg;
 	struct nfs4_pnfs_ds *ds;
 	struct rpc_clnt *ds_clnt;
+	struct file *filp;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
 	loff_t offset = hdr->args.offset;
@@ -1873,12 +1951,20 @@ ff_layout_write_pagelist(struct nfs_pageio_descriptor *desc,
 	 */
 	hdr->args.offset = offset;
 
+	/* Start IO accounting for local write */
+	filp = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
+				FMODE_READ|FMODE_WRITE);
+	if (filp) {
+		hdr->task.tk_start = ktime_get();
+		ff_layout_write_record_layoutstats_start(&hdr->task, hdr);
+	}
+
 	/* Perform an asynchronous write */
 	nfs_initiate_pgio(desc, ds->ds_clp, ds_clnt, hdr, ds_cred,
 			  ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_write_call_ops_v3 :
 				      &ff_layout_write_call_ops_v4,
-			  sync, RPC_TASK_SOFTCONN, NULL);
+			  sync, RPC_TASK_SOFTCONN, filp);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1912,6 +1998,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	struct pnfs_layout_segment *lseg = data->lseg;
 	struct nfs4_pnfs_ds *ds;
 	struct rpc_clnt *ds_clnt;
+	struct file *filp;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
 	u32 idx;
@@ -1950,10 +2037,18 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	if (fh)
 		data->args.fh = fh;
 
+	/* Start IO accounting for local commit */
+	filp = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
+				FMODE_READ|FMODE_WRITE);
+	if (filp) {
+		data->task.tk_start = ktime_get();
+		ff_layout_commit_record_layoutstats_start(&data->task, data);
+	}
+
 	ret = nfs_initiate_commit(ds_clnt, data, ds->ds_clp->rpc_ops,
-				   vers == 3 ? &ff_layout_commit_call_ops_v3 :
-					       &ff_layout_commit_call_ops_v4,
-				   how, RPC_TASK_SOFTCONN, NULL);
+				  vers == 3 ? &ff_layout_commit_call_ops_v3 :
+					      &ff_layout_commit_call_ops_v4,
+				  how, RPC_TASK_SOFTCONN, filp);
 	put_cred(ds_cred);
 	return ret;
 out_err:
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index f84b3fb0dddd..8e042df5a2c9 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -82,7 +82,9 @@ struct nfs4_ff_layout_mirror {
 	struct nfs_fh			*fh_versions;
 	nfs4_stateid			stateid;
 	const struct cred __rcu		*ro_cred;
+	struct file __rcu		*ro_file;
 	const struct cred __rcu		*rw_cred;
+	struct file __rcu		*rw_file;
 	refcount_t			ref;
 	spinlock_t			lock;
 	unsigned long			flags;
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


