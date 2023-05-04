Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3647B6F715B
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjEDRnr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 13:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEDRnq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 13:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E078B133
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 10:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D1E461530
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 17:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E86C433EF;
        Thu,  4 May 2023 17:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683222224;
        bh=9FbL2AUMyz0xL2FXA1/X6fHN1iuzH8UE5HlM3cvbgRg=;
        h=Subject:From:To:Cc:Date:From;
        b=M2EaCutiM7PunDixlDZ6HLpTlEzJwjRIW3Wa26NbLLH4F+0kOItsap+k1ePE8t2dA
         OBPvZaysVtGd87tvQLQ2XTim5EhMQbln3MBHyPW2EbNtVg5rp6NsLxjHiQ5vqbLryQ
         rBAosn+zsrbPw7koY1qP3O8+lB96JCFJ5awDTKJwRS3Rwgcw4TAfe7OmqWDnXgVtab
         3jTXRhkopl2A3p6wUJRnyh6tRGDFPKQfHIPdUfolpKhoNqG1Q5vIWwRLVHbslBLO6u
         RENjUq88uF25CA409AAwp32NbZ/IePne2lhgNX7fOil3jawfCPZOh5h9YBPQvw271y
         tSZMohNvVpOYA==
Subject: [PATCH v1] SUNRPC: Fix error handling in svc_setup_socket()
From:   Chuck Lever <cel@kernel.org>
To:     kernel-tls-handshake@lists.linux.dev
Cc:     linux-nfs@vger.kernel.org, dan.carpenter@linaro.org
Date:   Thu, 04 May 2023 13:43:33 -0400
Message-ID: <168322220320.5195.11276819140236494259.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Dan points out that sock_alloc_file() releases @sock on error, but
so do all of svc_setup_socket's callers, resulting in a double-
release if sock_alloc_file() returns an error.

Rather than allocating a struct file for all new sockets, allocate
one only for sockets created during a TCP accept. For the moment,
those are the only ones that will ever be used with RPC-with-TLS.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: ae0d77708aae ("SUNRPC: Ensure server-side sockets have a sock->file")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index a51c9b989d58..9989194446a5 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -895,6 +895,9 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xprt *xprt)
 		trace_svcsock_accept_err(xprt, serv->sv_name, err);
 		return NULL;
 	}
+	if (IS_ERR(sock_alloc_file(newsock, O_NONBLOCK, NULL)))
+		return NULL;
+
 	set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
 
 	err = kernel_getpeername(newsock, sin);
@@ -935,7 +938,7 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xprt *xprt)
 	return &newsvsk->sk_xprt;
 
 failed:
-	sock_release(newsock);
+	sockfd_put(newsock);
 	return NULL;
 }
 
@@ -1430,7 +1433,6 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 						struct socket *sock,
 						int flags)
 {
-	struct file	*filp = NULL;
 	struct svc_sock	*svsk;
 	struct sock	*inet;
 	int		pmap_register = !(flags & SVC_SOCK_ANONYMOUS);
@@ -1439,14 +1441,6 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 	if (!svsk)
 		return ERR_PTR(-ENOMEM);
 
-	if (!sock->file) {
-		filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
-		if (IS_ERR(filp)) {
-			kfree(svsk);
-			return ERR_CAST(filp);
-		}
-	}
-
 	inet = sock->sk;
 
 	if (pmap_register) {
@@ -1456,8 +1450,6 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 				     inet->sk_protocol,
 				     ntohs(inet_sk(inet)->inet_sport));
 		if (err < 0) {
-			if (filp)
-				fput(filp);
 			kfree(svsk);
 			return ERR_PTR(err);
 		}


