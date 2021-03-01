Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A640D32821C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbhCAPRe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:17:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:40674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237020AbhCAPR1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:17:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3F00614A5
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:16:43 +0000 (UTC)
Subject: [PATCH v1 14/42] NFSD: Update the NFSv3 PATHCONF3res encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:16:43 -0500
Message-ID: <161461180307.8508.9954286154242416300.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 514f53ad7302..8485ab50ff3f 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1501,25 +1501,47 @@ nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
+static bool
+svcxdr_encode_pathconf3resok(struct xdr_stream *xdr,
+			     const struct nfsd3_pathconfres *resp)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT * 6);
+	if (!p)
+		return false;
+	*p++ = cpu_to_be32(resp->p_link_max);
+	*p++ = cpu_to_be32(resp->p_name_max);
+	*p++ = resp->p_no_trunc ? xdr_one : xdr_zero;
+	*p++ = resp->p_chown_restricted ? xdr_one : xdr_zero;
+	*p++ = resp->p_case_insensitive ? xdr_one : xdr_zero;
+	*p = resp->p_case_preserving ? xdr_one : xdr_zero;
+
+	return true;
+}
+
 /* PATHCONF */
 int
 nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_pathconfres *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	*p++ = xdr_zero;	/* no post_op_attr */
-
-	if (resp->status == 0) {
-		*p++ = htonl(resp->p_link_max);
-		*p++ = htonl(resp->p_name_max);
-		*p++ = htonl(resp->p_no_trunc);
-		*p++ = htonl(resp->p_chown_restricted);
-		*p++ = htonl(resp->p_case_insensitive);
-		*p++ = htonl(resp->p_case_preserving);
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
+			return 0;
+		if (!svcxdr_encode_pathconf3resok(xdr, resp))
+			return 0;
+		break;
+	default:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
+			return 0;
 	}
 
-	return xdr_ressize_check(rqstp, p);
+	return 1;
 }
 
 /* COMMIT */


