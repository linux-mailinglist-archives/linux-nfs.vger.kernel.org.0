Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C8432FDDE
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Mar 2021 23:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhCFWdW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Mar 2021 17:33:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhCFWdO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Mar 2021 17:33:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 843B1650D0
        for <linux-nfs@vger.kernel.org>; Sat,  6 Mar 2021 22:33:14 +0000 (UTC)
Subject: [PATCH v2 40/43] NFSD: Update the NFSv3 SETACL result encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 06 Mar 2021 17:33:13 -0500
Message-ID: <161506999379.4312.6200804985899934848.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3acl.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 11991026ab3a..a1591feeea22 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -219,11 +219,11 @@ static int nfs3svc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 /* SETACL */
 static int nfs3svc_encode_setaclres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	p = nfs3svc_encode_post_op_attr(rqstp, p, &resp->fh);
-	return xdr_ressize_check(rqstp, p);
+	return svcxdr_encode_nfsstat3(xdr, resp->status) &&
+		svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh);
 }
 
 /*


