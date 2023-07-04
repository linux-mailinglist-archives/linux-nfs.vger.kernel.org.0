Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EA7746659
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 02:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGDAIN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 20:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGDAIM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 20:08:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5840018C
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 17:08:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAD9B6101C
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 00:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3CAC433C9;
        Tue,  4 Jul 2023 00:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688429290;
        bh=2AKlM2UKSM/EniRYCYKt9OAzmDYjbBy3x9koUY76S6Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pyZgcqz5dV42Dk/xIfpJnKJ8++rTXnp5pt9DxwmLLn23x+uRCJI2FBRCBFlwjUfNl
         EVr6OqBcOlyFnGacMH5NhMrjtHzc7BCPd9hcZLzhE2k9HqZ3WKWdA7BKDMcD9zTLxW
         exs7q5xbJBjhCFPtZuHEtrgrtdh0X/Z0Ky5T4BiRHBxWPCt/MkVVj9i5/yCRYuPhtH
         zDHz8P/TOSBYG6qwjqcuAIm3LNZrQxZTh7o3If5LYWeJYAQjb4q5RsQFihfK9nLqz/
         U1RFnxBuV4N37mG36gHRXg/cP4MHPPjLnirx54UMJMIOMcbIdixUX+IB+eo5vo3NMs
         +QRv7ODJZB0dQ==
Subject: [PATCH v2 6/9] SUNRPC: Replace dprintk() call site in __svc_create()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Mon, 03 Jul 2023 20:08:09 -0400
Message-ID: <168842928906.139194.18404088591647355711.stgit@manet.1015granger.net>
In-Reply-To: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
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

Done as part of converting SunRPC observability from printk-style to
tracepoints.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   23 +++++++++++++++++++++++
 net/sunrpc/svc.c              |    5 ++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 2e83887b58cd..60c8e03268d4 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1918,6 +1918,29 @@ TRACE_EVENT(svc_stats_latency,
 		__get_str(procedure), __entry->execute)
 );
 
+TRACE_EVENT(svc_pool_init,
+	TP_PROTO(
+		const struct svc_serv *serv,
+		const struct svc_pool *pool
+	),
+
+	TP_ARGS(serv, pool),
+
+	TP_STRUCT__entry(
+		__string(name, serv->sv_name)
+		__field(int, pool_id)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, serv->sv_name);
+		__entry->pool_id = pool->sp_id;
+	),
+
+	TP_printk("service=%s pool=%d",
+		__get_str(name), __entry->pool_id
+	)
+);
+
 #define show_svc_xprt_flags(flags)					\
 	__print_flags(flags, "|",					\
 		{ BIT(XPT_BUSY),		"BUSY" },		\
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 42d38cd99f29..9b6701a38e71 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -505,9 +505,6 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 	for (i = 0; i < serv->sv_nrpools; i++) {
 		struct svc_pool *pool = &serv->sv_pools[i];
 
-		dprintk("svc: initialising pool %u for %s\n",
-				i, serv->sv_name);
-
 		pool->sp_id = i;
 		INIT_LIST_HEAD(&pool->sp_sockets);
 		INIT_LIST_HEAD(&pool->sp_all_threads);
@@ -518,6 +515,8 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		percpu_counter_init(&pool->sp_threads_woken, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_threads_timedout, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_threads_starved, 0, GFP_KERNEL);
+
+		trace_svc_pool_init(serv, pool);
 	}
 
 	return serv;


