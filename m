Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C050664BA2
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 19:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjAJSw6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 13:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239744AbjAJSwL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 13:52:11 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4C15564E
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 10:46:47 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id r132so300393oif.10
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 10:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AlYrDztWoz+DugdjOPeyxvgVHMdNdoGweZrVqz/ioo=;
        b=nHnvBfD9OeKTy9vYno++wSKbYhrJiBbe6DQ5i+NEeX5BstOROIEwKmcrK6lW8dzBTV
         O5JrGHxvsL8Mrro7GJZe1OnyF0nIaKfB7h/fCz1QhcnHro4mZlq5aIBMoKW/bWpXELww
         osS4xH5np0SVeJ7jXExc1Qyg2Iqt4cv3X1MSMAj0GQbBykYqkiKK8OTK2LCkV5te9U6d
         Lop6WpxFA9CNZOJm72neaWuMoPJYlsf6JmTaPeLo0KPMd9sZIocqun9K/TFEIAlCU2sp
         GCJ8FHIvS1s+IA9AB4Vfnzn5FYBeSI8az+3QkFmQi5pl58fnUH6GvhsfDVSo173oE6Rz
         JwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AlYrDztWoz+DugdjOPeyxvgVHMdNdoGweZrVqz/ioo=;
        b=0hW6Val5Z4uY8Hto/AcdNg/VXgLa7QzgdnB7j53PPdsxzorUOSvwtI3yXHdIyL+AcN
         NC2bQEnssu6NeSrbh4va0NGqY+sKl/LAkfo4NCaThjRebO4AKjWD7FsFYJSsKMrTw660
         VPoIgXdOUKG/kp/0hTVaDNiuzQxwDzTpSelyzPOZCjTsBKAuCWgdkeJ+X3hBh3U7WVtj
         cM/pKY/Tr8Pxi+RjVJ03QpiUoYz6VkJYH4jRDpXi0tlBW9RISu7xxmpPXCz0oo06cTTi
         xy3Kl4z8LEwtKf9CRe1jfDW8jAjHZqmF4HEAbKcUVCuKbyapAlwZNrdE6XGY4iHplCQk
         MPNw==
X-Gm-Message-State: AFqh2koq8EBmXXm9gGLeNIgdcReqGx6UxDLQFEoL8pLpOeCma9FQHhGf
        kx1OhWdEOXOlcCNFqdO1Iau5C/VkPIE=
X-Google-Smtp-Source: AMrXdXvs5qRGxGnmH+S6BcVyMFLNy4UtsX5HLqbo9y7+alFhnojt9nIID6SiSEO/zN2Z8kKCJnjkRg==
X-Received: by 2002:a05:6808:a06:b0:355:1de9:6524 with SMTP id n6-20020a0568080a0600b003551de96524mr38316251oij.6.1673376405866;
        Tue, 10 Jan 2023 10:46:45 -0800 (PST)
Received: from localhost.localdomain (cpe-24-28-172-218.elp.res.rr.com. [24.28.172.218])
        by smtp.gmail.com with ESMTPSA id t11-20020a9d590b000000b00677714a440fsm6438775oth.81.2023.01.10.10.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:46:45 -0800 (PST)
From:   Jorge Mora <jmora1300@gmail.com>
X-Google-Original-From: Jorge Mora <mora@netapp.com>
To:     linux-nfs@vger.kernel.org
Cc:     trond.myklebust@hammerspace.com, Anna.Schumaker@netapp.com
Subject: [PATCH v1 1/2] NFS: add IO_ADVISE operation
Date:   Tue, 10 Jan 2023 11:46:40 -0700
Message-Id: <20230110184641.13334-2-mora@netapp.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230110184641.13334-1-mora@netapp.com>
References: <20230110184641.13334-1-mora@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Adds support for using the NFS v4.2 operation IO_ADVISE to
send client I/O access pattern hints to the server.

There is a one-to-one correspondence between the advice
(POSIX_FADV_*) given in fadvise64() and the bitmap mask sent
to the server. Any other advice given results in just
calling generic_fadvise().

The bitmap mask given by the server reply is just ignored
since the fadvise64() returns 0 on success. If server
replies with more than one bitmap word, only the first word
is stored on the nfs42_io_advise_res struct and all other
words are ignored.

Signed-off-by: Jorge Mora <mora@netapp.com>
---
 fs/nfs/nfs42.h            |  1 +
 fs/nfs/nfs42proc.c        | 67 +++++++++++++++++++++++++++++++
 fs/nfs/nfs42xdr.c         | 84 +++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4file.c         | 37 +++++++++++++++++
 fs/nfs/nfs4proc.c         |  1 +
 fs/nfs/nfs4xdr.c          |  1 +
 include/linux/nfs4.h      |  1 +
 include/linux/nfs_fs_sb.h |  1 +
 include/linux/nfs_xdr.h   | 28 +++++++++++++
 9 files changed, 221 insertions(+)

diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index 0fe5aacbcfdf..c3e9fcd54c72 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -20,6 +20,7 @@ int nfs42_proc_allocate(struct file *, loff_t, loff_t);
 ssize_t nfs42_proc_copy(struct file *, loff_t, struct file *, loff_t, size_t,
 			struct nl4_server *, nfs4_stateid *, bool);
 int nfs42_proc_deallocate(struct file *, loff_t, loff_t);
+int nfs42_proc_io_advise(struct file *, loff_t, u64, u32);
 loff_t nfs42_proc_llseek(struct file *, loff_t, int);
 int nfs42_proc_layoutstats_generic(struct nfs_server *,
 				   struct nfs42_layoutstat_data *);
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index ecb428512fe1..af40f705386a 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -172,6 +172,73 @@ int nfs42_proc_deallocate(struct file *filep, loff_t offset, loff_t len)
 	return err;
 }
 
+static loff_t _nfs42_proc_io_advise(struct file *filep,
+		struct nfs_lock_context *lock, loff_t offset,
+		u64 count, u32 hints)
+{
+	struct inode *inode = file_inode(filep);
+	struct nfs42_io_advise_args args = {
+		.fh	= NFS_FH(inode),
+		.offset	= offset,
+		.count	= count,
+		.hints	= hints,
+	};
+	struct nfs42_io_advise_res res;
+	struct rpc_message msg = {
+		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_IO_ADVISE],
+		.rpc_argp = &args,
+		.rpc_resp = &res,
+	};
+	struct nfs_server *server = NFS_SERVER(inode);
+	int status;
+
+	if (!nfs_server_capable(inode, NFS_CAP_IO_ADVISE))
+		return -ENOTSUPP;
+
+	status = nfs4_set_rw_stateid(&args.stateid, lock->open_context,
+			lock, FMODE_READ);
+	if (status) {
+		if (status == -EAGAIN)
+			status = -NFS4ERR_BAD_STATEID;
+		return status;
+	}
+
+	status = nfs4_call_sync(server->client, server, &msg,
+				&args.seq_args, &res.seq_res, 0);
+	if (status == -ENOTSUPP)
+		server->caps &= ~NFS_CAP_IO_ADVISE;
+	return status;
+}
+
+int nfs42_proc_io_advise(struct file *filep, loff_t offset, u64 count, u32 hints)
+{
+	struct nfs_server *server = NFS_SERVER(file_inode(filep));
+	struct nfs4_exception exception = { };
+	struct nfs_lock_context *lock;
+	loff_t err;
+
+	lock = nfs_get_lock_context(nfs_file_open_context(filep));
+	if (IS_ERR(lock))
+		return PTR_ERR(lock);
+
+	exception.inode = file_inode(filep);
+	exception.state = lock->open_context->state;
+
+	do {
+		err = _nfs42_proc_io_advise(filep, lock, offset, count, hints);
+		if (err >= 0)
+			break;
+		if (err == -ENOTSUPP) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+		err = nfs4_handle_exception(server, err, &exception);
+	} while (exception.retry);
+
+	nfs_put_lock_context(lock);
+	return err;
+}
+
 static int handle_async_copy(struct nfs42_copy_res *res,
 			     struct nfs_server *dst_server,
 			     struct nfs_server *src_server,
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index d80ee88ca996..1e30729b0ed5 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -45,6 +45,14 @@
 #define encode_deallocate_maxsz		(op_encode_hdr_maxsz + \
 					 encode_fallocate_maxsz)
 #define decode_deallocate_maxsz		(op_decode_hdr_maxsz)
+#define nfs42_io_advise_bitmap_maxsz	2 /* bitmap length and hints mask */
+#define encode_io_advise_maxsz		(op_encode_hdr_maxsz + \
+					 encode_stateid_maxsz + \
+					 2 /* offset */ + \
+					 2 /* count */  + \
+					 nfs42_io_advise_bitmap_maxsz /* hints */)
+#define decode_io_advise_maxsz		(op_decode_hdr_maxsz + \
+					 nfs42_io_advise_bitmap_maxsz /* hints */)
 #define encode_read_plus_maxsz		(op_encode_hdr_maxsz + \
 					 encode_stateid_maxsz + 3)
 #define NFS42_READ_PLUS_DATA_SEGMENT_SIZE \
@@ -138,6 +146,14 @@
 					 decode_putfh_maxsz + \
 					 decode_deallocate_maxsz + \
 					 decode_getattr_maxsz)
