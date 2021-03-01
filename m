Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24079328214
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbhCAPRS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:17:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236841AbhCAPRM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:17:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F28F64E2E
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:15:49 +0000 (UTC)
Subject: [PATCH v1 05/42] NFSD: Update the NFSv3 wccstat result encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:15:48 -0500
Message-ID: <161461174867.8508.16627455899477344158.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 2bb998b3834b..29b923a497f4 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -400,6 +400,35 @@ encode_saved_post_attr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp)
 	return encode_fattr3(rqstp, p, fhp, &fhp->fh_post_attr);
 }
 
+static bool
+svcxdr_encode_wcc_attr(struct xdr_stream *xdr, const struct svc_fh *fhp)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT * 6);
+	if (!p)
+		return false;
+	p = xdr_encode_hyper(p, (u64)fhp->fh_pre_size);
+	p = encode_nfstime3(p, &fhp->fh_pre_mtime);
+	encode_nfstime3(p, &fhp->fh_pre_ctime);
+
+	return true;
+}
+
+static bool
+svcxdr_encode_pre_op_attr(struct xdr_stream *xdr, const struct svc_fh *fhp)
+{
+	if (!fhp->fh_pre_saved) {
+		if (xdr_stream_encode_item_absent(xdr) < 0)
+			return false;
+		return true;
+	}
+
+	if (xdr_stream_encode_item_present(xdr) < 0)
+		return false;
+	return svcxdr_encode_wcc_attr(xdr, fhp);
+}
+
 static bool
 svcxdr_encode_post_op_attr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 			   const struct svc_fh *fhp)
@@ -460,6 +489,39 @@ nfs3svc_encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fh
 	return encode_post_op_attr(rqstp, p, fhp);
 }
 
+/*
+ * Encode weak cache consistency data
+ */
+static bool
+svcxdr_encode_wcc_data(struct svc_rqst *rqstp, struct xdr_stream *xdr,
+		       const struct svc_fh *fhp)
+{
+	struct dentry *dentry = fhp->fh_dentry;
+
+	if (!dentry || !d_really_is_positive(dentry) || !fhp->fh_post_saved)
+		goto neither;
+
+	/* before */
+	if (!svcxdr_encode_pre_op_attr(xdr, fhp))
+		return false;
+
+	/* after */
+	if (xdr_stream_encode_item_present(xdr) < 0)
+		return false;
+	if (!svcxdr_encode_fattr3(rqstp, xdr, fhp, &fhp->fh_post_attr))
+		return false;
+
+	return true;
+
+neither:
+	if (xdr_stream_encode_item_absent(xdr) < 0)
+		return false;
+	if (!svcxdr_encode_post_op_attr(rqstp, xdr, fhp))
+		return false;
+
+	return true;
+}
+
 /*
  * Enocde weak cache consistency data
  */
@@ -855,11 +917,11 @@ nfs3svc_encode_getattrres(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_encode_wccstat(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	p = encode_wcc_data(rqstp, p, &resp->fh);
-	return xdr_ressize_check(rqstp, p);
+	return svcxdr_encode_nfsstat3(xdr, resp->status) &&
+		svcxdr_encode_wcc_data(rqstp, xdr, &resp->fh);
 }
 
 /* LOOKUP */


