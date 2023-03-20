Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B276C14A2
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Mar 2023 15:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjCTOYc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Mar 2023 10:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjCTOYb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Mar 2023 10:24:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC09C17150
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 07:24:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 796E26153E
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 14:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF8AC43321;
        Mon, 20 Mar 2023 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679322268;
        bh=U3y1XZP97v3mpiJsoeXYz/zNPCQ6cgMsirKDIOqrf3s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fF0cmYZe8CgbFWDbWt3Sz07t0ZU2NQa/5cnhdC/p7gXSDE42vQke4U4zUTTDPvKVq
         5Bd4M0RPEZxLaniXC5SBsmYhiB/V6AASux0ojgCgRuUIsoZLitNvQnz7bsVeBpehDb
         fl+fTPSm0LKgVYp5ZqV4wbMb2tLUxLaeA+MgcZ6SVNgFuJ5inNxUnqpCw2dsIh3AH2
         0OnTpvYjwYePSnsgrJGibf76CnvpC+jVxLcYyMs/0AAScZNDaPagjMzUeFVIzQdoNG
         B4YMqcDkTx5stJZVcV3LGn8an04IEVZ/lL1S0fgkeLaaLXFn2OnKA/WH73Jc/DpygT
         YmFmLY84wtGDA==
Subject: [PATCH RFC 1/5] SUNRPC: Revert 987c7b1d094d
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     kernel-tls-handshake@lists.linux.dev
Date:   Mon, 20 Mar 2023 10:24:27 -0400
Message-ID: <167932226768.3131.11453687398743948295.stgit@manet.1015granger.net>
In-Reply-To: <167932094748.3131.11264549266195745851.stgit@manet.1015granger.net>
References: <167932094748.3131.11264549266195745851.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

I noticed that server-side TLS always sends the RPC record marker as
a separate 4-byte TLS record. This is très inefficace.

It seems to be due to commit 987c7b1d094d ("SUNRPC: Remove redundant
socket flags from svc_tcp_sendmsg()"), which removed the MSG_* flags
from svc_tcp_sendmsg() in favor of using tcp_sock_set_cork. TLS,
which rides on top of TCP, ignores the socket's cork setting.

Client-side RPC also uses tcp_sock_set_cork, but it still sets
MSG_MORE. I don't see similar uncoalesced TLS record traffic there.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 03a4f5615086..28deb4acc392 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1086,9 +1086,9 @@ static int svc_tcp_sendmsg(struct socket *sock, struct xdr_buf *xdr,
 		.iov_len	= sizeof(marker),
 	};
 	struct msghdr msg = {
-		.msg_flags	= 0,
+		.msg_flags	= MSG_MORE,
 	};
-	int ret;
+	int flags, ret;
 
 	*sentp = 0;
 	ret = xdr_alloc_bvec(xdr, GFP_KERNEL);
@@ -1101,8 +1101,8 @@ static int svc_tcp_sendmsg(struct socket *sock, struct xdr_buf *xdr,
 	*sentp += ret;
 	if (ret != rm.iov_len)
 		return -EAGAIN;
-
-	ret = svc_tcp_send_kvec(sock, head, 0);
+	flags = head->iov_len < xdr->len ? MSG_MORE | MSG_SENDPAGE_NOTLAST : 0;
+	ret = svc_tcp_send_kvec(sock, head, flags);
 	if (ret < 0)
 		return ret;
 	*sentp += ret;
@@ -1117,10 +1117,12 @@ static int svc_tcp_sendmsg(struct socket *sock, struct xdr_buf *xdr,
 		offset = offset_in_page(xdr->page_base);
 		remaining = xdr->page_len;
 		while (remaining > 0) {
+			if (remaining <= PAGE_SIZE && tail->iov_len == 0)
+				flags = 0;
 			len = min(remaining, bvec->bv_len - offset);
 			ret = kernel_sendpage(sock, bvec->bv_page,
 					      bvec->bv_offset + offset,
-					      len, 0);
+					      len, flags);
 			if (ret < 0)
 				return ret;
 			*sentp += ret;


