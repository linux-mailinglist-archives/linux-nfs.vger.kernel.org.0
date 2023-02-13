Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8156952D0
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Feb 2023 22:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjBMVNz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Feb 2023 16:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBMVNy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 16:13:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED921CF52
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 13:13:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0241FB8165B
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 21:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E30AC4339C;
        Mon, 13 Feb 2023 21:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676322829;
        bh=vnTorKN1PUAoaNpTYdsIjGwQiD7ESufSVGXVhD8Urnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shUjUCMBDIfwXe1YthYzQPUK+Ofl8gsr8uHhZGYeuHMXps03nFYr+m5kSfftiOj6X
         78c3ltnE2wA55q8501BK3Sj7Rjnm240tUovqKq+t4LAXcu/mU/EjEudaH4ziz8Tz7I
         wCsIx8lFUrDIUDcrkxJAmWh4eYhkuGF00tpHTXbHJm9U1gLsSearha1apNdXde+kED
         v0GBKDHV8lKQWCM/GtCYYLiIZsAtU60pUdiCSghkn9F/ReKSF7ZK7imoJcKm1nc9WT
         vtzZo4Zp2ma6YfRhyr+47jC6RuGKrgRgWUPBtPCyXXw8feeWlRn64gLSGGI7ZlaenU
         aqNAx3XDDR/dA==
From:   Jeff Layton <jlayton@kernel.org>
To:     trond.myklebust@hammerspace.com, chuck.lever@oracle.com
Cc:     willy@infradead.org, linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH 3/3] nfsd: simplify write verifier handling
Date:   Mon, 13 Feb 2023 16:13:45 -0500
Message-Id: <20230213211345.385005-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213211345.385005-1-jlayton@kernel.org>
References: <20230213211345.385005-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The write verifier exists to tell the client when the server may have
forgotten some unstable writes. The typical way that this happens is if
the server crashes, but we've also extended nfsd to change it when there
are writeback errors as well.

The way it works today though, we call something like vfs_fsync (e.g.
for a COMMIT call) and if we get back an error, we'll reset the write
verifier.

This is non-optimal for a couple of reasons:

1/ There could be significant delay between an error being
recorded and the reset. It would be ideal if the write verifier were to
change as soon as the error was recorded.

2/ It's a bit of a waste, in that if we get a writeback error on a
single inode, we'll end up resetting the write verifier for everything,
even on inodes that may be fine (e.g. on a completely separate fs).

The protocol doesn't require that we use the same verifier for all
inodes. The only requirement is that the verifier change if the server
may have forgotten some unstable writes.

Instead of resetting the per-net write verifier on errors, we can just
fetch the current errseq_t for the inode, and fold that value into the
verifier on a write. If an error is reported, then that value will
change and the verifier will also naturally change without nfsd having
to take any explicit steps.

Make nfsd only set the per-net verifier at startup time. When we need a
verifier for a reply, fetch the current errseq_t value for the mapping
and xor it into the per-net verifier.

Cc: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 22 +--------------------
 fs/nfsd/netns.h     |  4 ----
 fs/nfsd/nfs4proc.c  | 17 +++++++---------
 fs/nfsd/nfsctl.c    |  1 -
 fs/nfsd/nfssvc.c    | 48 ++++++++++++++-------------------------------
 fs/nfsd/trace.h     | 28 --------------------------
 fs/nfsd/vfs.c       | 28 +++++---------------------
 fs/nfsd/vfs.h       |  1 +
 8 files changed, 29 insertions(+), 120 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 3b9a10378c83..1ca9ad0aabcd 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -233,23 +233,6 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
 	return nf;
 }
 
-/**
- * nfsd_file_check_write_error - check for writeback errors on a file
- * @nf: nfsd_file to check for writeback errors
- *
- * Check whether a nfsd_file has an unseen error. Reset the write
- * verifier if so.
- */
-static void
-nfsd_file_check_write_error(struct nfsd_file *nf)
-{
-	struct file *file = nf->nf_file;
-
-	if ((file->f_mode & FMODE_WRITE) &&
-	    filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err)))
-		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
-}
-
 static void
 nfsd_file_hash_remove(struct nfsd_file *nf)
 {
@@ -281,10 +264,8 @@ nfsd_file_free(struct nfsd_file *nf)
 	nfsd_file_unhash(nf);
 	if (nf->nf_mark)
 		nfsd_file_mark_put(nf->nf_mark);
-	if (nf->nf_file) {
-		nfsd_file_check_write_error(nf);
+	if (nf->nf_file)
 		filp_close(nf->nf_file, NULL);
-	}
 
 	/*
 	 * If this item is still linked via nf_lru, that's a bug.
@@ -1038,7 +1019,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 out:
 	if (status == nfs_ok) {
 		this_cpu_inc(nfsd_file_acquisitions);
-		nfsd_file_check_write_error(nf);
 		*pnf = nf;
 	}
 	put_cred(cred);
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 51a4b7885cae..95d7adb73b24 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -109,7 +109,6 @@ struct nfsd_net {
 	bool nfsd_net_up;
 	bool lockd_up;
 
-	seqlock_t writeverf_lock;
 	unsigned char writeverf[8];
 
 	/*
@@ -204,7 +203,4 @@ struct nfsd_net {
 extern void nfsd_netns_free_versions(struct nfsd_net *nn);
 
 extern unsigned int nfsd_net_id;
-
-void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
-void nfsd_reset_write_verifier(struct nfsd_net *nn);
 #endif /* __NFSD_NETNS_H__ */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5ae670807449..d63648d79f17 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -717,15 +717,6 @@ nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			   &access->ac_supported);
 }
 
