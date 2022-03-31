Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538D74EE2C0
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Mar 2022 22:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbiCaUkq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 16:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbiCaUkq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 16:40:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB95580FB
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 13:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05163B82235
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 20:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC34EC340ED
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 20:38:55 +0000 (UTC)
Subject: [PATCH RFC] SUNRPC: Cache timeout injection
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 31 Mar 2022 16:38:54 -0400
Message-ID: <164875901265.5020.8768104920180114958.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Cache timeout injection stress-tests the cache timeout logic as well
as upper layer protocol deferred request handlers.

A file called /sys/kernel/debug/fail_sunrpc/ignore-cache-timeout
enables administrators to turn off cache timeout injection while
allowing other types of sunrpc errors to be injected. The default
setting is that cache timeout injection is enabled (ignore=false).

To enable cache timeout injection, CONFIG_FAULT_INJECTION,
CONFIG_FAULT_INJECTION_DEBUG_FS, and CONFIG_SUNRPC_DEBUG must all be
set to "Y".

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/cache.c   |   16 ++++++++++++++++
 net/sunrpc/debugfs.c |    3 +++
 net/sunrpc/fail.h    |    2 +-
 3 files changed, 20 insertions(+), 1 deletion(-)


Proof of concept: compile-tested only. The idea is to inject timeout
failures in the cache code so we can see what happens when a rqst
actually has to be deferred.


diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index bb1177395b99..e5ec125afec9 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -33,7 +33,9 @@
 #include <linux/sunrpc/stats.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
 #include <trace/events/sunrpc.h>
+
 #include "netns.h"
+#include "fail.h"
 
 #define	 RPCDBG_FACILITY RPCDBG_CACHE
 
@@ -629,6 +631,19 @@ static void cache_restart_thread(struct cache_deferred_req *dreq, int too_many)
 	complete(&dr->completion);
 }
 
+#if IS_ENABLED(CONFIG_FAIL_SUNRPC)
+static inline bool cache_timeout_should_fail(void)
+{
+	return !fail_sunrpc.ignore_cache_timeout &&
+		should_fail(&fail_sunrpc.attr, 1);
+}
+#else
+static inline bool cache_timeout_should_fail(void)
+{
+	return false;
+}
+#endif
+
 static void cache_wait_req(struct cache_req *req, struct cache_head *item)
 {
 	struct thread_deferred_req sleeper;
@@ -640,6 +655,7 @@ static void cache_wait_req(struct cache_req *req, struct cache_head *item)
 	setup_deferral(dreq, item, 0);
 
 	if (!test_bit(CACHE_PENDING, &item->flags) ||
+	    cache_timeout_should_fail() ||
 	    wait_for_completion_interruptible_timeout(
 		    &sleeper.completion, req->thread_wait) <= 0) {
 		/* The completion wasn't completed, so we need
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index 7dc9cc929bfd..68272885873a 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -262,6 +262,9 @@ static void fail_sunrpc_init(void)
 
 	debugfs_create_bool("ignore-server-disconnect", S_IFREG | 0600, dir,
 			    &fail_sunrpc.ignore_server_disconnect);
+
+	debugfs_create_bool("ignore-cache-timeout", S_IFREG | 0600, dir,
+			    &fail_sunrpc.ignore_cache_timeout);
 }
 #else
 static void fail_sunrpc_init(void)
diff --git a/net/sunrpc/fail.h b/net/sunrpc/fail.h
index 69dc30cc44b8..13b8436b5f15 100644
--- a/net/sunrpc/fail.h
+++ b/net/sunrpc/fail.h
@@ -14,8 +14,8 @@ struct fail_sunrpc_attr {
 	struct fault_attr	attr;
 
 	bool			ignore_client_disconnect;
-
 	bool			ignore_server_disconnect;
+	bool			ignore_cache_timeout;
 };
 
 extern struct fail_sunrpc_attr fail_sunrpc;


