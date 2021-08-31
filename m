Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F16D3FCD7C
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 21:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbhHaTGh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 15:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239852AbhHaTGg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 31 Aug 2021 15:06:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0578961074;
        Tue, 31 Aug 2021 19:05:40 +0000 (UTC)
Subject: [PATCH RFC 5/6] NFSD: Add a transport hook for pulling argument
 payloads
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 31 Aug 2021 15:05:40 -0400
Message-ID: <163043674032.1415.4517139610988941857.stgit@klimt.1015granger.net>
In-Reply-To: <163043485613.1415.4979286233971984855.stgit@klimt.1015granger.net>
References: <163043485613.1415.4979286233971984855.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor.

The new hook is a no-op at the moment, but it will soon be used to
pull RDMA Read chunks such that the payload is aligned to the pages
in the target file's page cache.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c                        |    4 ++++
 fs/nfsd/nfs4xdr.c                        |    6 ++++++
 fs/nfsd/nfsxdr.c                         |    4 ++++
 include/linux/sunrpc/svc.h               |    3 +++
 include/linux/sunrpc/svc_rdma.h          |    2 ++
 include/linux/sunrpc/svc_xprt.h          |    3 +++
 net/sunrpc/svc.c                         |   20 ++++++++++++++++++++
 net/sunrpc/svcsock.c                     |    8 ++++++++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |   22 ++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    1 +
 10 files changed, 73 insertions(+)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 91d4e2b8b854..1bb61a7d125a 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -642,6 +642,8 @@ nfs3svc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 		args->count = max_blocksize;
 		args->len = max_blocksize;
 	}
+	if (svc_decode_argument_payload(rqstp, args->offset, args->len) < 0)
+		return 0;
 	if (!xdr_stream_subsegment(xdr, &args->payload, args->count))
 		return 0;
 
@@ -705,6 +707,8 @@ nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p)
 	remaining -= xdr_stream_pos(xdr);
 	if (remaining < xdr_align_size(args->tlen))
 		return 0;
+	if (svc_decode_argument_payload(rqstp, 0, args->tlen) < 0)
+		return 0;
 
 	args->first.iov_base = xdr->p;
 	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7abeccb975b2..e919f409cb9c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -813,6 +813,9 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, struct nfsd4_create *create
 		p = xdr_inline_decode(argp->xdr, create->cr_datalen);
 		if (!p)
 			return nfserr_bad_xdr;
+		if (svc_decode_argument_payload(argp->rqstp, 0,
+						create->cr_datalen) < 0)
+			return nfserr_bad_xdr;
 		create->cr_data = svcxdr_dupstr(argp, p, create->cr_datalen);
 		if (!create->cr_data)
 			return nfserr_jukebox;
@@ -1410,6 +1413,9 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 		return nfserr_bad_xdr;
 	if (xdr_stream_decode_u32(argp->xdr, &write->wr_buflen) < 0)
 		return nfserr_bad_xdr;
+	if (svc_decode_argument_payload(argp->rqstp, write->wr_offset,
+					write->wr_buflen) < 0)
+		return nfserr_bad_xdr;
 	if (!xdr_stream_subsegment(argp->xdr, &write->wr_payload, write->wr_buflen))
 		return nfserr_bad_xdr;
 
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 26a42f87c240..7c15f31f91da 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -343,6 +343,8 @@ nfssvc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 		return 0;
 	if (args->len > NFSSVC_MAXBLKSIZE_V2)
 		return 0;
+	if (svc_decode_argument_payload(rqstp, args->offset, args->len) < 0)
+		return 0;
 	if (!xdr_stream_subsegment(xdr, &args->payload, args->len))
 		return 0;
 
@@ -397,6 +399,8 @@ nfssvc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p)
 	if (args->tlen == 0)
 		return 0;
 
+	if (svc_decode_argument_payload(rqstp, 0, args->tlen) < 0)
+		return 0;
 	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
 	args->first.iov_base = xdr_inline_decode(xdr, args->tlen);
 	if (!args->first.iov_base)
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 5a277acf2667..59d5016d9ec4 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -528,6 +528,9 @@ void		   svc_reserve(struct svc_rqst *rqstp, int space);
 struct svc_pool *  svc_pool_for_cpu(struct svc_serv *serv, int cpu);
 char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
 const char *	   svc_proc_name(const struct svc_rqst *rqstp);
+int		   svc_decode_argument_payload(struct svc_rqst *rqstp,
+					       unsigned int offset,
+					       unsigned int length);
 int		   svc_encode_result_payload(struct svc_rqst *rqstp,
 					     unsigned int offset,
 					     unsigned int length);
diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 24aa159d29a7..f660244cc8ba 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -178,6 +178,8 @@ extern void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 extern void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma);
 extern void svc_rdma_release_rqst(struct svc_rqst *rqstp);
 extern int svc_rdma_recvfrom(struct svc_rqst *);
