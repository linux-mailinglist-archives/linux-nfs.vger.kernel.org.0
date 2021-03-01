Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F7232824A
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbhCAPTu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:19:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237060AbhCAPTm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:19:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FAB364E22
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:19:02 +0000 (UTC)
Subject: [PATCH v1 37/42] NFSD: Update the NFSv2 ACL GETATTR result encoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:19:01 -0500
Message-ID: <161461194139.8508.5689155130398147462.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs2acl.c |   24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 9c572ffa5e7b..9270530a0c2f 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -279,19 +279,6 @@ static int nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
-static int nfsaclsvc_encode_attrstatres(struct svc_rqst *rqstp, __be32 *p)
-{
-	struct nfsd_attrstat *resp = rqstp->rq_resp;
-
-	*p++ = resp->status;
-	if (resp->status != nfs_ok)
-		goto out;
-
-	p = nfs2svc_encode_fattr(rqstp, p, &resp->fh, &resp->stat);
-out:
-	return xdr_ressize_check(rqstp, p);
-}
-
 /* ACCESS */
 static int nfsaclsvc_encode_accessres(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -319,13 +306,6 @@ static void nfsaclsvc_release_getacl(struct svc_rqst *rqstp)
 	posix_acl_release(resp->acl_default);
 }
 
-static void nfsaclsvc_release_attrstat(struct svc_rqst *rqstp)
-{
-	struct nfsd_attrstat *resp = rqstp->rq_resp;
-
-	fh_put(&resp->fh);
-}
-
 static void nfsaclsvc_release_access(struct svc_rqst *rqstp)
 {
 	struct nfsd3_accessres *resp = rqstp->rq_resp;
@@ -376,8 +356,8 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 	[ACLPROC2_GETATTR] = {
 		.pc_func = nfsacld_proc_getattr,
 		.pc_decode = nfssvc_decode_fhandleargs,
-		.pc_encode = nfsaclsvc_encode_attrstatres,
-		.pc_release = nfsaclsvc_release_attrstat,
+		.pc_encode = nfssvc_encode_attrstatres,
+		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
 		.pc_cachetype = RC_NOCACHE,


