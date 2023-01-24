Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE0067A413
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jan 2023 21:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjAXUka (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 15:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjAXUk0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 15:40:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B654C6E3
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 12:40:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A1D460F1F
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 20:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CFFC433D2
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674592823;
        bh=WKZfXqLgfjf0zNr/i7gytEk2GsLozZ5loBYymrX0de8=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Q1sThVduVEvHvr2kINGA8NRtoaFuhlZB0hqTdXz4dh7mJJfvdOgfsMN+7IfXKKvQa
         JqZz3MBJqyRcEyBztlt2w1eo0s7CgXrAOqPGzD2P4bI3uiXUCdd79At6llE1JuUZwB
         uT6dvmw4dWwfowrwOIY3QHbD4XJZUJDGVm0WZ0E0IqoAjKwk9T23tQ9y01e8zKY6Ke
         nmIfs+lIBczYReHawqJYatZ32fXAgX5j4A06aC0ymA7/t7/41ynNV7IOhtu76fJEsk
         +O6BGzsRzwgSEnKxrx0pjYcKbbcm8IepfPqx97YL4+VHQv654SOJ1f/THdl1FVCx6u
         +crAU/jC6bRBA==
Subject: [PATCH v1 2/2] SUNRPC: Remove ->xpo_secure_port()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 24 Jan 2023 15:40:22 -0500
Message-ID: <167459282253.15600.13316537036010057131.stgit@manet.1015granger.net>
In-Reply-To: <167459281558.15600.1555010122091924488.stgit@manet.1015granger.net>
References: <167459281558.15600.1555010122091924488.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

There's no need for the cost of this extra virtual function call
during every RPC transaction: the RQ_SECURE bit can be set properly
in ->xpo_recvfrom() instead.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_xprt.h          |    1 -
 net/sunrpc/svc_xprt.c                    |    1 -
 net/sunrpc/svcsock.c                     |    4 ++--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |    1 +
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 -------
 5 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index d42a75b3be10..775368802762 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -26,7 +26,6 @@ struct svc_xprt_ops {
 	void		(*xpo_release_rqst)(struct svc_rqst *);
 	void		(*xpo_detach)(struct svc_xprt *);
 	void		(*xpo_free)(struct svc_xprt *);
-	void		(*xpo_secure_port)(struct svc_rqst *rqstp);
 	void		(*xpo_kill_temp_xprt)(struct svc_xprt *);
 	void		(*xpo_start_tls)(struct svc_xprt *);
 };
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index c2ce12538008..573a494f11d7 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -888,7 +888,6 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
 
 	clear_bit(XPT_OLD, &xprt->xpt_flags);
 
-	xprt->xpt_ops->xpo_secure_port(rqstp);
 	rqstp->rq_chandle.defer = svc_defer;
 	rqstp->rq_xid = svc_getu32(&rqstp->rq_arg.head[0]);
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 815baf308236..81bdcb6f73bb 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -508,6 +508,7 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
 	if (serv->sv_stats)
 		serv->sv_stats->netudpcnt++;
 
+	svc_sock_secure_port(rqstp);
 	svc_xprt_received(rqstp->rq_xprt);
 	return len;
 
@@ -636,7 +637,6 @@ static const struct svc_xprt_ops svc_udp_ops = {
 	.xpo_free = svc_sock_free,
 	.xpo_has_wspace = svc_udp_has_wspace,
 	.xpo_accept = svc_udp_accept,
-	.xpo_secure_port = svc_sock_secure_port,
 	.xpo_kill_temp_xprt = svc_udp_kill_temp_xprt,
 };
 
@@ -1028,6 +1028,7 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	if (serv->sv_stats)
 		serv->sv_stats->nettcpcnt++;
 
+	svc_sock_secure_port(rqstp);
 	svc_xprt_received(rqstp->rq_xprt);
 	return rqstp->rq_arg.len;
 
@@ -1209,7 +1210,6 @@ static const struct svc_xprt_ops svc_tcp_ops = {
 	.xpo_free = svc_sock_free,
 	.xpo_has_wspace = svc_tcp_has_wspace,
 	.xpo_accept = svc_tcp_accept,
-	.xpo_secure_port = svc_sock_secure_port,
 	.xpo_kill_temp_xprt = svc_tcp_kill_temp_xprt,
 };
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 5242ad121450..1c658fa43063 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -847,6 +847,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	rqstp->rq_xprt_ctxt = ctxt;
 	rqstp->rq_prot = IPPROTO_MAX;
 	svc_xprt_copy_addrs(rqstp, xprt);
+	set_bit(RQ_SECURE, &rqstp->rq_flags);
 	return rqstp->rq_arg.len;
 
 out_err:
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 94b20fb47135..416b298f74dd 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -73,7 +73,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt);
 static void svc_rdma_detach(struct svc_xprt *xprt);
 static void svc_rdma_free(struct svc_xprt *xprt);
 static int svc_rdma_has_wspace(struct svc_xprt *xprt);
-static void svc_rdma_secure_port(struct svc_rqst *);
 static void svc_rdma_kill_temp_xprt(struct svc_xprt *);
 
 static const struct svc_xprt_ops svc_rdma_ops = {
@@ -86,7 +85,6 @@ static const struct svc_xprt_ops svc_rdma_ops = {
 	.xpo_free = svc_rdma_free,
 	.xpo_has_wspace = svc_rdma_has_wspace,
 	.xpo_accept = svc_rdma_accept,
-	.xpo_secure_port = svc_rdma_secure_port,
 	.xpo_kill_temp_xprt = svc_rdma_kill_temp_xprt,
 };
 
@@ -600,11 +598,6 @@ static int svc_rdma_has_wspace(struct svc_xprt *xprt)
 	return 1;
 }
 
-static void svc_rdma_secure_port(struct svc_rqst *rqstp)
-{
-	set_bit(RQ_SECURE, &rqstp->rq_flags);
-}
-
 static void svc_rdma_kill_temp_xprt(struct svc_xprt *xprt)
 {
 }


