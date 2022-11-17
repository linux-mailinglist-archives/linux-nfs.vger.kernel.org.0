Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D8F62D1D4
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 04:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbiKQDpN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Nov 2022 22:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiKQDpK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Nov 2022 22:45:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FD66BDE3
        for <linux-nfs@vger.kernel.org>; Wed, 16 Nov 2022 19:45:02 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH25RQl004141;
        Thu, 17 Nov 2022 03:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=epNQbk8js5rpTfSM3LY+W+rNDSSYrc8EGcU74isXt1s=;
 b=f0QWopdtAvL9G6lAWRyAJgnSy0ba2IEPsyjAY8KvovjV369nZ2uq2r/9cE0rG2PLKtpY
 Zq16tb38CpqodMLzyelvaWgsSaAJvDdKp70g5/oCJEXypIrMLWnUPOsYa/reJl4km1An
 13jTvXANiWnAM2ZfjM4Wgi0zuo/s4T37/PC+JN+ArSFaCatHouMgDC2ndMUU37FgAsE9
 wp9cnbhNVzBamTjXpQkND/Y2cGS/jRNMc+kotQkwVrohq9PJ3McH/UMy2OdYt6ijz/0a
 zq/hOXVMc6/ErFJg57BZhtJAnPMf46WDqo6OhkfAawfGTai5cLdqbO951PQ0J7Iy+TV3 lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3hdy5t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 03:44:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AH3PGY8016843;
        Thu, 17 Nov 2022 03:44:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kuk1ya277-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 03:44:57 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AH3iuth030624;
        Thu, 17 Nov 2022 03:44:57 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kuk1ya262-3;
        Thu, 17 Nov 2022 03:44:57 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 2/4] NFSD: add support for sending CB_RECALL_ANY
Date:   Wed, 16 Nov 2022 19:44:46 -0800
Message-Id: <1668656688-22507-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
References: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170024
X-Proofpoint-ORIG-GUID: sQqJBk78NniTnx4SjNbsXzIm3HORiDHn
X-Proofpoint-GUID: sQqJBk78NniTnx4SjNbsXzIm3HORiDHn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add XDR encode and decode function for CB_RECALL_ANY.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4callback.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/state.h        |  1 +
 fs/nfsd/xdr4.h         |  5 ++++
 fs/nfsd/xdr4cb.h       |  6 +++++
 4 files changed, 74 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index f0e69edf5f0f..01226e5233cd 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -329,6 +329,25 @@ static void encode_cb_recall4args(struct xdr_stream *xdr,
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
+	struct nfs4_cb_compound_hdr *hdr, struct nfsd4_cb_recall_any *ra)
+{
+	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
+	WARN_ON_ONCE(xdr_stream_encode_u32(xdr, ra->ra_keep) < 0);
+	WARN_ON_ONCE(xdr_stream_encode_uint32_array(xdr,
+		ra->ra_bmval, sizeof(ra->ra_bmval) / sizeof(u32)) < 0);
+	hdr->nops++;
+}
+
+/*
  * CB_SEQUENCE4args
  *
  *	struct CB_SEQUENCE4args {
@@ -482,6 +501,26 @@ static void nfs4_xdr_enc_cb_recall(struct rpc_rqst *req, struct xdr_stream *xdr,
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
+	struct nfsd4_cb_recall_any *ra;
+	struct nfs4_cb_compound_hdr hdr = {
+		.ident = cb->cb_clp->cl_cb_ident,
+		.minorversion = cb->cb_clp->cl_minorversion,
+	};
+
+	ra = container_of(cb, struct nfsd4_cb_recall_any, ra_cb);
+	encode_cb_compound4args(xdr, &hdr);
+	encode_cb_sequence4args(xdr, cb, &hdr);
+	encode_cb_recallany4args(xdr, &hdr, ra);
+	encode_cb_nops(&hdr);
+}
 
 /*
  * NFSv4.0 and NFSv4.1 XDR decode functions
@@ -520,6 +559,28 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *rqstp,
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
@@ -783,6 +844,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
 #endif
 	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
 	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
+	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
 };
 
 static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index e2daef3cc003..6b33cbbe76d3 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -639,6 +639,7 @@ enum nfsd4_cb_op {
 	NFSPROC4_CLNT_CB_OFFLOAD,
 	NFSPROC4_CLNT_CB_SEQUENCE,
 	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
+	NFSPROC4_CLNT_CB_RECALL_ANY,
 };
 
 /* Returns true iff a is later than b: */
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 0eb00105d845..4fd2cf6d1d2d 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -896,5 +896,10 @@ struct nfsd4_operation {
 			union nfsd4_op_u *);
 };
 
+struct nfsd4_cb_recall_any {
+	struct nfsd4_callback	ra_cb;
+	u32			ra_keep;
+	u32			ra_bmval[1];
+};
 
 #endif
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

