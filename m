Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6B07B8133
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 15:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjJDNmP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 09:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjJDNmP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 09:42:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1829CC
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 06:42:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAEDC433C7;
        Wed,  4 Oct 2023 13:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696426931;
        bh=7bdhWdU/hZv4YE1RRzOgpa/HAfERUY0aI2bNaGaycEI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LesEWZXriHhXQRq95XtQ4rJZXywe+4IaSEZ6ZAs4Q+R2+GsiUQ/Lg5wd3B9LnrsqT
         WLwxVkqdoiK0W6BtbGhnAKUcP8atQ2oSgM7AgQG+PVpNyManqsIUl5yxSrRi4LbwLI
         3Q9ftNNhGgznFKx5cmcXwXST3p8Eu8/4ET/qV0aLHsZVWvLkjlnWmYrZUa6zVfuxpT
         6qpUy6LCnY6nDDCKgfPVx4Rt8mpfUv1GeGCGs7UGl9mAwmRb9MxgPnSUNVrY2mhdsL
         tOsO97crrbZvCl1F0HSRCZGK5IwL4fddZADROXnjuGTWfRyVavmZf0Bo9wLOQzICJL
         0BrD5Nn9FEsbw==
Subject: [PATCH v1 5/5] NFSD: Clean up nfsd4_encode_readdir()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 04 Oct 2023 09:42:10 -0400
Message-ID: <169642693016.7503.11226063374751505918.stgit@klimt.1015granger.net>
In-Reply-To: <169642681764.7503.2925922561588558142.stgit@klimt.1015granger.net>
References: <169642681764.7503.2925922561588558142.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Untangle nfsd4_encode_readdir() so it is more clear what XDR data
item is being encoded by which piece of code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |  112 ++++++++++++++++++++++++++---------------------------
 1 file changed, 55 insertions(+), 57 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index cfc8e241e8fb..5efcd9691e5d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4448,85 +4448,83 @@ nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr,
 	return nfserr;
 }
 
-static __be32
-nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr,
-		     union nfsd4_op_u *u)
+static __be32 nfsd4_encode_dirlist4(struct xdr_stream *xdr,
+				    struct nfsd4_readdir *readdir,
+				    u32 max_payload)
 {
-	struct nfsd4_readdir *readdir = &u->readdir;
-	int maxcount;
-	int bytes_left;
+	int bytes_left, maxcount, starting_len = xdr->buf->len;
 	loff_t offset;
-	struct xdr_stream *xdr = resp->xdr;
-	int starting_len = xdr->buf->len;
-	__be32 *p;
-
-	nfserr = nfsd4_encode_verifier4(xdr, &readdir->rd_verf);
-	if (nfserr != nfs_ok)
-		return nfserr;
+	__be32 status;
 
 	/*
 	 * Number of bytes left for directory entries allowing for the
-	 * final 8 bytes of the readdir and a following failed op:
+	 * final 8 bytes of the readdir and a following failed op.
 	 */
-	bytes_left = xdr->buf->buflen - xdr->buf->len
-			- COMPOUND_ERR_SLACK_SPACE - 8;
-	if (bytes_left < 0) {
-		nfserr = nfserr_resource;
-		goto err_no_verf;
-	}
-	maxcount = svc_max_payload(resp->rqstp);
-	maxcount = min_t(u32, readdir->rd_maxcount, maxcount);
+	bytes_left = xdr->buf->buflen - xdr->buf->len -
+		COMPOUND_ERR_SLACK_SPACE - XDR_UNIT * 2;
+	if (bytes_left < 0)
+		return nfserr_resource;
+	maxcount = min_t(u32, readdir->rd_maxcount, max_payload);
+
 	/*
-	 * Note the rfc defines rd_maxcount as the size of the
-	 * READDIR4resok structure, which includes the verifier above
-	 * and the 8 bytes encoded at the end of this function:
+	 * The RFC defines rd_maxcount as the size of the
+	 * READDIR4resok structure, which includes the verifier
+	 * and the 8 bytes encoded at the end of this function.
 	 */
-	if (maxcount < 16) {
-		nfserr = nfserr_toosmall;
-		goto err_no_verf;
-	}
-	maxcount = min_t(int, maxcount-16, bytes_left);
+	if (maxcount < XDR_UNIT * 4)
+		return nfserr_toosmall;
+	maxcount = min_t(int, maxcount - XDR_UNIT * 4, bytes_left);
 
-	/* RFC 3530 14.2.24 allows us to ignore dircount when it's 0: */
+	/* RFC 3530 14.2.24 allows us to ignore dircount when it's 0 */
 	if (!readdir->rd_dircount)
-		readdir->rd_dircount = svc_max_payload(resp->rqstp);
+		readdir->rd_dircount = max_payload;
 
+	/* *entries */
 	readdir->xdr = xdr;
 	readdir->rd_maxcount = maxcount;
 	readdir->common.err = 0;
 	readdir->cookie_offset = 0;
-
 	offset = readdir->rd_cookie;
-	nfserr = nfsd_readdir(readdir->rd_rqstp, readdir->rd_fhp, &offset,
+	status = nfsd_readdir(readdir->rd_rqstp, readdir->rd_fhp, &offset,
 			      &readdir->common, nfsd4_encode_entry4);
-	if (nfserr == nfs_ok &&
-	    readdir->common.err == nfserr_toosmall &&
-	    xdr->buf->len == starting_len + 8) {
-		/* nothing encoded; which limit did we hit?: */
-		if (maxcount - 16 < bytes_left)
-			/* It was the fault of rd_maxcount: */
-			nfserr = nfserr_toosmall;
-		else
-			/* We ran out of buffer space: */
-			nfserr = nfserr_resource;
+	if (status)
+		return status;
+	if (readdir->common.err == nfserr_toosmall &&
+	    xdr->buf->len == starting_len) {
+		/* No entries were encoded. Which limit did we hit? */
+		if (maxcount - XDR_UNIT * 4 < bytes_left)
+			/* It was the fault of rd_maxcount */
+			return nfserr_toosmall;
+		/* We ran out of buffer space */
+		return nfserr_resource;
 	}
-	if (nfserr)
-		goto err_no_verf;
-
 	/* Encode the final entry's cookie value */
 	nfsd4_encode_entry4_nfs_cookie4(readdir, offset);
+	/* No entries follow */
+	if (xdr_stream_encode_item_absent(xdr) != XDR_UNIT)
+		return nfserr_resource;
 
-	p = xdr_reserve_space(xdr, 8);
-	if (!p) {
-		WARN_ON_ONCE(1);
-		goto err_no_verf;
-	}
-	*p++ = 0;	/* no more entries */
-	*p++ = htonl(readdir->common.err == nfserr_eof);
+	/* eof */
+	return nfsd4_encode_bool(xdr, readdir->common.err == nfserr_eof);
+}
 
-	return 0;
-err_no_verf:
-	xdr_truncate_encode(xdr, starting_len);
+static __be32
+nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr,
+		     union nfsd4_op_u *u)
+{
+	struct nfsd4_readdir *readdir = &u->readdir;
+	struct xdr_stream *xdr = resp->xdr;
+	int starting_len = xdr->buf->len;
+
+	/* cookieverf */
+	nfserr = nfsd4_encode_verifier4(xdr, &readdir->rd_verf);
+	if (nfserr != nfs_ok)
+		return nfserr;
+
+	/* reply */
+	nfserr = nfsd4_encode_dirlist4(xdr, readdir, svc_max_payload(resp->rqstp));
+	if (nfserr != nfs_ok)
+		xdr_truncate_encode(xdr, starting_len);
 	return nfserr;
 }
 


