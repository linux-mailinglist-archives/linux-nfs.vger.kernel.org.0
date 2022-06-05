Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172AB53DE25
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jun 2022 21:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347198AbiFET6t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Jun 2022 15:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347132AbiFET6s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 5 Jun 2022 15:58:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD5D4A3D3
        for <linux-nfs@vger.kernel.org>; Sun,  5 Jun 2022 12:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC9B7B80DCA
        for <linux-nfs@vger.kernel.org>; Sun,  5 Jun 2022 19:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBB4C385A5
        for <linux-nfs@vger.kernel.org>; Sun,  5 Jun 2022 19:58:45 +0000 (UTC)
Subject: [PATCH v1 4/5] SUNRPC: Clean up xdr_get_next_encode_buffer()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 05 Jun 2022 15:58:44 -0400
Message-ID: <165445912444.1664.7733109680322574177.stgit@bazille.1015granger.net>
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

The value of @p is not used until the "location of the next item" is
computed. Help human readers by moving its initial assignment to the
paragraph where that value is used and by clarifying the antecedents
in the documenting comment.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xdr.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index de8f71468637..89cb48931a1f 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -971,6 +971,7 @@ static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
 		xdr->buf->page_len += frag1bytes;
 	xdr->page_ptr++;
 	xdr->iov = NULL;
+
 	/*
 	 * If the last encode didn't end exactly on a page boundary, the
 	 * next one will straddle boundaries.  Encode into the next
@@ -979,11 +980,12 @@ static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
 	 * space at the end of the previous buffer:
 	 */
 	xdr_set_scratch_buffer(xdr, xdr->p, frag1bytes);
-	p = page_address(*xdr->page_ptr);
+
 	/*
-	 * Note this is where the next encode will start after we've
-	 * shifted this one back:
+	 * xdr->p is where the next encode will start after
+	 * xdr_commit_encode() has shifted this one back:
 	 */
+	p = page_address(*xdr->page_ptr);
 	xdr->p = (void *)p + frag2bytes;
 	space_left = xdr->buf->buflen - xdr->buf->len;
 	if (space_left - nbytes >= PAGE_SIZE)