+#define NFS4_enc_io_advise_sz		(compound_encode_hdr_maxsz + \
+					 encode_sequence_maxsz + \
+					 encode_putfh_maxsz + \
+					 encode_io_advise_maxsz)
+#define NFS4_dec_io_advise_sz		(compound_decode_hdr_maxsz + \
+					 decode_sequence_maxsz + \
+					 decode_putfh_maxsz + \
+					 decode_io_advise_maxsz)
 #define NFS4_enc_read_plus_sz		(compound_encode_hdr_maxsz + \
 					 encode_sequence_maxsz + \
 					 encode_putfh_maxsz + \
@@ -342,6 +358,17 @@ static void encode_deallocate(struct xdr_stream *xdr,
 	encode_fallocate(xdr, args);
 }
 
+static void encode_io_advise(struct xdr_stream *xdr,
+			const struct nfs42_io_advise_args *args,
+			struct compound_hdr *hdr)
+{
+	encode_op_hdr(xdr, OP_IO_ADVISE, decode_io_advise_maxsz, hdr);
+	encode_nfs4_stateid(xdr, &args->stateid);
+	encode_uint64(xdr, args->offset);
+	encode_uint64(xdr, args->count);
+	xdr_encode_bitmap4(xdr, &args->hints, 1);
+}
+
 static void encode_read_plus(struct xdr_stream *xdr,
 			     const struct nfs_pgio_args *args,
 			     struct compound_hdr *hdr)
@@ -764,6 +791,25 @@ static void nfs4_xdr_enc_deallocate(struct rpc_rqst *req,
 	encode_nops(&hdr);
 }
 
+/*
+ * Encode IO_ADVISE request
+ */
+static void nfs4_xdr_enc_io_advise(struct rpc_rqst *req,
+				   struct xdr_stream *xdr,
+				   const void *data)
+{
+	const struct nfs42_io_advise_args *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	encode_io_advise(xdr, args, &hdr);
+	encode_nops(&hdr);
+}
+
 /*
  * Encode READ_PLUS request
  */
@@ -1034,6 +1080,19 @@ static int decode_deallocate(struct xdr_stream *xdr, struct nfs42_falloc_res *re
 	return decode_op_hdr(xdr, OP_DEALLOCATE);
 }
 
+static int decode_io_advise(struct xdr_stream *xdr, struct nfs42_io_advise_res *res)
+{
+	int status;
+
+	status = decode_op_hdr(xdr, OP_IO_ADVISE);
+	if (status)
+		return status;
+
+	if (unlikely(decode_bitmap4(xdr, &res->hints, 1) < 0))
+		return -EIO;
+	return 0;
+}
+
 struct read_plus_segment {
 	enum data_content4 type;
 	uint64_t offset;
@@ -1337,6 +1396,31 @@ static int nfs4_xdr_dec_deallocate(struct rpc_rqst *rqstp,
 	return status;
 }
 
+/*
+ * Decode IO_ADVISE response
+ */
+static int nfs4_xdr_dec_io_advise(struct rpc_rqst *rqstp,
+				  struct xdr_stream *xdr,
+				  void *data)
+{
+	struct nfs42_io_advise_res *res = data;
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
+	status = decode_io_advise(xdr, res);
+out:
+	return status;
+}
+
 /*
  * Decode READ_PLUS request
  */
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 2563ed8580f3..5f6e4b5f1559 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -7,6 +7,7 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/falloc.h>
+#include <linux/fadvise.h>
 #include <linux/mount.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_ssc.h>
@@ -236,6 +237,41 @@ static long nfs42_fallocate(struct file *filep, int mode, loff_t offset, loff_t
 	return nfs42_proc_allocate(filep, offset, len);
 }
 
+static int nfs42_file_fadvise(struct file *filep, loff_t start, loff_t len, int advice)
+{
+	int ret;
+	unsigned int hints = 0;
+
+	switch (advice) {
+	case POSIX_FADV_NORMAL:
+		hints = NFS_IO_ADVISE4_NORMAL;
+		break;
+	case POSIX_FADV_RANDOM:
+		hints = NFS_IO_ADVISE4_RANDOM;
+		break;
+	case POSIX_FADV_SEQUENTIAL:
+		hints = NFS_IO_ADVISE4_SEQUENTIAL;
+		break;
+	case POSIX_FADV_WILLNEED:
+		hints = NFS_IO_ADVISE4_WILLNEED;
+		break;
+	case POSIX_FADV_DONTNEED:
+		hints = NFS_IO_ADVISE4_DONTNEED;
+		break;
+	case POSIX_FADV_NOREUSE:
+		hints = NFS_IO_ADVISE4_NOREUSE;
+		break;
+	default:
+		goto out;
+	}
+
+	ret = nfs42_proc_io_advise(filep, start, len, hints);
+	if (ret < 0)
+		return ret;
+out:
+	return generic_fadvise(filep, start, len, advice);
+}
+
 static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
 		struct file *dst_file, loff_t dst_off, loff_t count,
 		unsigned int remap_flags)
