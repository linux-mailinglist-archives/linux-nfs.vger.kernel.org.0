Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC417E832C
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 20:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbjKJTw1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 14:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346617AbjKJTwN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 14:52:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B1A3E425
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 08:28:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8280FC433C8
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 16:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699633720;
        bh=/cYSvJjSofIZtx0Epialyqso0kKqyNa9nMBfGzbA3a4=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Jn5pUa8HSN/vKWaN+F187hPuFvpmEUHRw+0SZjR/e7msZY0JVn3M6rIFpymiOkO7r
         3Mv7o21+PtKzYGgwasKSStfplf9HitlgDPKHHNoO/ebP0PQvtZaDjgge/vWU2pnrh8
         AMinKQC8EgSmjhEQ0TqV6RG25nmFutRUIPWFGbxgdNIGZrBRz0roaENuGrVoYUehxl
         boCaB5yk6s+SpxuR5bx8hQtdYzjd4hfK7g7oOe3waMmbVjTJGErEXFwrmTDuDJ0CZ1
         pseFQmoxJjimZT4jyzCAZlQIG26BBD16i3dLfsYn3EwQ+oqEMwb4Mt1cwhCyOVzy1d
         tY4ob3uWdhO8A==
Subject: [PATCH v2 2/3] NFSD: Update nfsd_cache_append() to use xdr_stream
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 10 Nov 2023 11:28:39 -0500
Message-ID: <169963371954.5404.15414594140516305111.stgit@bazille.1015granger.net>
In-Reply-To: <169963305585.5404.9796036538735192053.stgit@bazille.1015granger.net>
References: <169963305585.5404.9796036538735192053.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

When inserting a DRC-cached response into the reply buffer, ensure
that the buffer's xdr_stream is updated properly. Otherwise the
server will send a garbage response.

This should have been part of last year's series to handle NFS
response encoding using the xdr_stream utilities.

Cc: <stable@vger.kernel.org> # v5.16+
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index fd56a52aa5fb..9046331e0e5e 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -641,24 +641,17 @@ void nfsd_cache_update(struct svc_rqst *rqstp, struct nfsd_cacherep *rp,
 	return;
 }
 
-/*
- * Copy cached reply to current reply buffer. Should always fit.
- * FIXME as reply is in a page, we should just attach the page, and
- * keep a refcount....
- */
 static int
 nfsd_cache_append(struct svc_rqst *rqstp, struct kvec *data)
 {
-	struct kvec	*vec = &rqstp->rq_res.head[0];
-
-	if (vec->iov_len + data->iov_len > PAGE_SIZE) {
-		printk(KERN_WARNING "nfsd: cached reply too large (%zd).\n",
-				data->iov_len);
-		return 0;
-	}
-	memcpy((char*)vec->iov_base + vec->iov_len, data->iov_base, data->iov_len);
-	vec->iov_len += data->iov_len;
-	return 1;
+	__be32 *p;
+
+	p = xdr_reserve_space(&rqstp->rq_res_stream, data->iov_len);
+	if (unlikely(!p))
+		return false;
+	memcpy(p, data->iov_base, data->iov_len);
+	xdr_commit_encode(&rqstp->rq_res_stream);
+	return true;
 }
 
 /*


