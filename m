Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DBB32FDCB
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Mar 2021 23:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhCFWbH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Mar 2021 17:31:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229901AbhCFWao (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Mar 2021 17:30:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE0A1650D7
        for <linux-nfs@vger.kernel.org>; Sat,  6 Mar 2021 22:30:43 +0000 (UTC)
Subject: [PATCH v2 15/43] NFSD: Update the NFSv3 COMMIT3res encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 06 Mar 2021 17:30:42 -0500
Message-ID: <161506984295.4312.2875289986709067202.stgit@klimt.1015granger.net>
In-Reply-To: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
References: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As an additional clean up, encode_wcc_data() is removed because it
is now no longer used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |   54 +++++++++++++++--------------------------------------
 1 file changed, 15 insertions(+), 39 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 1467bba02e18..eab14b52db20 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -432,14 +432,6 @@ encode_fattr3(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 	return p;
 }
 
-static __be32 *
-encode_saved_post_attr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp)
-{
-	/* Attributes to follow */
-	*p++ = xdr_one;
-	return encode_fattr3(rqstp, p, fhp, &fhp->fh_post_attr);
-}
-
 static bool
 svcxdr_encode_wcc_attr(struct xdr_stream *xdr, const struct svc_fh *fhp)
 {
@@ -562,30 +554,6 @@ svcxdr_encode_wcc_data(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	return true;
 }
 
-/*
- * Enocde weak cache consistency data
- */
-static __be32 *
-encode_wcc_data(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp)
-{
-	struct dentry	*dentry = fhp->fh_dentry;
-
-	if (dentry && d_really_is_positive(dentry) && fhp->fh_post_saved) {
-		if (fhp->fh_pre_saved) {
-			*p++ = xdr_one;
-			p = xdr_encode_hyper(p, (u64) fhp->fh_pre_size);
-			p = encode_time3(p, &fhp->fh_pre_mtime);
-			p = encode_time3(p, &fhp->fh_pre_ctime);
-		} else {
-			*p++ = xdr_zero;
-		}
-		return encode_saved_post_attr(rqstp, p, fhp);
-	}
-	/* no pre- or post-attrs */
-	*p++ = xdr_zero;
-	return encode_post_op_attr(rqstp, p, fhp);
-}
-
 static bool fs_supports_change_attribute(struct super_block *sb)
 {
 	return sb->s_flags & SB_I_VERSION || sb->s_export_op->fetch_iversion;
@@ -1548,16 +1516,24 @@ nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_encode_commitres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_commitres *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	p = encode_wcc_data(rqstp, p, &resp->fh);
-	/* Write verifier */
-	if (resp->status == 0) {
-		*p++ = resp->verf[0];
-		*p++ = resp->verf[1];
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->fh))
+			return 0;
+		if (!svcxdr_encode_writeverf3(xdr, resp->verf))
+			return 0;
+		break;
+	default:
+		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->fh))
+			return 0;
 	}
-	return xdr_ressize_check(rqstp, p);
+
+	return 1;
 }
 
 /*


