Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACF5AC32D
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2019 01:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393112AbfIFXgR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 19:36:17 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:34799 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388714AbfIFXgR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 19:36:17 -0400
Received: by mail-io1-f45.google.com with SMTP id k13so1361952ioj.1
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 16:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nHLCuMdZo7xym5dZqtgMq862iMS4HXuzYEW0JsUuwG0=;
        b=LZYs6bpx+0FznJl8rLBDNzO1+Rzir1c32mq4yeHoqmlpiYf/DDy/rdVAWrYkEDue4y
         ywnEVeVzSxOgatMCuSxY5IhtTq7BObJeAW8WlJ6V4tHlCmNiyl9oQ5f8b0IWqUGHblQA
         T7I+0k2oYtpGDzf1CnCMFFJqxDM/8uvMwPsdBLVvHUPuIMrC1+zm4vz9QHIox/5r4Vij
         tV1s7RFl8CjDvM/KpmK6U++3imx12L591CYUYz7qvHftYZQp0JCHfpt2mFENnSFrWkLh
         RekE7YDeZl1bhC2tut0u6m858e358eSSbwW8RMCoNmjSt+gKa1alqyP89/oHWQpLBULO
         mzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nHLCuMdZo7xym5dZqtgMq862iMS4HXuzYEW0JsUuwG0=;
        b=peJDkLb7M/D+XndoSG6V3cTQ9XOxQkEEPAl7BA5jrZQUIrVYPiTB6F3uKKC92aQCGT
         Bksd/4/okM+Mb9uMP7/izvX48a7oWuDm8t++3zwH8rrna1dOpegnFZITT7LDEACFz6ON
         NaEnpH06zhh1470EDgfEGsI0LO03a6ieu20Le7IJDjmFT/Pcf9mbidgWiPMwkm8hyQSa
         5g435eRZ39WopW9OMAH20xs4H1jyK/7sk2OuSiCxZZspIpl4361Ctl3/x+DKG96CwHXG
         uePnjy33pgyCnPgLJPA9jqxgYUMEMd+S1/szinD3hl0aPIboS3YbLw10e2BR8oH2+67c
         LAOQ==
X-Gm-Message-State: APjAAAVBf6y3TQ7ZHdYNsrOndTISv1/X9pDdllLfXQ/oU5dG3Qabvzhz
        13vrylf7nh4IhhcbXDCgdtE=
X-Google-Smtp-Source: APXvYqz/qPYKM8VTdQ3lWpMlVcWto89nFIE2OUasTJof8H66+i4VOkXgGQB9kBrGl//fxQkCmF158A==
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr10120314ior.173.1567812975264;
        Fri, 06 Sep 2019 16:36:15 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm10439360iod.59.2019.09.06.16.36.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:36:14 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 02/21] NFS: add COPY_NOTIFY operation
Date:   Fri,  6 Sep 2019 19:35:52 -0400
Message-Id: <20190906233611.4031-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
References: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Try using the delegation stateid, then the open stateid.

Only NL4_NETATTR, No support for NL4_NAME and NL4_URL.
Allow only one source server address to be returned for now.

To distinguish between same server copy offload ("intra") and
a copy between different server ("inter"), do a check of server
owner identity and also make sure server is capable of doing
a copy offload.

Signed-off-by: Andy Adamson <andros@netapp.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42.h            |  12 +++
 fs/nfs/nfs42proc.c        |  91 +++++++++++++++++++
 fs/nfs/nfs42xdr.c         | 178 ++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4_fs.h          |   2 +
 fs/nfs/nfs4client.c       |   2 +-
 fs/nfs/nfs4file.c         |  20 ++++-
 fs/nfs/nfs4proc.c         |   1 +
 fs/nfs/nfs4xdr.c          |   1 +
 include/linux/nfs4.h      |   1 +
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |  16 ++++
 11 files changed, 323 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index 901cca7542f9..4995731a6714 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -13,6 +13,7 @@
 #define PNFS_LAYOUTSTATS_MAXDEV (4)
 
 /* nfs4.2proc.c */
