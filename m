Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DD03BA2DA
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jul 2021 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhGBPkY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Jul 2021 11:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhGBPkX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Jul 2021 11:40:23 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6874C061762
        for <linux-nfs@vger.kernel.org>; Fri,  2 Jul 2021 08:37:51 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2646B6482; Fri,  2 Jul 2021 11:37:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2646B6482
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1625240271;
        bh=RMlGmxw1gL9vINTfmaaDQlB36HAck4fofdq2QwTDLfM=;
        h=Date:To:Cc:Subject:From:From;
        b=NVKy/i57vRHObguXY7ZZW12vmP/BGGBtpQGTAdVX997nICQABOgKetTCx+SC9sI21
         1Gn8C5h8sXNHs09YtODhy1+ofmvHMXrUTmFlppSsNwzyRh0yOi104k/pfJjggt1Esd
         25CpEqdg7Ts/mqECFjMjgA+3P+vUSnmZzzrNko3o=
Date:   Fri, 2 Jul 2021 11:37:51 -0400
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] nfsd: fix NULL dereference in nfs3svc_encode_getaclres
Message-ID: <20210702153751.GA29685@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

In error cases the dentry may be NULL.

Before 20798dfe249a, the encoder also checked dentry and
d_really_is_positive(dentry), but that looks like overkill to me--zero
status should be enough to guarantee a positive dentry.

This isn't the first time we've seen an error-case NULL dereference
hidden in the initialization of a local variable in an xdr encoder.  But
I went back through the other recent rewrites and didn't spot any
similar bugs.

Reported-by: JianHong Yin <jiyin@redhat.com>
Fixes: 20798dfe249a ("NFSD: Update the NFSv3 GETACL result encoder...")
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs3acl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index a1591feeea22..5dfe7644a517 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -172,7 +172,7 @@ static int nfs3svc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
 	struct dentry *dentry = resp->fh.fh_dentry;
 	struct kvec *head = rqstp->rq_res.head;
-	struct inode *inode = d_inode(dentry);
+	struct inode *inode;
 	unsigned int base;
 	int n;
 	int w;
@@ -181,6 +181,7 @@ static int nfs3svc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 		return 0;
 	switch (resp->status) {
 	case nfs_ok:
+		inode = d_inode(dentry);
 		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &resp->fh))
 			return 0;
 		if (xdr_stream_encode_u32(xdr, resp->mask) < 0)
-- 
2.31.1

