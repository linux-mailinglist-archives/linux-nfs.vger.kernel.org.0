Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD6179EBEE
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Sep 2023 17:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbjIMPCU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Sep 2023 11:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjIMPCU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Sep 2023 11:02:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4B9B7
        for <linux-nfs@vger.kernel.org>; Wed, 13 Sep 2023 08:02:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DEkL1K032128;
        Wed, 13 Sep 2023 15:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=FW9n/DEaFA9orw0UuTEHMghxnaKUiHsRvGNYKURSAp0=;
 b=GWF7xro3eCtZ1l6ni9184bkRsH4mH59lHz1dhfEEsumdrF52UBV0J/TxERRtzlDKGjtM
 63Wr3PKUSu0kyJVVI6TCqPrvOFwUVygFjd+kRcdkqoL1pryr0UFpY4pHaCVILEqX318V
 uSFLz7+nicSEclF/EYhsJGgE9IUXCSv6PTDHCyPN5NLHe3b6IDEDa9CJ5dfaE/4IwESW
 Cuc/VVoXQDhAE/f90vbBF/Q1mWGIR3rd+h2h1ANBqP3XEuLLKo92sfSPhyB7N8nQkOuy
 TVSrCW0p7KZBURWrpOHUZMyWPeuANamiYhcXk6E6sYMSAbuOLneSt212WEbmNM/vUTOv lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7mt92y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 15:02:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DEVZwx032903;
        Wed, 13 Sep 2023 15:02:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkgn1dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 15:02:11 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DF21QP037651;
        Wed, 13 Sep 2023 15:02:10 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3t0wkgn1bk-2;
        Wed, 13 Sep 2023 15:02:10 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSD: add supports for CB_GETATTR callback
Date:   Wed, 13 Sep 2023 08:01:58 -0700
Message-Id: <1694617319-27455-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1694617319-27455-1-git-send-email-dai.ngo@oracle.com>
References: <1694617319-27455-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130123
X-Proofpoint-ORIG-GUID: thU0wFAKUryx1aqtOqWE2QXnn8mRVT31
X-Proofpoint-GUID: thU0wFAKUryx1aqtOqWE2QXnn8mRVT31
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Includes:
   . CB_GETATTR proc for nfs4_cb_procedures[]
   . XDR encoding and decoding function for CB_GETATTR request/reply
   . add nfs4_cb_fattr to nfs4_delegation for sending CB_GETATTR
     and store file attributes from client's reply.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4callback.c | 97 +++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/state.h        | 14 ++++++
 fs/nfsd/xdr4cb.h       | 18 ++++++++
 3 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 4039ffcf90ba..92bc109dabe6 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -84,7 +84,21 @@ static void encode_uint32(struct xdr_stream *xdr, u32 n)
 static void encode_bitmap4(struct xdr_stream *xdr, const __u32 *bitmap,
 			   size_t len)
 {
-	WARN_ON_ONCE(xdr_stream_encode_uint32_array(xdr, bitmap, len) < 0);
+	xdr_stream_encode_uint32_array(xdr, bitmap, len);
+}
+
+static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
+				struct nfs4_cb_fattr *fattr)
+{
+	fattr->ncf_cb_change = 0;
+	fattr->ncf_cb_fsize = 0;
+	if (bitmap[0] & FATTR4_WORD0_CHANGE)
+		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_change) < 0)
+			return -NFSERR_BAD_XDR;
+	if (bitmap[0] & FATTR4_WORD0_SIZE)
+		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_fsize) < 0)
+			return -NFSERR_BAD_XDR;
+	return 0;
 }
 
 /*
@@ -357,6 +371,30 @@ encode_cb_recallany4args(struct xdr_stream *xdr,
 	hdr->nops++;
 }
 
+/*
+ * CB_GETATTR4args
+ *	struct CB_GETATTR4args {
+ *	   nfs_fh4 fh;
+ *	   bitmap4 attr_request;
+ *	};
+ *
+ * The size and change attributes are the only one
+ * guaranteed to be serviced by the client.
+ */
+static void
+encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
+			struct nfs4_cb_fattr *fattr)
+{
+	struct nfs4_delegation *dp =
+		container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
+	struct knfsd_fh *fh = &dp->dl_stid.sc_file->fi_fhandle;
+
+	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
+	encode_nfs_fh4(xdr, fh);
+	encode_bitmap4(xdr, fattr->ncf_cb_bmap, ARRAY_SIZE(fattr->ncf_cb_bmap));
+	hdr->nops++;
+}
+
 /*
  * CB_SEQUENCE4args
  *
@@ -492,6 +530,26 @@ static void nfs4_xdr_enc_cb_null(struct rpc_rqst *req, struct xdr_stream *xdr,
 	xdr_reserve_space(xdr, 0);
 }
 
+/*
+ * 20.1.  Operation 3: CB_GETATTR - Get Attributes
+ */
+static void nfs4_xdr_enc_cb_getattr(struct rpc_rqst *req,
+		struct xdr_stream *xdr, const void *data)
+{
+	const struct nfsd4_callback *cb = data;
+	struct nfs4_cb_fattr *ncf =
+		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
+	struct nfs4_cb_compound_hdr hdr = {
+		.ident = cb->cb_clp->cl_cb_ident,
+		.minorversion = cb->cb_clp->cl_minorversion,
+	};
+
+	encode_cb_compound4args(xdr, &hdr);
+	encode_cb_sequence4args(xdr, cb, &hdr);
+	encode_cb_getattr4args(xdr, &hdr, ncf);
+	encode_cb_nops(&hdr);
+}
+
 /*
  * 20.2. Operation 4: CB_RECALL - Recall a Delegation
  */
