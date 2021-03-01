Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC38328217
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhCAPRW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:17:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236841AbhCAPRV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:17:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 691C264E22
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:16:01 +0000 (UTC)
Subject: [PATCH v1 07/42] NFSD: Update the NFSv3 READ3res encode to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:16:00 -0500
Message-ID: <161461176064.8508.7770286583856276750.stgit@klimt.1015granger.net>
In-Reply-To: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c         |    1 +
 fs/nfsd/nfs3xdr.c          |   43 +++++++++++++++++++++++--------------------
 fs/nfsd/xdr3.h             |    1 +
 include/linux/sunrpc/xdr.h |   20 ++++++++++++++++++++
 4 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index e55a1d14ede2..93d196752f87 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -159,6 +159,7 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
 
 	v = 0;
 	len = argp->count;
+	resp->pages = rqstp->rq_next_page;
 	while (len > 0) {
 		struct page *page = *(rqstp->rq_next_page++);
 
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 352691c3e246..859cc6c51c1a 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1005,30 +1005,33 @@ nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_readres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
-	*p++ = resp->status;
-	p = encode_post_op_attr(rqstp, p, &resp->fh);
-	if (resp->status == 0) {
-		*p++ = htonl(resp->count);
-		*p++ = htonl(resp->eof);
-		*p++ = htonl(resp->count);	/* xdr opaque count */
-		xdr_ressize_check(rqstp, p);
-		/* now update rqstp->rq_res to reflect data as well */
-		rqstp->rq_res.page_len = resp->count;
-		if (resp->count & 3) {
-			/* need to pad the tail */
-			rqstp->rq_res.tail[0].iov_base = p;
-			*p = 0;
-			rqstp->rq_res.tail[0].iov_len = 4 - (resp->count & 3);
-		}
-		if (svc_encode_result_payload(rqstp, head->iov_len,
-					      resp->count))
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
 			return 0;
-		return 1;
-	} else
-		return xdr_ressize_check(rqstp, p);
+		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
+			return 0;
+		if (xdr_stream_encode_bool(xdr, resp->eof) < 0)
+			return 0;
+		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
+			return 0;
+		xdr_write_pages(xdr, resp->pages, rqstp->rq_res.page_base,
+				resp->count);
+		if (svc_encode_result_payload(rqstp, head->iov_len, resp->count) < 0)
+			return 0;
+		break;
+	default:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+			return 0;
+	}
+
+	return 1;
 }
 
 /* WRITE */
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 1d633c5d5fa2..8073350418ae 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -145,6 +145,7 @@ struct nfsd3_readres {
 	struct svc_fh		fh;
 	unsigned long		count;
 	__u32			eof;
+	struct page		**pages;
 };
 
 struct nfsd3_writeres {
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 2bc75c167f00..9dda7171b7b4 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -394,6 +394,26 @@ static inline int xdr_stream_encode_item_absent(struct xdr_stream *xdr)
 	return len;
 }
 
+/**
+ * xdr_stream_encode_bool - Encode a "not present" list item
+ * @xdr: pointer to xdr_stream
+ * @n: boolean value to encode
+ *
+ * Return values:
+ *   On success, returns length in bytes of XDR buffer consumed
+ *   %-EMSGSIZE on XDR buffer overflow
+ */
+static inline int xdr_stream_encode_bool(struct xdr_stream *xdr, __u32 n)
+{
+	const size_t len = XDR_UNIT;
+	__be32 *p = xdr_reserve_space(xdr, len);
+
+	if (unlikely(!p))
+		return -EMSGSIZE;
+	*p = n ? xdr_one : xdr_zero;
+	return len;
+}
+
 /**
  * xdr_stream_encode_u32 - Encode a 32-bit integer
  * @xdr: pointer to xdr_stream


