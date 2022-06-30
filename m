Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A30562131
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jun 2022 19:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbiF3RY0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jun 2022 13:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiF3RYZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jun 2022 13:24:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4553434641
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jun 2022 10:24:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7B52B82CC1
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jun 2022 17:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2A1C34115;
        Thu, 30 Jun 2022 17:24:21 +0000 (UTC)
Subject: [PATCH v1] SUNRPC: Fix READ_PLUS crasher
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     anna.schumaker@netapp.com, bfields@fieldses.org, zlang@redhat.com
Date:   Thu, 30 Jun 2022 13:24:20 -0400
Message-ID: <165660978413.2453.15153844664543877314.stgit@klimt.1015granger.net>
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

Hi-

I had a few minutes yesterday afternoon to look into this one. The
following one-liner seems to address the issue and passes my smoke
tests with NFSv4.1/TCP and NFSv3/RDMA. Any thoughts?


diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index f87a2d8f23a7..916659be2774 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -987,7 +987,7 @@ static noinline __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
 	if (space_left - nbytes >= PAGE_SIZE)
 		xdr->end = p + PAGE_SIZE;
 	else
-		xdr->end = p + space_left - frag1bytes;
+		xdr->end = p + min_t(int, space_left - frag1bytes, PAGE_SIZE);
 
 	xdr->buf->page_len += frag2bytes;
 	xdr->buf->len += nbytes;


