Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D913FCD78
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 21:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbhHaTGZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 15:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240212AbhHaTGY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 31 Aug 2021 15:06:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA99661041;
        Tue, 31 Aug 2021 19:05:28 +0000 (UTC)
Subject: [PATCH RFC 3/6] NFSD: Have legacy NFSD WRITE decoders use
 xdr_stream_subsegment()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 31 Aug 2021 15:05:28 -0400
Message-ID: <163043672812.1415.17532727182816586412.stgit@klimt.1015granger.net>
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

Now that the NFSv2 and NFSv3 XDR decoders have been converted to
use xdr_streams, the WRITE decoder functions can use
xdr_stream_subsegment() to extract the WRITE payload into its own
xdr_buf, just as the NFSv4 WRITE XDR decoder currently does.

That makes it possible to pass the first kvec, pages array + length,
page_base, and total payload length via a single function parameter.

The payload's page_base is not yet assigned or used, but will be in
subsequent patches.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c         |    3 +--
 fs/nfsd/nfs3xdr.c          |   12 ++----------
 fs/nfsd/nfs4proc.c         |    3 +--
 fs/nfsd/nfsproc.c          |    3 +--
 fs/nfsd/nfsxdr.c           |    9 +--------
 fs/nfsd/xdr.h              |    2 +-
 fs/nfsd/xdr3.h             |    2 +-
 include/linux/sunrpc/svc.h |    3 +--
 net/sunrpc/svc.c           |   11 ++++++-----
 9 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 17715a6c7a40..4418517f6f12 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -201,8 +201,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->committed = argp->stable;
-	nvecs = svc_fill_write_vector(rqstp, rqstp->rq_arg.pages,
-				      &argp->first, cnt);
+	nvecs = svc_fill_write_vector(rqstp, &argp->payload);
 	if (!nvecs) {
 		resp->status = nfserr_io;
 		goto out;
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 0a5ebc52e6a9..91d4e2b8b854 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -621,9 +621,6 @@ nfs3svc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_writeargs *args = rqstp->rq_argp;
 	u32 max_blocksize = svc_max_payload(rqstp);
-	struct kvec *head = rqstp->rq_arg.head;
-	struct kvec *tail = rqstp->rq_arg.tail;
-	size_t remaining;
 
 	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
 		return 0;
@@ -641,17 +638,12 @@ nfs3svc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 	/* request sanity */
 	if (args->count != args->len)
 		return 0;
-	remaining = head->iov_len + rqstp->rq_arg.page_len + tail->iov_len;
-	remaining -= xdr_stream_pos(xdr);
-	if (remaining < xdr_align_size(args->len))
-		return 0;
 	if (args->count > max_blocksize) {
 		args->count = max_blocksize;
 		args->len = max_blocksize;
 	}
-
-	args->first.iov_base = xdr->p;
-	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
+	if (!xdr_stream_subsegment(xdr, &args->payload, args->count))
+		return 0;
 
 	return 1;
 }
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 486c5dba4b65..55c9551fa74e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1033,8 +1033,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	write->wr_how_written = write->wr_stable_how;
 
-	nvecs = svc_fill_write_vector(rqstp, write->wr_payload.pages,
-				      write->wr_payload.head, write->wr_buflen);
+	nvecs = svc_fill_write_vector(rqstp, &write->wr_payload);
 	WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
 
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 90fcd6178823..eea5b59b6a6c 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -234,8 +234,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 		SVCFH_fmt(&argp->fh),
 		argp->len, argp->offset);
 
-	nvecs = svc_fill_write_vector(rqstp, rqstp->rq_arg.pages,
-				      &argp->first, cnt);
+	nvecs = svc_fill_write_vector(rqstp, &argp->payload);
 	if (!nvecs) {
 		resp->status = nfserr_io;
 		goto out;
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index a06c05fe3b42..26a42f87c240 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -325,10 +325,7 @@ nfssvc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_writeargs *args = rqstp->rq_argp;
-	struct kvec *head = rqstp->rq_arg.head;
-	struct kvec *tail = rqstp->rq_arg.tail;
 	u32 beginoffset, totalcount;
-	size_t remaining;
 
 	if (!svcxdr_decode_fhandle(xdr, &args->fh))
 		return 0;
@@ -346,12 +343,8 @@ nfssvc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 		return 0;
 	if (args->len > NFSSVC_MAXBLKSIZE_V2)
 		return 0;
-	remaining = head->iov_len + rqstp->rq_arg.page_len + tail->iov_len;
-	remaining -= xdr_stream_pos(xdr);
-	if (remaining < xdr_align_size(args->len))
+	if (!xdr_stream_subsegment(xdr, &args->payload, args->len))
 		return 0;
-	args->first.iov_base = xdr->p;
-	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
 
 	return 1;
 }
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index f45b4bc93f52..80fd6d7f3404 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -33,7 +33,7 @@ struct nfsd_writeargs {
 	svc_fh			fh;
 	__u32			offset;
 	int			len;
-	struct kvec		first;
+	struct xdr_buf		payload;
 };
 
 struct nfsd_createargs {
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 933008382bbe..712c117300cb 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -40,7 +40,7 @@ struct nfsd3_writeargs {
 	__u32			count;
 	int			stable;
 	__u32			len;
-	struct kvec		first;
+	struct xdr_buf		payload;
 };
 
 struct nfsd3_createargs {
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index f0f846fa396e..5a277acf2667 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -532,8 +532,7 @@ int		   svc_encode_result_payload(struct svc_rqst *rqstp,
 					     unsigned int offset,
 					     unsigned int length);
 unsigned int	   svc_fill_write_vector(struct svc_rqst *rqstp,
-					 struct page **pages,
-					 struct kvec *first, size_t total);
+					 struct xdr_buf *payload);
 char		  *svc_fill_symlink_pathname(struct svc_rqst *rqstp,
 					     struct kvec *first, void *p,
 					     size_t total);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index bfcbaf7b3822..34ced7f538ee 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1693,16 +1693,17 @@ EXPORT_SYMBOL_GPL(svc_encode_result_payload);
 /**
  * svc_fill_write_vector - Construct data argument for VFS write call
  * @rqstp: svc_rqst to operate on
- * @pages: list of pages containing data payload
- * @first: buffer containing first section of write payload
- * @total: total number of bytes of write payload
+ * @payload: xdr_buf containing only the write data payload
  *
  * Fills in rqstp::rq_vec, and returns the number of elements.
  */
-unsigned int svc_fill_write_vector(struct svc_rqst *rqstp, struct page **pages,
-				   struct kvec *first, size_t total)
+unsigned int svc_fill_write_vector(struct svc_rqst *rqstp,
+				   struct xdr_buf *payload)
 {
+	struct page **pages = payload->pages;
+	struct kvec *first = payload->head;
 	struct kvec *vec = rqstp->rq_vec;
+	size_t total = payload->len;
 	unsigned int i;
 
 	/* Some types of transport can present the write payload


