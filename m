Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8869A702E2B
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 15:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbjEONdB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 09:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241913AbjEONc6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 09:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1065119AE
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 06:32:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FFB4617FB
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 13:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA35C433EF;
        Mon, 15 May 2023 13:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684157575;
        bh=Z15hsD/8FFDGUqV7uZIf9TkSoakYKb4C/ksvcrcRi7c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GOkOo8hL87xQ+A0NH/WZLTj0ZEpJ81K3UHlzrY4T0FCrBrK8bn0Mlw/u9S7WY/VE+
         QJMF7RhsQxzRT7ftNYOy8/mCYGf8Q3q+jGaTD91V9xoLzjof+EuHH5GtidOpHP5QXV
         zhYHJVrkbHwWOQblhxd1P9Xph6bS/pYZxfZpyi+ZRyWckrskkLCLQXv2sv7YCO7NTc
         RnqmyaUjczXDg8fJ/Hfn5nlvMGFsrwAYJVmqwsDnpM8pobvCFQ63MMYhqq3Gh0pq3m
         9EPQCzsun0NM8SuKnyCp/AbOahEb+RjIW3pVH2MmS56Yr19NN5ZGNVVJg8fWRIonpn
         Y4Xo6QtV8CTzQ==
Subject: [PATCH 3/4] SUNRPC: Improve observability in svc_tcp_accept()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 15 May 2023 09:32:53 -0400
Message-ID: <168415757392.9504.14836685251349712202.stgit@manet.1015granger.net>
In-Reply-To: <168415745478.9504.1882537002036193828.stgit@manet.1015granger.net>
References: <168415745478.9504.1882537002036193828.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The -ENOMEM arm could fire repeatedly if the system runs low on
memory, so remove it.

Don't bother to trace -EAGAIN error events, since those fire after
a listener is created (with no work done) and once again after an
accept has been handled successfully (again, with no work done).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index e0fb65e90af2..2058641ab9f6 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -885,13 +885,8 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xprt *xprt)
 	clear_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
 	err = kernel_accept(sock, &newsock, O_NONBLOCK);
 	if (err < 0) {
-		if (err == -ENOMEM)
-			printk(KERN_WARNING "%s: no more sockets!\n",
-			       serv->sv_name);
-		else if (err != -EAGAIN)
-			net_warn_ratelimited("%s: accept failed (err %d)!\n",
-					     serv->sv_name, -err);
-		trace_svcsock_accept_err(xprt, serv->sv_name, err);
+		if (err != -EAGAIN)
+			trace_svcsock_accept_err(xprt, serv->sv_name, err);
 		return NULL;
 	}
 	set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);


