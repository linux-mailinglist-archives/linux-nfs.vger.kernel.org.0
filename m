Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1296107C8
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 04:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbiJ1CQg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 22:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbiJ1CQf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 22:16:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6573CB878B
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 19:16:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S1i65F027938;
        Fri, 28 Oct 2022 02:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=/6xjQ98fTvQd7AcdUwxDYNQnrQ7Z70nWpLuoK0ss1fo=;
 b=Ssm/7jRWox0hxXLjBZwRZFUYenQi2Jr4WbZIVxtffRHws8qxx4SylaSJsnBf8VChlSar
 pEzrk6MhsA/znmGSR5/xcWAfyOkw0MLxwF9DsoNnaZDyiMRxBZCiXvx0OBbOP1JhohJS
 rrCfA4yODi3rEmUJBMyFtFJslrj4jNq+WkKfT0to8oER8cibJ1POEaQd0jUvrr9XtmuD
 SLLyDXbUweHyTeUA6M+BAUkZGzMxiOU09g5i1d8bzWr/JtOKJMDnDKQbdGQnDFk+DK4c
 APYTMUHCBJGzGMVu6LNu43ZilqLBcxMbGlEZNDB/U12dcW4mAYdLULpVq2Zr4MfOwgHc 1A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfays3yhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 02:16:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29S09R44011562;
        Fri, 28 Oct 2022 02:16:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagrm5vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 02:16:29 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29S2GSSI002910;
        Fri, 28 Oct 2022 02:16:29 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kfagrm5v3-2;
        Fri, 28 Oct 2022 02:16:29 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/2] NFSD: add support for sending CB_RECALL_ANY
