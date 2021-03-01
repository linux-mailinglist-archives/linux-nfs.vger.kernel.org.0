Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA54232821E
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhCAPRh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:17:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237033AbhCAPRa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:17:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA36D600CC
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:16:31 +0000 (UTC)
Subject: [PATCH v1 12/42] NFSD: Update the NFSv3 FSSTAT3res encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:16:31 -0500
Message-ID: <161461179102.8508.11890812651210896607.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   58 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index e159e4557428..e4a569e7216d 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -17,6 +17,13 @@
 #define NFSDDBG_FACILITY		NFSDDBG_XDR
 
 
+/*
+ * Force construction of an empty post-op attr
+ */
+static const struct svc_fh nfs3svc_null_fh = {
+	.fh_no_wcc	= true,
+};
+
 /*
  * Mapping of S_IF* types to NFS file types
  */
@@ -1392,27 +1399,50 @@ nfs3svc_encode_entry_plus(void *cd, const char *name,
 	return encode_entry(cd, name, namlen, offset, ino, d_type, 1);
 }
 
+static bool
+svcxdr_encode_fsstat3resok(struct xdr_stream *xdr,
+			   const struct nfsd3_fsstatres *resp)
+{
+	const struct kstatfs *s = &resp->stats;
+	u64 bs = s->f_bsize;
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT * 13);
+	if (!p)
+		return false;
+	p = xdr_encode_hyper(p, bs * s->f_blocks);	/* total bytes */
+	p = xdr_encode_hyper(p, bs * s->f_bfree);	/* free bytes */
+	p = xdr_encode_hyper(p, bs * s->f_bavail);	/* user available bytes */
+	p = xdr_encode_hyper(p, s->f_files);		/* total inodes */
+	p = xdr_encode_hyper(p, s->f_ffree);		/* free inodes */
+	p = xdr_encode_hyper(p, s->f_ffree);		/* user available inodes */
+	*p = cpu_to_be32(resp->invarsec);		/* mean unchanged time */
+
+	return true;
+}
+
 /* FSSTAT */
 int
 nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_fsstatres *resp = rqstp->rq_resp;
-	struct kstatfs	*s = &resp->stats;
-	u64		bs = s->f_bsize;
 
-	*p++ = resp->status;
-	*p++ = xdr_zero;	/* no post_op_attr */
-
-	if (resp->status == 0) {
-		p = xdr_encode_hyper(p, bs * s->f_blocks);	/* total bytes */
-		p = xdr_encode_hyper(p, bs * s->f_bfree);	/* free bytes */
-		p = xdr_encode_hyper(p, bs * s->f_bavail);	/* user available bytes */
-		p = xdr_encode_hyper(p, s->f_files);	/* total inodes */
-		p = xdr_encode_hyper(p, s->f_ffree);	/* free inodes */
-		p = xdr_encode_hyper(p, s->f_ffree);	/* user available inodes */
-		*p++ = htonl(resp->invarsec);	/* mean unchanged time */
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
+			return 0;
+		if (!svcxdr_encode_fsstat3resok(xdr, resp))
+			return 0;
+		break;
+	default:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
+			return 0;
 	}
-	return xdr_ressize_check(rqstp, p);
+
+	return 1;
 }
 
 /* FSINFO */


