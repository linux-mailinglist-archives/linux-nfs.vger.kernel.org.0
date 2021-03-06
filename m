Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DBE32FDC6
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Mar 2021 23:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhCFWac (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Mar 2021 17:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhCFWaB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Mar 2021 17:30:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80178650D0
        for <linux-nfs@vger.kernel.org>; Sat,  6 Mar 2021 22:30:01 +0000 (UTC)
Subject: [PATCH v2 08/43] NFSD: Update the NFSv3 WRITE3res encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 06 Mar 2021 17:30:00 -0500
Message-ID: <161506980076.4312.5094651486155562367.stgit@klimt.1015granger.net>
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


