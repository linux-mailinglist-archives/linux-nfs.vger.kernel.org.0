Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C119132FDC5
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Mar 2021 23:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhCFWac (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Mar 2021 17:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhCFWaH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Mar 2021 17:30:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C4F96509D
        for <linux-nfs@vger.kernel.org>; Sat,  6 Mar 2021 22:30:07 +0000 (UTC)
Subject: [PATCH v2 09/43] NFSD: Update the NFSv3 CREATE family of encoders to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 06 Mar 2021 17:30:06 -0500
Message-ID: <161506980679.4312.9985790938132109031.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 0191cbfc486b..052376a65f72 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -121,6 +121,17 @@ svcxdr_encode_nfs_fh3(struct xdr_stream *xdr, const struct svc_fh *fhp)
 	return true;
 }
 
+static bool
+svcxdr_encode_post_op_fh3(struct xdr_stream *xdr, const struct svc_fh *fhp)
+{
+	if (xdr_stream_encode_item_present(xdr) < 0)
+		return false;
+	if (!svcxdr_encode_nfs_fh3(xdr, fhp))
+		return false;
+
+	return true;
+}
+
 static __be32 *
 encode_fh(__be32 *p, struct svc_fh *fhp)
 {
@@ -1079,16 +1090,26 @@ nfs3svc_encode_writeres(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_encode_createres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	if (resp->status == 0) {
-		*p++ = xdr_one;
-		p = encode_fh(p, &resp->fh);
-		p = encode_post_op_attr(rqstp, p, &resp->fh);
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_post_op_fh3(xdr, &resp->fh))
+			return 0;
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+			return 0;
+		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->dirfh))
+			return 0;
+		break;
+	default:
+		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->dirfh))
+			return 0;
 	}
-	p = encode_wcc_data(rqstp, p, &resp->dirfh);
-	return xdr_ressize_check(rqstp, p);
+
+	return 1;
 }
 
 /* RENAME */


