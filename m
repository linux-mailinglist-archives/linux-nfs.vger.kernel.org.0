Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF37328234
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbhCAPTB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:19:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237082AbhCAPSs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:18:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E179B64E01
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:18:07 +0000 (UTC)
Subject: [PATCH v1 28/42] NFSD: Update the NFSv2 STATFS result encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:18:07 -0500
Message-ID: <161461188720.8508.6558067613011265623.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsxdr.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index d6d7d07dbb1b..39d296aecd3e 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -592,19 +592,26 @@ nfssvc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_encode_statfsres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd_statfsres *resp = rqstp->rq_resp;
 	struct kstatfs	*stat = &resp->stats;
 
-	*p++ = resp->status;
-	if (resp->status != nfs_ok)
-		return xdr_ressize_check(rqstp, p);
+	if (!svcxdr_encode_stat(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		p = xdr_reserve_space(xdr, XDR_UNIT * 5);
+		if (!p)
+			return 0;
+		*p++ = cpu_to_be32(NFSSVC_MAXBLKSIZE_V2);
+		*p++ = cpu_to_be32(stat->f_bsize);
+		*p++ = cpu_to_be32(stat->f_blocks);
+		*p++ = cpu_to_be32(stat->f_bfree);
+		*p = cpu_to_be32(stat->f_bavail);
+		break;
+	}
 
-	*p++ = htonl(NFSSVC_MAXBLKSIZE_V2);	/* max transfer size */
-	*p++ = htonl(stat->f_bsize);
-	*p++ = htonl(stat->f_blocks);
-	*p++ = htonl(stat->f_bfree);
-	*p++ = htonl(stat->f_bavail);
-	return xdr_ressize_check(rqstp, p);
+	return 1;
 }
 
 int


