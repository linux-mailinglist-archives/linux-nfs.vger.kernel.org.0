Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBFC32821A
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbhCAPRa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:17:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236915AbhCAPRZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:17:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87BD664E31
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:16:07 +0000 (UTC)
Subject: [PATCH v1 08/42] NFSD: Update the NFSv3 WRITE3res encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:16:06 -0500
Message-ID: <161461176674.8508.12991761223475535795.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 859cc6c51c1a..0191cbfc486b 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -131,6 +131,19 @@ encode_fh(__be32 *p, struct svc_fh *fhp)
 	return p + XDR_QUADLEN(size);
 }
 
+static bool
+svcxdr_encode_writeverf3(struct xdr_stream *xdr, const __be32 *verf)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, NFS3_WRITEVERFSIZE);
+	if (!p)
+		return false;
+	memcpy(p, verf, NFS3_WRITEVERFSIZE);
+
+	return true;
+}
+
 static bool
 svcxdr_decode_filename3(struct xdr_stream *xdr, char **name, unsigned int *len)
 {
@@ -1038,17 +1051,28 @@ nfs3svc_encode_readres(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_encode_writeres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_writeres *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	p = encode_wcc_data(rqstp, p, &resp->fh);
-	if (resp->status == 0) {
-		*p++ = htonl(resp->count);
-		*p++ = htonl(resp->committed);
-		*p++ = resp->verf[0];
-		*p++ = resp->verf[1];
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_wcc_data(rqstp, xdr, &resp->fh))
+			return 0;
+		if (xdr_stream_encode_u32(xdr, resp->count) < 0)
+			return 0;
+		if (xdr_stream_encode_u32(xdr, resp->committed) < 0)
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
 
 /* CREATE, MKDIR, SYMLINK, MKNOD */