+#ifdef CONFIG_NFS_V4_2
 int nfs42_proc_allocate(struct file *, loff_t, loff_t);
 ssize_t nfs42_proc_copy(struct file *, loff_t, struct file *, loff_t, size_t);
 int nfs42_proc_deallocate(struct file *, loff_t, loff_t);
@@ -23,5 +24,16 @@ int nfs42_proc_clone(struct file *, struct file *, loff_t, loff_t, loff_t);
 int nfs42_proc_layouterror(struct pnfs_layout_segment *lseg,
 			   const struct nfs42_layout_error *errors,
 			   size_t n);
+int nfs42_proc_copy_notify(struct file *, struct file *,
+			   struct nfs42_copy_notify_res *);
+static inline bool nfs42_files_from_same_server(struct file *in,
+						struct file *out)
+{
+	struct nfs_client *c_in = (NFS_SERVER(file_inode(in)))->nfs_client;
+	struct nfs_client *c_out = (NFS_SERVER(file_inode(out)))->nfs_client;
 
+	return nfs4_check_serverowner_major_id(c_in->cl_serverowner,
+					       c_out->cl_serverowner);
+}
+#endif /* CONFIG_NFS_V4_2 */
 #endif /* __LINUX_FS_NFS_NFS4_2_H */
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 5196bfa7894d..6317dd89cf43 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014 Anna Schumaker <Anna.Schumaker@Netapp.com>
  */
 #include <linux/fs.h>
+#include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/sched.h>
 #include <linux/nfs.h>
 #include <linux/nfs3.h>
@@ -15,10 +16,30 @@
 #include "pnfs.h"
 #include "nfs4session.h"
 #include "internal.h"
+#include "delegation.h"
 
 #define NFSDBG_FACILITY NFSDBG_PROC
 static int nfs42_do_offload_cancel_async(struct file *dst, nfs4_stateid *std);
 
