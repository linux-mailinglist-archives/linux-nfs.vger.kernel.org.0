Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86C91B64A8
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2020 21:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgDWTnP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Apr 2020 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgDWTnO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Apr 2020 15:43:14 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D36C09B042
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2020 12:43:14 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m67so7716067qke.12
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2020 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lmiGKU/0BzK3kvDCVebAFBHLnXuLfxEKHT7+An2vDSY=;
        b=SilGvuehru++w3CaSjNF9/99NO3lea2mM8qR7vger4JywbVejtuxidO+UAzmxas2ns
         vlJK77PoUpYMSEWj79l0qI3dT0Y6XI7Avh/ASWmCUKYrGy5HCja4dQ7PZYT9pOYxRWw5
         WzN8C2mf1DtVtBg5R0yGdQveBdQwGjpUVvbWwB7WytfHUZDhq5QX+hoaTnU2brrhejRI
         lXJwLarkmXF76EsZIXe2wfX8Kc/v75Gs0fZbI0ZomFuWZf67XaYEJnL26tJdj0kq7gZU
         CMfTnUYFqmPr4oL/3MwgH4RbdKrdZK9DGL+qq9QLLfDxuajoXkB+PhKnzIu+4NCAoqnI
         hE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lmiGKU/0BzK3kvDCVebAFBHLnXuLfxEKHT7+An2vDSY=;
        b=t1CTS09bztlPF15lXNFgEqgAoF1OzlMgmhhjPwLTytM/xv+5u0F7Oy4aw6JgbiQ9/p
         RK5RK6MeCCzeX8c37TJ9oQd6w360iuW25R1ay4y37OLlovLfig/XZo9Oxk4CxjtJ45ZI
         fSl9CwJeUjo0/wCBQHT6Fja2HxLGgH+kZnHlpG9Luo5vIbomDCoWnpqGuaG9FWvCaJfk
         8xi1J43eXfVClmmVBACOJ/qc2ET4RXWRLdKfXzxdyP86U+x1+wuPVw/Tf0Dz7BUZp+Jn
         DB11b7pgNWJ7Xzkr2c4mFfO7Hdsf09XRCcwjy8zrRbUnAEmCiPkSs97WMYCSDQaBM/ZA
         wHaw==
X-Gm-Message-State: AGi0PuY/gkLBRufAwZEmgtwFFUaAURntMhU8OKYwDmI9JsCZD3UzKYrm
        4GUMLm+MqIxlt4z5F8FxclKszTEI
X-Google-Smtp-Source: APiQypLuF+WpK/XZKjfnGHmrjvVX1hrMjs7EDjI5GfyyC1ODu+70wTr4PzZURgzGJfK47E0a4mjTUA==
X-Received: by 2002:a05:620a:15a4:: with SMTP id f4mr5041918qkk.221.1587670993945;
        Thu, 23 Apr 2020 12:43:13 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g25sm2166255qkl.50.2020.04.23.12.43.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 12:43:13 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 03NJhBM9030431;
        Thu, 23 Apr 2020 19:43:11 GMT
Subject: [PATCH RFC2 1/2] SUNRPC: Set SOFTCONN when destroying GSS contexts
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 23 Apr 2020 15:43:11 -0400
Message-ID: <20200423194311.7849.36326.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Prevent a (temporary) hang when shutting down an rpc_clnt that has
used one or more GSS creds.

I noticed that callers of rpc_call_null_helper() use a common set of
flags, so I collected them all in that helper function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/auth_gss.c |    2 +-
 net/sunrpc/clnt.c              |   10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index ac5cac0dd24b..16cec9755b86 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1285,7 +1285,7 @@ static void gss_pipe_free(struct gss_pipe *p)
 		ctx->gc_proc = RPC_GSS_PROC_DESTROY;
 
 		task = rpc_call_null(gss_auth->client, &new->gc_base,
-				RPC_TASK_ASYNC|RPC_TASK_SOFT);
+				     RPC_TASK_ASYNC);
 		if (!IS_ERR(task))
 			rpc_put_task(task);
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 325a0858700f..ddc98b97c170 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2742,7 +2742,8 @@ struct rpc_task *rpc_call_null_helper(struct rpc_clnt *clnt,
 		.rpc_op_cred = cred,
 		.callback_ops = (ops != NULL) ? ops : &rpc_default_ops,
 		.callback_data = data,
-		.flags = flags | RPC_TASK_NULLCREDS,
+		.flags = flags | RPC_TASK_SOFT | RPC_TASK_SOFTCONN |
+			 RPC_TASK_NULLCREDS,
 	};
 
 	return rpc_run_task(&task_setup_data);
@@ -2805,8 +2806,7 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 		goto success;
 	}
 
-	task = rpc_call_null_helper(clnt, xprt, NULL,
-			RPC_TASK_SOFT|RPC_TASK_SOFTCONN|RPC_TASK_ASYNC|RPC_TASK_NULLCREDS,
+	task = rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_ASYNC,
 			&rpc_cb_add_xprt_call_ops, data);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
@@ -2850,9 +2850,7 @@ int rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *clnt,
 		goto out_err;
 
 	/* Test the connection */
-	task = rpc_call_null_helper(clnt, xprt, NULL,
-				    RPC_TASK_SOFT | RPC_TASK_SOFTCONN | RPC_TASK_NULLCREDS,
-				    NULL, NULL);
+	task = rpc_call_null_helper(clnt, xprt, NULL, 0, NULL, NULL);
 	if (IS_ERR(task)) {
 		status = PTR_ERR(task);
 		goto out_err;

