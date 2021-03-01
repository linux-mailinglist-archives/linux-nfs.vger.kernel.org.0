Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42A6328220
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbhCAPRk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:17:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236993AbhCAPRg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:17:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C84CA64E45
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:17:07 +0000 (UTC)
Subject: [PATCH v1 18/42] NFSD: Update the NFSv3 READDIR3res encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:17:07 -0500
Message-ID: <161461182707.8508.12728593435426765105.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3proc.c |    3 ++-
 fs/nfsd/nfs3xdr.c  |   54 ++++++++++++++++++++++++++++++++++------------------
 fs/nfsd/xdr3.h     |    1 +
 3 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 791d77363acd..f1096aa0f47c 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -447,7 +447,8 @@ static void nfsd3_init_dirlist_pages(struct svc_rqst *rqstp,
 	 * and reserve room for the NULL ptr & eof flag (-2 words) */
 	resp->buflen = (count >> 2) - 2;
 
-	resp->buffer = page_address(*rqstp->rq_next_page);
+	resp->pages = rqstp->rq_next_page;
+	resp->buffer = page_address(*resp->pages);
 	while (count > 0) {
 		rqstp->rq_next_page++;
 		count -= PAGE_SIZE;
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 9f8afc5b126b..f8362b5ea98f 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -158,6 +158,19 @@ encode_fh(__be32 *p, struct svc_fh *fhp)
 	return p + XDR_QUADLEN(size);
 }
 
+static bool
+svcxdr_encode_cookieverf3(struct xdr_stream *xdr, const __be32 *verf)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, NFS3_COOKIEVERFSIZE);
+	if (!p)
+		return false;
+	memcpy(p, verf, NFS3_COOKIEVERFSIZE);
+
+	return true;
+}
+
 static bool
 svcxdr_encode_writeverf3(struct xdr_stream *xdr, const __be32 *verf)
 {
@@ -1124,27 +1137,30 @@ nfs3svc_encode_linkres(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_readdirres *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	p = encode_post_op_attr(rqstp, p, &resp->fh);
-
-	if (resp->status == 0) {
-		/* stupid readdir cookie */
-		memcpy(p, resp->verf, 8); p += 2;
-		xdr_ressize_check(rqstp, p);
-		if (rqstp->rq_res.head[0].iov_len + (2<<2) > PAGE_SIZE)
-			return 1; /*No room for trailer */
-		rqstp->rq_res.page_len = (resp->count) << 2;
-
-		/* add the 'tail' to the end of the 'head' page - page 0. */
-		rqstp->rq_res.tail[0].iov_base = p;
-		*p++ = 0;		/* no more entries */
-		*p++ = htonl(resp->common.err == nfserr_eof);
-		rqstp->rq_res.tail[0].iov_len = 2<<2;
-		return 1;
-	} else
-		return xdr_ressize_check(rqstp, p);
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+			return 0;
+		if (!svcxdr_encode_cookieverf3(xdr, resp->verf))
+			return 0;
+		xdr_write_pages(xdr, resp->pages, 0, resp->count << 2);
+		/* no more entries */
+		if (xdr_stream_encode_item_absent(xdr) < 0)
+			return 0;
+		if (xdr_stream_encode_bool(xdr, resp->common.err == nfserr_eof) < 0)
+			return 0;
+		break;
+	default:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+			return 0;
+	}
+
+	return 1;
 }
 
 static __be32 *
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index e76e9230827e..a4cdd8ccb175 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -176,6 +176,7 @@ struct nfsd3_readdirres {
 	struct svc_fh		scratch;
 	int			count;
 	__be32			verf[2];
+	struct page		**pages;
 
 	struct readdir_cd	common;
 	__be32 *		buffer;


