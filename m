Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C834F6A6C
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Apr 2022 21:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiDFTwF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 15:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiDFTvk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 15:51:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5DA1EC9AF
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 11:08:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39ADD61C11
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 18:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6ECC385A5
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 18:08:09 +0000 (UTC)
Subject: [PATCH v2 2/2] SUNRPC: Fix the svc_deferred_event trace class
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Apr 2022 14:08:08 -0400
Message-ID: <164926848846.12216.6872977249610829189.stgit@klimt.1015granger.net>
In-Reply-To: <164926821551.12216.9112595778893638551.stgit@klimt.1015granger.net>
References: <164926821551.12216.9112595778893638551.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev1+g8516920
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

Fix a NULL deref crash that occurs when an svc_rqst is deferred
while the sunrpc tracing subsystem is enabled. svc_revisit() sets
dr->xprt to NULL, so it can't be relied upon in the tracepoint to
provide the remote's address.

Since __sockaddr() and friends are not available before v5.18, this
is just a partial revert of commit ece200ddd54b ("sunrpc: Save
remote presentation address in svc_xprt for trace events") in order
to enable backports of the fix. It can be cleaned up during a
future merge window.

Fixes: ece200ddd54b ("sunrpc: Save remote presentation address in svc_xprt for trace events")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ab8ae1f6ba84..4abc2fddd3b8 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -2017,18 +2017,19 @@ DECLARE_EVENT_CLASS(svc_deferred_event,
 	TP_STRUCT__entry(
 		__field(const void *, dr)
 		__field(u32, xid)
-		__string(addr, dr->xprt->xpt_remotebuf)
+		__dynamic_array(u8, addr, dr->addrlen)
 	),
 
 	TP_fast_assign(
 		__entry->dr = dr;
 		__entry->xid = be32_to_cpu(*(__be32 *)(dr->args +
 						       (dr->xprt_hlen>>2)));
-		__assign_str(addr, dr->xprt->xpt_remotebuf);
+		memcpy(__get_dynamic_array(addr), &dr->addr, dr->addrlen);
 	),
 
-	TP_printk("addr=%s dr=%p xid=0x%08x", __get_str(addr), __entry->dr,
-		__entry->xid)
+	TP_printk("addr=%pISpc dr=%p xid=0x%08x",
+		(struct sockaddr *)__get_dynamic_array(addr),
+		__entry->dr, __entry->xid)
 );
 
 #define DEFINE_SVC_DEFERRED_EVENT(name) \


