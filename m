Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9782132FDD6
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Mar 2021 23:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhCFWcN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Mar 2021 17:32:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhCFWbo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Mar 2021 17:31:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2060B650D0
        for <linux-nfs@vger.kernel.org>; Sat,  6 Mar 2021 22:31:44 +0000 (UTC)
Subject: [PATCH v2 25/43] NFSD: Update the NFSv2 READLINK result encoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 06 Mar 2021 17:31:43 -0500
Message-ID: <161506990338.4312.11719706096635719984.stgit@klimt.1015granger.net>
In-Reply-To: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
References: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c |    5 +++--
 fs/nfsd/nfsxdr.c  |   26 ++++++++++++--------------
 fs/nfsd/xdr.h     |    1 +
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 2ae6409ee39e..f55080482997 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -151,13 +151,14 @@ nfsd_proc_readlink(struct svc_rqst *rqstp)
 {
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd_readlinkres *resp = rqstp->rq_resp;
-	char *buffer = page_address(*(rqstp->rq_next_page++));
 
 	dprintk("nfsd: READLINK %s\n", SVCFH_fmt(&argp->fh));
 
 	/* Read the symlink. */
 	resp->len = NFS_MAXPATHLEN;
-	resp->status = nfsd_readlink(rqstp, &argp->fh, buffer, &resp->len);
+	resp->page = *(rqstp->rq_next_page++);
+	resp->status = nfsd_readlink(rqstp, &argp->fh,
+				     page_address(resp->page), &resp->len);
 
 	fh_put(&argp->fh);
 	return rpc_success;
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 989144b0d5be..74d9d11949c6 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -527,24 +527,22 @@ nfssvc_encode_diropres(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_readlinkres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
-	*p++ = resp->status;
-	if (resp->status != nfs_ok)
-		return xdr_ressize_check(rqstp, p);
-
-	*p++ = htonl(resp->len);
-	xdr_ressize_check(rqstp, p);
-	rqstp->rq_res.page_len = resp->len;
-	if (resp->len & 3) {
-		/* need to pad the tail */
-		rqstp->rq_res.tail[0].iov_base = p;
-		*p = 0;
-		rqstp->rq_res.tail[0].iov_len = 4 - (resp->len&3);
-	}
-	if (svc_encode_result_payload(rqstp, head->iov_len, resp->len))
+	if (!svcxdr_encode_stat(xdr, resp->status))
 		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (xdr_stream_encode_u32(xdr, resp->len) < 0)
+			return 0;
+		xdr_write_pages(xdr, &resp->page, 0, resp->len);
+		if (svc_encode_result_payload(rqstp, head->iov_len, resp->len) < 0)
+			return 0;
+		break;
+	}
+
 	return 1;
 }
 
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index a9b4ee6d098b..b868565c471f 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -94,6 +94,7 @@ struct nfsd_diropres  {
 struct nfsd_readlinkres {
 	__be32			status;
 	int			len;
+	struct page		*page;
 };
 
 struct nfsd_readres {


