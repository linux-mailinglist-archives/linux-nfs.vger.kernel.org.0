Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78245B62AC
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Sep 2022 23:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiILVXa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 17:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiILVX2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 17:23:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B7E2AC65
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 14:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7903A6124A
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89C3C433D7
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 21:23:25 +0000 (UTC)
Subject: [PATCH v1 10/12] NFSD: Remove "inline" directives on op_rsize_bop
 helpers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 17:23:25 -0400
Message-ID: <166301780513.89884.1812750767511042737.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <166301759113.89884.7985359396842428444.stgit@oracle-102.nfsv4.dev>
References: <166301759113.89884.7985359396842428444.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These helpers are always invoked indirectly, so the compiler can't
inline these anyway. While we're updating the synopses of these
helpers, defensively convert their parameters to const pointers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |  121 ++++++++++++++++++++++++++++++++--------------------
 fs/nfsd/xdr4.h     |    3 +
 2 files changed, 77 insertions(+), 47 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index bb22f53c7ba9..8e1e560effa2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2771,28 +2771,33 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 
 #define op_encode_channel_attrs_maxsz	(6 + 1 + 1)
 
-static inline u32 nfsd4_only_status_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_only_status_rsize(const struct svc_rqst *rqstp,
+				   const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_status_stateid_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_status_stateid_rsize(const struct svc_rqst *rqstp,
+				      const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_stateid_maxsz)* sizeof(__be32);
 }
 
-static inline u32 nfsd4_access_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_access_rsize(const struct svc_rqst *rqstp,
+			      const struct nfsd4_op *op)
 {
 	/* ac_supported, ac_resp_access */
 	return (op_encode_hdr_size + 2)* sizeof(__be32);
 }
 
-static inline u32 nfsd4_commit_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_commit_rsize(const struct svc_rqst *rqstp,
+			      const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_verifier_maxsz) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_create_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_create_rsize(const struct svc_rqst *rqstp,
+			      const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_change_info_maxsz
 		+ nfs4_fattr_bitmap_maxsz) * sizeof(__be32);
@@ -2803,10 +2808,10 @@ static inline u32 nfsd4_create_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op
  * the op prematurely if the estimate is too large.  We may turn off splice
  * reads unnecessarily.
  */
-static inline u32 nfsd4_getattr_rsize(struct svc_rqst *rqstp,
-				      struct nfsd4_op *op)
+static u32 nfsd4_getattr_rsize(const struct svc_rqst *rqstp,
+			       const struct nfsd4_op *op)
 {
-	u32 *bmap = op->u.getattr.ga_bmval;
+	const u32 *bmap = op->u.getattr.ga_bmval;
 	u32 bmap0 = bmap[0], bmap1 = bmap[1], bmap2 = bmap[2];
 	u32 ret = 0;
 
@@ -2841,24 +2846,28 @@ static inline u32 nfsd4_getattr_rsize(struct svc_rqst *rqstp,
 	return ret;
 }
 
-static inline u32 nfsd4_getfh_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_getfh_rsize(const struct svc_rqst *rqstp,
+			     const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + 1) * sizeof(__be32) + NFS4_FHSIZE;
 }
 
-static inline u32 nfsd4_link_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_link_rsize(const struct svc_rqst *rqstp,
+			    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_change_info_maxsz)
 		* sizeof(__be32);
 }
 
-static inline u32 nfsd4_lock_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_lock_rsize(const struct svc_rqst *rqstp,
+			    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_lock_denied_maxsz)
 		* sizeof(__be32);
 }
 
