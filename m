Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5098832FDC4
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Mar 2021 23:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCFWad (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Mar 2021 17:30:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:34190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229861AbhCFWaN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Mar 2021 17:30:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3609650D0
        for <linux-nfs@vger.kernel.org>; Sat,  6 Mar 2021 22:30:13 +0000 (UTC)
Subject: [PATCH v2 10/43] NFSD: Update the NFSv3 RENAMEv3res encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 06 Mar 2021 17:30:12 -0500
Message-ID: <161506981290.4312.12720351255284346875.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 052376a65f72..1d52a69562b8 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1116,12 +1116,12 @@ nfs3svc_encode_createres(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_encode_renameres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_renameres *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	p = encode_wcc_data(rqstp, p, &resp->ffh);
-	p = encode_wcc_data(rqstp, p, &resp->tfh);
-	return xdr_ressize_check(rqstp, p);
+	return svcxdr_encode_nfsstat3(xdr, resp->status) &&
+		svcxdr_encode_wcc_data(rqstp, xdr, &resp->ffh) &&
+		svcxdr_encode_wcc_data(rqstp, xdr, &resp->tfh);
 }
 
 /* LINK */


