Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493A953DE26
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jun 2022 21:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347133AbiFET64 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Jun 2022 15:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347132AbiFET6z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 5 Jun 2022 15:58:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D33949687
        for <linux-nfs@vger.kernel.org>; Sun,  5 Jun 2022 12:58:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A4A2B80DAE
        for <linux-nfs@vger.kernel.org>; Sun,  5 Jun 2022 19:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAACDC385A5
        for <linux-nfs@vger.kernel.org>; Sun,  5 Jun 2022 19:58:51 +0000 (UTC)
Subject: [PATCH v1 5/5] SUNRPC: Remove pointer type casts from
 xdr_get_next_encode_buffer()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 05 Jun 2022 15:58:50 -0400
Message-ID: <165445913079.1664.5467024491080755855.stgit@bazille.1015granger.net>
In-Reply-To: <165445865736.1664.4497130284832282034.stgit@bazille.1015granger.net>
References: <165445865736.1664.4497130284832282034.stgit@bazille.1015granger.net>
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
---
 net/sunrpc/xdr.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 89cb48931a1f..4e4cad7aeec2 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -955,9 +955,9 @@ EXPORT_SYMBOL_GPL(xdr_commit_encode);
 static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
 						   size_t nbytes)
 {
-	__be32 *p;
 	int space_left;
 	int frag1bytes, frag2bytes;
+	void *p;
 
 	if (nbytes > PAGE_SIZE)
 		goto out_overflow; /* Bigger buffers require special handling */
@@ -986,12 +986,12 @@ static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
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


