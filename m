Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA05720C315
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jun 2020 18:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgF0QfH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 27 Jun 2020 12:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgF0QfH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 27 Jun 2020 12:35:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EFEC061794;
        Sat, 27 Jun 2020 09:35:06 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l6so11675115qkc.6;
        Sat, 27 Jun 2020 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=hqrnM2P86aSZRrC5NtmU271qkiumzYYR3Yt7LqqAEUc=;
        b=J6PMz3whRLurBm6qpccrsfC2D0yZUvlOLgOI3Sg7viz+70uV9xC6f0/Y7kzD5PJ6+i
         RCjWEEtpfPWK930xqPstd6AZ+ap49b+NPMFPw7fA0/bxbbIpwLDQWpkLqgIbnXx89crs
         SmwZKMLBTUGx5O9+pYuSUSpjix4erRB9P6r3f3VIzWfOFvH5HIHT0q5ZJXbVDAhwvv++
         JqZqCA9Jso7Lky/xvylI8jiwMxknJ80muBD6qBE/DtrRZMdU/C3pPEhsu7lo3NdDk/Dm
         0Oxq5wUzJliNIUyYjHU2FtNKJZtUhvr3D+sQ0SykEAGTWBuE05j83gJgz827liZwaZMc
         3nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=hqrnM2P86aSZRrC5NtmU271qkiumzYYR3Yt7LqqAEUc=;
        b=KvLVURGQr9whVWL6IAJ2Ti+jvtWjzM2PmmUgQQGvMmq8k5VEsCFpIJ0+60q4DIsgzQ
         Mxar9ShXgKsb/hoXeT4A+N5J9tprb369f5kI2dzGygPRbH3kiBeaoBDdVDzElB7Uxb9p
         Icz8nF2o7GeA1+Ge04G8JbK44VI+va8157seGNsX0uyHSYmIKdUkk2R3tCTVFgwFrwbV
         HTfB7E2cnkQPuSYCwl+FJIVG6VIsyx7p3FEYhoHDyXWdNbmc2G/1UMmhwrWrROTR5c/Q
         fWApRCBjcDGVUssG0W0+tz+aoD41r08d7FJBSOzyLba1oAN1vLLgdjhQ3JzNaL3/Dstf
         UBmw==
X-Gm-Message-State: AOAM532WhC2+pxe6rqZEESsItz0XLNnNeisnl/NSZYobRbJQ3mbisjnF
        eNrnHuXjkV4vz9QKCBeKY/w=
X-Google-Smtp-Source: ABdhPJz/dTTvjuIk8kgihzZIy6g9s7Ai2OSL8ruUdz0cIhq2GSMYvxxbD6eUts2WiamQ/UfOi6b5Ag==
X-Received: by 2002:a37:4c0d:: with SMTP id z13mr7813682qka.170.1593275706212;
        Sat, 27 Jun 2020 09:35:06 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z17sm9998959qth.24.2020.06.27.09.35.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jun 2020 09:35:05 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05RGZ49O003758;
        Sat, 27 Jun 2020 16:35:04 GMT
Subject: [PATCH v1 1/4] xprtrdma: Fix double-free in rpcrdma_ep_create()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     dan@kernelim.com
Date:   Sat, 27 Jun 2020 12:35:04 -0400
Message-ID: <20200627163504.22826.98966.stgit@manet.1015granger.net>
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

In the error paths, there's no need to call kfree(ep) after calling
rpcrdma_ep_put(ep).

Fixes: e28ce90083f0 ("xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 2198c8ec8dff..e4c0df7c7d78 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -406,8 +406,8 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 
 	id = rpcrdma_create_id(r_xprt, ep);
 	if (IS_ERR(id)) {
-		rc = PTR_ERR(id);
-		goto out_free;
+		kfree(ep);
+		return PTR_ERR(id);
 	}
 	__module_get(THIS_MODULE);
 	device = id->device;
@@ -506,9 +506,6 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 out_destroy:
 	rpcrdma_ep_put(ep);
 	rdma_destroy_id(id);
-out_free:
-	kfree(ep);
-	r_xprt->rx_ep = NULL;
 	return rc;
 }
 