-static inline u32 nfsd4_open_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_open_rsize(const struct svc_rqst *rqstp,
+			    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_stateid_maxsz
 		+ op_encode_change_info_maxsz + 1
@@ -2866,7 +2875,8 @@ static inline u32 nfsd4_open_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 		+ op_encode_delegation_maxsz) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_read_rsize(const struct svc_rqst *rqstp,
+			    const struct nfsd4_op *op)
 {
 	u32 maxcount = 0, rlen = 0;
 
@@ -2876,7 +2886,8 @@ static inline u32 nfsd4_read_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 	return (op_encode_hdr_size + 2 + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_read_plus_rsize(const struct svc_rqst *rqstp,
+				 const struct nfsd4_op *op)
 {
 	u32 maxcount = svc_max_payload(rqstp);
 	u32 rlen = min(op->u.read.rd_length, maxcount);
@@ -2890,7 +2901,8 @@ static inline u32 nfsd4_read_plus_rsize(struct svc_rqst *rqstp, struct nfsd4_op
 	return (op_encode_hdr_size + 2 + seg_len + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_readdir_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_readdir_rsize(const struct svc_rqst *rqstp,
+			       const struct nfsd4_op *op)
 {
 	u32 maxcount = 0, rlen = 0;
 
@@ -2901,59 +2913,68 @@ static inline u32 nfsd4_readdir_rsize(struct svc_rqst *rqstp, struct nfsd4_op *o
 		XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_readlink_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_readlink_rsize(const struct svc_rqst *rqstp,
+				const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + 1) * sizeof(__be32) + PAGE_SIZE;
 }
 
-static inline u32 nfsd4_remove_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_remove_rsize(const struct svc_rqst *rqstp,
+			      const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_change_info_maxsz)
 		* sizeof(__be32);
 }
 
-static inline u32 nfsd4_rename_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_rename_rsize(const struct svc_rqst *rqstp,
+			      const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_change_info_maxsz
 		+ op_encode_change_info_maxsz) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_sequence_rsize(struct svc_rqst *rqstp,
-				       struct nfsd4_op *op)
+static u32 nfsd4_sequence_rsize(const struct svc_rqst *rqstp,
+				const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size
 		+ XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN) + 5) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_test_stateid_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_test_stateid_rsize(const struct svc_rqst *rqstp,
+				    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + 1 + op->u.test_stateid.ts_num_ids)
 		* sizeof(__be32);
 }
 
-static inline u32 nfsd4_setattr_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_setattr_rsize(const struct svc_rqst *rqstp,
+			       const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + nfs4_fattr_bitmap_maxsz) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_secinfo_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_secinfo_rsize(const struct svc_rqst *rqstp,
+			       const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + RPC_AUTH_MAXFLAVOR *
 		(4 + XDR_QUADLEN(GSS_OID_MAX_LEN))) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_setclientid_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_setclientid_rsize(const struct svc_rqst *rqstp,
+				   const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + 2 + XDR_QUADLEN(NFS4_VERIFIER_SIZE)) *
 								sizeof(__be32);
 }
 
-static inline u32 nfsd4_write_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_write_rsize(const struct svc_rqst *rqstp,
+			     const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + 2 + op_encode_verifier_maxsz) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_exchange_id_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_exchange_id_rsize(const struct svc_rqst *rqstp,
+				   const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + 2 + 1 + /* eir_clientid, eir_sequenceid */\
 		1 + 1 + /* eir_flags, spr_how */\
@@ -2967,14 +2988,16 @@ static inline u32 nfsd4_exchange_id_rsize(struct svc_rqst *rqstp, struct nfsd4_o
 		0 /* ignored eir_server_impl_id contents */) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_bind_conn_to_session_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_bind_conn_to_session_rsize(const struct svc_rqst *rqstp,
+					    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + \
 		XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN) + /* bctsr_sessid */\
 		2 /* bctsr_dir, use_conn_in_rdma_mode */) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_create_session_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_create_session_rsize(const struct svc_rqst *rqstp,
+				      const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + \
 		XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN) + /* sessionid */\
@@ -2983,7 +3006,8 @@ static inline u32 nfsd4_create_session_rsize(struct svc_rqst *rqstp, struct nfsd
 		op_encode_channel_attrs_maxsz) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_copy_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_copy_rsize(const struct svc_rqst *rqstp,
+			    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size +
 		1 /* wr_callback */ +
@@ -2995,16 +3019,16 @@ static inline u32 nfsd4_copy_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 		1 /* cr_synchronous */) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_offload_status_rsize(struct svc_rqst *rqstp,
-					     struct nfsd4_op *op)
+static u32 nfsd4_offload_status_rsize(const struct svc_rqst *rqstp,
+				      const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size +
 		2 /* osr_count */ +
 		1 /* osr_complete<1> optional 0 for now */) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_copy_notify_rsize(struct svc_rqst *rqstp,
-					struct nfsd4_op *op)
+static u32 nfsd4_copy_notify_rsize(const struct svc_rqst *rqstp,
+				   const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size +
 		3 /* cnr_lease_time */ +
@@ -3019,7 +3043,8 @@ static inline u32 nfsd4_copy_notify_rsize(struct svc_rqst *rqstp,
 }
 
 #ifdef CONFIG_NFSD_PNFS
-static inline u32 nfsd4_getdeviceinfo_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_getdeviceinfo_rsize(const struct svc_rqst *rqstp,
+				     const struct nfsd4_op *op)
 {
 	u32 maxcount = 0, rlen = 0;
 
@@ -3037,7 +3062,8 @@ static inline u32 nfsd4_getdeviceinfo_rsize(struct svc_rqst *rqstp, struct nfsd4
  * so we need to define an arbitrary upper bound here.
  */
 #define MAX_LAYOUT_SIZE		128
-static inline u32 nfsd4_layoutget_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_layoutget_rsize(const struct svc_rqst *rqstp,
+				 const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size +
 		1 /* logr_return_on_close */ +
@@ -3046,14 +3072,16 @@ static inline u32 nfsd4_layoutget_rsize(struct svc_rqst *rqstp, struct nfsd4_op
 		MAX_LAYOUT_SIZE) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_layoutcommit_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_layoutcommit_rsize(const struct svc_rqst *rqstp,
+				    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size +
 		1 /* locr_newsize */ +
 		2 /* ns_size */) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_layoutreturn_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_layoutreturn_rsize(const struct svc_rqst *rqstp,
+				    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size +
 		1 /* lrs_stateid */ +
@@ -3062,13 +3090,14 @@ static inline u32 nfsd4_layoutreturn_rsize(struct svc_rqst *rqstp, struct nfsd4_
 #endif /* CONFIG_NFSD_PNFS */
 
 
-static inline u32 nfsd4_seek_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
+static u32 nfsd4_seek_rsize(const struct svc_rqst *rqstp,
+			    const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + 3) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_getxattr_rsize(struct svc_rqst *rqstp,
-				       struct nfsd4_op *op)
+static u32 nfsd4_getxattr_rsize(const struct svc_rqst *rqstp,
+				const struct nfsd4_op *op)
 {
 	u32 maxcount, rlen;
 
@@ -3078,14 +3107,14 @@ static inline u32 nfsd4_getxattr_rsize(struct svc_rqst *rqstp,
 	return (op_encode_hdr_size + 1 + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_setxattr_rsize(struct svc_rqst *rqstp,
-				       struct nfsd4_op *op)
+static u32 nfsd4_setxattr_rsize(const struct svc_rqst *rqstp,
+				const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_change_info_maxsz)
 		* sizeof(__be32);
 }
-static inline u32 nfsd4_listxattrs_rsize(struct svc_rqst *rqstp,
-					 struct nfsd4_op *op)
+static u32 nfsd4_listxattrs_rsize(const struct svc_rqst *rqstp,
+				  const struct nfsd4_op *op)
 {
 	u32 maxcount, rlen;
 
@@ -3095,8 +3124,8 @@ static inline u32 nfsd4_listxattrs_rsize(struct svc_rqst *rqstp,
 	return (op_encode_hdr_size + 4 + XDR_QUADLEN(rlen)) * sizeof(__be32);
 }
 
-static inline u32 nfsd4_removexattr_rsize(struct svc_rqst *rqstp,
-					  struct nfsd4_op *op)
+static u32 nfsd4_removexattr_rsize(const struct svc_rqst *rqstp,
+				   const struct nfsd4_op *op)
 {
 	return (op_encode_hdr_size + op_encode_change_info_maxsz)
 		* sizeof(__be32);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 466e2786fc97..7fcbc7a46c15 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -889,7 +889,8 @@ struct nfsd4_operation {
 	u32 op_flags;
 	char *op_name;
 	/* Try to get response size before operation */
-	u32 (*op_rsize_bop)(struct svc_rqst *, struct nfsd4_op *);
+	u32 (*op_rsize_bop)(const struct svc_rqst *rqstp,
+			const struct nfsd4_op *op);
 	void (*op_get_currentstateid)(struct nfsd4_compound_state *,
 			union nfsd4_op_u *);
 	void (*op_set_currentstateid)(struct nfsd4_compound_state *,


