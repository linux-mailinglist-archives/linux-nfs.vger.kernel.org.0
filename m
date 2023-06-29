Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C5F742C02
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 20:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjF2SnB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 14:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjF2SnA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 14:43:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD222681
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 11:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B94E7615E4
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 18:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABFAC433C8;
        Thu, 29 Jun 2023 18:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688064178;
        bh=LCNqZcxIVd1RO7ZlOOofBxJSB+d62egEMIvK6s5EX2c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hF3kYUTDZcMqcnqOWKC6JgSAhs8YpIZley9hZDcNmTONM3cS1U8TNhuSdMSYCRTch
         HxsEEXxyiQuKwwH1lcxYyaJQ+Ch7n/33KSn1bGfZFwk+Ihgm0cnR8hekVOLgUPyVMN
         N4MJOZ9YpHAvqwD8lqw7IjZY/yhTyilps8sox/E8EGPXgPi8Eb2RVa4/AdPEDwbslL
         55TZzI/tjgdzLTW7hrd8WOqNlq3Ljk4s2CW/PkcgkjhUzIXczzt5kQ3dORIHDyPQ8O
         TKArG337X72EcOv3CT78fKDzcXYKANuofwYZgkbSaXbEp6871YwSP95cABZke1FZHW
         xT38mH1SmvYDA==
Subject: [PATCH RFC 5/8] SUNRPC: Replace dprintk() call site in __svc_create()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, jlayton@redhat.com, david@fromorbit.com
Date:   Thu, 29 Jun 2023 14:42:56 -0400
Message-ID: <168806417679.1034990.17820560466387975643.stgit@morisot.1015granger.net>
In-Reply-To: <168806401782.1034990.9686296943273298604.stgit@morisot.1015granger.net>
References: <168806401782.1034990.9686296943273298604.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Done as part of converting SunRPC observability from printk to
tracepoints.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   23 +++++++++++++++++++++++
 net/sunrpc/svc.c              |    5 ++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index cf3d404ca6d8..70f3bc22c429 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1842,6 +1842,29 @@ TRACE_EVENT(svc_stats_latency,
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
index cf2e58ead35d..828d28883ea8 100644
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
@@ -517,6 +514,8 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		percpu_counter_init(&pool->sp_threads_woken, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_threads_timedout, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_threads_starved, 0, GFP_KERNEL);
+
+		trace_svc_pool_init(serv, pool);
 	}
 
 	return serv;


