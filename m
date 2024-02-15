Return-Path: <linux-nfs+bounces-1966-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF02C856CA2
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 19:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F0E1F2389F
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 18:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9901A1386B1;
	Thu, 15 Feb 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U8UuDisP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2A81386B3
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021622; cv=none; b=XhM6UT3fv9rkf6HMYDS/IbxiXf4/dYr6sfgfWtZnY5A9A+6rX00b7rYDsR4K9FZx3l2G5UlbBJyZv51QsO3vuLs/EgfuCc90xd94QRiGp5SEIO8QEiG/EgWcxAejoJQZFZ0YohmOAZF9s7HP9DMnSpu5Tpw5NS3XNerD+I2Ligw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021622; c=relaxed/simple;
	bh=FwzDvPpwG+WFyMwoPd3gHGL+n2i+3oZ7VGv8P8OmoTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=V6XVbEQDpNjKhzL+16q/7SUjREs6ltI4bT10gTWNuVvuhInUBOYe0F0CgYLgPrUA3zOZfmgoUntHpgI+nuWFwp90sliCmAvOUvPnRuz0CgcIanVWrFk6tNRU7kyXB3euXjsi6T5FEjg0wVxrMxPMcJxauqIptbw7XSQHQpGjS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U8UuDisP; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFSsSU030976;
	Thu, 15 Feb 2024 18:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=0nCMHz7XwHwnmrgpBfK0G7lnjKDLoGRcdV1ke//auXg=;
 b=U8UuDisPTM3Jq0I1cxHeZm+xhuTNxDpm7I5s7ySIWtq38jYd/0TGWsKgjk0chK7JXDhl
 YPpmIdtcc4b1YAruTngOAVo5P6gfsmpLwE29EhTaYnxw9cUsDV46bJgYf+SuhzxYrJOq
 kcbwfwVGcyH2SXq+1JHx0DIZM7HtMEPGHM06vXSWJiuHs0L7PNnKjN4lCY7ZL5WygnIk
 PrUhymr1Cx62iiZyvPaat8N6Ij1AyJmXEMhRhQ/i40ag0iCUJbmWCkpvaPgPo+k+2W6j
 6DpT2PwlOxaXU7U/CCXiW8+s9343vFljVq/s81x0fiWH9J0zE1PvAHHJeirivJcECwax 7A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301jwwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 18:26:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FI2mfm000755;
	Thu, 15 Feb 2024 18:26:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykay7j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 18:26:55 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FIQsmS032173;
	Thu, 15 Feb 2024 18:26:55 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w5ykay7gf-2;
	Thu, 15 Feb 2024 18:26:55 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] NFSD: add supports for CB_GETATTR callback
Date: Thu, 15 Feb 2024 10:26:43 -0800
Message-Id: <1708021604-28321-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708021604-28321-1-git-send-email-dai.ngo@oracle.com>
References: <1708021604-28321-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_17,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150149
X-Proofpoint-GUID: bfeHj3kb7sRWIS8S3cJIcrrwYYx9_e4w
X-Proofpoint-ORIG-GUID: bfeHj3kb7sRWIS8S3cJIcrrwYYx9_e4w
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

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
index 926c29879c6a..30aa241038eb 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -85,7 +85,21 @@ static void encode_uint32(struct xdr_stream *xdr, u32 n)
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
 
 static void encode_nfs_cb_opnum4(struct xdr_stream *xdr, enum nfs_cb_opnum4 op)
@@ -333,6 +347,30 @@ encode_cb_recallany4args(struct xdr_stream *xdr,
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
@@ -468,6 +506,26 @@ static void nfs4_xdr_enc_cb_null(struct rpc_rqst *req, struct xdr_stream *xdr,
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
@@ -523,6 +581,42 @@ static int nfs4_xdr_dec_cb_null(struct rpc_rqst *req, struct xdr_stream *xdr,
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
@@ -831,6 +925,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
 	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
 	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
 	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
+	PROC(CB_GETATTR,	COMPOUND,	cb_getattr,	cb_getattr),
 };
 
 static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 41bdc913fa71..0bbbe57e027d 100644
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
@@ -640,6 +653,7 @@ enum nfsd4_cb_op {
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


