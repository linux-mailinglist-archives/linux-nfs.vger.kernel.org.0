Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F1667A40F
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jan 2023 21:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjAXUkU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 15:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjAXUkT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 15:40:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543E54DE0F
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 12:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8C066132E
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 20:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAD2C433EF
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674592817;
        bh=biJlJHV2m+XrDzm9fQdAZBGpAIuqNFpxorl8NEobaDs=;
        h=Subject:From:To:Date:From;
        b=E4gTFrZTM9TiQwIld3c0mB5N0l12xrgNNH4x3cQul2pyo4oU2GFZdXm+nlfDPT/bN
         JJsjmdHmXgfhHaS5ATfF9FgqtxR/jm4am6U9mjBsDg7Qqgq4p2caCEsMP3sb6jPh6Y
         zmxfMuo4cwLQScejOScVJwn9+p+i90d8YaHZeAIOgQ337Me7zFmI+1fOp96pHMDeXT
         oIIUoo3SnU1gFgVhEjsZpDb7ozaJJK8arngWMauHdRnnv1igpcJb6XxbVQB4SwIOzl
         iWHMDh+d7RqU6zQPL/UPBcicS8GGw7djoUE39C/hEysrvlKwSyWjKCFwduUEGYTnG7
         vz05upNF9t6Rg==
Subject: [PATCH v1 1/2] SUNRPC: Clean up the svc_xprt_flags() macro
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 24 Jan 2023 15:40:15 -0500
Message-ID: <167459281558.15600.1555010122091924488.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Make this macro more conventional:
 - Use BIT() instead of open-coding " 1UL << "
 - Don't display the "XPT_" in every flag name

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 37604e0e5963..3ca54536f8f7 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1819,20 +1819,20 @@ TRACE_EVENT(svc_stats_latency,
 
 #define show_svc_xprt_flags(flags)					\
 	__print_flags(flags, "|",					\
-		{ (1UL << XPT_BUSY),		"XPT_BUSY"},		\
-		{ (1UL << XPT_CONN),		"XPT_CONN"},		\
-		{ (1UL << XPT_CLOSE),		"XPT_CLOSE"},		\
-		{ (1UL << XPT_DATA),		"XPT_DATA"},		\
-		{ (1UL << XPT_TEMP),		"XPT_TEMP"},		\
-		{ (1UL << XPT_DEAD),		"XPT_DEAD"},		\
-		{ (1UL << XPT_CHNGBUF),		"XPT_CHNGBUF"},		\
-		{ (1UL << XPT_DEFERRED),	"XPT_DEFERRED"},	\
-		{ (1UL << XPT_OLD),		"XPT_OLD"},		\
-		{ (1UL << XPT_LISTENER),	"XPT_LISTENER"},	\
-		{ (1UL << XPT_CACHE_AUTH),	"XPT_CACHE_AUTH"},	\
-		{ (1UL << XPT_LOCAL),		"XPT_LOCAL"},		\
-		{ (1UL << XPT_KILL_TEMP),	"XPT_KILL_TEMP"},	\
-		{ (1UL << XPT_CONG_CTRL),	"XPT_CONG_CTRL"})
+		{ BIT(XPT_BUSY),		"BUSY" },		\
+		{ BIT(XPT_CONN),		"CONN" },		\
+		{ BIT(XPT_CLOSE),		"CLOSE" },		\
+		{ BIT(XPT_DATA),		"DATA" },		\
+		{ BIT(XPT_TEMP),		"TEMP" },		\
+		{ BIT(XPT_DEAD),		"DEAD" },		\
+		{ BIT(XPT_CHNGBUF),		"CHNGBUF" },		\
+		{ BIT(XPT_DEFERRED),		"DEFERRED" },		\
+		{ BIT(XPT_OLD),			"OLD" },		\
+		{ BIT(XPT_LISTENER),		"LISTENER" },		\
+		{ BIT(XPT_CACHE_AUTH),		"CACHE_AUTH" },		\
+		{ BIT(XPT_LOCAL),		"LOCAL" },		\
+		{ BIT(XPT_KILL_TEMP),		"KILL_TEMP" },		\
+		{ BIT(XPT_CONG_CTRL),		"CONG_CTRL" })
 
 TRACE_EVENT(svc_xprt_create_err,
 	TP_PROTO(


