Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD98246D5D
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388246AbgHQQy1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 12:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388918AbgHQQxs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 12:53:48 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7720C06134E
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:33 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s1so5195442iot.10
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l+ZGO2nOKVIaedpt0/2dNjU3KSqG+FvsHd7B5cxb/64=;
        b=Po5yALYHMWbphOJTxIoojx9cm+Crb21vlE9A4VZF5qfhZ+eKB8fy2VUdB131cBkq3f
         7MFq7yU65I9GbgEErMNUhrDs6gxuW2Tl36ZTybCeYa/2Wa4qR8tV0n9BJf4aRpHUVxtm
         wB5FjbiuMroA8WyNfNwYb+pGmw1Dpj/4MsgfMkYQGOH9Jp5HTit0P2Dzl9M3PnMoKx3E
         doh3ysj/oUmTB1jyKJ15Ie6VQN5sOCUAygH7E1atJ/FJPmHS7nOAabcBNOi+Xr/rzRMm
         vGS0tnThwPApADDKgoufdEofaiYHZ64R1TAYLK1smQ4qaYF6X8OFXBipvxjyxDt5ngkQ
         Jzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=l+ZGO2nOKVIaedpt0/2dNjU3KSqG+FvsHd7B5cxb/64=;
        b=jXxYjt/MAqJa08bEaKfxh8yM2hyBCZrgleCbiQzAHktcQwu0/dp0l/A59Mn9agxNvW
         /Qvv/FW7+m/+gs6iLTCorg4A6oBqsvtHCr41azEIMUc+4vfWk4yms8tDRcISPG1YAyIy
         maaVHhT7Z9djNK82lvEXDC3V3q9/zXe5qeL+YNfRgjm+gKxI1LNo+iJW/q9miBPZ4DsR
         rGt9cx3G11qocbdH4G+dkJbZmCdhvbBePbwsNGqo7QW7eEJw9i/iTsBgKA/ErYZMMFwJ
         0vYyscK9wRimuMp0TIWZZgjRIivTGSUpYjIbLUv2nMk17MyMweGgEFLLvZDRwya3LMGb
         xQ7g==
X-Gm-Message-State: AOAM5303SiR+6kDjfm0Y1AHusVn0l+LhijrutCKIkA1dqfotaMsiG0ZX
        jn7qIFjTPl19vkwhQO5VatXBYJFLR3s=
X-Google-Smtp-Source: ABdhPJyHr7esTL58DPBRuzBiUqWTEmTY5mWFtKEhiqKXbbgvuw6MQyvKV9EjTIvzZ/CxvHpuYyQ0yQ==
X-Received: by 2002:a05:6638:2595:: with SMTP id s21mr15124991jat.12.1597683212702;
        Mon, 17 Aug 2020 09:53:32 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id a16sm7413106ilc.7.2020.08.17.09.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:53:32 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 04/10] NFS: Add READ_PLUS data segment support
Date:   Mon, 17 Aug 2020 12:53:21 -0400
Message-Id: <20200817165327.354181-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817165327.354181-1-Anna.Schumaker@Netapp.com>
References: <20200817165327.354181-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This patch adds client support for decoding a single NFS4_CONTENT_DATA
segment returned by the server. This is the simplest implementation
possible, since it does not account for any hole segments in the reply.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c         | 141 ++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4proc.c         |  43 +++++++++++-
 fs/nfs/nfs4xdr.c          |   1 +
 include/linux/nfs4.h      |   2 +-
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |   2 +-
 6 files changed, 185 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index c03f3246d6c5..055a944d043d 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -45,6 +45,15 @@
 #define encode_deallocate_maxsz		(op_encode_hdr_maxsz + \
 					 encode_fallocate_maxsz)
 #define decode_deallocate_maxsz		(op_decode_hdr_maxsz)
+#define encode_read_plus_maxsz		(op_encode_hdr_maxsz + \
+					 encode_stateid_maxsz + 3)
+#define NFS42_READ_PLUS_SEGMENT_SIZE	(1 /* data_content4 */ + \
+					 2 /* data_info4.di_offset */ + \
+					 2 /* data_info4.di_length */)
+#define decode_read_plus_maxsz		(op_decode_hdr_maxsz + \
+					 1 /* rpr_eof */ + \
+					 1 /* rpr_contents count */ + \
+					 NFS42_READ_PLUS_SEGMENT_SIZE)
 #define encode_seek_maxsz		(op_encode_hdr_maxsz + \
 					 encode_stateid_maxsz + \
 					 2 /* offset */ + \
@@ -128,6 +137,14 @@
 					 decode_putfh_maxsz + \
 					 decode_deallocate_maxsz + \
 					 decode_getattr_maxsz)
