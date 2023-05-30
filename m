Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FDA716322
	for <lists+linux-nfs@lfdr.de>; Tue, 30 May 2023 16:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjE3OH3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 May 2023 10:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjE3OH2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 May 2023 10:07:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE18D9
        for <linux-nfs@vger.kernel.org>; Tue, 30 May 2023 07:07:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 945C4630CC
        for <linux-nfs@vger.kernel.org>; Tue, 30 May 2023 14:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF71C433EF;
        Tue, 30 May 2023 14:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685455647;
        bh=Kyed/UbvWRho6vpmPpr7ylX/Da6hV2+VkFDzdFRluTc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ARUshBiCW88hfTpqzspXs3PR47AJYk3fV9S3YxpeHtjmFm4rskaXxdDbHXj7nmp+X
         S8kjI2edxBMdCrf2373fAhzD8hmNwT19d6BOoY/2zEu+6p+TzOZRHyqadd36SRE4KH
         3WLeWCYpzQg2FtSz3rIouFlG6aWwIA+PIt6hoD9ylfKrKFZ994XvsrYcCOI635pXRy
         koHBKuX8ot8Wc+mSeFrOfjqaCTPrQalQ4rYNKwlj8QY8uCkMS/rP2dEQ5osGo7TWlO
         hUFVJkJlpYJ3A1tZhgWx2GG6+ZTMTBcY7xwRzUrZChT0IXuG9qQd8W5kYeYskjcQfT
         5IZehF5q7nu4A==
Subject: [PATCH v3 05/11] SUNRPC: Ignore data_ready callbacks during TLS
 handshakes
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, jlayton@redhat.com,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date:   Tue, 30 May 2023 10:07:15 -0400
Message-ID: <168545563400.1917.12895266351746616109.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168545533442.1917.10040716812361925735.stgit@oracle-102.nfsv4bat.org>
References: <168545533442.1917.10040716812361925735.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The RPC header parser doesn't recognize TLS handshake traffic, so it
will close the connection prematurely with an error. To avoid that,
shunt the transport's data_ready callback when there is a TLS
handshake in progress.

The XPRT_SOCK_IGNORE_RECV flag will be toggled by code added in a
subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/xprtsock.h |    1 +
 net/sunrpc/xprtsock.c           |    6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
index 38284f25eddf..daef030f4848 100644
--- a/include/linux/sunrpc/xprtsock.h
+++ b/include/linux/sunrpc/xprtsock.h
@@ -90,5 +90,6 @@ struct sock_xprt {
 #define XPRT_SOCK_WAKE_DISCONNECT	(7)
 #define XPRT_SOCK_CONNECT_SENT	(8)
 #define XPRT_SOCK_NOSPACE	(9)
+#define XPRT_SOCK_IGNORE_RECV	(10)
 
 #endif /* _LINUX_SUNRPC_XPRTSOCK_H */
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 5f9030b81c9e..37f608c2c0a0 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -695,6 +695,8 @@ static void xs_poll_check_readable(struct sock_xprt *transport)
 {
 
 	clear_bit(XPRT_SOCK_DATA_READY, &transport->sock_state);
+	if (test_bit(XPRT_SOCK_IGNORE_RECV, &transport->sock_state))
+		return;
 	if (!xs_poll_socket_readable(transport))
 		return;
 	if (!test_and_set_bit(XPRT_SOCK_DATA_READY, &transport->sock_state))
@@ -1380,6 +1382,10 @@ static void xs_data_ready(struct sock *sk)
 		trace_xs_data_ready(xprt);
 
 		transport->old_data_ready(sk);
+
+		if (test_bit(XPRT_SOCK_IGNORE_RECV, &transport->sock_state))
+			return;
+
 		/* Any data means we had a useful conversation, so
 		 * then we don't need to delay the next reconnect
 		 */


