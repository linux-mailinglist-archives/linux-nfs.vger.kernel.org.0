Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49120702E29
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbjEONcq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 09:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbjEONcp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 09:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F681700
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 06:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1091762471
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 13:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA12C433EF;
        Mon, 15 May 2023 13:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684157562;
        bh=yCDjkNv+oqwBKcrh0OpYTEwzg7kxtSFsXePgNXq/u0k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N7KmZOSRCe7fyuZOy8hGwjEnLvC/rAO9DrGb6yVbblHnwBe3fO4k25rbE1SOdM0jF
         AjWv90vQ7kfg+1TweZYqU7UuERkBpmcq0pYLjKUQb70G99McuDeKeHbHuDHQUEzAmP
         3vJObVjXxfZK04fSGIUga3GYXIylrvb4EFpcFkklgkL/us8SiJaBk94h9QRFl+LeQj
         h7ZWciEguAficMs6aCzHHDQa2K0R6FqFAg9QRGpfnXiVimV8X6qW5nqm0dWAZyuaMI
         qFBCmF6ybVx6yU6OagS88jRaA3gD8Iv5jbhEbePX2P3YhgpstAha+X9DSPcw1OKPUS
         nq7DmKSor1Qww==
Subject: [PATCH 1/4] SUNRPC: Fix an incorrect comment
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 15 May 2023 09:32:41 -0400
Message-ID: <168415756128.9504.10972346476896238136.stgit@manet.1015granger.net>
In-Reply-To: <168415745478.9504.1882537002036193828.stgit@manet.1015granger.net>
References: <168415745478.9504.1882537002036193828.stgit@manet.1015granger.net>
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

The correct function name is svc_tcp_listen_data_ready().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 9aca6e1e78e4..e0fb65e90af2 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1469,7 +1469,7 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 	svsk->sk_owspace = inet->sk_write_space;
 	/*
 	 * This barrier is necessary in order to prevent race condition
-	 * with svc_data_ready(), svc_listen_data_ready() and others
+	 * with svc_data_ready(), svc_tcp_listen_data_ready(), and others
 	 * when calling callbacks above.
 	 */
 	wmb();


