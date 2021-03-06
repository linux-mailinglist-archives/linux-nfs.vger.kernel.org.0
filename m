Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCA132FDC1
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Mar 2021 23:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhCFWad (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Mar 2021 17:30:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhCFWac (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Mar 2021 17:30:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5D1C6509D
        for <linux-nfs@vger.kernel.org>; Sat,  6 Mar 2021 22:30:31 +0000 (UTC)
Subject: [PATCH v2 13/43] NFSD: Update the NFSv3 FSINFO3res encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 06 Mar 2021 17:30:30 -0500
Message-ID: <161506983093.4312.13142437982897767662.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   62 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index e4a569e7216d..514f53ad7302 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -24,6 +24,15 @@ static const struct svc_fh nfs3svc_null_fh = {
 	.fh_no_wcc	= true,
 };
 
+/*
+ * time_delta. {1, 0} means the server is accurate only
+ * to the nearest second.
+ */
+static const struct timespec64 nfs3svc_time_delta = {
+	.tv_sec		= 1,
+	.tv_nsec	= 0,
+};
+
 /*
  * Mapping of S_IF* types to NFS file types
  */
@@ -1445,30 +1454,51 @@ nfs3svc_encode_fsstatres(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
+static bool
+svcxdr_encode_fsinfo3resok(struct xdr_stream *xdr,
+			   const struct nfsd3_fsinfores *resp)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT * 12);
+	if (!p)
+		return false;
+	*p++ = cpu_to_be32(resp->f_rtmax);
+	*p++ = cpu_to_be32(resp->f_rtpref);
+	*p++ = cpu_to_be32(resp->f_rtmult);
+	*p++ = cpu_to_be32(resp->f_wtmax);
+	*p++ = cpu_to_be32(resp->f_wtpref);
+	*p++ = cpu_to_be32(resp->f_wtmult);
+	*p++ = cpu_to_be32(resp->f_dtpref);
+	p = xdr_encode_hyper(p, resp->f_maxfilesize);
+	p = encode_nfstime3(p, &nfs3svc_time_delta);
+	*p = cpu_to_be32(resp->f_properties);
+
+	return true;
+}
+
 /* FSINFO */
 int
 nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_fsinfores *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	*p++ = xdr_zero;	/* no post_op_attr */
-
-	if (resp->status == 0) {
-		*p++ = htonl(resp->f_rtmax);
-		*p++ = htonl(resp->f_rtpref);
-		*p++ = htonl(resp->f_rtmult);
-		*p++ = htonl(resp->f_wtmax);
-		*p++ = htonl(resp->f_wtpref);
-		*p++ = htonl(resp->f_wtmult);
-		*p++ = htonl(resp->f_dtpref);
-		p = xdr_encode_hyper(p, resp->f_maxfilesize);
-		*p++ = xdr_one;
-		*p++ = xdr_zero;
-		*p++ = htonl(resp->f_properties);
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
+			return 0;
+		if (!svcxdr_encode_fsinfo3resok(xdr, resp))
+			return 0;
+		break;
+	default:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
+			return 0;
 	}
 
-	return xdr_ressize_check(rqstp, p);
+	return 1;
 }
 
 /* PATHCONF */


