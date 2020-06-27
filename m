Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABC120C319
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jun 2020 18:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgF0QfS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 27 Jun 2020 12:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgF0QfR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 27 Jun 2020 12:35:17 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84342C061794;
        Sat, 27 Jun 2020 09:35:17 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h23so9885124qtr.0;
        Sat, 27 Jun 2020 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3wdZ6UFKpvgBlLdEtBtXrh1crlptSTbcovoH+7aLRMQ=;
        b=IWZ9wXK0xt1DQCazFK5TkC/xkX6HVWi94XkTfLgCuptFPieec+s+nqh9yX+OEfrHak
         VkYqZFc0p6waWrvlU4GXe1ZImP+6o0QrrAbI/vtmxkGmf++MIXMsHZvJGY5nsWEAi8dP
         WGe2/+lsSJhDvCSzov484W+5yFiUc/c4mDTzkfH0XiCcORqqg604fAchGtWKu9soxpAF
         5sukU78DE1O/vQeD8pXdiMrWNoR8s6eqFz6FphAtVtiJDvVPqwEGwmEDImeO4tB85wBh
         TVKxTV7XjestqWu2eMMopmuBJuGo9J0O18zn3CxLlOjq03wRIH3guVliYUnCa7OsxvKk
         oRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=3wdZ6UFKpvgBlLdEtBtXrh1crlptSTbcovoH+7aLRMQ=;
        b=XyBBfG3EL8A2XURU3Uyfb5UIKOfTT3EeqSxP4cFDWbAkC42Wvf6Vx4ymc0Y9h59XNp
         dn059f2KRR2qMTT0L2Pit/kqGCdtTEqEWnYUEq/B56Z8CWQ3avzKZTNHlIrasUy+8tq9
         lRRrTlvT31zptWwWt9mMkuOTNY7p8HP4lRkd8Zyj89m6ucLSajfDje0jpK0UcD3zOFDn
         LOl0A2nCENlh7ApT+A+ZAsfBoA3R4slOwumhoapFKbXm2URU4Rz/XkJLrvHsf4OCIAUr
         WYUcBPKp0YW3qjjCaDCIjZcdMj1qCUvpo+K+Gt51NxiQF0UjZKOhnLMWcE0GuAdTu7ge
         cnyw==
X-Gm-Message-State: AOAM533z/+JVP6y8VcX7BPyia2RNwZWVgs87S244CFc8CxKiCEWJShx8
        YpIijK7Co1SBPOP3Ysigs7o=
X-Google-Smtp-Source: ABdhPJxHHuM5dJaEuYe14CzJzCyWWEob3EpVuMrH+ade7fGprocCZAq+hItkuMroCNIxoAyEmvP6iQ==
X-Received: by 2002:aed:2846:: with SMTP id r64mr8646791qtd.55.1593275716809;
        Sat, 27 Jun 2020 09:35:16 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s71sm11470036qke.0.2020.06.27.09.35.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jun 2020 09:35:16 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05RGZFhA003764;
        Sat, 27 Jun 2020 16:35:15 GMT
Subject: [PATCH v1 3/4] xprtrdma: Fix return code from rpcrdma_xprt_connect()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     dan@kernelim.com
Date:   Sat, 27 Jun 2020 12:35:15 -0400
Message-ID: <20200627163515.22826.65783.stgit@manet.1015granger.net>
In-Reply-To: <20200627162911.22826.34426.stgit@manet.1015granger.net>
References: <20200627162911.22826.34426.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I noticed that when rpcrdma_xprt_connect() returns -ENOMEM,
instead of retrying the connect, the RPC client kills the
RPC task that requested the connection. We want a retry
here.

Fixes: cb586decbb88 ("xprtrdma: Make sendctx queue lifetime the same as connection lifetime")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 641a3ca0fc8f..13d671dccfd8 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -400,7 +400,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 
 	ep = kzalloc(sizeof(*ep), GFP_NOFS);
 	if (!ep)
-		return -EAGAIN;
+		return -ENOTCONN;
 	ep->re_xprt = &r_xprt->rx_xprt;
 	kref_init(&ep->re_kref);
 
@@ -535,10 +535,6 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 	rpcrdma_ep_get(ep);
 	rpcrdma_post_recvs(r_xprt, true);
 
-	rc = rpcrdma_sendctxs_create(r_xprt);
-	if (rc)
-		goto out;
-
 	rc = rdma_connect(ep->re_id, &ep->re_remote_cma);
 	if (rc)
 		goto out;
@@ -552,9 +548,17 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 		goto out;
 	}
 
+	rc = rpcrdma_sendctxs_create(r_xprt);
+	if (rc) {
+		rc = -ENOTCONN;
+		goto out;
+	}
+
 	rc = rpcrdma_reqs_setup(r_xprt);
-	if (rc)
+	if (rc) {
+		rc = -ENOTCONN;
 		goto out;
+	}
 	rpcrdma_mrs_create(r_xprt);
 
 out:

