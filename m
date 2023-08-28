Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596BC78B16D
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Aug 2023 15:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjH1NPA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Aug 2023 09:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjH1NOu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Aug 2023 09:14:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ABD9D
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 06:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8641C635F6
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 13:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEE0C433C8;
        Mon, 28 Aug 2023 13:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693228487;
        bh=lFqe3KZ+2Or52yW9U1XmH2C9lU8dT+jDmn/8c3aBTgg=;
        h=Subject:From:To:Cc:Date:From;
        b=jgKSt03pz3ql6p/m1CiSzzNX3pYMn7DXJ04iukjTb4d6Kmp/6eNPPY+EGGUmPKMSz
         BYUfv0j0z2ZcgWqJcg90yBXvvwI3RrzJjiKDBQdwImZCWxIuXkjvVXV4PKAQ4HZj/D
         Y1JnvK2KVEZq29Hh3ZeSqCUf4vs4mD25NWKHxyFrXPGDIjkVmy0fZH5WKNYBqurpyx
         F5gbER8WBSxKauAyWWNRvBRZRaZQq9ojuPQZ2VihF/l/JcycV77xzPbP7jWdPorrjN
         jpiRpmU4vQY9YUa39mwKsb6+LpZU2Ai+Rqk6M3cA73yIr5bPBc5/kn2Ukf2EVeoNOB
         yqNRWbWxRJ7uA==
Subject: [PATCH] SUNRPC: Fix the recent bv_offset fix
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsky@redhat.com>,
        Maxim Levitsky <mlevitsky@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 28 Aug 2023 09:14:45 -0400
Message-ID: <169322843904.10891.2463559234906066461.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Reported-by: Maxim Levitsky <mlevitsky@redhat.com>
Fixes: c96e2a695e00 ("sunrpc: set the bv_offset of first bvec in svc_tcp_sendmsg")
Tested-by: Maxim Levitsky <mlevitsky@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

The plan is to put this first in the nfsd-next pull request so that
it can back-ported immediately to 6.5.y.


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