Date:   Thu, 27 Oct 2022 19:16:08 -0700
Message-Id: <1666923369-21235-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1666923369-21235-1-git-send-email-dai.ngo@oracle.com>
References: <1666923369-21235-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280013
X-Proofpoint-ORIG-GUID: anoYp37bp5DymuX-yqWMw-M5zsdjHTRe
X-Proofpoint-GUID: anoYp37bp5DymuX-yqWMw-M5zsdjHTRe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There is only one nfsd4_callback, cl_recall_any, added for each
nfs4_client. Access to it must be serialized. For now it's done
by the cl_recall_any_busy flag since it's used only by the
delegation shrinker. If there is another consumer of CB_RECALL_ANY
then a spinlock must be used.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4callback.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4state.c    | 32 +++++++++++++++++++++++++
 fs/nfsd/state.h        |  8 +++++++
 fs/nfsd/xdr4cb.h       |  6 +++++
 4 files changed, 110 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index f0e69edf5f0f..03587e1397f4 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -329,6 +329,29 @@ static void encode_cb_recall4args(struct xdr_stream *xdr,
 }
 
 /*
+ * CB_RECALLANY4args
+ *
+ *	struct CB_RECALLANY4args {
+ *		uint32_t	craa_objects_to_keep;
+ *		bitmap4		craa_type_mask;
+ *	};
+ */
+static void
+encode_cb_recallany4args(struct xdr_stream *xdr,
+			struct nfs4_cb_compound_hdr *hdr, uint32_t bmval)
+{
+	__be32 *p;
+
+	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
+	p = xdr_reserve_space(xdr, 4);
+	*p++ = xdr_zero;	/* craa_objects_to_keep */
+	p = xdr_reserve_space(xdr, 8);
+	*p++ = cpu_to_be32(1);
+	*p++ = cpu_to_be32(bmval);
+	hdr->nops++;
+}
+
+/*
  * CB_SEQUENCE4args
  *
  *	struct CB_SEQUENCE4args {
@@ -482,6 +505,24 @@ static void nfs4_xdr_enc_cb_recall(struct rpc_rqst *req, struct xdr_stream *xdr,
 	encode_cb_nops(&hdr);
 }
 
+/*
+ * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
+ */
+static void
+nfs4_xdr_enc_cb_recall_any(struct rpc_rqst *req,
+		struct xdr_stream *xdr, const void *data)
+{
+	const struct nfsd4_callback *cb = data;
+	struct nfs4_cb_compound_hdr hdr = {
+		.ident = cb->cb_clp->cl_cb_ident,
+		.minorversion = cb->cb_clp->cl_minorversion,
+	};
+
+	encode_cb_compound4args(xdr, &hdr);
+	encode_cb_sequence4args(xdr, cb, &hdr);
+	encode_cb_recallany4args(xdr, &hdr, cb->cb_clp->cl_recall_any_bm);
+	encode_cb_nops(&hdr);
+}
 
 /*
  * NFSv4.0 and NFSv4.1 XDR decode functions
@@ -520,6 +561,28 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *rqstp,
 	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
 }
 
+/*
+ * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
+ */
+static int
+nfs4_xdr_dec_cb_recall_any(struct rpc_rqst *rqstp,
+				  struct xdr_stream *xdr,
+				  void *data)
+{
+	struct nfsd4_callback *cb = data;
+	struct nfs4_cb_compound_hdr hdr;
+	int status;
+
+	status = decode_cb_compound4res(xdr, &hdr);
+	if (unlikely(status))
+		return status;
+	status = decode_cb_sequence4res(xdr, cb);
+	if (unlikely(status || cb->cb_seq_status))
+		return status;
+	status =  decode_cb_op_status(xdr, OP_CB_RECALL_ANY, &cb->cb_status);
+	return status;
+}
+
 #ifdef CONFIG_NFSD_PNFS
 /*
  * CB_LAYOUTRECALL4args
@@ -783,6 +846,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
 #endif
 	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
 	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
+	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
 };
 
 static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4e718500a00c..68d049973ce3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2854,6 +2854,36 @@ static const struct tree_descr client_files[] = {
 	[3] = {""},
 };
 
+static int
+nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
+			struct rpc_task *task)
+{
+	switch (task->tk_status) {
+	case -NFS4ERR_DELAY:
+		rpc_delay(task, 2 * HZ);
+		return 0;
+	default:
+		return 1;
+	}
+}
+
+static void
+nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
+{
+	struct nfs4_client *clp = cb->cb_clp;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+
+	spin_lock(&nn->client_lock);
+	clp->cl_recall_any_busy = false;
+	put_client_renew_locked(clp);
+	spin_unlock(&nn->client_lock);
+}
+
+static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
+	.done		= nfsd4_cb_recall_any_done,
+	.release	= nfsd4_cb_recall_any_release,
+};
+
 static struct nfs4_client *create_client(struct xdr_netobj name,
 		struct svc_rqst *rqstp, nfs4_verifier *verf)
 {
@@ -2891,6 +2921,8 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 		free_client(clp);
 		return NULL;
 	}
+	nfsd4_init_cb(&clp->cl_recall_any, clp, &nfsd4_cb_recall_any_ops,
+			NFSPROC4_CLNT_CB_RECALL_ANY);
 	return clp;
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e2daef3cc003..49ca06169642 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -411,6 +411,10 @@ struct nfs4_client {
 
 	unsigned int		cl_state;
 	atomic_t		cl_delegs_in_recall;
+
+	bool			cl_recall_any_busy;
+	uint32_t		cl_recall_any_bm;
+	struct nfsd4_callback	cl_recall_any;
 };
 
 /* struct nfs4_client_reset
@@ -639,8 +643,12 @@ enum nfsd4_cb_op {
 	NFSPROC4_CLNT_CB_OFFLOAD,
 	NFSPROC4_CLNT_CB_SEQUENCE,
 	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
+	NFSPROC4_CLNT_CB_RECALL_ANY,
 };
 
+#define RCA4_TYPE_MASK_RDATA_DLG	0
+#define RCA4_TYPE_MASK_WDATA_DLG	1
+
 /* Returns true iff a is later than b: */
 static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_t *b)
 {
diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
index 547cf07cf4e0..0d39af1b00a0 100644
--- a/fs/nfsd/xdr4cb.h
+++ b/fs/nfsd/xdr4cb.h
@@ -48,3 +48,9 @@
 #define NFS4_dec_cb_offload_sz		(cb_compound_dec_hdr_sz  +      \
 					cb_sequence_dec_sz +            \
 					op_dec_sz)
+#define NFS4_enc_cb_recall_any_sz	(cb_compound_enc_hdr_sz +       \
+					cb_sequence_enc_sz +            \
+					1 + 1 + 1)
+#define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +      \
+					cb_sequence_dec_sz +            \
+					op_dec_sz)
-- 
2.9.5

