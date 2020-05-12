Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1611D0079
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgELVOB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELVOB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:14:01 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239C9C061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:59 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 190so9668697qki.1
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MLNB41RqHnsCcHn2RXLBerNJNNqDOGqID/1gFOp2egI=;
        b=fzMw2FJXLA8tlYBwDkqcv8ik9Xmg7kN8nfcgK+d6iOLUJcjrLh8djoZJNiJXhGLFTU
         LP9PSbEKLxhOZXUH6shaJM6e2e0CLwmR/6n0oq9NWnb8U1pIci9wl8mdFxLVatRtNakH
         WFbkISkz3G84ygmuQ/CJ5qtg9eyVR1fkg73XxpwxM7WTP+nGXHKAWgufoSWkJ+rOdISV
         4CqFWRnrGRyADQGqfNS2ClhPhhtKV1NxCLfW+VOtMT7YclhorxiffFUtmt+9fZ9cmoI7
         cLEbNsHz/2E4hUBHOiGZcgu5NKRIAq/0mikY3O5ijbsKQK+FpWKzaZUn4QX9uT1QSACF
         eErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=MLNB41RqHnsCcHn2RXLBerNJNNqDOGqID/1gFOp2egI=;
        b=gESOk76l1zyCEF6v/pCYD73x/PElj4X5e9KpWJFWtrVXDPYn8Vcmr4lOrm0dH+Tqoo
         irB+iFpcHMXtyS/b8b4Y/mhQr3Z7W5Dl6vmr6G1OPqse4bZQ0dwA5Kc3dlifJrQ+CTbl
         o5aP5e614aGxoiT3Nd8PwO9BNxt6qGhaBIMJVwThk/CC/tgXYELQ0iuX4gkjaz1yZ59r
         FGNuItL4DK76s3Goen89/c8YdUpQo9Nhj0/D4lHUJo5T9KduVTbEpc406MC/ZrKTm+fZ
         FnSYhWAFuzNlR+yBweyNDL5PlbnaZNC0nMsKy4zcdpfgndd+uXXYHHfnCrSsHJWGa7PC
         UbNw==
X-Gm-Message-State: AGi0PuZz+NUZfBYTIQEdcFyXB0uos4crucHwpbwov6KoSkN5AG7hNMCV
        4MB1UvkUusPJsFFfA+zI6iXZEAd2
X-Google-Smtp-Source: APiQypIvGwTwVRm0OlY7tMMhOd/lV0dLve+q14tmUEK/8k87xTPp47OzSXNpMtbztjVkwTu6Hb/HcA==
X-Received: by 2002:a37:aa4e:: with SMTP id t75mr15511236qke.46.1589318036938;
        Tue, 12 May 2020 14:13:56 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y18sm13900301qty.41.2020.05.12.14.13.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:13:56 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLDtIo009819;
        Tue, 12 May 2020 21:13:55 GMT
Subject: [PATCH v1 12/15] SUNRPC: Set SOFTCONN when destroying GSS contexts
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:13:55 -0400
Message-ID: <20200512211355.3288.36563.stgit@manet.1015granger.net>
In-Reply-To: <20200512210724.3288.15187.stgit@manet.1015granger.net>
References: <20200512210724.3288.15187.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Move the RPC_TASK_SOFTCONN flag into rpc_call_null_helper(). The
only minor behavior change is that it is now also set when
destroying GSS contexts.

This gives a better guarantee that gss_send_destroy_context() will
not hang for long if a connection cannot be established.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index dad018b42939..e7ed151079d0 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2752,7 +2752,8 @@ struct rpc_task *rpc_call_null_helper(struct rpc_clnt *clnt,
 		.rpc_op_cred = cred,
 		.callback_ops = (ops != NULL) ? ops : &rpc_default_ops,
 		.callback_data = data,
-		.flags = flags | RPC_TASK_SOFT | RPC_TASK_NULLCREDS,
+		.flags = flags | RPC_TASK_SOFT | RPC_TASK_SOFTCONN |
+			 RPC_TASK_NULLCREDS,
 	};
 
 	return rpc_run_task(&task_setup_data);
@@ -2815,8 +2816,7 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 		goto success;
 	}
 
-	task = rpc_call_null_helper(clnt, xprt, NULL,
-			RPC_TASK_SOFTCONN|RPC_TASK_ASYNC,
+	task = rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_ASYNC,
 			&rpc_cb_add_xprt_call_ops, data);
 
 	rpc_put_task(task);
@@ -2859,8 +2859,7 @@ int rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *clnt,
 		goto out_err;
 
 	/* Test the connection */
-	task = rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_SOFTCONN,
-				    NULL, NULL);
+	task = rpc_call_null_helper(clnt, xprt, NULL, 0, NULL, NULL);
 	if (IS_ERR(task)) {
 		status = PTR_ERR(task);
 		goto out_err;