+static void nfs42_set_netaddr(struct file *filep, struct nfs42_netaddr *naddr)
+{
+	struct nfs_client *clp = (NFS_SERVER(file_inode(filep)))->nfs_client;
+	unsigned short port = 2049;
+
+	rcu_read_lock();
+	naddr->netid_len = scnprintf(naddr->netid,
+					sizeof(naddr->netid), "%s",
+					rpc_peeraddr2str(clp->cl_rpcclient,
+					RPC_DISPLAY_NETID));
+	naddr->addr_len = scnprintf(naddr->addr,
+					sizeof(naddr->addr),
+					"%s.%u.%u",
+					rpc_peeraddr2str(clp->cl_rpcclient,
+					RPC_DISPLAY_ADDR),
+					port >> 8, port & 255);
+	rcu_read_unlock();
+}
+
 static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 		struct nfs_lock_context *lock, loff_t offset, loff_t len)
 {
@@ -459,6 +480,76 @@ static int nfs42_do_offload_cancel_async(struct file *dst,
 	return status;
 }
 
+int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
+			    struct nfs42_copy_notify_args *args,
+			    struct nfs42_copy_notify_res *res)
+{
+	struct nfs_server *src_server = NFS_SERVER(file_inode(src));
+	struct rpc_message msg = {
+		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_COPY_NOTIFY],
+		.rpc_argp = args,
+		.rpc_resp = res,
+	};
+	int status;
+	struct nfs_open_context *ctx;
+	struct nfs_lock_context *l_ctx;
+
+	ctx = get_nfs_open_context(nfs_file_open_context(src));
+	l_ctx = nfs_get_lock_context(ctx);
+	if (IS_ERR(l_ctx))
+		return PTR_ERR(l_ctx);
+
+	status = nfs4_set_rw_stateid(&args->cna_src_stateid, ctx, l_ctx,
+				     FMODE_READ);
+	nfs_put_lock_context(l_ctx);
+	if (status)
+		return status;
+
+	status = nfs4_call_sync(src_server->client, src_server, &msg,
+				&args->cna_seq_args, &res->cnr_seq_res, 0);
+	if (status == -ENOTSUPP)
+		src_server->caps &= ~NFS_CAP_COPY_NOTIFY;
+
+	put_nfs_open_context(nfs_file_open_context(src));
+	return status;
+}
+
+int nfs42_proc_copy_notify(struct file *src, struct file *dst,
+				struct nfs42_copy_notify_res *res)
+{
+	struct nfs_server *src_server = NFS_SERVER(file_inode(src));
+	struct nfs42_copy_notify_args *args;
+	struct nfs4_exception exception = {
+		.inode = file_inode(src),
+	};
+	int status;
+
+	if (!(src_server->caps & NFS_CAP_COPY_NOTIFY))
+		return -EOPNOTSUPP;
+
+	args = kzalloc(sizeof(struct nfs42_copy_notify_args), GFP_NOFS);
+	if (args == NULL)
+		return -ENOMEM;
+
+	args->cna_src_fh  = NFS_FH(file_inode(src)),
+	args->cna_dst.nl4_type = NL4_NETADDR;
+	nfs42_set_netaddr(dst, &args->cna_dst.u.nl4_addr);
+	exception.stateid = &args->cna_src_stateid;
+
+	do {
+		status = _nfs42_proc_copy_notify(src, dst, args, res);
+		if (status == -ENOTSUPP) {
+			status = -EOPNOTSUPP;
+			goto out;
+		}
+		status = nfs4_handle_exception(src_server, status, &exception);
+	} while (exception.retry);
+
+out:
+	kfree(args);
+	return status;
+}
+
 static loff_t _nfs42_proc_llseek(struct file *filep,
 		struct nfs_lock_context *lock, loff_t offset, int whence)
 {
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index aed865a84629..ccabc0cd93dd 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -29,6 +29,16 @@
 #define encode_offload_cancel_maxsz	(op_encode_hdr_maxsz + \
 					 XDR_QUADLEN(NFS4_STATEID_SIZE))
 #define decode_offload_cancel_maxsz	(op_decode_hdr_maxsz)
+#define encode_copy_notify_maxsz	(op_encode_hdr_maxsz + \
+					 XDR_QUADLEN(NFS4_STATEID_SIZE) + \
+					 1 + /* nl4_type */ \
+					 1 + XDR_QUADLEN(NFS4_OPAQUE_LIMIT))
+#define decode_copy_notify_maxsz	(op_decode_hdr_maxsz + \
+					 3 + /* cnr_lease_time */\
+					 XDR_QUADLEN(NFS4_STATEID_SIZE) + \
+					 1 + /* Support 1 cnr_source_server */\
+					 1 + /* nl4_type */ \
+					 1 + XDR_QUADLEN(NFS4_OPAQUE_LIMIT))
 #define encode_deallocate_maxsz		(op_encode_hdr_maxsz + \
 					 encode_fallocate_maxsz)
 #define decode_deallocate_maxsz		(op_decode_hdr_maxsz)
@@ -99,6 +109,12 @@
 					 decode_sequence_maxsz + \
 					 decode_putfh_maxsz + \
 					 decode_offload_cancel_maxsz)
+#define NFS4_enc_copy_notify_sz		(compound_encode_hdr_maxsz + \
+					 encode_putfh_maxsz + \
+					 encode_copy_notify_maxsz)
+#define NFS4_dec_copy_notify_sz		(compound_decode_hdr_maxsz + \
+					 decode_putfh_maxsz + \
+					 decode_copy_notify_maxsz)
 #define NFS4_enc_deallocate_sz		(compound_encode_hdr_maxsz + \
 					 encode_sequence_maxsz + \
 					 encode_putfh_maxsz + \
@@ -166,6 +182,26 @@ static void encode_allocate(struct xdr_stream *xdr,
 	encode_fallocate(xdr, args);
 }
 