@@ -547,6 +605,42 @@ static int nfs4_xdr_dec_cb_null(struct rpc_rqst *req, struct xdr_stream *xdr,
 	return 0;
 }
 
+/*
+ * 20.1.  Operation 3: CB_GETATTR - Get Attributes
+ */
+static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
+				  struct xdr_stream *xdr,
+				  void *data)
+{
+	struct nfsd4_callback *cb = data;
+	struct nfs4_cb_compound_hdr hdr;
+	int status;
+	u32 bitmap[3] = {0};
+	u32 attrlen;
+	struct nfs4_cb_fattr *ncf =
+		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
+
+	status = decode_cb_compound4res(xdr, &hdr);
+	if (unlikely(status))
+		return status;
+
+	status = decode_cb_sequence4res(xdr, cb);
+	if (unlikely(status || cb->cb_seq_status))
+		return status;
+
+	status = decode_cb_op_status(xdr, OP_CB_GETATTR, &cb->cb_status);
+	if (status)
+		return status;
+	if (xdr_stream_decode_uint32_array(xdr, bitmap, 3) < 0)
+		return -NFSERR_BAD_XDR;
+	if (xdr_stream_decode_u32(xdr, &attrlen) < 0)
+		return -NFSERR_BAD_XDR;
+	if (attrlen > (sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsize)))
+		return -NFSERR_BAD_XDR;
+	status = decode_cb_fattr4(xdr, bitmap, ncf);
+	return status;
+}
+
 /*
  * 20.2. Operation 4: CB_RECALL - Recall a Delegation
  */
@@ -855,6 +949,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
 	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
 	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
 	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
+	PROC(CB_GETATTR,	COMPOUND,	cb_getattr,	cb_getattr),
 };
 
 static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index cbddcf484dba..82718d42f3b2 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -117,6 +117,16 @@ struct nfs4_cpntf_state {
 	time64_t		cpntf_time;	/* last time stateid used */
 };
 
+struct nfs4_cb_fattr {
+	struct nfsd4_callback ncf_getattr;
+	u32 ncf_cb_status;
+	u32 ncf_cb_bmap[1];
+
+	/* from CB_GETATTR reply */
+	u64 ncf_cb_change;
+	u64 ncf_cb_fsize;
+};
+
 /*
  * Represents a delegation stateid. The nfs4_client holds references to these
  * and they are put when it is being destroyed or when the delegation is
@@ -150,6 +160,9 @@ struct nfs4_delegation {
 	int			dl_retries;
 	struct nfsd4_callback	dl_recall;
 	bool			dl_recalled;
+
+	/* for CB_GETATTR */
+	struct nfs4_cb_fattr    dl_cb_fattr;
 };
 
 #define cb_to_delegation(cb) \
@@ -642,6 +655,7 @@ enum nfsd4_cb_op {
 	NFSPROC4_CLNT_CB_SEQUENCE,
 	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
 	NFSPROC4_CLNT_CB_RECALL_ANY,
+	NFSPROC4_CLNT_CB_GETATTR,
 };
 
 /* Returns true iff a is later than b: */
diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
index 0d39af1b00a0..e8b00309c449 100644
--- a/fs/nfsd/xdr4cb.h
+++ b/fs/nfsd/xdr4cb.h
@@ -54,3 +54,21 @@
 #define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +      \
 					cb_sequence_dec_sz +            \
 					op_dec_sz)
+
+/*
+ * 1: CB_GETATTR opcode (32-bit)
+ * N: file_handle
+ * 1: number of entry in attribute array (32-bit)
+ * 1: entry 0 in attribute array (32-bit)
+ */
+#define NFS4_enc_cb_getattr_sz		(cb_compound_enc_hdr_sz +       \
+					cb_sequence_enc_sz +            \
+					1 + enc_nfs4_fh_sz + 1 + 1)
+/*
+ * 4: fattr_bitmap_maxsz
+ * 1: attribute array len
+ * 2: change attr (64-bit)
+ * 2: size (64-bit)
+ */
+#define NFS4_dec_cb_getattr_sz		(cb_compound_dec_hdr_sz  +      \
+			cb_sequence_dec_sz + 4 + 1 + 2 + 2 + op_dec_sz)
-- 
2.39.3

