Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD824F1B76
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Apr 2022 23:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379651AbiDDVU1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Apr 2022 17:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379822AbiDDSLR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Apr 2022 14:11:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A601122B27
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 11:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F8CEB818D3
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 18:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197AAC2BBE4
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 18:09:18 +0000 (UTC)
Subject: [PATCH v1 3/6] SUNRPC: Cache deferral injection
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 04 Apr 2022 14:09:17 -0400
Message-ID: <164909575709.3716.7317334286489397904.stgit@manet.1015granger.net>
In-Reply-To: <164909503892.3716.8666091898179474248.stgit@manet.1015granger.net>
References: <164909503892.3716.8666091898179474248.stgit@manet.1015granger.net>
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

Cache deferral injection stress-tests the cache deferral logic as
well as upper layer protocol deferred request handlers. This
facility is for developers and professional testers to ensure
coverage of the rqst deferral code paths. To date, we haven't
had an adequate way to ensure these code paths are covered
during testing, short of temporary code changes to force their
use.

A file called /sys/kernel/debug/fail_sunrpc/ignore-cache-wait
enables administrators to disable cache deferral injection while
allowing other types of sunrpc errors to be injected. The default
setting is that cache deferral injection is enabled (ignore=false).

To enable support for cache deferral injection,
CONFIG_FAULT_INJECTION, CONFIG_FAULT_INJECTION_DEBUG_FS, and
CONFIG_SUNRPC_DEBUG must all be set to "Y".

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/cache.c   |   18 +++++++++++++++++-
 net/sunrpc/debugfs.c |    3 +++
 net/sunrpc/fail.h    |    2 +-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index bb1177395b99..c3c693b51c94 100644
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
 
@@ -688,16 +690,30 @@ static void cache_limit_defers(void)
 		discard->revisit(discard, 1);
 }
 
+#if IS_ENABLED(CONFIG_FAIL_SUNRPC)
+static inline bool cache_defer_immediately(void)
+{
+	return !fail_sunrpc.ignore_cache_wait &&
+		should_fail(&fail_sunrpc.attr, 1);
+}
+#else
+static inline bool cache_defer_immediately(void)
+{
+	return false;
+}
+#endif
+
 /* Return true if and only if a deferred request is queued. */
 static bool cache_defer_req(struct cache_req *req, struct cache_head *item)
 {
 	struct cache_deferred_req *dreq;
 
-	if (req->thread_wait) {
+	if (!cache_defer_immediately()) {
 		cache_wait_req(req, item);
 		if (!test_bit(CACHE_PENDING, &item->flags))
 			return false;
 	}
+
 	dreq = req->defer(req);
 	if (dreq == NULL)
 		return false;
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index 7dc9cc929bfd..a176d5a0b0ee 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -262,6 +262,9 @@ static void fail_sunrpc_init(void)
 
 	debugfs_create_bool("ignore-server-disconnect", S_IFREG | 0600, dir,
 			    &fail_sunrpc.ignore_server_disconnect);
+
+	debugfs_create_bool("ignore-cache-wait", S_IFREG | 0600, dir,
+			    &fail_sunrpc.ignore_cache_wait);
 }
 #else
 static void fail_sunrpc_init(void)
diff --git a/net/sunrpc/fail.h b/net/sunrpc/fail.h
index 69dc30cc44b8..4b4b500df428 100644
--- a/net/sunrpc/fail.h
+++ b/net/sunrpc/fail.h
@@ -14,8 +14,8 @@ struct fail_sunrpc_attr {
 	struct fault_attr	attr;
 
 	bool			ignore_client_disconnect;
-
 	bool			ignore_server_disconnect;
+	bool			ignore_cache_wait;
 };
 
 extern struct fail_sunrpc_attr fail_sunrpc;


