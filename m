Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6BD32822F
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhCAPSe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:18:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237082AbhCAPSa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:18:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA19F64E22
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:17:49 +0000 (UTC)
Subject: [PATCH v1 25/42] NFSD: Update the NFSv2 diropres encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:17:49 -0500
Message-ID: <161461186923.8508.8982817749793595128.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsxdr.c |   38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 65c8f8f31444..989144b0d5be 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -63,11 +63,17 @@ svcxdr_decode_fhandle(struct xdr_stream *xdr, struct svc_fh *fhp)
 	return true;
 }
 
-static __be32 *
-encode_fh(__be32 *p, struct svc_fh *fhp)
+static bool
+svcxdr_encode_fhandle(struct xdr_stream *xdr, const struct svc_fh *fhp)
 {
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, NFS_FHSIZE);
+	if (!p)
+		return false;
 	memcpy(p, &fhp->fh_handle.fh_base, NFS_FHSIZE);
-	return p + (NFS_FHSIZE>> 2);
+
+	return true;
 }
 
 static __be32 *
@@ -244,7 +250,7 @@ encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp,
 	return p;
 }
 
-static int
+static bool
 svcxdr_encode_fattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		    const struct svc_fh *fhp, const struct kstat *stat)
 {
@@ -257,7 +263,7 @@ svcxdr_encode_fattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 
 	p = xdr_reserve_space(xdr, XDR_UNIT * 17);
 	if (!p)
-		return 0;
+		return false;
 
 	*p++ = cpu_to_be32(nfs_ftypes[type >> 12]);
 	*p++ = cpu_to_be32((u32)stat->mode);
@@ -299,7 +305,7 @@ svcxdr_encode_fattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	p = encode_timeval(p, &time);
 	encode_timeval(p, &stat->ctime);
 
-	return 1;
+	return true;
 }
 
 /* Helper function for NFSv2 ACL code */
@@ -501,15 +507,21 @@ nfssvc_encode_attrstatres(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_encode_diropres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_diropres *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	if (resp->status != nfs_ok)
-		goto out;
-	p = encode_fh(p, &resp->fh);
-	p = encode_fattr(rqstp, p, &resp->fh, &resp->stat);
-out:
-	return xdr_ressize_check(rqstp, p);
+	if (!svcxdr_encode_stat(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_fhandle(xdr, &resp->fh))
+			return 0;
+		if (!svcxdr_encode_fattr(rqstp, xdr, &resp->fh, &resp->stat))
+			return 0;
+		break;
+	}
+
+	return 1;
 }
 
 int


