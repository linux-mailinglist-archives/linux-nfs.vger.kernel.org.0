Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0582A77EED7
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 03:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347443AbjHQBtY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Aug 2023 21:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347569AbjHQBtC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Aug 2023 21:49:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD25270A
        for <linux-nfs@vger.kernel.org>; Wed, 16 Aug 2023 18:49:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c4d30c349so36474877b3.2
        for <linux-nfs@vger.kernel.org>; Wed, 16 Aug 2023 18:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692236940; x=1692841740;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sP6Usm0yXizaY1YHdJi/W/NJJGhkqQmiqhsEBc8iTjA=;
        b=Mjz0NM8EnrdR1wiNWMCYlu4wgYlpm4B3A6kAE1IHj4DRam4ZweUJOd8FbMS0r5txxw
         xSKkhstAJOg6re/MXvAKQDqUNZAAZXEB3zAwMIAcAK2sWcY8RR+J6A4KfuCeShxSQiO6
         8aowrQ5bnEYKW76XbUZUY/KrpeBzjb05RSfP2Xf7H4eKAqpgCyqWDlbX3HTKXn5GZ/my
         pkKqd/+9aUnUhtPeZTu9i4IP/QEjyVeqw626GyRQ26lzL7uxGt+NVZT3Z3UnwVfWq93r
         bPjZdmUyE/sXSVYJXWfB28R2b8mpF8Us1RsoHKjkGU7TGSOfcHA/d0xH854uu6QXQZT4
         XAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692236940; x=1692841740;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sP6Usm0yXizaY1YHdJi/W/NJJGhkqQmiqhsEBc8iTjA=;
        b=ii+WZudWJtUBlt7up004PQb+9U37h7fKB3RlXq4aeDL88Hz5nh3onMO5x0PQICRM/1
         gxmsh0UB4LY5gh7++8fIX13iLPvfKBUlGLE87dtsRdpCHxFZK/0oHbTqCshOOV6IsUd0
         B77WCEba/i9WfbfuMcfL6Gf+Rjmc9ImnweVoJPt9FUw/wkk9LpMVUKXNEEeKHreCdUJt
         ctW65S180HTqJ2gbzSSukiIJ1U2HDKI8MnQ2zU5egPkgkGgz8Z/6Ao9lRvULUn/iNKOL
         /Y+YdZhgIx9xI+wfmDl1ZLUYKcFgwp4moOr+ORCNGKHU3lG1XAqI/u7UnBQovDQ41oy2
         su9g==
X-Gm-Message-State: AOJu0YyL7nlQu9qFhdzf6GjXmW+Dxz7vbab8eTaUHiRGClh2CZmBzCnX
        MSY72FG4gA4nppVj6HQ9K19VjMjPaA==
X-Google-Smtp-Source: AGHT+IH00J7sCwuPZxCb8lpVW2m9tS3ER/T/EjGkOuyYSpMTf8Sby/1gT25kBhcABlJy6N6SpigVgQySmg==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:e7c7:0:b0:d3f:5b2:e89e with SMTP id
 e190-20020a25e7c7000000b00d3f05b2e89emr42718ybh.6.1692236940597; Wed, 16 Aug
 2023 18:49:00 -0700 (PDT)
Date:   Wed, 16 Aug 2023 20:48:09 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230817014808.3494465-2-jrife@google.com>
Subject: [PATCH] SUNRPC: Avoid address overwrite with eBPF NAT
From:   Jordan Rife <jrife@google.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de
Cc:     linux-nfs@vger.kernel.org, Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

kernel_connect() will modify the rpc_xprt socket address in contexts
where eBPF programs perform NAT instead of iptables. In these contexts,
it is common for an NFS mount to be mounted to be a static virtual IP
while the server has an ephemeral IP leading to a problem where the
virtual IP gets overwritten and forgotten. When the endpoint IP changes,
reconnect attempts fail and the mount never recovers.

This patch protects addr from being modified in these scenarios, allowing
NFS reconnects to work as intended.

Link: https://github.com/cilium/cilium/issues/21541#issuecomment-1386857338
Signed-off-by: Jordan Rife <jrife@google.com>
---
 include/linux/sunrpc/xprt.h |  1 +
 net/sunrpc/xprtsock.c       | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index b52411bcfe4e7..ddde79b025c53 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -211,6 +211,7 @@ struct rpc_xprt {
 
 	const struct rpc_timeout *timeout;	/* timeout parms */
 	struct sockaddr_storage	addr;		/* server address */
+	struct sockaddr_storage m_addr;      /* mutable server address */
 	size_t			addrlen;	/* size of server address */
 	int			prot;		/* IP protocol */
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 9f010369100a2..4100e0bf5ebba 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -236,6 +236,18 @@ static inline struct sockaddr *xs_addr(struct rpc_xprt *xprt)
 	return (struct sockaddr *) &xprt->addr;
 }
 
+static inline struct sockaddr *xs_m_addr(struct rpc_xprt *xprt)
+{
+    /* kernel_connect() may modify the address in contexts where NAT is
+     * performed by eBPF programs instead of iptables. Make a copy to ensure
+     * that our original address, xprt->addr, is not modified. Without this,
+     * NFS reconnects may fail if the endpoint address changes.
+     */
+	memcpy(&xprt->m_addr, &xprt->addr, xprt->addrlen);
+
+	return (struct sockaddr *) &xprt->m_addr;
+}
+
 static inline struct sockaddr_un *xs_addr_un(struct rpc_xprt *xprt)
 {
 	return (struct sockaddr_un *) &xprt->addr;
@@ -1954,7 +1966,7 @@ static int xs_local_finish_connecting(struct rpc_xprt *xprt,
 
 	xs_stream_start_connect(transport);
 
-	return kernel_connect(sock, xs_addr(xprt), xprt->addrlen, 0);
+	return kernel_connect(sock, xs_m_addr(xprt), xprt->addrlen, 0);
 }
 
 /**
@@ -2334,7 +2346,8 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 
 	/* Tell the socket layer to start connecting... */
 	set_bit(XPRT_SOCK_CONNECTING, &transport->sock_state);
-	return kernel_connect(sock, xs_addr(xprt), xprt->addrlen, O_NONBLOCK);
+
+	return kernel_connect(sock, xs_m_addr(xprt), xprt->addrlen, O_NONBLOCK);
 }
 
 /**
-- 
2.42.0.rc1.204.g551eb34607-goog