-static void gen_boot_verifier(nfs4_verifier *verifier, struct net *net)
-{
-	__be32 *verf = (__be32 *)verifier->data;
-
-	BUILD_BUG_ON(2*sizeof(*verf) != sizeof(verifier->data));
-
-	nfsd_copy_write_verifier(verf, net_generic(net, nfsd_net_id));
-}
-
 static __be32
 nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
@@ -1586,11 +1577,17 @@ static const struct nfsd4_callback_ops nfsd4_cb_offload_ops = {
 
 static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
 {
+	__be32 *verf;
+	nfs4_verifier *verifier = &copy->cp_res.wr_verifier;
+
+	BUILD_BUG_ON(2*sizeof(*verf) != sizeof(verifier->data));
+
 	copy->cp_res.wr_stable_how =
 		test_bit(NFSD4_COPY_F_COMMITTED, &copy->cp_flags) ?
 			NFS_FILE_SYNC : NFS_UNSTABLE;
 	nfsd4_copy_set_sync(copy, sync);
-	gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
+	verf = (__be32 *)verifier->data;
+	nfsd_set_write_verifier(verf, copy->nf_dst);
 }
 
 static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 04474b8ccf0a..28a73577beaa 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1501,7 +1501,6 @@ static __net_init int nfsd_init_net(struct net *net)
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
-	seqlock_init(&nn->writeverf_lock);
 
 	return 0;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 3a38ab304b02..8b09bfc1fae9 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -350,25 +350,27 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
 }
 
 /**
- * nfsd_copy_write_verifier - Atomically copy a write verifier
+ * nfsd_set_write_verifier - set the write verifier for a call
  * @verf: buffer in which to receive the verifier cookie
- * @nn: NFS net namespace
+ * @nf: nfsd_file being operated on for write
  *
- * This function provides a wait-free mechanism for copying the
- * namespace's write verifier without tearing it.
+ * Grab the (static) write verifier for the nfsd_net, and then fold
+ * the current errseq_t value into it for the inode to create a
+ * write verifier.
  */
-void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
+void nfsd_set_write_verifier(__be32 verf[2], struct nfsd_file *nf)
 {
-	int seq = 0;
+	struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
+	errseq_t eseq = errseq_fetch(&nf->nf_file->f_mapping->wb_err);
 
-	do {
-		read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
-		memcpy(verf, nn->writeverf, sizeof(*verf) * 2);
-	} while (need_seqretry(&nn->writeverf_lock, seq));
-	done_seqretry(&nn->writeverf_lock, seq);
+	/* copy in the per-net write verifier */
+	memcpy(verf, nn->writeverf, sizeof(*verf) * 2);
+
+	/* fold the errseq into first word */
+	verf[0] ^= (__force __be32)eseq;
 }
 
-static void nfsd_reset_write_verifier_locked(struct nfsd_net *nn)
+static void nfsd_init_write_verifier(struct nfsd_net *nn)
 {
 	struct timespec64 now;
 	u64 verf;
@@ -382,26 +384,6 @@ static void nfsd_reset_write_verifier_locked(struct nfsd_net *nn)
 	memcpy(nn->writeverf, &verf, sizeof(nn->writeverf));
 }
 
-/**
- * nfsd_reset_write_verifier - Generate a new write verifier
- * @nn: NFS net namespace
- *
- * This function updates the ->writeverf field of @nn. This field
- * contains an opaque cookie that, according to Section 18.32.3 of
- * RFC 8881, "the client can use to determine whether a server has
- * changed instance state (e.g., server restart) between a call to
- * WRITE and a subsequent call to either WRITE or COMMIT.  This
- * cookie MUST be unchanged during a single instance of the NFSv4.1
- * server and MUST be unique between instances of the NFSv4.1
- * server."
- */
-void nfsd_reset_write_verifier(struct nfsd_net *nn)
-{
-	write_seqlock(&nn->writeverf_lock);
-	nfsd_reset_write_verifier_locked(nn);
-	write_sequnlock(&nn->writeverf_lock);
-}
-
 static int nfsd_startup_net(struct net *net, const struct cred *cred)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
@@ -687,7 +669,7 @@ int nfsd_create_serv(struct net *net)
 		register_inet6addr_notifier(&nfsd_inet6addr_notifier);
 #endif
 	}
