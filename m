Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A84732823E
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbhCAPTT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:19:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:41352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237160AbhCAPTJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:19:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C14464E2E
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:18:26 +0000 (UTC)
Subject: [PATCH v1 31/42] NFSD: Update the NFSv2 READDIR result encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:18:25 -0500
Message-ID: <161461190544.8508.10593525144266404868.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsxdr.c |   22 +++++++++++++---------
 fs/nfsd/xdr.h    |    1 +
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 8ae23ed6dc5d..9522e5c5f49d 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -574,17 +574,21 @@ nfssvc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_readdirres *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	if (resp->status != nfs_ok)
-		return xdr_ressize_check(rqstp, p);
-
-	xdr_ressize_check(rqstp, p);
-	p = resp->buffer;
-	*p++ = 0;			/* no more entries */
-	*p++ = htonl((resp->common.err == nfserr_eof));
-	rqstp->rq_res.page_len = resp->count << 2;
+	if (!svcxdr_encode_stat(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		xdr_write_pages(xdr, &resp->page, 0, resp->count << 2);
+		/* no more entries */
+		if (xdr_stream_encode_item_absent(xdr) < 0)
+			return 0;
+		if (xdr_stream_encode_bool(xdr, resp->common.err == nfserr_eof) < 0)
+			return 0;
+		break;
+	}
 
 	return 1;
 }
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 651de13e62fe..69a6efc71ecb 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -114,6 +114,7 @@ struct nfsd_readdirres {
 	__be32 *		buffer;
 	int			buflen;
 	__be32 *		offset;
+	struct page		*page;
 };
 
 struct nfsd_statfsres {