@@ -462,6 +498,7 @@ const struct file_operations nfs4_file_operations = {
 	.copy_file_range = nfs4_copy_file_range,
 	.llseek		= nfs4_file_llseek,
 	.fallocate	= nfs42_fallocate,
+	.fadvise	= nfs42_file_fadvise,
 	.remap_file_range = nfs42_remap_file_range,
 #else
 	.llseek		= nfs_file_llseek,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 40d749f29ed3..89b21b94f948 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10529,6 +10529,7 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
 		| NFS_CAP_OFFLOAD_CANCEL
 		| NFS_CAP_COPY_NOTIFY
 		| NFS_CAP_DEALLOCATE
+		| NFS_CAP_IO_ADVISE
 		| NFS_CAP_SEEK
 		| NFS_CAP_LAYOUTSTATS
 		| NFS_CAP_CLONE
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index deec76cf5afe..962c5b023769 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7698,6 +7698,7 @@ const struct rpc_procinfo nfs4_procedures[] = {
 	PROC42(SEEK,		enc_seek,		dec_seek),
 	PROC42(ALLOCATE,	enc_allocate,		dec_allocate),
 	PROC42(DEALLOCATE,	enc_deallocate,		dec_deallocate),
+	PROC42(IO_ADVISE,	enc_io_advise,		dec_io_advise),
 	PROC42(LAYOUTSTATS,	enc_layoutstats,	dec_layoutstats),
 	PROC42(CLONE,		enc_clone,		dec_clone),
 	PROC42(COPY,		enc_copy,		dec_copy),
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 8d04b6a5964c..a1d925b1f06b 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -557,6 +557,7 @@ enum {
 	NFSPROC4_CLNT_LISTXATTRS,
 	NFSPROC4_CLNT_REMOVEXATTR,
 	NFSPROC4_CLNT_READ_PLUS,
+	NFSPROC4_CLNT_IO_ADVISE,
 };
 
 /* nfs41 types */
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index ea2f7e6b1b0b..38eb0cd86979 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -270,6 +270,7 @@ struct nfs_server {
 #define NFS_CAP_LGOPEN		(1U << 5)
 #define NFS_CAP_CASE_INSENSITIVE	(1U << 6)
 #define NFS_CAP_CASE_PRESERVING	(1U << 7)
+#define NFS_CAP_IO_ADVISE	(1U << 13)
 #define NFS_CAP_POSIX_LOCK	(1U << 14)
 #define NFS_CAP_UIDGID_NOMAP	(1U << 15)
 #define NFS_CAP_STATEID_NFSV41	(1U << 16)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index e86cf6642d21..3a52e5dc2fea 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -17,6 +17,18 @@
 
 #define NFS_BITMASK_SZ		3
 
+#define NFS_IO_ADVISE4_NORMAL			(1U << 0)
+#define NFS_IO_ADVISE4_SEQUENTIAL		(1U << 1)
+#define NFS_IO_ADVISE4_SEQUENTIAL_BACKWARDS	(1U << 2)
+#define NFS_IO_ADVISE4_RANDOM			(1U << 3)
+#define NFS_IO_ADVISE4_WILLNEED			(1U << 4)
+#define NFS_IO_ADVISE4_WILLNEED_OPPORTUNISTIC	(1U << 5)
+#define NFS_IO_ADVISE4_DONTNEED			(1U << 6)
+#define NFS_IO_ADVISE4_NOREUSE			(1U << 7)
+#define NFS_IO_ADVISE4_READ			(1U << 8)
+#define NFS_IO_ADVISE4_WRITE			(1U << 9)
+#define NFS_IO_ADVISE4_INIT_PROXIMITY		(1U << 10)
+
 struct nfs4_string {
 	unsigned int len;
 	char *data;
@@ -1449,6 +1461,22 @@ struct nfs42_falloc_res {
 	const struct nfs_server		*falloc_server;
 };
 
+struct nfs42_io_advise_args {
+	struct nfs4_sequence_args	seq_args;
+
+	struct nfs_fh			*fh;
+	nfs4_stateid			stateid;
+	loff_t				offset;
+	u64				count;
+	u32				hints;
+};
+
+struct nfs42_io_advise_res {
+	struct nfs4_sequence_res	seq_res;
+
+	u32				hints;
+};
+
 struct nfs42_copy_args {
 	struct nfs4_sequence_args	seq_args;
 
-- 
2.31.1