+static void encode_nl4_server(struct xdr_stream *xdr,
+			      const struct nl4_server *ns)
+{
+	encode_uint32(xdr, ns->nl4_type);
+	switch (ns->nl4_type) {
+	case NL4_NAME:
+	case NL4_URL:
+		encode_string(xdr, ns->u.nl4_str_sz, ns->u.nl4_str);
+		break;
+	case NL4_NETADDR:
+		encode_string(xdr, ns->u.nl4_addr.netid_len,
+			      ns->u.nl4_addr.netid);
+		encode_string(xdr, ns->u.nl4_addr.addr_len,
+			      ns->u.nl4_addr.addr);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+
 static void encode_copy(struct xdr_stream *xdr,
 			const struct nfs42_copy_args *args,
 			struct compound_hdr *hdr)
@@ -191,6 +227,15 @@ static void encode_offload_cancel(struct xdr_stream *xdr,
 	encode_nfs4_stateid(xdr, &args->osa_stateid);
 }
 
+static void encode_copy_notify(struct xdr_stream *xdr,
+			       const struct nfs42_copy_notify_args *args,
+			       struct compound_hdr *hdr)
+{
+	encode_op_hdr(xdr, OP_COPY_NOTIFY, decode_copy_notify_maxsz, hdr);
+	encode_nfs4_stateid(xdr, &args->cna_src_stateid);
+	encode_nl4_server(xdr, &args->cna_dst);
+}
+
 static void encode_deallocate(struct xdr_stream *xdr,
 			      const struct nfs42_falloc_args *args,
 			      struct compound_hdr *hdr)
@@ -354,6 +399,25 @@ static void nfs4_xdr_enc_offload_cancel(struct rpc_rqst *req,
 	encode_nops(&hdr);
 }
 
+/*
+ * Encode COPY_NOTIFY request
+ */
+static void nfs4_xdr_enc_copy_notify(struct rpc_rqst *req,
+				     struct xdr_stream *xdr,
+				     const void *data)
+{
+	const struct nfs42_copy_notify_args *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->cna_seq_args),
+	};
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->cna_seq_args, &hdr);
+	encode_putfh(xdr, args->cna_src_fh, &hdr);
+	encode_copy_notify(xdr, args, &hdr);
+	encode_nops(&hdr);
+}
+
 /*
  * Encode DEALLOCATE request
  */
@@ -490,6 +554,58 @@ static int decode_write_response(struct xdr_stream *xdr,
 	return decode_verifier(xdr, &res->verifier.verifier);
 }
 
