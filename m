Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1370759D4F
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jul 2023 20:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjGSSb0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 14:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGSSbZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 14:31:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF34DB6
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 11:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E1A8617C2
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 18:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D04BC433C8;
        Wed, 19 Jul 2023 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689791483;
        bh=mAGQFDTC6IA3TAfBq3MGGlOTdVh4EYYF7vR8hzjuYVo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rAnIgY7HIZMT5qsJMT0sySPEVimREBNfXmVd9Tt8xDqjEPsDeBHUNrepYuXsTUROs
         E0D+Tbk6pGcu+QV1W9DjYzh/2fo/RnBgHEn4kGIknJI8pEBVMtEa5TD++dpdDQeqBO
         6FGIOtxpICw4zXTsiI5kUJNcsz2PeP0td3r3Ysuu716GhSES5hD8a6GXSHRAfWGaPo
         KEtMFea2sMQLygEBZdHd6QJQcjO8nmaEBvpI17AwWjCK2jzH6ouuohetHM9vwQ6kae
         J4LnXRY2JELJYe+Q3aC97UwzwYlttmILIwyqHuCBAz0i/cUZDQxJRaY6m6ZQtfqXzc
         3v7o0sQ491xyg==
Subject: [PATCH v3 4/5] SUNRPC: Revert e0a912e8ddba
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com
Date:   Wed, 19 Jul 2023 14:31:22 -0400
Message-ID: <168979148257.1905271.8311839188162164611.stgit@morisot.1015granger.net>
In-Reply-To: <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
References: <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Flamegraph analysis showed that the cork/uncork calls consume
nearly a third of the CPU time spent in svc_tcp_sendto(). The
other two consumers are mutex lock/unlock and svc_tcp_sendmsg().

Now that svc_tcp_sendto() coalesces RPC messages properly, there
is no need to introduce artificial delays to prevent sending
partial messages.

After applying this change, I measured a 1.2K read IOPS increase
for 8KB random I/O (several percent) on 56Gb IP over IB.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svcsock.h |    2 --
 net/sunrpc/svcsock.c           |    6 ------
 2 files changed, 8 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index caf3308f1f07..a7ea54460b1a 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -35,8 +35,6 @@ struct svc_sock {
 	/* Total length of the data (not including fragment headers)
 	 * received so far in the fragments making up this rpc: */
 	u32			sk_datalen;
-	/* Number of queued send requests */
-	atomic_t		sk_sendqlen;
 
 	struct page_frag_cache  sk_frag_cache;
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index f28790f282c2..7b7358908a21 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1267,22 +1267,17 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 	svc_tcp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
 	rqstp->rq_xprt_ctxt = NULL;
 
-	atomic_inc(&svsk->sk_sendqlen);
 	mutex_lock(&xprt->xpt_mutex);
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
-	tcp_sock_set_cork(svsk->sk_sk, true);
 	err = svc_tcp_sendmsg(svsk, rqstp, marker, &sent);
 	trace_svcsock_tcp_send(xprt, err < 0 ? (long)err : sent);
 	if (err < 0 || sent != (xdr->len + sizeof(marker)))
 		goto out_close;
-	if (atomic_dec_and_test(&svsk->sk_sendqlen))
-		tcp_sock_set_cork(svsk->sk_sk, false);
 	mutex_unlock(&xprt->xpt_mutex);
 	return sent;
 
 out_notconn:
-	atomic_dec(&svsk->sk_sendqlen);
 	mutex_unlock(&xprt->xpt_mutex);
 	return -ENOTCONN;
 out_close:
@@ -1291,7 +1286,6 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 		  (err < 0) ? "got error" : "sent",
 		  (err < 0) ? err : sent, xdr->len);
 	svc_xprt_deferred_close(xprt);
-	atomic_dec(&svsk->sk_sendqlen);
 	mutex_unlock(&xprt->xpt_mutex);
 	return -EAGAIN;
 }


