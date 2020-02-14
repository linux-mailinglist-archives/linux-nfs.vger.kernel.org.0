Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C442815F883
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 22:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbgBNVMf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 16:12:35 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37673 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388611AbgBNVMf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 16:12:35 -0500
Received: by mail-yw1-f67.google.com with SMTP id l5so4894985ywd.4
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2020 13:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ota7SihxH20GwGjM/+nSRdUD9/bCi0WbGiJXk6qQtsg=;
        b=ZykNWgHGnM8ypie3BR59usDi9joEpTUpFmLF6HdGXM9eS+2tkWWeOMZPmRbZnBNzJM
         wk7+w37O97qhAxOXCsC5grP0Oncyp9ZRFV4gVqZBy3ehxrhCv9+/aCKeOZsF8icBFZY4
         1R06Nrvjet8E+5rQMsNMamZFeGUpr1QA9/rMALKK0hdW4OaEJjkLNOoucJyzEUovXGFn
         SvPLmYW12i8Ig/aO1VJ41W87CmlMdYpXeVim+4NJd+HJ3EG9cOhlZaNRhP3ApGemrVvV
         NF6hHPaV25scvfnINvfmNW9CGCEzu4JoJEO5PIwtm/K7m4vr7hVh+oXT9k3wa5ArWIUt
         J9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ota7SihxH20GwGjM/+nSRdUD9/bCi0WbGiJXk6qQtsg=;
        b=qYknXxfZSIBboJXxg7WQA/7abDIW/dhMbCx25t1+EVnpm2titu1dBOMfv/PTlcZ7V7
         LsVEljDV0yQNJzXKH1KEoYZH3k3oo1rmffjsBzrYpJaLNh6bT5mB5htMpSgptgpyGUa5
         qr356SwqqYESbmVMJpBiWNhocMhiphR20/9y1DMDT291lwlCZ8NU7v8n5zmlhFu6YLlS
         KjW4/9iRAeKcgO2yEfVL++NxDG5WHegad3mDv7dnbJTmNtlMEpb5yikGvgDzN53DRHqR
         pfr+cA7a8SxETTxLfj2fAFfUeeZfJ1ZcvJ8wzpmhnjYzYbe2rBMZKV+bTLRHFhgGg9rZ
         xc3g==
X-Gm-Message-State: APjAAAXh1ENIMK79q58HfIS16xcukJJ4UIHGQ1y4ezBEk+j/0q0tkvjr
        b+Shca7bdTad5BmXfisF2qpeCQs5
X-Google-Smtp-Source: APXvYqx41Q328WaC5NXq5ohYA/0ngq2woI2hoxuWmVziRDwlqoEuvsSsc7/lAS2LI8/osaUmpYYZrg==
X-Received: by 2002:a0d:d1c6:: with SMTP id t189mr3902682ywd.393.1581714753382;
        Fri, 14 Feb 2020 13:12:33 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id z2sm2840636ywb.13.2020.02.14.13.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:12:32 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 4/6] NFS: Add READ_PLUS data segment support
Date:   Fri, 14 Feb 2020 16:12:25 -0500
Message-Id: <20200214211227.407836-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214211227.407836-1-Anna.Schumaker@Netapp.com>
References: <20200214211227.407836-1-Anna.Schumaker@Netapp.com>
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
 fs/nfs/nfs42xdr.c         | 138 ++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4proc.c         |  43 +++++++++++-
 fs/nfs/nfs4xdr.c          |   1 +
 include/linux/nfs4.h      |   2 +-
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |   2 +-
 6 files changed, 182 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index c03f3246d6c5..bf118ecabe2c 100644
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
@@ -446,6 +473,29 @@ static void nfs4_xdr_enc_deallocate(struct rpc_rqst *req,
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
+	req->rq_rcv_buf.flags |= XDRBUF_READ;
+	encode_nops(&hdr);
+}
+
 /*
  * Encode SEEK request
  */
@@ -694,6 +744,67 @@ static int decode_deallocate(struct xdr_stream *xdr, struct nfs42_falloc_res *re
 	return decode_op_hdr(xdr, OP_DEALLOCATE);
 }
 
+static uint32_t decode_read_plus_data(struct xdr_stream *xdr, struct nfs_pgio_res *res,
+				      uint32_t *eof)
+{
+	__be32 *p;
+	uint32_t count, recvd;
+	uint64_t offset;
+
+	p = xdr_inline_decode(xdr, 8 + 4);
+	if (unlikely(!p))
+		return -EIO;
+
+	p = xdr_decode_hyper(p, &offset);
+	count = be32_to_cpup(p);
+	if (count == 0)
+		return 0;
+
+	recvd = xdr_read_pages(xdr, count);
+	if (count > recvd) {
+		dprintk("NFS: server cheating in read reply: "
+				"count %u > recvd %u\n", count, recvd);
+		count = recvd;
+		*eof = 0;
+	}
+
+	return count;
+}
+
+static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
+{
+	__be32 *p;
+	uint32_t count, eof, segments, type;
+	int status;
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
+		return 0;
+
+	p = xdr_inline_decode(xdr, 4);
+	if (unlikely(!p))
+		return -EIO;
+
+	type = be32_to_cpup(p++);
+	if (type == NFS4_CONTENT_DATA)
+		count = decode_read_plus_data(xdr, res, &eof);
+	else
+		return -EINVAL;
+
+	res->eof = eof;
+	res->count = count;
+	return 0;
+}
+
 static int decode_seek(struct xdr_stream *xdr, struct nfs42_seek_res *res)
 {
 	int status;
@@ -870,6 +981,33 @@ static int nfs4_xdr_dec_deallocate(struct rpc_rqst *rqstp,
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
index 95d07a3dc5d1..ed3ec8c36273 100644
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
@@ -5199,28 +5203,60 @@ static bool nfs4_read_stateid_changed(struct rpc_task *task,
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
 
@@ -9970,7 +10006,8 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
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
index 47817ef0aadb..68b2917d0537 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7584,6 +7584,7 @@ const struct rpc_procinfo nfs4_procedures[] = {
 	PROC42(COPY_NOTIFY,	enc_copy_notify,	dec_copy_notify),
 	PROC(LOOKUPP,		enc_lookupp,		dec_lookupp),
 	PROC42(LAYOUTERROR,	enc_layouterror,	dec_layouterror),
+	PROC42(READ_PLUS,	enc_read_plus,		dec_read_plus),
 };
 
 static unsigned int nfs_version4_counts[ARRAY_SIZE(nfs4_procedures)];
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 82d8fb422092..c1eeef52545c 100644
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
index 94c77ed55ce1..8efbf3d8b263 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -655,7 +655,7 @@ struct nfs_pgio_args {
 struct nfs_pgio_res {
 	struct nfs4_sequence_res	seq_res;
 	struct nfs_fattr *	fattr;
-	__u32			count;
+	__u64			count;
 	__u32			op_status;
 	union {
 		struct {
-- 
2.25.0