+static int decode_nl4_server(struct xdr_stream *xdr, struct nl4_server *ns)
+{
+	struct nfs42_netaddr *naddr;
+	uint32_t dummy;
+	char *dummy_str;
+	__be32 *p;
+	int status;
+
+	/* nl_type */
+	p = xdr_inline_decode(xdr, 4);
+	if (unlikely(!p))
+		return -EIO;
+	ns->nl4_type = be32_to_cpup(p);
+	switch (ns->nl4_type) {
+	case NL4_NAME:
+	case NL4_URL:
+		status = decode_opaque_inline(xdr, &dummy, &dummy_str);
+		if (unlikely(status))
+			return status;
+		if (unlikely(dummy > NFS4_OPAQUE_LIMIT))
+			return -EIO;
+		memcpy(&ns->u.nl4_str, dummy_str, dummy);
+		ns->u.nl4_str_sz = dummy;
+		break;
+	case NL4_NETADDR:
+		naddr = &ns->u.nl4_addr;
+
+		/* netid string */
+		status = decode_opaque_inline(xdr, &dummy, &dummy_str);
+		if (unlikely(status))
+			return status;
+		if (unlikely(dummy > RPCBIND_MAXNETIDLEN))
+			return -EIO;
+		naddr->netid_len = dummy;
+		memcpy(naddr->netid, dummy_str, naddr->netid_len);
+
+		/* uaddr string */
+		status = decode_opaque_inline(xdr, &dummy, &dummy_str);
+		if (unlikely(status))
+			return status;
+		if (unlikely(dummy > RPCBIND_MAXUADDRLEN))
+			return -EIO;
+		naddr->addr_len = dummy;
+		memcpy(naddr->addr, dummy_str, naddr->addr_len);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EIO;
+	}
+	return 0;
+}
+
 static int decode_copy_requirements(struct xdr_stream *xdr,
 				    struct nfs42_copy_res *res) {
 	__be32 *p;
@@ -529,6 +645,42 @@ static int decode_offload_cancel(struct xdr_stream *xdr,
 	return decode_op_hdr(xdr, OP_OFFLOAD_CANCEL);
 }
 
+static int decode_copy_notify(struct xdr_stream *xdr,
+			      struct nfs42_copy_notify_res *res)
+{
+	__be32 *p;
+	int status, count;
+
+	status = decode_op_hdr(xdr, OP_COPY_NOTIFY);
+	if (status)
+		return status;
+	/* cnr_lease_time */
+	p = xdr_inline_decode(xdr, 12);
+	if (unlikely(!p))
+		return -EIO;
+	p = xdr_decode_hyper(p, &res->cnr_lease_time.seconds);
+	res->cnr_lease_time.nseconds = be32_to_cpup(p);
+
+	status = decode_opaque_fixed(xdr, &res->cnr_stateid, NFS4_STATEID_SIZE);
+	if (unlikely(status))
+		return -EIO;
+
+	/* number of source addresses */
+	p = xdr_inline_decode(xdr, 4);
+	if (unlikely(!p))
+		return -EIO;
+
+	count = be32_to_cpup(p);
+	if (count > 1)
+		pr_warn("NFS: %s: nsvr %d > Supported. Use first servers\n",
+			 __func__, count);
+
+	status = decode_nl4_server(xdr, &res->cnr_src);
+	if (unlikely(status))
+		return -EIO;
+	return 0;
+}
+
 static int decode_deallocate(struct xdr_stream *xdr, struct nfs42_falloc_res *res)
 {
 	return decode_op_hdr(xdr, OP_DEALLOCATE);
@@ -656,6 +808,32 @@ static int nfs4_xdr_dec_offload_cancel(struct rpc_rqst *rqstp,
 	return status;
 }
 
+/*
+ * Decode COPY_NOTIFY response
+ */
+static int nfs4_xdr_dec_copy_notify(struct rpc_rqst *rqstp,
+				    struct xdr_stream *xdr,
+				    void *data)
+{
+	struct nfs42_copy_notify_res *res = data;
+	struct compound_hdr hdr;
+	int status;
+
+	status = decode_compound_hdr(xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_sequence(xdr, &res->cnr_seq_res, rqstp);
+	if (status)
+		goto out;
+	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+	status = decode_copy_notify(xdr, res);
+
+out:
+	return status;
+}
+
 /*
  * Decode DEALLOCATE request
  */
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 16b2e5cc3e94..8e590b424d75 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -457,6 +457,8 @@ int nfs41_discover_server_trunking(struct nfs_client *clp,
 			struct nfs_client **, const struct cred *);
 extern void nfs4_schedule_session_recovery(struct nfs4_session *, int);
 extern void nfs41_notify_server(struct nfs_client *);
+bool nfs4_check_serverowner_major_id(struct nfs41_server_owner *o1,
+			struct nfs41_server_owner *o2);
 #else
 static inline void nfs4_schedule_session_recovery(struct nfs4_session *session, int err)
 {
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index da6204025a2d..54aaf553d009 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -629,7 +629,7 @@ int nfs40_walk_client_list(struct nfs_client *new,
 /*
  * Returns true if the server major ids match
  */
-static bool
+bool
 nfs4_check_serverowner_major_id(struct nfs41_server_owner *o1,
 				struct nfs41_server_owner *o2)
 {
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 339663d04bf8..686a6c4071e3 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -133,6 +133,9 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 				      struct file *file_out, loff_t pos_out,
 				      size_t count, unsigned int flags)
 {
+	struct nfs42_copy_notify_res *cn_resp = NULL;
+	ssize_t ret;
+
 	/* Only offload copy if superblock is the same */
 	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
 		return -EXDEV;
@@ -140,7 +143,22 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 		return -EOPNOTSUPP;
 	if (file_inode(file_in) == file_inode(file_out))
 		return -EOPNOTSUPP;
-	return nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count);
+	if (!nfs42_files_from_same_server(file_in, file_out)) {
+		cn_resp = kzalloc(sizeof(struct nfs42_copy_notify_res),
+				GFP_NOFS);
+		if (unlikely(cn_resp == NULL))
+			return -ENOMEM;
+
+		ret = nfs42_proc_copy_notify(file_in, file_out, cn_resp);
+		if (ret) {
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+	}
+	ret = nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count);
+out:
+	kfree(cn_resp);
+	return ret;
 }
 
 static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ecfaf4b1ba5d..5311def18dbb 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9853,6 +9853,7 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
 		| NFS_CAP_ALLOCATE
 		| NFS_CAP_COPY
 		| NFS_CAP_OFFLOAD_CANCEL
+		| NFS_CAP_COPY_NOTIFY
 		| NFS_CAP_DEALLOCATE
 		| NFS_CAP_SEEK
 		| NFS_CAP_LAYOUTSTATS
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 46a8d636d151..d76c7723807c 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7581,6 +7581,7 @@ const struct rpc_procinfo nfs4_procedures[] = {
 	PROC42(CLONE,		enc_clone,		dec_clone),
 	PROC42(COPY,		enc_copy,		dec_copy),
 	PROC42(OFFLOAD_CANCEL,	enc_offload_cancel,	dec_offload_cancel),
+	PROC42(COPY_NOTIFY,	enc_copy_notify,	dec_copy_notify),
 	PROC(LOOKUPP,		enc_lookupp,		dec_lookupp),
 	PROC42(LAYOUTERROR,	enc_layouterror,	dec_layouterror),
 };
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 5810e248c1bd..5e7a5261af4e 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -537,6 +537,7 @@ enum {
 	NFSPROC4_CLNT_CLONE,
 	NFSPROC4_CLNT_COPY,
 	NFSPROC4_CLNT_OFFLOAD_CANCEL,
+	NFSPROC4_CLNT_COPY_NOTIFY,
 
 	NFSPROC4_CLNT_LOOKUPP,
 	NFSPROC4_CLNT_LAYOUTERROR,
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index a87fe854f008..e1c8748e1e82 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -276,5 +276,6 @@ struct nfs_server {
 #define NFS_CAP_COPY		(1U << 24)
 #define NFS_CAP_OFFLOAD_CANCEL	(1U << 25)
 #define NFS_CAP_LAYOUTERROR	(1U << 26)
+#define NFS_CAP_COPY_NOTIFY	(1U << 27)
 
 #endif
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 9b8324ec08f3..0a7af40026d7 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1463,6 +1463,22 @@ struct nfs42_offload_status_res {
 	int				osr_status;
 };
 
+struct nfs42_copy_notify_args {
+	struct nfs4_sequence_args	cna_seq_args;
+
+	struct nfs_fh		*cna_src_fh;
+	nfs4_stateid		cna_src_stateid;
+	struct nl4_server	cna_dst;
+};
+
+struct nfs42_copy_notify_res {
+	struct nfs4_sequence_res	cnr_seq_res;
+
+	struct nfstime4		cnr_lease_time;
+	nfs4_stateid		cnr_stateid;
+	struct nl4_server	cnr_src;
+};
+
 struct nfs42_seek_args {
 	struct nfs4_sequence_args	seq_args;
 
-- 
2.18.1

