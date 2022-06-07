Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE125423C2
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jun 2022 08:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiFHAso (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jun 2022 20:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1450005AbiFGXKo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jun 2022 19:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8691C38EBBA
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 13:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F19A26166B
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 20:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FFAC385A2;
        Tue,  7 Jun 2022 20:48:06 +0000 (UTC)
Subject: [PATCH v2 3/5] SUNRPC: Clean up xdr_commit_encode()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Date:   Tue, 07 Jun 2022 16:48:05 -0400
Message-ID: <165463488517.38298.1636534035418213053.stgit@bazille.1015granger.net>
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

Both the kvec::iov_len field and the third parameter of memcpy() and
memmove() are size_t. There's no reason for the implicit conversion
from size_t to int and back. Change the type of @shift to make the
code easier to read and understand.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/xdr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 1ad8b4ef14de..3c182041e790 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -933,7 +933,7 @@ EXPORT_SYMBOL_GPL(xdr_init_encode);
  */
 void __xdr_commit_encode(struct xdr_stream *xdr)
 {
-	int shift = xdr->scratch.iov_len;
+	size_t shift = xdr->scratch.iov_len;
 	void *page;
 
 	page = page_address(*xdr->page_ptr);


