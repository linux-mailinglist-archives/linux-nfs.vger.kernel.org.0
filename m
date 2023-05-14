Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EF0701F4E
	for <lists+linux-nfs@lfdr.de>; Sun, 14 May 2023 21:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjENTwB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 May 2023 15:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjENTwB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 May 2023 15:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80531CE
        for <linux-nfs@vger.kernel.org>; Sun, 14 May 2023 12:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F9EF60D2C
        for <linux-nfs@vger.kernel.org>; Sun, 14 May 2023 19:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506DEC433EF;
        Sun, 14 May 2023 19:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684093919;
        bh=d4OEIanrVuKIyxV2aCXzxScHdOmhLzrIVb4oLSOJNf0=;
        h=Subject:From:To:Cc:Date:From;
        b=gWw5rY4fgAVkYxJU8TW+okbemFcgDGiaJ8hj+eBswtj7Lw967XCAW37TGmXkEpOf2
         T9Ri2uN2tjooWpdPcWcuX/Qu1b23ot17lLaFI7+1qzHvFHOavzvM1HTzirai+B+/Gd
         xOJze2CwTMpmWVVleyMN6MGhV0c0AfQlqkWYB9zrGPEgX23ynf4kh1j/BXl7dodCw8
         SBzEW8SOLfH4AAjDAmkB3gWELgFmdID5eP1PWHut64AWX+fIDEW6H1ZQ/ekgbwcBMw
         OwBtWfBVkNB3k34S8gUHCXVWhop+5g6MpgZILZjj1fqsSqLNxS/2UP6LyEbmkasGkI
         I6Xs91Q29qBVQ==
Subject: [PATCH] SUNRPC: Fix trace_svc_register() call site
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Sun, 14 May 2023 15:51:48 -0400
Message-ID: <168409389798.9284.10566481510384675833.stgit@oracle-102.nfsv4bat.org>
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

The arguments are in the wrong order.

Fixes: b4af59328c25 ("SUNRPC: Trace server-side rpcbind registration events")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 26367cf4c17a..a83d849318b3 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1052,7 +1052,7 @@ static int __svc_register(struct net *net, const char *progname,
 #endif
 	}
 
-	trace_svc_register(progname, version, protocol, port, family, error);
+	trace_svc_register(progname, version, family, protocol, port, error);
 	return error;
 }
 