+extern int svc_rdma_argument_payload(struct svc_rqst *rqstp,
+				     unsigned int offset, unsigned int length);
 
 /* svc_rdma_rw.c */
 extern void svc_rdma_destroy_rw_ctxts(struct svcxprt_rdma *rdma);
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 571f605bc91e..2d4c61f3307e 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -20,6 +20,9 @@ struct svc_xprt_ops {
 	struct svc_xprt	*(*xpo_accept)(struct svc_xprt *);
 	int		(*xpo_has_wspace)(struct svc_xprt *);
 	int		(*xpo_recvfrom)(struct svc_rqst *);
+	int		(*xpo_argument_payload)(struct svc_rqst *rqstp,
+						unsigned int offset,
+						unsigned int length);
 	int		(*xpo_sendto)(struct svc_rqst *);
 	int		(*xpo_result_payload)(struct svc_rqst *, unsigned int,
 					      unsigned int);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 3d9f9da98aed..6eca2f420371 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1673,6 +1673,26 @@ const char *svc_proc_name(const struct svc_rqst *rqstp)
 }
 
 
+/**
+ * svc_decode_argument_payload - set up pages containing an argument
+ * @rqstp: svc_rqst to operate on
+ * @offset: byte offset of payload in file's page cache
+ * @length: size of payload, in bytes
+ *
+ * This function can modify rqstp->rq_arg.page_base and the content
+ * of rqstp->rq_arg.pages, but no other fields of rq_arg are changed.
+ *
+ * Returns zero on success, or a negative errno if a permanent error
+ * occurred.
+ */
+int svc_decode_argument_payload(struct svc_rqst *rqstp, unsigned int offset,
+				unsigned int length)
+{
+	return rqstp->rq_xprt->xpt_ops->xpo_argument_payload(rqstp, offset,
+							     length);
+}
+EXPORT_SYMBOL_GPL(svc_decode_argument_payload);
+
 /**
  * svc_encode_result_payload - mark a range of bytes as a result payload
  * @rqstp: svc_rqst to operate on
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 478f857cdaed..05eb63c182fd 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -181,6 +181,12 @@ static void svc_set_cmsg_data(struct svc_rqst *rqstp, struct cmsghdr *cmh)
 	}
 }
 
+static int svc_sock_argument_payload(struct svc_rqst *rqstp,
+				     unsigned int offset, unsigned int length)
+{
+	return 0;
+}
+
 static int svc_sock_result_payload(struct svc_rqst *rqstp, unsigned int offset,
 				   unsigned int length)
 {
@@ -637,6 +643,7 @@ static struct svc_xprt *svc_udp_create(struct svc_serv *serv,
 static const struct svc_xprt_ops svc_udp_ops = {
 	.xpo_create = svc_udp_create,
 	.xpo_recvfrom = svc_udp_recvfrom,
+	.xpo_argument_payload = svc_sock_argument_payload,
 	.xpo_sendto = svc_udp_sendto,
 	.xpo_result_payload = svc_sock_result_payload,
 	.xpo_release_rqst = svc_udp_release_rqst,
@@ -1208,6 +1215,7 @@ static struct svc_xprt *svc_tcp_create(struct svc_serv *serv,
 static const struct svc_xprt_ops svc_tcp_ops = {
 	.xpo_create = svc_tcp_create,
 	.xpo_recvfrom = svc_tcp_recvfrom,
+	.xpo_argument_payload = svc_sock_argument_payload,
 	.xpo_sendto = svc_tcp_sendto,
 	.xpo_result_payload = svc_sock_result_payload,
 	.xpo_release_rqst = svc_tcp_release_rqst,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index cf76a6ad127b..08a620b370ae 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -867,3 +867,25 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
 	return 0;
 }
+
+/**
+ * svc_rdma_argument_payload - special processing for an argument payload
+ * @rqstp: svc_rqst to operate on
+ * @offset: offset of payload in file's page cache
+ * @length: size of payload, in bytes
+ *
+ * Pull an RDMA Read payload chunk into rqstp->rq_arg.
+ *
+ * Return values:
+ *   %0 if successful or nothing needed to be done
+ *   %-EMSGSIZE on XDR buffer overflow
+ *   %-EINVAL if client provided too many segments
+ *   %-ENOMEM if rdma_rw context pool was exhausted
+ *   %-ENOTCONN if posting failed (connection is lost)
+ *   %-EIO if rdma_rw initialization failed (DMA mapping, etc)
+ */
+int svc_rdma_argument_payload(struct svc_rqst *rqstp, unsigned int offset,
+			      unsigned int length)
+{
+	return 0;
+}
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 94b20fb47135..ee7cc112504c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -79,6 +79,7 @@ static void svc_rdma_kill_temp_xprt(struct svc_xprt *);
 static const struct svc_xprt_ops svc_rdma_ops = {
 	.xpo_create = svc_rdma_create,
 	.xpo_recvfrom = svc_rdma_recvfrom,
+	.xpo_argument_payload = svc_rdma_argument_payload,
 	.xpo_sendto = svc_rdma_sendto,
 	.xpo_result_payload = svc_rdma_result_payload,
 	.xpo_release_rqst = svc_rdma_release_rqst,