-	nfsd_reset_write_verifier(nn);
+	nfsd_init_write_verifier(nn);
 	return 0;
 }
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 4183819ea082..93d76fe33514 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -744,34 +744,6 @@ DEFINE_EVENT(nfsd_net_class, nfsd_##name, \
 DEFINE_NET_EVENT(grace_start);
 DEFINE_NET_EVENT(grace_complete);
 
-TRACE_EVENT(nfsd_writeverf_reset,
-	TP_PROTO(
-		const struct nfsd_net *nn,
-		const struct svc_rqst *rqstp,
-		int error
-	),
-	TP_ARGS(nn, rqstp, error),
-	TP_STRUCT__entry(
-		__field(unsigned long long, boot_time)
-		__field(u32, xid)
-		__field(int, error)
-		__array(unsigned char, verifier, NFS4_VERIFIER_SIZE)
-	),
-	TP_fast_assign(
-		__entry->boot_time = nn->boot_time;
-		__entry->xid = be32_to_cpu(rqstp->rq_xid);
-		__entry->error = error;
-
-		/* avoid seqlock inside TP_fast_assign */
-		memcpy(__entry->verifier, nn->writeverf,
-		       NFS4_VERIFIER_SIZE);
-	),
-	TP_printk("boot_time=%16llx xid=0x%08x error=%d new verifier=0x%s",
-		__entry->boot_time, __entry->xid, __entry->error,
-		__print_hex_str(__entry->verifier, NFS4_VERIFIER_SIZE)
-	)
-);
-
 TRACE_EVENT(nfsd_clid_cred_mismatch,
 	TP_PROTO(
 		const struct nfs4_client *clp,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 21d5209f6e04..6e8ba8357735 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -628,17 +628,12 @@ __be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
 		if (!status)
 			status = commit_inode_metadata(file_inode(src));
 		if (status < 0) {
-			struct nfsd_net *nn = net_generic(nf_dst->nf_net,
-							  nfsd_net_id);
-
 			trace_nfsd_clone_file_range_err(rqstp,
 					&nfsd4_get_cstate(rqstp)->save_fh,
 					src_pos,
 					&nfsd4_get_cstate(rqstp)->current_fh,
 					dst_pos,
 					count, status);
-			nfsd_reset_write_verifier(nn);
-			trace_nfsd_writeverf_reset(nn, rqstp, status);
 			ret = nfserrno(status);
 		}
 	}
@@ -1058,7 +1053,6 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 				unsigned long *cnt, int stable,
 				__be32 *verf)
 {
-	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file		*file = nf->nf_file;
 	struct super_block	*sb = file_inode(file)->i_sb;
 	struct svc_export	*exp;
@@ -1103,13 +1097,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
-		nfsd_copy_write_verifier(verf, nn);
+		nfsd_set_write_verifier(verf, nf);
 	host_err = vfs_iter_write(file, &iter, &pos, flags);
-	if (host_err < 0) {
-		nfsd_reset_write_verifier(nn);
-		trace_nfsd_writeverf_reset(nn, rqstp, host_err);
+	if (host_err < 0)
 		goto out_nfserr;
-	}
 	*cnt = host_err;
 	nfsd_stats_io_write_add(exp, *cnt);
 	fsnotify_modify(file);
@@ -1117,13 +1108,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	if (host_err < 0)
 		goto out_nfserr;
 
-	if (stable && use_wgather) {
+	if (stable && use_wgather)
 		host_err = wait_for_concurrent_writes(file);
-		if (host_err < 0) {
-			nfsd_reset_write_verifier(nn);
-			trace_nfsd_writeverf_reset(nn, rqstp, host_err);
-		}
-	}
 
 out_nfserr:
 	if (host_err >= 0) {
@@ -1223,7 +1209,6 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	__be32			err = nfs_ok;
 	u64			maxbytes;
 	loff_t			start, end;
-	struct nfsd_net		*nn;
 
 	/*
 	 * Convert the client-provided (offset, count) range to a
@@ -1240,7 +1225,6 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 			end = offset + count - 1;
 	}
 
-	nn = net_generic(nf->nf_net, nfsd_net_id);
 	if (EX_ISSYNC(fhp->fh_export)) {
 		errseq_t since = READ_ONCE(nf->nf_file->f_wb_err);
 		int err2;
@@ -1248,7 +1232,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		err2 = vfs_fsync_range(nf->nf_file, start, end, 0);
 		switch (err2) {
 		case 0:
-			nfsd_copy_write_verifier(verf, nn);
+			nfsd_set_write_verifier(verf, nf);
 			err2 = filemap_check_wb_err(nf->nf_file->f_mapping,
 						    since);
 			err = nfserrno(err2);
@@ -1257,12 +1241,10 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 			err = nfserr_notsupp;
 			break;
 		default:
-			nfsd_reset_write_verifier(nn);
-			trace_nfsd_writeverf_reset(nn, rqstp, err2);
 			err = nfserrno(err2);
 		}
 	} else
-		nfsd_copy_write_verifier(verf, nn);
+		nfsd_set_write_verifier(verf, nf);
 
 	return err;
 }
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index dbdfef7ae85b..e69f304407ae 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -176,4 +176,5 @@ static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *stat)
 				    AT_STATX_SYNC_AS_STAT));
 }
 
+void nfsd_set_write_verifier(__be32 verf[2], struct nfsd_file *nf);
 #endif /* LINUX_NFSD_VFS_H */
-- 
2.39.1

