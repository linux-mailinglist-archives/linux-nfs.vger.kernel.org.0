Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A58178B1BA
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Aug 2023 15:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjH1NXh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Aug 2023 09:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjH1NXF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Aug 2023 09:23:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E3811D
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 06:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6998A6478C
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 13:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84440C433C7;
        Mon, 28 Aug 2023 13:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693228981;
        bh=eolfdfM7FdyFU8xHf3A0VLjuxhC9mhLGLjxf66QRh0U=;
        h=Subject:From:To:Cc:Date:From;
        b=gWGVondqBNPEaNrXLe9p2Ph0TR0gA6+jOyo+Oimwk/PrZCmqYd7udY1J5dTb71Dto
         M/N3E+zllWEru2/5RA2R5fwOGchkXepjwMyNdXVaZna2mdwR85/rAe/9WHDvCBRxu2
         kUlnDZ7Fnm5DGpkkyJ7D6bkkDkOS3tl7adwSmpQckFgry5y7L9EzLb2C1hXzzwSpv1
         K43ThhkDrIsRJRYKw6e/8Rxmon237EGXmyW+Cee+cuvly4d3PRTQafbtzvfcmbDRYF
         /0ipzeGEW3puVj3vNBEKcFzYZqDiD0O1VB6xa/tN1N+/Pu3OSP6BX2DoLa2+Hl9kCU
         71dhC8YTFRDLQ==
Subject: [PATCH v2] SUNRPC: Fix the recent bv_offset fix
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 28 Aug 2023 09:23:00 -0400
Message-ID: <169322894408.11188.14223137341540815863.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Jeff confirmed his original fix addressed his pynfs test failure,
but this same bug also impacted qemu: accessing qcow2 virtual disks
using direct I/O was failing. Jeff's fix missed that you have to
shorten the bio_vec element by the same amount as you increased
the page offset.

Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
Fixes: c96e2a695e00 ("sunrpc: set the bv_offset of first bvec in svc_tcp_sendmsg")
Tested-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

v2:
- Correct Maxim's email addresses.

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 2eb8df44f894..589020ed909d 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1244,8 +1244,10 @@ static int svc_tcp_sendmsg(struct socket *sock, struct xdr_buf *xdr,
 	if (ret != head->iov_len)
 		goto out;
 
-	if (xdr_buf_pagecount(xdr))
+	if (xdr_buf_pagecount(xdr)) {
 		xdr->bvec[0].bv_offset = offset_in_page(xdr->page_base);
+		xdr->bvec[0].bv_len -= offset_in_page(xdr->page_base);
+	}
 
 	msg.msg_flags = MSG_SPLICE_PAGES;
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, xdr->bvec,


