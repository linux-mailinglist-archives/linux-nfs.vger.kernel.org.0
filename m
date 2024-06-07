Return-Path: <linux-nfs+bounces-3598-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0092B900689
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52FA8B28F39
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62332195B2E;
	Fri,  7 Jun 2024 14:27:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6265198E8D
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770431; cv=none; b=l52nBw7/TZXvzOSbzh0RtPrQZIkCd1qctmScXUhZ03xoUTCqg5RpztMN00qshWQpfe9kQc8UPltughjGKHfru55kDoEH8a93hTDVfYRg516oH1C9SztCKBcqkVf11zwijZdo80h0I90PQlZeex9yD24dSzLkKnls6OX/zU/hjJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770431; c=relaxed/simple;
	bh=ImNkn1NNs5nQOkVo+Sxl/E0i2HCTfpcXjsVQS6k4/Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ly+BA8m1lnSi4uEZ0pPf3cbWeNxUIhcAUPL8Hk2OZ8rXKQUzj1/nee6YzUjf/ficpexyOmONZB5c9oxvYx8f8NsEXrOpJCbN+LcxfRmhRBuUrsI1QG3W/tS/33J65wkoBos4HkIHtDtLxhGMVSqYCr9guLasp7ZZg3NMBqB4HrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b04e41cdb2so10320876d6.3
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770428; x=1718375228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vZbMfTbgFWvKilJo5tnpnzf5Si39+84C6I/Y3AxLIU=;
        b=M4ZIuFdA/ZkkUjaM9tMnua+nbhjeIuB6IPLKimcuesUARsNOXjUQATOKqblzcmnu9i
         ID316vUP+kA6oVbp5gJb3mu/vaQr6cYy3w3uAIMbisigM5cL2ZSrIthyQBb5teYeiwrt
         Tp33mrDLjJLzsNMmszzAzugptZEKG1y7RKqVb556czqbqnZJx7uWrEsy5mjDjl5uf8o9
         VbiS7JMvf5wCUwl/c4fvgtifcbkVhaT4fGZEzMXcBCC1gSNr9occhEnqaW5IrY3izklm
         Q03Q5N9FNxcnG2Nu6Cm1xbHPOnoUOBRnv1HbNVlRDroGtfAeXWskeBd+EPVP2Thtz5fs
         8ddA==
X-Gm-Message-State: AOJu0YzXvDXIBlUPSP6abZvCII9Qtau47QkVTVdstk0k3yYLwey59O7P
	8w0MUpX2YtOijQ0OAShFrDXbkLg5EvO653Uo3ll9ijmbAPN2KFV7nPwCush1nRUQRR88a6ODQPY
	nDFrQew==
X-Google-Smtp-Source: AGHT+IHfeLcurmWXW7iACyGbGtr3Pi+iO7mID9vF/jCwQOCeIANRNsuyBSKOca392Vb8xrsM2h+Tog==
X-Received: by 2002:a05:6214:4386:b0:6aa:f948:7f4a with SMTP id 6a1803df08f44-6b059fae06fmr22177636d6.61.1717770428174;
        Fri, 07 Jun 2024 07:27:08 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038b38fd8sm12507431cf.60.2024.06.07.07.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:07 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 13/29] pnfs/flexfiles: Enable localio for flexfiles I/O
Date: Fri,  7 Jun 2024 10:26:30 -0400
Message-ID: <20240607142646.20924-14-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the DS is local to this client, then we might be able to use local
I/O to write the data.

[snitm: rebase accounted for commit 0ede61d8589cc ("file: convert to SLAB_TYPESAFE_BY_RCU")]

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 109 +++++++++++++++++++++++--
 fs/nfs/flexfilelayout/flexfilelayout.h |   2 +
 2 files changed, 104 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index ce6cb5d82427..0a9eccb44085 100644
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
 	ret = nfs_initiate_commit(ds->ds_clp, ds_clnt, data, ds->ds_clp->rpc_ops,
 				   vers == 3 ? &ff_layout_commit_call_ops_v3 :
 					       &ff_layout_commit_call_ops_v4,
-				   how, RPC_TASK_SOFTCONN, NULL);
+				   how, RPC_TASK_SOFTCONN, filp);
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
-- 
2.44.0


