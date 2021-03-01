Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F91328212
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbhCAPQx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:16:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237043AbhCAPQZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:16:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63D5764E12
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:15:43 +0000 (UTC)
Subject: [PATCH v1 04/42] NFSD: Update the NFSv3 LOOKUP3res encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:15:42 -0500
Message-ID: <161461174266.8508.12126784460493352342.stgit@klimt.1015granger.net>
In-Reply-To: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Also, clean up: Rename the encoder function to match the name of
the result structure in RFC 1813, consistent with other encoder
function names in nfs3xdr.c. "diropres" is an NFSv2 thingie.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    2 +-
 fs/nfsd/nfs3xdr.c  |   43 +++++++++++++++++++++++++++++++++++--------
 fs/nfsd/xdr3.h     |    2 +-
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 76a84481d526..49b018afc6ea 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -758,7 +758,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 	[NFS3PROC_LOOKUP] = {
 		.pc_func = nfsd3_proc_lookup,
 		.pc_decode = nfs3svc_decode_diropargs,
-		.pc_encode = nfs3svc_encode_diropres,
+		.pc_encode = nfs3svc_encode_lookupres,
 		.pc_release = nfs3svc_release_fhandle2,
 		.pc_argsize = sizeof(struct nfsd3_diropargs),
 		.pc_ressize = sizeof(struct nfsd3_diropres),
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 9d6c989df6d8..2bb998b3834b 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -104,6 +104,23 @@ svcxdr_encode_nfsstat3(struct xdr_stream *xdr, __be32 status)
 	return true;
 }
 
+static bool
+svcxdr_encode_nfs_fh3(struct xdr_stream *xdr, const struct svc_fh *fhp)
+{
+	u32 size = fhp->fh_handle.fh_size;
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT + size);
+	if (!p)
+		return false;
+	*p++ = cpu_to_be32(size);
+	if (size)
+		p[XDR_QUADLEN(size) - 1] = 0;
+	memcpy(p, &fhp->fh_handle.fh_base, size);
+
+	return true;
+}
+
 static __be32 *
 encode_fh(__be32 *p, struct svc_fh *fhp)
 {
@@ -846,18 +863,28 @@ nfs3svc_encode_wccstat(struct svc_rqst *rqstp, __be32 *p)
 }
 
 /* LOOKUP */
-int
-nfs3svc_encode_diropres(struct svc_rqst *rqstp, __be32 *p)
+int nfs3svc_encode_lookupres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	if (resp->status == 0) {
-		p = encode_fh(p, &resp->fh);
-		p = encode_post_op_attr(rqstp, p, &resp->fh);
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_nfs_fh3(xdr, &resp->fh))
+			return 0;
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
+			return 0;
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->dirfh))
+			return 0;
+		break;
+	default:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->dirfh))
+			return 0;
 	}
-	p = encode_post_op_attr(rqstp, p, &resp->dirfh);
-	return xdr_ressize_check(rqstp, p);
+
+	return 1;
 }
 
 /* ACCESS */
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 0822981c61b9..7db4ee17aa20 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -282,7 +282,7 @@ int nfs3svc_decode_readdirplusargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_commitargs(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_getattrres(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_wccstat(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_diropres(struct svc_rqst *, __be32 *);
+int nfs3svc_encode_lookupres(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_accessres(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_readlinkres(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_readres(struct svc_rqst *, __be32 *);


