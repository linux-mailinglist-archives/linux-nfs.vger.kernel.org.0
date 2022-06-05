Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA0653DE24
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jun 2022 21:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243571AbiFET6p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Jun 2022 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347198AbiFET6n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 5 Jun 2022 15:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C0E4A3D3
        for <linux-nfs@vger.kernel.org>; Sun,  5 Jun 2022 12:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE5196118D
        for <linux-nfs@vger.kernel.org>; Sun,  5 Jun 2022 19:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA01C385A5
        for <linux-nfs@vger.kernel.org>; Sun,  5 Jun 2022 19:58:39 +0000 (UTC)
Subject: [PATCH v1 3/5] SUNRPC: Clean up xdr_commit_encode()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 05 Jun 2022 15:58:38 -0400
Message-ID: <165445911819.1664.8436212544546306528.stgit@bazille.1015granger.net>
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

Both the ::iov_len field and the third parameter of memcpy() and
memmove() are size_t. There's no reason for the implicit conversion
from size_t to int and back. Change the type of @shift to make the
code easier to read and understand.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xdr.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 08a85375b311..de8f71468637 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -933,14 +933,16 @@ EXPORT_SYMBOL_GPL(xdr_init_encode);
  */
 inline void xdr_commit_encode(struct xdr_stream *xdr)
 {
-	int shift = xdr->scratch.iov_len;
+	size_t shift = xdr->scratch.iov_len;
 	void *page;
 
 	if (shift == 0)
 		return;
+
 	page = page_address(*xdr->page_ptr);
 	memcpy(xdr->scratch.iov_base, page, shift);
 	memmove(page, page + shift, (void *)xdr->p - page);
+
 	xdr_reset_scratch_buffer(xdr);
 }
 EXPORT_SYMBOL_GPL(xdr_commit_encode);


