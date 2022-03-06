Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6584CEEB4
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Mar 2022 00:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiCFXo2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Mar 2022 18:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiCFXo1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Mar 2022 18:44:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2404198F
        for <linux-nfs@vger.kernel.org>; Sun,  6 Mar 2022 15:43:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7547121111;
        Sun,  6 Mar 2022 23:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646610208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hRVIPm23nHnrI7WtoIgjrZUWa+2YaFb1uWafdgoA9iU=;
        b=P1khN2D5Si+pdXiOTkY7AffOEEGHB4eCjmyc+4gPbxnhr2n6b236zSF+2fljRAZi/svIB2
        113c6SzCXxgsJIPpIlj/D2/m4jdP3EglfUsJ7inBjkO2r2wBjineTR0yN90bVzLepJLefg
        a05OkmS9KoM5uzoaRXjcfM23PhJNCZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646610208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hRVIPm23nHnrI7WtoIgjrZUWa+2YaFb1uWafdgoA9iU=;
        b=RyXhAuTtzDSOo5toNnzJomClbjAPpUYc/hsBYm4iI8zItfW9AZM1H5rVEj/0+Jwnjv4vKq
        UHRM+e8yE98MQtCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55E69134CD;
        Sun,  6 Mar 2022 23:43:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sTKUBB9HJWJRWAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 06 Mar 2022 23:43:27 +0000
Subject: [PATCH 11/11] SUNRPC: change locking for xs_swap_enable/disable
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 07 Mar 2022 10:41:45 +1100
Message-ID: <164661010499.31054.12748930938408125464.stgit@noble.brown>
In-Reply-To: <164660993703.31054.17075972410545449555.stgit@noble.brown>
References: <164660993703.31054.17075972410545449555.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

It is not in general safe to wait for XPRT_LOCKED to clear.
A wakeup is only sent when
 - connection completes
 - sock close completes
so during normal operations, this can wait indefinitely.

The event we need to protect against is ->inet being set to NULL, and
that happens under the recv_mutex lock.

So drop the handlign of XPRT_LOCKED and use recv_mutex instead.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/xprtsock.c |   26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 61d3293f1d68..7e39f87cde2d 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1936,9 +1936,9 @@ static void xs_local_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 
 #if IS_ENABLED(CONFIG_SUNRPC_SWAP)
 /*
- * Note that this should be called with XPRT_LOCKED held (or when we otherwise
- * know that we have exclusive access to the socket), to guard against
- * races with xs_reset_transport.
+ * Note that this should be called with XPRT_LOCKED held, or recv_mutex
+ * held, or when we otherwise know that we have exclusive access to the
+ * socket, to guard against races with xs_reset_transport.
  */
 static void xs_set_memalloc(struct rpc_xprt *xprt)
 {
@@ -1967,13 +1967,11 @@ xs_enable_swap(struct rpc_xprt *xprt)
 {
 	struct sock_xprt *xs = container_of(xprt, struct sock_xprt, xprt);
 
-	if (atomic_inc_return(&xprt->swapper) != 1)
-		return 0;
-	if (wait_on_bit_lock(&xprt->state, XPRT_LOCKED, TASK_KILLABLE))
-		return -ERESTARTSYS;
-	if (xs->inet)
+	mutex_lock(&xs->recv_mutex);
+	if (atomic_inc_return(&xprt->swapper) == 1 &&
+	    xs->inet)
 		sk_set_memalloc(xs->inet);
-	xprt_release_xprt(xprt, NULL);
+	mutex_unlock(&xs->recv_mutex);
 	return 0;
 }
 
@@ -1989,13 +1987,11 @@ xs_disable_swap(struct rpc_xprt *xprt)
 {
 	struct sock_xprt *xs = container_of(xprt, struct sock_xprt, xprt);
 
-	if (!atomic_dec_and_test(&xprt->swapper))
-		return;
-	if (wait_on_bit_lock(&xprt->state, XPRT_LOCKED, TASK_KILLABLE))
-		return;
-	if (xs->inet)
+	mutex_lock(&xs->recv_mutex);
+	if (atomic_dec_and_test(&xprt->swapper) &&
+	    xs->inet)
 		sk_clear_memalloc(xs->inet);
-	xprt_release_xprt(xprt, NULL);
+	mutex_unlock(&xs->recv_mutex);
 }
 #else
 static void xs_set_memalloc(struct rpc_xprt *xprt)