+#define NFS4_enc_read_plus_sz		(compound_encode_hdr_maxsz + \
+					 encode_sequence_maxsz + \
+					 encode_putfh_maxsz + \
+					 encode_read_plus_maxsz)
+#define NFS4_dec_read_plus_sz		(compound_decode_hdr_maxsz + \
+					 decode_sequence_maxsz + \
+					 decode_putfh_maxsz + \
+					 decode_read_plus_maxsz)
 #define NFS4_enc_seek_sz		(compound_encode_hdr_maxsz + \
 					 encode_sequence_maxsz + \
 					 encode_putfh_maxsz + \
@@ -252,6 +269,16 @@ static void encode_deallocate(struct xdr_stream *xdr,
 	encode_fallocate(xdr, args);
 }
 
+static void encode_read_plus(struct xdr_stream *xdr,
+			     const struct nfs_pgio_args *args,
+			     struct compound_hdr *hdr)
+{
+	encode_op_hdr(xdr, OP_READ_PLUS, decode_read_plus_maxsz, hdr);
+	encode_nfs4_stateid(xdr, &args->stateid);
+	encode_uint64(xdr, args->offset);
+	encode_uint32(xdr, args->count);
+}
+
 static void encode_seek(struct xdr_stream *xdr,
 			const struct nfs42_seek_args *args,
 			struct compound_hdr *hdr)
@@ -446,6 +473,28 @@ static void nfs4_xdr_enc_deallocate(struct rpc_rqst *req,
 	encode_nops(&hdr);
 }
 
+/*
+ * Encode READ_PLUS request
+ */
+static void nfs4_xdr_enc_read_plus(struct rpc_rqst *req,
+				   struct xdr_stream *xdr,
+				   const void *data)
+{
+	const struct nfs_pgio_args *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	encode_read_plus(xdr, args, &hdr);
+
+	rpc_prepare_reply_pages(req, args->pages, args->pgbase,
+				args->count, hdr.replen);
+	encode_nops(&hdr);
+}
+
 /*
  * Encode SEEK request
  */
@@ -694,6 +743,71 @@ static int decode_deallocate(struct xdr_stream *xdr, struct nfs42_falloc_res *re
 	return decode_op_hdr(xdr, OP_DEALLOCATE);
 }
 
