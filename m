Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD357E833
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 22:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiGVUTb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 16:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbiGVUTa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 16:19:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31877F50A
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 13:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40C7961EFE
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9788CC341C6
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:19:28 +0000 (UTC)
Subject: [PATCH v1 05/11] NFSD: Make boolean fields in struct nfsd4_copy into
 atomic bit flags
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 22 Jul 2022 16:19:27 -0400
Message-ID: <165852116766.11403.9703256710820903764.stgit@manet.1015granger.net>
In-Reply-To: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
References: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: saves 8 bytes, and we can replace check_and_set_stop_copy()
with an atomic bitop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |   51 +++++++++++++++++++--------------------------------
 fs/nfsd/nfs4xdr.c  |   12 ++++++------
 fs/nfsd/xdr4.h     |   33 ++++++++++++++++++++++++++++-----
 3 files changed, 53 insertions(+), 43 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7e41f40829c4..e459384b8bee 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1293,23 +1293,9 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
 	kfree(copy);
 }
 
-static bool
-check_and_set_stop_copy(struct nfsd4_copy *copy)
-{
-	bool value;
-
-	spin_lock(&copy->cp_clp->async_lock);
-	value = copy->stopped;
-	if (!copy->stopped)
-		copy->stopped = true;
-	spin_unlock(&copy->cp_clp->async_lock);
-	return value;
-}
-
 static void nfsd4_stop_copy(struct nfsd4_copy *copy)
 {
-	/* only 1 thread should stop the copy */
-	if (!check_and_set_stop_copy(copy))
+	if (!test_and_set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags))
 		kthread_stop(copy->copy_task);
 	nfs4_put_copy(copy);
 }
@@ -1678,8 +1664,9 @@ static const struct nfsd4_callback_ops nfsd4_cb_offload_ops = {
 static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
 {
 	copy->cp_res.wr_stable_how =
-		copy->committed ? NFS_FILE_SYNC : NFS_UNSTABLE;
-	copy->cp_synchronous = sync;
+		test_bit(NFSD4_COPY_F_COMMITTED, &copy->cp_flags) ?
+			NFS_FILE_SYNC : NFS_UNSTABLE;
+	nfsd4_copy_set_sync(copy, sync);
 	gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
 }
 
@@ -1708,16 +1695,16 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
 		copy->cp_res.wr_bytes_written += bytes_copied;
 		src_pos += bytes_copied;
 		dst_pos += bytes_copied;
-	} while (bytes_total > 0 && !copy->cp_synchronous);
+	} while (bytes_total > 0 && nfsd4_copy_is_async(copy));
 	/* for a non-zero asynchronous copy do a commit of data */
-	if (!copy->cp_synchronous && copy->cp_res.wr_bytes_written > 0) {
+	if (nfsd4_copy_is_async(copy) && copy->cp_res.wr_bytes_written > 0) {
 		since = READ_ONCE(dst->f_wb_err);
 		status = vfs_fsync_range(dst, copy->cp_dst_pos,
 					 copy->cp_res.wr_bytes_written, 0);
 		if (!status)
 			status = filemap_check_wb_err(dst->f_mapping, since);
 		if (!status)
-			copy->committed = true;
+			set_bit(NFSD4_COPY_F_COMMITTED, &copy->cp_flags);
 	}
 	return bytes_copied;
 }
@@ -1738,7 +1725,7 @@ static __be32 nfsd4_do_copy(struct nfsd4_copy *copy, bool sync)
 		status = nfs_ok;
 	}
 
-	if (!copy->cp_intra) /* Inter server SSC */
+	if (nfsd4_ssc_is_inter(copy))
 		nfsd4_cleanup_inter_ssc(copy->ss_mnt, copy->nf_src,
 					copy->nf_dst);
 	else
@@ -1752,13 +1739,13 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
 	dst->cp_src_pos = src->cp_src_pos;
 	dst->cp_dst_pos = src->cp_dst_pos;
 	dst->cp_count = src->cp_count;
-	dst->cp_synchronous = src->cp_synchronous;
+	dst->cp_flags = src->cp_flags;
 	memcpy(&dst->cp_res, &src->cp_res, sizeof(src->cp_res));
 	memcpy(&dst->fh, &src->fh, sizeof(src->fh));
 	dst->cp_clp = src->cp_clp;
 	dst->nf_dst = nfsd_file_get(src->nf_dst);
-	dst->cp_intra = src->cp_intra;
-	if (src->cp_intra) /* for inter, file_src doesn't exist yet */
+	/* for inter, nf_src doesn't exist yet */
+	if (!nfsd4_ssc_is_inter(src))
 		dst->nf_src = nfsd_file_get(src->nf_src);
 
 	memcpy(&dst->cp_stateid, &src->cp_stateid, sizeof(src->cp_stateid));
