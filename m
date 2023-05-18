Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA68708721
	for <lists+linux-nfs@lfdr.de>; Thu, 18 May 2023 19:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjERRqF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 May 2023 13:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjERRpz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 May 2023 13:45:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D8B10D7
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 10:45:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B30A65152
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 17:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B4AC433D2;
        Thu, 18 May 2023 17:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684431945;
        bh=w9dAfnhhZKznEo7cq52KQd5r+P0fpvIilJBFp8XqpGs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o7wA40gOV0D16I2HtIzDQfWxJdpZU5w4yEm5XqWvU0xdDIHWX5zd9AB6UlotSuePJ
         FRm7vhRWl5ILgCTXU5yxbGNpwwmzYMo5KfJFfcPvPg7coRctuPrIlDW9R9ZDSQQ+4r
         a+U6sGlwZYqn2DGL0O4gxQv1pB/fFecMlUe0BpHo3AWJmEx5ZgIm1Ob26Yj+1T9KJK
         DEwNHcu6d9J67GYnY2+C736gFKhlLstU+M/N5OxEriui645Hix3T30GGZp+oLP/zza
         XNlr4joDjrZ4McIU3leBXqxwMj7bvsY1r94HVGf3vhuBwPbVOFJ7R3iKKGgmBc57tV
         ADVMwGwUKbtwg==
Subject: [PATCH v1 2/6] NFSD: Use svcxdr_encode_opaque_pages() in
 nfsd4_encode_splice_read()
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, dhowells@redhat.com, jlayton@redhat.com
Cc:     Andy Zlotek <andy.zlotek@oracle.com>,
        Calum Mackay <calum.mackay@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Thu, 18 May 2023 13:45:43 -0400
Message-ID: <168443194347.516083.17882210704288086567.stgit@klimt.1015granger.net>
In-Reply-To: <168443154055.516083.746756240848084451.stgit@klimt.1015granger.net>
References: <168443154055.516083.746756240848084451.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Commit 15b23ef5d348 ("nfsd4: fix corruption of NFSv4 read data")
encountered exactly the same issue: after a splice read, a
filesystem-owned page is left in rq_pages[]; the symptoms are the
same as described there.

If the computed number of pages in nfsd4_encode_splice_read() is not
exactly the same as the actual number of pages that were consumed by
nfsd_splice_actor() (say, because of a bug) then hilarity ensues.

Instead of recomputing the page offset based on the size of the
payload, use rq_next_page, which is already properly updated by
nfsd_splice_actor(), to cause svc_rqst_release_pages() to operate
correctly in every instance.

This is a defensive change since we believe that after commit
27c934dd8832 ("nfsd: don't replace page in rq_pages if it's a
continuation of last page") has been applied, there are no known
opportunities for nfsd_splice_actor() to screw up. So I'm not
marking it for stable backport.

Reported-by: Andy Zlotek <andy.zlotek@oracle.com>
Suggested-by: Calum Mackay <calum.mackay@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c5c6873b938d..0368e0902146 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4032,6 +4032,11 @@ nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, __be32 nfserr,
 	return nfsd4_encode_stateid(xdr, &od->od_stateid);
 }
 
+/*
+ * The operation of this function assumes that this is the only
+ * READ operation in the COMPOUND. If there are multiple READs,
+ * we use nfsd4_encode_readv().
+ */
 static __be32 nfsd4_encode_splice_read(
 				struct nfsd4_compoundres *resp,
 				struct nfsd4_read *read,
@@ -4042,8 +4047,12 @@ static __be32 nfsd4_encode_splice_read(
 	int status, space_left;
 	__be32 nfserr;
 
-	/* Make sure there will be room for padding if needed */
-	if (xdr->end - xdr->p < 1)
+	/*
+	 * Make sure there is room at the end of buf->head for
+	 * svcxdr_encode_opaque_pages() to create a tail buffer
+	 * to XDR-pad the payload.
+	 */
+	if (xdr->iov != xdr->buf->head || xdr->end - xdr->p < 1)
 		return nfserr_resource;
 
 	nfserr = nfsd_splice_read(read->rd_rqstp, read->rd_fhp,
@@ -4059,31 +4068,22 @@ static __be32 nfsd4_encode_splice_read(
 		goto out_err;
 	}
 
-	buf->page_len = maxcount;
-	buf->len += maxcount;
-	xdr->page_ptr += (buf->page_base + maxcount + PAGE_SIZE - 1)
-							/ PAGE_SIZE;
-
-	/* Use rest of head for padding and remaining ops: */
-	buf->tail[0].iov_base = xdr->p;
-	buf->tail[0].iov_len = 0;
-	xdr->iov = buf->tail;
-	if (maxcount&3) {
-		int pad = 4 - (maxcount&3);
-
-		*(xdr->p++) = 0;
-
-		buf->tail[0].iov_base += maxcount&3;
-		buf->tail[0].iov_len = pad;
-		buf->len += pad;
-	}
+	svcxdr_encode_opaque_pages(read->rd_rqstp, xdr, buf->pages, 0,
+				   maxcount);
 
+	/*
+	 * Prepare to encode subsequent operations.
+	 *
+	 * xdr_truncate_encode() is not safe to use after a successful
+	 * splice read has been done, so the following stream
+	 * manipulations are open-coded.
+	 */
 	space_left = min_t(int, (void *)xdr->end - (void *)xdr->p,
 				buf->buflen - buf->len);
 	buf->buflen = buf->len + space_left;
 	xdr->end = (__be32 *)((void *)xdr->end + space_left);
 
-	return 0;
+	return nfs_ok;
 
 out_err:
 	/*


