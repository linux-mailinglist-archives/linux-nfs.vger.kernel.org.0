Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23FD328215
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhCAPRV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:17:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236904AbhCAPRU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:17:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AD7264E38
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:15:55 +0000 (UTC)
Subject: [PATCH v1 06/42] NFSD: Update the NFSv3 READLINK3res encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:15:54 -0500
Message-ID: <161461175465.8508.4525125731204422839.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3proc.c |    5 +++--
 fs/nfsd/nfs3xdr.c  |   34 ++++++++++++++++++----------------
 fs/nfsd/xdr3.h     |    1 +
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 49b018afc6ea..e55a1d14ede2 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -126,14 +126,15 @@ nfsd3_proc_readlink(struct svc_rqst *rqstp)
 {
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd3_readlinkres *resp = rqstp->rq_resp;
-	char *buffer = page_address(*(rqstp->rq_next_page++));
 
 	dprintk("nfsd: READLINK(3) %s\n", SVCFH_fmt(&argp->fh));
 
 	/* Read the symlink. */
 	fh_copy(&resp->fh, &argp->fh);
 	resp->len = NFS3_MAXPATHLEN;
-	resp->status = nfsd_readlink(rqstp, &resp->fh, buffer, &resp->len);
+	resp->pages = rqstp->rq_next_page++;
+	resp->status = nfsd_readlink(rqstp, &resp->fh,
+				     page_address(*resp->pages), &resp->len);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 29b923a497f4..352691c3e246 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -977,26 +977,28 @@ nfs3svc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_readlinkres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
-	*p++ = resp->status;
-	p = encode_post_op_attr(rqstp, p, &resp->fh);
-	if (resp->status == 0) {
-		*p++ = htonl(resp->len);
-		xdr_ressize_check(rqstp, p);
-		rqstp->rq_res.page_len = resp->len;
-		if (resp->len & 3) {
-			/* need to pad the tail */
-			rqstp->rq_res.tail[0].iov_base = p;
-			*p = 0;
-			rqstp->rq_res.tail[0].iov_len = 4 - (resp->len&3);
-		}
-		if (svc_encode_result_payload(rqstp, head->iov_len, resp->len))
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
 			return 0;
-		return 1;
-	} else
-		return xdr_ressize_check(rqstp, p);
+		if (xdr_stream_encode_u32(xdr, resp->len) < 0)
+			return 0;
+		xdr_write_pages(xdr, resp->pages, 0, resp->len);
+		if (svc_encode_result_payload(rqstp, head->iov_len, resp->len) < 0)
+			return 0;
+		break;
+	default:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+			return 0;
+	}
+
+	return 1;
 }
 
 /* READ */
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 7db4ee17aa20..1d633c5d5fa2 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -137,6 +137,7 @@ struct nfsd3_readlinkres {
 	__be32			status;
 	struct svc_fh		fh;
 	__u32			len;
+	struct page		**pages;
 };
 
 struct nfsd3_readres {


