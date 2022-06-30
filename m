Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F64562497
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jun 2022 22:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiF3UsW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jun 2022 16:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiF3UsV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jun 2022 16:48:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90961835C
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jun 2022 13:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E30462358
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jun 2022 20:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83134C34115;
        Thu, 30 Jun 2022 20:48:19 +0000 (UTC)
Subject: [PATCH v2] SUNRPC: Fix READ_PLUS crasher
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     anna.schumaker@netapp.com, bfields@fieldses.org, zlang@redhat.com
Date:   Thu, 30 Jun 2022 16:48:18 -0400
Message-ID: <165662209842.1459.4593520026847863736.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
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

Looks like there are still cases when "space_left - frag1bytes" can
legitimately exceed PAGE_SIZE. Ensure that xdr->end always remains
within the current encode buffer.

Reported-by: Bruce Fields <bfields@fieldses.org>
Reported-by: Zorro Lang <zlang@redhat.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216151
Fixes: 6c254bf3b637 ("SUNRPC: Fix the calculation of xdr->end in xdr_get_next_encode_buffer()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xdr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index f87a2d8f23a7..5d2b3e6979fb 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -984,7 +984,7 @@ static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
 	p = page_address(*xdr->page_ptr);
 	xdr->p = p + frag2bytes;
 	space_left = xdr->buf->buflen - xdr->buf->len;
-	if (space_left - nbytes >= PAGE_SIZE)
+	if (space_left - frag1bytes >= PAGE_SIZE)
 		xdr->end = p + PAGE_SIZE;
 	else
 		xdr->end = p + space_left - frag1bytes;


