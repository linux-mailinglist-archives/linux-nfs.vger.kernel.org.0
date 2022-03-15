Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CFC4DA027
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 17:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350096AbiCOQfs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 12:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiCOQfs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 12:35:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF71D5005F
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 09:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1B82FCE1BB4
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 16:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA37C340F4
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 16:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647362072;
        bh=uJxKKJu2tEJQPfSUQtoREIBPxxuB+bwNaGc87lg9iaE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b+AjVT7tQ+3zlfR0J/lHMR41QEkFMhOAc2p1TCJk8wmFR1ZalSnDQYm7HawHC9NEt
         1/9CCWJLVxIJJBqSkzcojjr4iYKKjFk2Rcsp1Q2jQ8aNAZuAdb5Fylfez5KiiVbrRh
         H1RWjqi8/ZIFMUImcPFBLAsgogmLrnbwgXTjoNsMxyqMvX9ThIWIvSgDhTo1unUI7Z
         a/4UV07YWVnAf6v4W1GOdSVopqupAKqVPxGoGfxaFwl2LcUWOw/mLv+3z1AuVkMPnc
         m97Wrmc8Sdc6pY88WinwCEaDIvLv5KrVwvl9rmAopPLMHncxnR7eMeFX/nFf0mYQiH
         psYOHVwz0JxXw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] SUNRPC: Improve accuracy of socket ENOBUFS determination
Date:   Tue, 15 Mar 2022 12:28:05 -0400
Message-Id: <20220315162805.570850-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315162805.570850-2-trondmy@kernel.org>
References: <20220315162805.570850-1-trondmy@kernel.org>
 <20220315162805.570850-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The current code checks for whether or not the socket is in a writeable
state after we get an EAGAIN. That is racy, since we've dropped the
socket lock, so the amount of free buffer may have changed.

Instead, let's check whether the socket is writeable before we try to
write to it. If that was the case, we do expect the message to be at
least partially sent unless we're in a low memory situation.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 53 +++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 23cdb841f056..87cc97d6c677 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -805,13 +805,15 @@ static int xs_sock_nospace(struct rpc_rqst *req)
 	return ret;
 }
 
-static int xs_stream_nospace(struct rpc_rqst *req)
+static int xs_stream_nospace(struct rpc_rqst *req, bool vm_wait)
 {
 	struct sock_xprt *transport =
 		container_of(req->rq_xprt, struct sock_xprt, xprt);
 	struct sock *sk = transport->inet;
 	int ret = -EAGAIN;
 
+	if (vm_wait)
+		return -ENOBUFS;
 	lock_sock(sk);
 	if (!sk_stream_memory_free(sk))
 		ret = xs_nospace(req, transport);
@@ -869,6 +871,7 @@ static int xs_local_send_request(struct rpc_rqst *req)
 	struct msghdr msg = {
 		.msg_flags	= XS_SENDMSG_FLAGS,
 	};
+	bool vm_wait;
 	unsigned int sent;
 	int status;
 
@@ -881,15 +884,14 @@ static int xs_local_send_request(struct rpc_rqst *req)
 	xs_pktdump("packet data:",
 			req->rq_svec->iov_base, req->rq_svec->iov_len);
 
+	vm_wait = sk_stream_is_writeable(transport->inet) ? true : false;
+
 	req->rq_xtime = ktime_get();
 	status = xprt_sock_sendmsg(transport->sock, &msg, xdr,
 				   transport->xmit.offset, rm, &sent);
 	dprintk("RPC:       %s(%u) = %d\n",
 			__func__, xdr->len - transport->xmit.offset, status);
 
-	if (status == -EAGAIN && sock_writeable(transport->inet))
-		status = -ENOBUFS;
-
 	if (likely(sent > 0) || status == 0) {
 		transport->xmit.offset += sent;
 		req->rq_bytes_sent = transport->xmit.offset;
@@ -899,13 +901,12 @@ static int xs_local_send_request(struct rpc_rqst *req)
 			return 0;
 		}
 		status = -EAGAIN;
+		vm_wait = false;
 	}
 
 	switch (status) {
-	case -ENOBUFS:
-		break;
 	case -EAGAIN:
-		status = xs_stream_nospace(req);
+		status = xs_stream_nospace(req, vm_wait);
 		break;
 	default:
 		dprintk("RPC:       sendmsg returned unrecognized error %d\n",
@@ -1023,7 +1024,7 @@ static int xs_tcp_send_request(struct rpc_rqst *req)
 	struct msghdr msg = {
 		.msg_flags	= XS_SENDMSG_FLAGS,
 	};
-	bool vm_wait = false;
+	bool vm_wait;
 	unsigned int sent;
 	int status;
 
@@ -1048,7 +1049,10 @@ static int xs_tcp_send_request(struct rpc_rqst *req)
 	 * called sendmsg(). */
 	req->rq_xtime = ktime_get();
 	tcp_sock_set_cork(transport->inet, true);
-	while (1) {
+
+	vm_wait = sk_stream_is_writeable(transport->inet) ? true : false;
+
+	do {
 		status = xprt_sock_sendmsg(transport->sock, &msg, xdr,
 					   transport->xmit.offset, rm, &sent);
 
@@ -1069,31 +1073,10 @@ static int xs_tcp_send_request(struct rpc_rqst *req)
 
 		WARN_ON_ONCE(sent == 0 && status == 0);
 
-		if (status == -EAGAIN ) {
-			/*
-			 * Return EAGAIN if we're sure we're hitting the
-			 * socket send buffer limits.
-			 */
-			if (test_bit(SOCK_NOSPACE, &transport->sock->flags))
-				break;
-			/*
-			 * Did we hit a memory allocation failure?
-			 */
-			if (sent == 0) {
-				status = -ENOBUFS;
-				if (vm_wait)
-					break;
-				/* Retry, knowing now that we're below the
-				 * socket send buffer limit
-				 */
-				vm_wait = true;
-			}
-			continue;
-		}
-		if (status < 0)
-			break;
-		vm_wait = false;
-	}
+		if (sent > 0)
+			vm_wait = false;
+
+	} while (status == 0);
 
 	switch (status) {
 	case -ENOTSOCK:
@@ -1101,7 +1084,7 @@ static int xs_tcp_send_request(struct rpc_rqst *req)
 		/* Should we call xs_close() here? */
 		break;
 	case -EAGAIN:
-		status = xs_stream_nospace(req);
+		status = xs_stream_nospace(req, vm_wait);
 		break;
 	case -ECONNRESET:
 	case -ECONNREFUSED:
-- 
2.35.1

