Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A444F1B79
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Apr 2022 23:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiDDVUb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Apr 2022 17:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379823AbiDDSLY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Apr 2022 14:11:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F310387A7
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 11:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F1764CE1A37
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 18:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A599C2BBE4
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 18:09:24 +0000 (UTC)
Subject: [PATCH v1 4/6] SUNRPC: Make cache_req::thread_wait an unsigned long
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 04 Apr 2022 14:09:23 -0400
Message-ID: <164909576335.3716.3735482567493845232.stgit@manet.1015granger.net>
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

The second parameter of wait_for_completion_interruptible_timeout()
is a jiffies value whose type is "unsigned long". Avoid an
unnecessary and potentially fraught implicit type conversion at the
wait_for_completion_interruptible_timeout() call site in
cache_wait_req().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/cache.h |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index b134b2b3371c..2fde954f1956 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -121,17 +121,16 @@ struct cache_detail {
 	struct net		*net;
 };
 
-
 /* this must be embedded in any request structure that
  * identifies an object that will want a callback on
  * a cache fill
  */
 struct cache_req {
 	struct cache_deferred_req *(*defer)(struct cache_req *req);
-	int thread_wait;  /* How long (jiffies) we can block the
-			   * current thread to wait for updates.
-			   */
+	unsigned long	thread_wait;	/* How long (jiffies) we can block the
+					 * current thread to wait for updates. */
 };
+
 /* this must be embedded in a deferred_request that is being
  * delayed awaiting cache-fill
  */