+static int decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_res *res,
+				 uint32_t *eof)
+{
+	uint32_t count, recvd;
+	uint64_t offset;
+	__be32 *p;
+
+	p = xdr_inline_decode(xdr, 8 + 4);
+	if (unlikely(!p))
+		return -EIO;
+
+	p = xdr_decode_hyper(p, &offset);
+	count = be32_to_cpup(p);
+	recvd = xdr_read_pages(xdr, count);
+	res->count += recvd;
+
+	if (count > recvd) {
+		dprintk("NFS: server cheating in read reply: "
+				"count %u > recvd %u\n", count, recvd);
+		*eof = 0;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
+{
+	uint32_t eof, segments, type;
+	int status;
+	__be32 *p;
+
+	status = decode_op_hdr(xdr, OP_READ_PLUS);
+	if (status)
+		return status;
+
+	p = xdr_inline_decode(xdr, 4 + 4);
+	if (unlikely(!p))
+		return -EIO;
+
+	eof = be32_to_cpup(p++);
+	segments = be32_to_cpup(p++);
+	if (segments == 0)
+		goto out;
+
+	p = xdr_inline_decode(xdr, 4);
+	if (unlikely(!p))
+		return -EIO;
+
+	type = be32_to_cpup(p++);
+	if (type == NFS4_CONTENT_DATA)
+		status = decode_read_plus_data(xdr, res, &eof);
+	else
+		return -EINVAL;
+
+	if (status)
+		return status;
+	if (segments > 1)
+		eof = 0;
+
+out:
+	res->eof = eof;
+	return 0;
+}
+
 static int decode_seek(struct xdr_stream *xdr, struct nfs42_seek_res *res)
 {
 	int status;
@@ -870,6 +984,33 @@ static int nfs4_xdr_dec_deallocate(struct rpc_rqst *rqstp,
 	return status;
 }
 
+/*
+ * Decode READ_PLUS request
+ */
+static int nfs4_xdr_dec_read_plus(struct rpc_rqst *rqstp,
+				  struct xdr_stream *xdr,
+				  void *data)
+{
+	struct nfs_pgio_res *res = data;
+	struct compound_hdr hdr;
+	int status;
+
+	status = decode_compound_hdr(xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_sequence(xdr, &res->seq_res, rqstp);
+	if (status)
+		goto out;
+	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+	status = decode_read_plus(xdr, res);
+	if (!status)
+		status = res->count;
+out:
+	return status;
+}
+
 /*
  * Decode SEEK request
  */
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2e2dac29a9e9..509198eb968e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -69,6 +69,10 @@
 
 #include "nfs4trace.h"
 
+#ifdef CONFIG_NFS_V4_2
+#include "nfs42.h"
+#endif /* CONFIG_NFS_V4_2 */
+
 #define NFSDBG_FACILITY		NFSDBG_PROC
 
 #define NFS4_BITMASK_SZ		3
@@ -5226,28 +5230,60 @@ static bool nfs4_read_stateid_changed(struct rpc_task *task,
 	return true;
 }
 
+static bool nfs4_read_plus_not_supported(struct rpc_task *task,
+					 struct nfs_pgio_header *hdr)
+{
+	struct nfs_server *server = NFS_SERVER(hdr->inode);
+	struct rpc_message *msg = &task->tk_msg;
+
+	if (msg->rpc_proc == &nfs4_procedures[NFSPROC4_CLNT_READ_PLUS] &&
+	    server->caps & NFS_CAP_READ_PLUS && task->tk_status == -ENOTSUPP) {
+		server->caps &= ~NFS_CAP_READ_PLUS;
+		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
+		rpc_restart_call_prepare(task);
+		return true;
+	}
+	return false;
+}
+
 static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 {
-
 	dprintk("--> %s\n", __func__);
 
 	if (!nfs4_sequence_done(task, &hdr->res.seq_res))
 		return -EAGAIN;
 	if (nfs4_read_stateid_changed(task, &hdr->args))
 		return -EAGAIN;
+	if (nfs4_read_plus_not_supported(task, hdr))
+		return -EAGAIN;
 	if (task->tk_status > 0)
 		nfs_invalidate_atime(hdr->inode);
 	return hdr->pgio_done_cb ? hdr->pgio_done_cb(task, hdr) :
 				    nfs4_read_done_cb(task, hdr);
 }
 
+#ifdef CONFIG_NFS_V4_2
+static void nfs42_read_plus_support(struct nfs_server *server, struct rpc_message *msg)
+{
+	if (server->caps & NFS_CAP_READ_PLUS)
+		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ_PLUS];
+	else
+		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
+}
+#else
+static void nfs42_read_plus_support(struct nfs_server *server, struct rpc_message *msg)
+{
+	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
+}
+#endif /* CONFIG_NFS_V4_2 */
+
 static void nfs4_proc_read_setup(struct nfs_pgio_header *hdr,
 				 struct rpc_message *msg)
 {
 	hdr->timestamp   = jiffies;
 	if (!hdr->pgio_done_cb)
 		hdr->pgio_done_cb = nfs4_read_done_cb;
-	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
+	nfs42_read_plus_support(NFS_SERVER(hdr->inode), msg);
 	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
 }
 
@@ -10006,7 +10042,8 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
 		| NFS_CAP_SEEK
 		| NFS_CAP_LAYOUTSTATS
 		| NFS_CAP_CLONE
-		| NFS_CAP_LAYOUTERROR,
+		| NFS_CAP_LAYOUTERROR
+		| NFS_CAP_READ_PLUS,
 	.init_client = nfs41_init_client,
 	.shutdown_client = nfs41_shutdown_client,
 	.match_stateid = nfs41_match_stateid,
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 6742646d4feb..80d9d55a48c2 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7580,6 +7580,7 @@ const struct rpc_procinfo nfs4_procedures[] = {
 	PROC42(COPY_NOTIFY,	enc_copy_notify,	dec_copy_notify),
 	PROC(LOOKUPP,		enc_lookupp,		dec_lookupp),
 	PROC42(LAYOUTERROR,	enc_layouterror,	dec_layouterror),
+	PROC42(READ_PLUS,	enc_read_plus,		dec_read_plus),
 };
 
 static unsigned int nfs_version4_counts[ARRAY_SIZE(nfs4_procedures)];
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 4dba3c948932..4bf75b56758c 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -540,8 +540,8 @@ enum {
 
 	NFSPROC4_CLNT_LOOKUPP,
 	NFSPROC4_CLNT_LAYOUTERROR,
-
 	NFSPROC4_CLNT_COPY_NOTIFY,
+	NFSPROC4_CLNT_READ_PLUS,
 };
 
 /* nfs41 types */
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 465fa98258a3..11248c5a7b24 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -281,5 +281,6 @@ struct nfs_server {
 #define NFS_CAP_OFFLOAD_CANCEL	(1U << 25)
 #define NFS_CAP_LAYOUTERROR	(1U << 26)
 #define NFS_CAP_COPY_NOTIFY	(1U << 27)
+#define NFS_CAP_READ_PLUS	(1U << 28)
 
 #endif
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 5fd0a9ef425f..6da54d010421 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -656,7 +656,7 @@ struct nfs_pgio_args {
 struct nfs_pgio_res {
 	struct nfs4_sequence_res	seq_res;
 	struct nfs_fattr *	fattr;
-	__u32			count;
+	__u64			count;
 	__u32			op_status;
 	union {
 		struct {
-- 
2.28.0

