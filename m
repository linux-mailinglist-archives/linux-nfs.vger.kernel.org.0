Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5AD61649
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2019 21:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfGGT0a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Jul 2019 15:26:30 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:33577 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727315AbfGGT0a (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 7 Jul 2019 15:26:30 -0400
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 02D8820669590;
        Sun,  7 Jul 2019 21:26:28 +0200 (CEST)
From:   Donald Buczek <buczek@molgen.mpg.de>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com
Cc:     Donald Buczek <buczek@molgen.mpg.de>
Subject: [PATCH V2 2/4] nfs4: Make nfs4_proc_get_lease_time available for nfs4.0
Date:   Sun,  7 Jul 2019 21:26:08 +0200
Message-Id: <20190707192610.14335-3-buczek@molgen.mpg.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707192610.14335-1-buczek@molgen.mpg.de>
References: <20190707192610.14335-1-buczek@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Compile nfs4_proc_get_lease_time, enc_get_lease_time and
dec_get_lease_time for nfs4.0. Use nfs4_sequence_done instead of
nfs41_sequence_done in nfs4_proc_get_lease_time,

Signed-off-by: Donald Buczek <buczek@molgen.mpg.de>
---
 fs/nfs/nfs4_fs.h  |  4 ++--
 fs/nfs/nfs4proc.c |  6 +++++-
 fs/nfs/nfs4xdr.c  | 12 +++++++++++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 8a38a254f516..d778dad9a75e 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -312,12 +312,12 @@ extern int nfs4_set_rw_stateid(nfs4_stateid *stateid,
 		const struct nfs_lock_context *l_ctx,
 		fmode_t fmode);
 
+extern int nfs4_proc_get_lease_time(struct nfs_client *clp,
+		struct nfs_fsinfo *fsinfo);
 #if defined(CONFIG_NFS_V4_1)
 extern int nfs41_sequence_done(struct rpc_task *, struct nfs4_sequence_res *);
 extern int nfs4_proc_create_session(struct nfs_client *, const struct cred *);
 extern int nfs4_proc_destroy_session(struct nfs4_session *, const struct cred *);
-extern int nfs4_proc_get_lease_time(struct nfs_client *clp,
-		struct nfs_fsinfo *fsinfo);
 extern int nfs4_proc_layoutcommit(struct nfs4_layoutcommit_data *data,
 				  bool sync);
 extern int nfs4_detect_session_trunking(struct nfs_client *clp,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6418cb6c079b..4783db7a1cf3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8241,6 +8241,8 @@ int nfs4_destroy_clientid(struct nfs_client *clp)
 	return ret;
 }
 
+#endif /* CONFIG_NFS_V4_1 */
+
 struct nfs4_get_lease_time_data {
 	struct nfs4_get_lease_time_args *args;
 	struct nfs4_get_lease_time_res *res;
@@ -8273,7 +8275,7 @@ static void nfs4_get_lease_time_done(struct rpc_task *task, void *calldata)
 			(struct nfs4_get_lease_time_data *)calldata;
 
 	dprintk("--> %s\n", __func__);
-	if (!nfs41_sequence_done(task, &data->res->lr_seq_res))
+	if (!nfs4_sequence_done(task, &data->res->lr_seq_res))
 		return;
 	switch (task->tk_status) {
 	case -NFS4ERR_DELAY:
@@ -8331,6 +8333,8 @@ int nfs4_proc_get_lease_time(struct nfs_client *clp, struct nfs_fsinfo *fsinfo)
 	return status;
 }
 
+#ifdef CONFIG_NFS_V4_1
+
 /*
  * Initialize the values to be used by the client in CREATE_SESSION
  * If nfs4_init_session set the fore channel request and response sizes,
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 6d51877cd383..07f28f6d0f31 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -837,6 +837,7 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 #define NFS4_dec_sequence_sz \
 				(compound_decode_hdr_maxsz + \
 				 decode_sequence_maxsz)
+#endif
 #define NFS4_enc_get_lease_time_sz	(compound_encode_hdr_maxsz + \
 					 encode_sequence_maxsz + \
 					 encode_putrootfh_maxsz + \
@@ -845,6 +846,7 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 					 decode_sequence_maxsz + \
 					 decode_putrootfh_maxsz + \
 					 decode_fsinfo_maxsz)
+#if defined(CONFIG_NFS_V4_1)
 #define NFS4_enc_reclaim_complete_sz	(compound_encode_hdr_maxsz + \
 					 encode_sequence_maxsz + \
 					 encode_reclaim_complete_maxsz)
@@ -2957,6 +2959,8 @@ static void nfs4_xdr_enc_sequence(struct rpc_rqst *req, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
 
+#endif
+
 /*
  * a GET_LEASE_TIME request
  */
@@ -2977,6 +2981,8 @@ static void nfs4_xdr_enc_get_lease_time(struct rpc_rqst *req,
 	encode_nops(&hdr);
 }
 
+#ifdef CONFIG_NFS_V4_1
+
 /*
  * a RECLAIM_COMPLETE request
  */
@@ -7122,6 +7128,8 @@ static int nfs4_xdr_dec_sequence(struct rpc_rqst *rqstp,
 	return status;
 }
 
+#endif
+
 /*
  * Decode GET_LEASE_TIME response
  */
@@ -7143,6 +7151,8 @@ static int nfs4_xdr_dec_get_lease_time(struct rpc_rqst *rqstp,
 	return status;
 }
 
+#ifdef CONFIG_NFS_V4_1
+
 /*
  * Decode RECLAIM_COMPLETE response
  */
@@ -7551,7 +7561,7 @@ const struct rpc_procinfo nfs4_procedures[] = {
 	PROC41(CREATE_SESSION,	enc_create_session,	dec_create_session),
 	PROC41(DESTROY_SESSION,	enc_destroy_session,	dec_destroy_session),
 	PROC41(SEQUENCE,	enc_sequence,		dec_sequence),
-	PROC41(GET_LEASE_TIME,	enc_get_lease_time,	dec_get_lease_time),
+	PROC(GET_LEASE_TIME,	enc_get_lease_time,	dec_get_lease_time),
 	PROC41(RECLAIM_COMPLETE,enc_reclaim_complete,	dec_reclaim_complete),
 	PROC41(GETDEVICEINFO,	enc_getdeviceinfo,	dec_getdeviceinfo),
 	PROC41(LAYOUTGET,	enc_layoutget,		dec_layoutget),
-- 
2.22.0

