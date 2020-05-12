Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB511D0078
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgELVNx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728379AbgELVNw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:13:52 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D71DC061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:52 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n14so15231810qke.8
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0K8dLTbvPsYMzOk2lUAqXDD323fhOkRCtyGfyOG6X6g=;
        b=pxAOA/YhqBU/z4MlBfkakPjzVZ3lFRw4rRmWBGhXVS7hZ5OZBbrU02YrmQu9SEht3a
         NXbgkmw19bbqp7K814iP74zkBSQaoBcN7CB+/Jflv0EOSWor8ClNB1YKm9Ylfh0gP6wD
         fErfjiUX4AJwDkceMB7e9ERc2F6O9xGdN4TPQ9+sXoa7s/8OVPGa+6z+9p0iqVmJIhKs
         SGtOFagImadlRKi0AsJH/rwB8veKLl3Kt959fftoxrRr2hVWUG63F47Bck2dnmPPQVi0
         J/kCQwGSFSZ5l+Vp+1RLiqtdWCPgIxaKNiAWEY9G2H5X4E9iZGFguGgTTgbE61pC4cDn
         l3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=0K8dLTbvPsYMzOk2lUAqXDD323fhOkRCtyGfyOG6X6g=;
        b=Iasto5MmD8RDoi2Bxp8YGBXO/6lyPtVMCz69lzAqpjmqtfThXyof5ZAra06hXtAZzb
         3TUjDVe3Uy7ENIkYXhfnzSFsssdhczRjoFy9QwCOxxoJeacx+4TWzHQwGtNozIQzj6er
         9vGU1RIEUx8AXOZhzil0WBYFE13xObPCzQHBjPdplrie5/GBKwqbRXjBLUwCVk0VICoX
         4mLAmZDbOeScKN5vnsJSQXK6OafrQYYazNpSeZ9f4LEZmlSskdukpNhJJQezzV/RH3KM
         KOo/JZuSNSk/iA5k2gfmFh4YAY3PRZ22CvnesHFHEcvzKm2V5fWPs9Pz3L0KlqSnmcK1
         KnDw==
X-Gm-Message-State: AGi0PuabKbWjtc+DDH+8xICckzwvsPmCX2E5TO4kvG0SNNTzPl2WE9NJ
        8qDx1RNCZtJTGT4tnOZxmF0=
X-Google-Smtp-Source: APiQypJ/b0aklLnh/pkzmfeEHjZGjpdnLsyIqQtWsRU311bYlc18AfDBr8sxDTfj5AcY/mdDVZrQOA==
X-Received: by 2002:a37:aad3:: with SMTP id t202mr11205087qke.186.1589318031776;
        Tue, 12 May 2020 14:13:51 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a124sm12344160qkf.93.2020.05.12.14.13.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:13:51 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLDofC009816;
        Tue, 12 May 2020 21:13:50 GMT
Subject: [PATCH v1 11/15] SUNRPC: rpc_call_null_helper() should set
 RPC_TASK_SOFT
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:13:50 -0400
Message-ID: <20200512211350.3288.81202.stgit@manet.1015granger.net>
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

Clean up.

All of rpc_call_null_helper() call sites assert RPC_TASK_SOFT, so
move that setting into rpc_call_null_helper() itself.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/auth_gss.c |    2 +-
 net/sunrpc/clnt.c              |    7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 429f17459ae3..4ecc2a959567 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1288,7 +1288,7 @@ static void gss_pipe_free(struct gss_pipe *p)
 
 		trace_rpcgss_ctx_destroy(gss_cred);
 		task = rpc_call_null(gss_auth->client, &new->gc_base,
-				RPC_TASK_ASYNC|RPC_TASK_SOFT);
+				     RPC_TASK_ASYNC);
 		if (!IS_ERR(task))
 			rpc_put_task(task);
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d456537992a2..dad018b42939 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2752,7 +2752,7 @@ struct rpc_task *rpc_call_null_helper(struct rpc_clnt *clnt,
 		.rpc_op_cred = cred,
 		.callback_ops = (ops != NULL) ? ops : &rpc_default_ops,
 		.callback_data = data,
-		.flags = flags | RPC_TASK_NULLCREDS,
+		.flags = flags | RPC_TASK_SOFT | RPC_TASK_NULLCREDS,
 	};
 
 	return rpc_run_task(&task_setup_data);
@@ -2816,7 +2816,7 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 	}
 
 	task = rpc_call_null_helper(clnt, xprt, NULL,
-			RPC_TASK_SOFT|RPC_TASK_SOFTCONN|RPC_TASK_ASYNC,
+			RPC_TASK_SOFTCONN|RPC_TASK_ASYNC,
 			&rpc_cb_add_xprt_call_ops, data);
 
 	rpc_put_task(task);
@@ -2859,8 +2859,7 @@ int rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *clnt,
 		goto out_err;
 
 	/* Test the connection */
-	task = rpc_call_null_helper(clnt, xprt, NULL,
-				    RPC_TASK_SOFT | RPC_TASK_SOFTCONN,
+	task = rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_SOFTCONN,
 				    NULL, NULL);
 	if (IS_ERR(task)) {
 		status = PTR_ERR(task);

