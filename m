Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B3D361860
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 05:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbhDPDw6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 23:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbhDPDw6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Apr 2021 23:52:58 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B96C061574
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:34 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d15so14621885qkc.9
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x4DaaU9yOVKZrRAH+MhLqkl5WKTJPjX+1LKTHN+yRCk=;
        b=R9geN5s38XJMWe0wyv2lPXHFnGq+PI5y5jFdKov7vA1gEKSRuYwQWzZHwODCFc4q2F
         AP4aWAHDKlGc5TMwa/6gmQx7bnBLx6RoCS8XR7QAkEPI4Ace5TSjBK/nePUlRd8pI+UF
         5M75a7FwNcOuke66tL0gpmlYB1huJVixVMR1WSYO4V5mjceQrCpE5zL3J7MGxSYM54Eg
         4zGSWce/sw8Wo5u2RDIDvUB4Rt9l0Rr3Mf67qdJV3LTnGX1KCP0D1GseCt0CE3oPwyyi
         EuAIiJZlrVoQYA8x8RnEKNKlmh4EooGwuB9kUjqeRNTW9FGZa2iL/F1H6MkJVmzV2BdG
         yp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4DaaU9yOVKZrRAH+MhLqkl5WKTJPjX+1LKTHN+yRCk=;
        b=qCD4NORDAZ6TIwQioVis0UQSZQncdiqMEbOYSMbERn++2e3+OhgMKj1ZQJAmw7I21m
         Mp5m+ipwEiLIUye4sSDOdrHqC8W0kGG4Zrb/lTmbp9yPZpUXSJBeXe0EnxidyFIZSnWA
         x/ZvX0gRJWzi7gVSFnR5iwR59d8eFCEoaeCHQgojw0zna/cVOs67S2OmuVrPSfC3JAPe
         BUZqXwJ5BtDdWMjA4vWuEDuSRwBnWAR6ZZ9ZKhMf7A7u5aRBLhLX7abazyjFm8pz6VGZ
         IBJMC/fX0T7zDIeI/0D0tyRpLlKQ0sGRuQ6E1QBrouaQXxika6pj/lP6MzwSFw4qJ0iE
         UjiA==
X-Gm-Message-State: AOAM531JHmrGxYTU7zyRXa9cG98kELIz6TybGhzRureG+z7uMzzzlr1S
        8KFz7AFaBlAv7czA0BEwnEI=
X-Google-Smtp-Source: ABdhPJyHkZ7G77vhdCixgtwzeHrM71CmbNjENMuUEhBWlDTSJP2FUXiZ8kb2Z0PzXfr67QqtFG/ZVg==
X-Received: by 2002:a37:7006:: with SMTP id l6mr6724258qkc.137.1618545153546;
        Thu, 15 Apr 2021 20:52:33 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id x82sm3500913qkb.0.2021.04.15.20.52.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 20:52:33 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 04/13] sunrpc: Prepare xs_connect() for taking NULL tasks
Date:   Thu, 15 Apr 2021 23:52:17 -0400
Message-Id: <20210416035226.53588-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
References: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We won't have a task structure when we go to change IP addresses, so
check for one before calling the WARN_ON() to avoid crashing.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/xprtsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 47aa47a2b07c..2bcb80c19339 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2317,7 +2317,7 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
 	unsigned long delay = 0;
 
-	WARN_ON_ONCE(!xprt_lock_connect(xprt, task, transport));
+	WARN_ON_ONCE(task && !xprt_lock_connect(xprt, task, transport));
 
 	if (transport->sock != NULL) {
 		dprintk("RPC:       xs_connect delayed xprt %p for %lu "
-- 
2.27.0

