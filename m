Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82D65832FC
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 21:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiG0THo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 15:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiG0THZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 15:07:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB06BD3
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 11:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 399A2B8224C
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA9AC433C1
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:41:19 +0000 (UTC)
Subject: [PATCH v2 13/13] NFSD: Move copy offload callback arguments into a
 separate structure
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 27 Jul 2022 14:41:18 -0400
Message-ID: <165894727888.11193.11556635666080088370.stgit@manet.1015granger.net>
In-Reply-To: <165894669884.11193.6386905165076468843.stgit@manet.1015granger.net>
References: <165894669884.11193.6386905165076468843.stgit@manet.1015granger.net>
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

Refactor so that CB_OFFLOAD arguments can be passed without
allocating a whole struct nfsd4_copy object. On my system (x86_64)
this removes another 96 bytes from struct nfsd4_copy.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |   37 ++++++++++++++++++-------------------
 fs/nfsd/nfs4proc.c     |   44 ++++++++++++++++++++++----------------------
 fs/nfsd/xdr4.h         |   11 +++++++----
 3 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 11f8715d92d6..4ce328209f61 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -679,7 +679,7 @@ static int nfs4_xdr_dec_cb_notify_lock(struct rpc_rqst *rqstp,
  *	case NFS4_OK:
  *		write_response4	coa_resok4;
  *	default:
- *	length4		coa_bytes_copied;
+ *		length4		coa_bytes_copied;
  * };
  * struct CB_OFFLOAD4args {
  *	nfs_fh4		coa_fh;
@@ -688,21 +688,22 @@ static int nfs4_xdr_dec_cb_notify_lock(struct rpc_rqst *rqstp,
  * };
  */
 static void encode_offload_info4(struct xdr_stream *xdr,
-				 __be32 nfserr,
-				 const struct nfsd4_copy *cp)
+				 const struct nfsd4_cb_offload *cbo)
 {
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 4);
-	*p++ = nfserr;
-	if (!nfserr) {
+	*p = cbo->co_nfserr;
+	switch (cbo->co_nfserr) {
+	case nfs_ok:
 		p = xdr_reserve_space(xdr, 4 + 8 + 4 + NFS4_VERIFIER_SIZE);
 		p = xdr_encode_empty_array(p);
-		p = xdr_encode_hyper(p, cp->cp_res.wr_bytes_written);
-		*p++ = cpu_to_be32(cp->cp_res.wr_stable_how);
-		p = xdr_encode_opaque_fixed(p, cp->cp_res.wr_verifier.data,
+		p = xdr_encode_hyper(p, cbo->co_res.wr_bytes_written);
+		*p++ = cpu_to_be32(cbo->co_res.wr_stable_how);
+		p = xdr_encode_opaque_fixed(p, cbo->co_res.wr_verifier.data,
 					    NFS4_VERIFIER_SIZE);
-	} else {
+		break;
+	default:
 		p = xdr_reserve_space(xdr, 8);
 		/* We always return success if bytes were written */
 		p = xdr_encode_hyper(p, 0);
@@ -710,18 +711,16 @@ static void encode_offload_info4(struct xdr_stream *xdr,
 }
 
 static void encode_cb_offload4args(struct xdr_stream *xdr,
-				   __be32 nfserr,
-				   const struct knfsd_fh *fh,
-				   const struct nfsd4_copy *cp,
+				   const struct nfsd4_cb_offload *cbo,
 				   struct nfs4_cb_compound_hdr *hdr)
 {
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, 4);
-	*p++ = cpu_to_be32(OP_CB_OFFLOAD);
-	encode_nfs_fh4(xdr, fh);
-	encode_stateid4(xdr, &cp->cp_res.cb_stateid);
-	encode_offload_info4(xdr, nfserr, cp);
+	*p = cpu_to_be32(OP_CB_OFFLOAD);
+	encode_nfs_fh4(xdr, &cbo->co_fh);
+	encode_stateid4(xdr, &cbo->co_res.cb_stateid);
+	encode_offload_info4(xdr, cbo);
 
 	hdr->nops++;
 }
@@ -731,8 +730,8 @@ static void nfs4_xdr_enc_cb_offload(struct rpc_rqst *req,
 				    const void *data)
 {
 	const struct nfsd4_callback *cb = data;
-	const struct nfsd4_copy *cp =
-		container_of(cb, struct nfsd4_copy, cp_cb);
+	const struct nfsd4_cb_offload *cbo =
+		container_of(cb, struct nfsd4_cb_offload, co_cb);
 	struct nfs4_cb_compound_hdr hdr = {
 		.ident = 0,
 		.minorversion = cb->cb_clp->cl_minorversion,
@@ -740,7 +739,7 @@ static void nfs4_xdr_enc_cb_offload(struct rpc_rqst *req,
 
 	encode_cb_compound4args(xdr, &hdr);
 	encode_cb_sequence4args(xdr, cb, &hdr);
-	encode_cb_offload4args(xdr, cp->nfserr, &cp->fh, cp, &hdr);
+	encode_cb_offload4args(xdr, cbo, &hdr);
 	encode_cb_nops(&hdr);
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 479dc03d286e..44b0a643708a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1645,9 +1645,10 @@ nfsd4_cleanup_intra_ssc(struct nfsd_file *src, struct nfsd_file *dst)
 
 static void nfsd4_cb_offload_release(struct nfsd4_callback *cb)
 {
-	struct nfsd4_copy *copy = container_of(cb, struct nfsd4_copy, cp_cb);
+	struct nfsd4_cb_offload *cbo =
+		container_of(cb, struct nfsd4_cb_offload, co_cb);
 
-	nfs4_put_copy(copy);
+	kfree(cbo);
 }
 
 static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
@@ -1763,25 +1764,23 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
 	nfs4_put_copy(copy);
 }
 
-static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
+static void nfsd4_send_cb_offload(struct nfsd4_copy *copy, __be32 nfserr)
 {
-	struct nfsd4_copy *cb_copy;
+	struct nfsd4_cb_offload *cbo;
 
-	cb_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
-	if (!cb_copy)
+	cbo = kzalloc(sizeof(*cbo), GFP_KERNEL);
+	if (!cbo)
 		return;
 
-	refcount_set(&cb_copy->refcount, 1);
-	memcpy(&cb_copy->cp_res, &copy->cp_res, sizeof(copy->cp_res));
-	cb_copy->cp_clp = copy->cp_clp;
-	cb_copy->nfserr = copy->nfserr;
-	memcpy(&cb_copy->fh, &copy->fh, sizeof(copy->fh));
+	memcpy(&cbo->co_res, &copy->cp_res, sizeof(copy->cp_res));
+	memcpy(&cbo->co_fh, &copy->fh, sizeof(copy->fh));
+	cbo->co_nfserr = nfserr;
 
-	nfsd4_init_cb(&cb_copy->cp_cb, cb_copy->cp_clp,
-			&nfsd4_cb_offload_ops, NFSPROC4_CLNT_CB_OFFLOAD);
-	trace_nfsd_cb_offload(copy->cp_clp, &copy->cp_res.cb_stateid,
-			      &copy->fh, copy->cp_count, copy->nfserr);
-	nfsd4_run_cb(&cb_copy->cp_cb);
+	nfsd4_init_cb(&cbo->co_cb, copy->cp_clp, &nfsd4_cb_offload_ops,
+		      NFSPROC4_CLNT_CB_OFFLOAD);
+	trace_nfsd_cb_offload(copy->cp_clp, &cbo->co_res.cb_stateid,
+			      &cbo->co_fh, copy->cp_count, nfserr);
+	nfsd4_run_cb(&cbo->co_cb);
 }
 
 /**
@@ -1794,6 +1793,7 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 static int nfsd4_do_async_copy(void *data)
 {
 	struct nfsd4_copy *copy = (struct nfsd4_copy *)data;
+	__be32 nfserr;
 
 	if (nfsd4_ssc_is_inter(copy)) {
 		struct file *filp;
@@ -1801,21 +1801,21 @@ static int nfsd4_do_async_copy(void *data)
 		filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
 				      &copy->stateid);
 		if (IS_ERR(filp)) {
-			copy->nfserr = nfserr_offload_denied;
+			nfserr = nfserr_offload_denied;
 			nfsd4_interssc_disconnect(copy->ss_mnt);
 			goto do_callback;
 		}
-		copy->nfserr = nfsd4_do_copy(copy, filp,
-					     copy->nf_dst->nf_file, false);
+		nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
+				       false);
 		nfsd4_cleanup_inter_ssc(copy->ss_mnt, filp, copy->nf_dst);
 	} else {
-		copy->nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
-					     copy->nf_dst->nf_file, false);
+		nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
+				       copy->nf_dst->nf_file, false);
 		nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
 	}
 
 do_callback:
-	nfsd4_send_cb_offload(copy);
+	nfsd4_send_cb_offload(copy, nfserr);
 	cleanup_async_copy(copy);
 	return 0;
 }
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index eb09bf5aa70e..8c8d7b503096 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -533,6 +533,13 @@ struct nfsd42_write_res {
 	stateid_t		cb_stateid;
 };
 
+struct nfsd4_cb_offload {
+	struct nfsd4_callback	co_cb;
+	struct nfsd42_write_res	co_res;
+	__be32			co_nfserr;
+	struct knfsd_fh		co_fh;
+};
+
 struct nfsd4_copy {
 	/* request */
 	stateid_t		cp_src_stateid;
@@ -550,10 +557,6 @@ struct nfsd4_copy {
 
 	/* response */
 	struct nfsd42_write_res	cp_res;
-
-	/* for cb_offload */
-	struct nfsd4_callback	cp_cb;
-	__be32			nfserr;
 	struct knfsd_fh		fh;
 
 	struct nfs4_client      *cp_clp;


