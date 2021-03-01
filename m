Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6948328232
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhCAPSo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:18:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237030AbhCAPSm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:18:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6C9764E04
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:18:01 +0000 (UTC)
Subject: [PATCH v1 27/42] NFSD: Update the NFSv2 READ result encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:18:01 -0500
Message-ID: <161461188121.8508.15688551888928802157.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsproc.c |    1 +
 fs/nfsd/nfsxdr.c  |   32 +++++++++++++++-----------------
 fs/nfsd/xdr.h     |    1 +
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index f55080482997..2088bb0887ba 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -185,6 +185,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 
 	v = 0;
 	len = argp->count;
+	resp->pages = rqstp->rq_next_page;
 	while (len > 0) {
 		struct page *page = *(rqstp->rq_next_page++);
 
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 74d9d11949c6..d6d7d07dbb1b 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -549,27 +549,25 @@ nfssvc_encode_readlinkres(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_readres *resp = rqstp->rq_resp;
 	struct kvec *head = rqstp->rq_res.head;
 
-	*p++ = resp->status;
-	if (resp->status != nfs_ok)
-		return xdr_ressize_check(rqstp, p);
-
-	p = encode_fattr(rqstp, p, &resp->fh, &resp->stat);
-	*p++ = htonl(resp->count);
-	xdr_ressize_check(rqstp, p);
-
-	/* now update rqstp->rq_res to reflect data as well */
-	rqstp->rq_res.page_len = resp->count;
-	if (resp->count & 3) {
-		/* need to pad the tail */
-		rqstp->rq_res.tail[0].iov_base = p;
-		*p = 0;
-		rqstp->rq_res.tail[0].iov_len = 4 - (resp->count&3);
-	}
-	if (svc_encode_result_payload(rqstp, head->iov_len, resp->count))
+	if (!svcxdr_encode_stat(xdr, resp->status))
 		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_fattr(rqstp, xdr, &resp->fh, &resp->stat))
+			return 0;
+		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
+			return 0;
+		xdr_write_pages(xdr, resp->pages, rqstp->rq_res.page_base,
+				resp->count);
+		if (svc_encode_result_payload(rqstp, head->iov_len, resp->count) < 0)
+			return 0;
+		break;
+	}
+
 	return 1;
 }
 
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index b868565c471f..277b74c511ce 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -102,6 +102,7 @@ struct nfsd_readres {
 	struct svc_fh		fh;
 	unsigned long		count;
 	struct kstat		stat;
+	struct page		**pages;
 };
 
 struct nfsd_readdirres {


