Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C8542427
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jun 2022 08:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiFHCzn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jun 2022 22:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448134AbiFHCxn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jun 2022 22:53:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35F238FB85
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 13:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81CDAB823EA
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 20:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1F3C385A5;
        Tue,  7 Jun 2022 20:48:19 +0000 (UTC)
Subject: [PATCH v2 5/5] SUNRPC: Remove pointer type casts from
 xdr_get_next_encode_buffer()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Date:   Tue, 07 Jun 2022 16:48:18 -0400
Message-ID: <165463489811.38298.8036154060998518968.stgit@bazille.1015granger.net>
In-Reply-To: <165463444560.38298.18296069287423675496.stgit@bazille.1015granger.net>
References: <165463444560.38298.18296069287423675496.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To make the code easier to read, remove visual clutter by changing
the declared type of @p.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/xdr.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index eca02d122476..f87a2d8f23a7 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -951,9 +951,9 @@ EXPORT_SYMBOL_GPL(__xdr_commit_encode);
 static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
 						   size_t nbytes)
 {
-	__be32 *p;
 	int space_left;
 	int frag1bytes, frag2bytes;
+	void *p;
 
 	if (nbytes > PAGE_SIZE)
 		goto out_overflow; /* Bigger buffers require special handling */
@@ -982,12 +982,12 @@ static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
 	 * xdr_commit_encode() has shifted this one back:
 	 */
 	p = page_address(*xdr->page_ptr);
-	xdr->p = (void *)p + frag2bytes;
+	xdr->p = p + frag2bytes;
 	space_left = xdr->buf->buflen - xdr->buf->len;
 	if (space_left - nbytes >= PAGE_SIZE)
-		xdr->end = (void *)p + PAGE_SIZE;
+		xdr->end = p + PAGE_SIZE;
 	else
-		xdr->end = (void *)p + space_left - frag1bytes;
+		xdr->end = p + space_left - frag1bytes;
 
 	xdr->buf->page_len += frag2bytes;
 	xdr->buf->len += nbytes;


