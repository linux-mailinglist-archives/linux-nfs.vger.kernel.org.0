Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71C07B812E
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 15:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjJDNl4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 09:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjJDNlz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 09:41:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE530BD
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 06:41:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C712C433C8;
        Wed,  4 Oct 2023 13:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696426912;
        bh=3QfietrAj3DTSx1qAZKGOWQZTTO2iq8xFKdPuQhHQ0Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Du5ClrtbOYHPy3rsCydG3n/89TanY7uM5h/jEtIrn4TQn6vKz+aAgjITnq4Gqg70l
         f2T++7HsnO6217VJ5gk/cL8eMH7cBC75DY9b9tcE2lTltAWXxf8rxPYL7ovzkXj+3N
         zU8u6JvJjKcnpN7UYNjU5MkujpbIYJ+WKddHy9qBWGbYdF+spzO0nsgp979qNPb+q1
         ZT97/7qg4UuM5AXeWkkc8pMA1gMmTLk/Fb2k6Oj6jBEqGCCvQeuVX2NegcR52DRb5r
         kfinbGFjEDybjGerfU2qNBYke1TUcrccTtLJodNyB6yUzuJX0O5BRoH0eQgUZEdLej
         8plwUqT/qOyxA==
Subject: [PATCH v1 2/5] NFSD: Clean up nfsd4_encode_rdattr_error()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 04 Oct 2023 09:41:51 -0400
Message-ID: <169642691116.7503.5603118483366668621.stgit@klimt.1015granger.net>
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

No need for specialized code here, as this function is invoked only
rarely. Convert it to encode to xdr_stream using conventional XDR
helpers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a6b6ff5819e9..26a9391d7766 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3722,21 +3722,22 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
 	return nfserr;
 }
 
-static __be32 *
-nfsd4_encode_rdattr_error(struct xdr_stream *xdr, __be32 nfserr)
+static __be32
+nfsd4_encode_entry4_rdattr_error(struct xdr_stream *xdr, __be32 nfserr)
 {
-	__be32 *p;
-
-	p = xdr_reserve_space(xdr, 20);
-	if (!p)
-		return NULL;
-	*p++ = htonl(2);
-	*p++ = htonl(FATTR4_WORD0_RDATTR_ERROR); /* bmval0 */
-	*p++ = htonl(0);			 /* bmval1 */
+	__be32 status;
 
-	*p++ = htonl(4);     /* attribute length */
-	*p++ = nfserr;       /* no htonl */
-	return p;
+	/* attrmask */
+	status = nfsd4_encode_bitmap4(xdr, FATTR4_WORD0_RDATTR_ERROR, 0, 0);
+	if (status != nfs_ok)
+		return status;
+	/* attr_vals */
+	if (xdr_stream_encode_u32(xdr, XDR_UNIT) != XDR_UNIT)
+		return nfserr_resource;
+	/* rdattr_error */
+	if (xdr_stream_encode_be32(xdr, nfserr) != XDR_UNIT)
+		return nfserr_resource;
+	return nfs_ok;
 }
 
 static int
@@ -3808,8 +3809,7 @@ nfsd4_encode_entry4(void *ccdv, const char *name, int namlen,
 		 */
 		if (!(cd->rd_bmval[0] & FATTR4_WORD0_RDATTR_ERROR))
 			goto fail;
-		p = nfsd4_encode_rdattr_error(xdr, nfserr);
-		if (p == NULL) {
+		if (nfsd4_encode_entry4_rdattr_error(xdr, nfserr)) {
 			nfserr = nfserr_toosmall;
 			goto fail;
 		}