@@ -1772,7 +1759,7 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
 {
 	nfs4_free_copy_state(copy);
 	nfsd_file_put(copy->nf_dst);
-	if (copy->cp_intra)
+	if (!nfsd4_ssc_is_inter(copy))
 		nfsd_file_put(copy->nf_src);
 	spin_lock(&copy->cp_clp->async_lock);
 	list_del(&copy->copies);
@@ -1785,7 +1772,7 @@ static int nfsd4_do_async_copy(void *data)
 	struct nfsd4_copy *copy = (struct nfsd4_copy *)data;
 	struct nfsd4_copy *cb_copy;
 
-	if (!copy->cp_intra) { /* Inter server SSC */
+	if (nfsd4_ssc_is_inter(copy)) {
 		copy->nf_src = kzalloc(sizeof(struct nfsd_file), GFP_KERNEL);
 		if (!copy->nf_src) {
 			copy->nfserr = nfserr_serverfault;
@@ -1817,7 +1804,7 @@ static int nfsd4_do_async_copy(void *data)
 			      &copy->fh, copy->cp_count, copy->nfserr);
 	nfsd4_run_cb(&cb_copy->cp_cb);
 out:
-	if (!copy->cp_intra)
+	if (nfsd4_ssc_is_inter(copy))
 		kfree(copy->nf_src);
 	cleanup_async_copy(copy);
 	return 0;
@@ -1831,8 +1818,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd4_copy *async_copy = NULL;
 
-	if (!copy->cp_intra) { /* Inter server SSC */
-		if (!inter_copy_offload_enable || copy->cp_synchronous) {
+	if (nfsd4_ssc_is_inter(copy)) {
+		if (!inter_copy_offload_enable || nfsd4_copy_is_sync(copy)) {
 			status = nfserr_notsupp;
 			goto out;
 		}
@@ -1849,7 +1836,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	copy->cp_clp = cstate->clp;
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
-	if (!copy->cp_synchronous) {
+	if (nfsd4_copy_is_async(copy)) {
 		struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
 		status = nfserrno(-ENOMEM);
@@ -1884,7 +1871,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (async_copy)
 		cleanup_async_copy(async_copy);
 	status = nfserrno(-ENOMEM);
-	if (!copy->cp_intra)
+	if (nfsd4_ssc_is_inter(copy))
 		nfsd4_interssc_disconnect(copy->ss_mnt);
 	goto out;
 }
@@ -2613,7 +2600,7 @@ check_if_stalefh_allowed(struct nfsd4_compoundargs *args)
 				return;
 			}
 			putfh = (struct nfsd4_putfh *)&saved_op->u;
-			if (!copy->cp_intra)
+			if (nfsd4_ssc_is_inter(copy))
 				putfh->no_verify = true;
 		}
 	}
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 045301ad6bb5..2587c7f9a030 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1896,8 +1896,8 @@ static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
 static __be32
 nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 {
+	u32 consecutive, i, count, sync;
 	struct nl4_server *ns_dummy;
-	u32 consecutive, i, count;
 	__be32 status;
 
 	status = nfsd4_decode_stateid4(argp, &copy->cp_src_stateid);
@@ -1915,14 +1915,14 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 	/* ca_consecutive: we always do consecutive copies */
 	if (xdr_stream_decode_u32(argp->xdr, &consecutive) < 0)
 		return nfserr_bad_xdr;
-	if (xdr_stream_decode_u32(argp->xdr, &copy->cp_synchronous) < 0)
+	if (xdr_stream_decode_bool(argp->xdr, &sync) < 0)
 		return nfserr_bad_xdr;
+	nfsd4_copy_set_sync(copy, sync);
 
 	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
 		return nfserr_bad_xdr;
-	copy->cp_intra = false;
 	if (count == 0) { /* intra-server copy */
-		copy->cp_intra = true;
+		__set_bit(NFSD4_COPY_F_INTRA, &copy->cp_flags);
 		return nfs_ok;
 	}
 
@@ -4705,13 +4705,13 @@ nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
 	__be32 *p;
 
 	nfserr = nfsd42_encode_write_res(resp, &copy->cp_res,
-					 !!copy->cp_synchronous);
+					 nfsd4_copy_is_sync(copy));
 	if (nfserr)
 		return nfserr;
 
 	p = xdr_reserve_space(resp->xdr, 4 + 4);
 	*p++ = xdr_one; /* cr_consecutive */
-	*p++ = cpu_to_be32(copy->cp_synchronous);
+	*p = nfsd4_copy_is_sync(copy) ? xdr_one : xdr_zero;
 	return 0;
 }
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index dd516d5b1d81..9e0722950ca7 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -541,10 +541,12 @@ struct nfsd4_copy {
 	u64			cp_dst_pos;
 	u64			cp_count;
 	struct nl4_server	*cp_src;
-	bool			cp_intra;
 
-	/* both */
-	u32			cp_synchronous;
+	unsigned long		cp_flags;
+#define NFSD4_COPY_F_STOPPED		(0)
+#define NFSD4_COPY_F_INTRA		(1)
+#define NFSD4_COPY_F_SYNCHRONOUS	(2)
+#define NFSD4_COPY_F_COMMITTED		(3)
 
 	/* response */
 	struct nfsd42_write_res	cp_res;
@@ -564,14 +566,35 @@ struct nfsd4_copy {
 	struct list_head	copies;
 	struct task_struct	*copy_task;
 	refcount_t		refcount;
-	bool			stopped;
 
 	struct vfsmount		*ss_mnt;
 	struct nfs_fh		c_fh;
 	nfs4_stateid		stateid;
-	bool			committed;
 };
 
+static inline void nfsd4_copy_set_sync(struct nfsd4_copy *copy, bool sync)
+{
+	if (sync)
+		set_bit(NFSD4_COPY_F_SYNCHRONOUS, &copy->cp_flags);
+	else
+		clear_bit(NFSD4_COPY_F_SYNCHRONOUS, &copy->cp_flags);
+}
+
+static inline bool nfsd4_copy_is_sync(const struct nfsd4_copy *copy)
+{
+	return test_bit(NFSD4_COPY_F_SYNCHRONOUS, &copy->cp_flags);
+}
+
+static inline bool nfsd4_copy_is_async(const struct nfsd4_copy *copy)
+{
+	return !test_bit(NFSD4_COPY_F_SYNCHRONOUS, &copy->cp_flags);
+}
+
+static inline bool nfsd4_ssc_is_inter(const struct nfsd4_copy *copy)
+{
+	return !test_bit(NFSD4_COPY_F_INTRA, &copy->cp_flags);
+}
+
 struct nfsd4_seek {
 	/* request */
 	stateid_t	seek_stateid;


