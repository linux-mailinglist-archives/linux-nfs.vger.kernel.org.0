Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F025520BF
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243762AbiFTP0E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244646AbiFTPZ0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:25:26 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B008254
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:42 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 15so8022699qki.6
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0VyjboFzsu/G6oZ+tax3StcECwDLW9wHRaQJ9kf/U4c=;
        b=CcFExt9KEh4TlFsX+QhnG4hE7XWQGM9c09SqsYpUTrB56xMldxEvqVL28KFstjeWUq
         P/ICCiWQQib/MrG0hu8QrOcLwH0p6CmqoMGLiCWc5AXh83ht69uErlN1sLV9NQ9bcN11
         TrbXyXmTvgYR8eogPPLnaNi8uI3F7+Xt58XHGVO/85Lcl9E0lWzLSMrb0CXtWu2QHyJK
         Y9i5XmlSBTmf6weUUgu0JzQiEVSsaY9lR3skMRfphZkDAx0d5WkTvziOtovj61fCrKW+
         UJ00L9pTkP9QiWSn5V6BPVqIoLs4kYGcunhAoHb3MAe69HnWNdkYOFvVkJo6/KoQ+T/0
         KFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0VyjboFzsu/G6oZ+tax3StcECwDLW9wHRaQJ9kf/U4c=;
        b=md5KPUyiIWekpUNh1hej9aMVc93n1+quRJl4sVHy2l4jV1nn+1zkT20CBsBUy7haGn
         Ab6vRHRNqJj8KzddEIYibyJg8JkyclcToqOGsmBhfZlh4H9tIOnlxlRT4ZDqHHolyOaK
         PllE8REJzXeaLUiO/9KS9+Svu7W/6VPPEzkXnpeT+y0rLnoiW4VGELbI4zTpMcpwJ/Ya
         P6R7cEuXArLUhRVx69+a3xgeUlL5qbQmW2Qplxj1JbXgPopohOImUqMV6THyjcHMDFKh
         J2LeigRgrzOqHj7AnTkcLQXBBsT+xILOJG9LxQaX7N/MHmuNt2Ip7QKGgfbKxhwAgAzP
         2zrQ==
X-Gm-Message-State: AJIora9uR/Uv/3/stWgxae+BLFsjfGbmI3YDfgDlfo6jXaaqh1CCK0+3
        fJTm7BDLXUkJrPRjppK4gNCpd4PuNkosgw==
X-Google-Smtp-Source: AGRyM1seUrhJGBOHQeM9GKCqjoUciCmUozuYALfs2uvHPp9KmtRmyymy0aQG8MDXT90VrGkm8DDuGg==
X-Received: by 2002:a37:6704:0:b0:6a6:fc41:864a with SMTP id b4-20020a376704000000b006a6fc41864amr16437872qkc.165.1655738681547;
        Mon, 20 Jun 2022 08:24:41 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:48cb:6eb8:1da1:a5c0])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006a791a42693sm12517862qko.133.2022.06.20.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:24:41 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 09/12] SUNRPC restructure rpc_clnt_setup_test_and_add_xprt
Date:   Mon, 20 Jun 2022 11:24:04 -0400
Message-Id: <20220620152407.63127-10-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
References: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

In preparation for code re-use, pull out the part of the
rpc_clnt_setup_test_and_add_xprt() portion that sends a NULL rpc
and then calls a session trunking function into a helper function.

Re-organize the end of the function for code re-use.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/clnt.c | 53 ++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 2b2515c121fa..6b04b29bf842 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2887,6 +2887,31 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_test_and_add_xprt);
 
+static int rpc_clnt_add_xprt_helper(struct rpc_clnt *clnt,
+				    struct rpc_xprt *xprt,
+				    void *data)
+{
+	struct rpc_task *task;
+	struct rpc_add_xprt_test *xtest = (struct rpc_add_xprt_test *)data;
+	int status = -EADDRINUSE;
+
+	/* Test the connection */
+	task = rpc_call_null_helper(clnt, xprt, NULL, 0, NULL, NULL);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	status = task->tk_status;
+	rpc_put_task(task);
+
+	if (status < 0)
+		return status;
+
+	/* rpc_xprt_switch and rpc_xprt are deferrenced by add_xprt_test() */
+	xtest->add_xprt_test(clnt, xprt, xtest->data);
+
+	return 0;
+}
+
 /**
  * rpc_clnt_setup_test_and_add_xprt()
  *
@@ -2910,8 +2935,6 @@ int rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *clnt,
 				     struct rpc_xprt *xprt,
 				     void *data)
 {
-	struct rpc_task *task;
-	struct rpc_add_xprt_test *xtest = (struct rpc_add_xprt_test *)data;
 	int status = -EADDRINUSE;
 
 	xprt = xprt_get(xprt);
@@ -2920,31 +2943,19 @@ int rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *clnt,
 	if (rpc_xprt_switch_has_addr(xps, (struct sockaddr *)&xprt->addr))
 		goto out_err;
 
-	/* Test the connection */
-	task = rpc_call_null_helper(clnt, xprt, NULL, 0, NULL, NULL);
-	if (IS_ERR(task)) {
-		status = PTR_ERR(task);
-		goto out_err;
-	}
-	status = task->tk_status;
-	rpc_put_task(task);
-
+	status = rpc_clnt_add_xprt_helper(clnt, xprt, data);
 	if (status < 0)
 		goto out_err;
 
-	/* rpc_xprt_switch and rpc_xprt are deferrenced by add_xprt_test() */
-	xtest->add_xprt_test(clnt, xprt, xtest->data);
-
-	xprt_put(xprt);
-	xprt_switch_put(xps);
-
-	/* so that rpc_clnt_add_xprt does not call rpc_xprt_switch_add_xprt */
-	return 1;
+	status = 1;
 out_err:
 	xprt_put(xprt);
 	xprt_switch_put(xps);
-	pr_info("RPC:   rpc_clnt_test_xprt failed: %d addr %s not added\n",
-		status, xprt->address_strings[RPC_DISPLAY_ADDR]);
+	if (status < 0)
+		pr_info("RPC:   rpc_clnt_test_xprt failed: %d addr %s not "
+			"added\n", status,
+			xprt->address_strings[RPC_DISPLAY_ADDR]);
+	/* so that rpc_clnt_add_xprt does not call rpc_xprt_switch_add_xprt */
 	return status;
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_setup_test_and_add_xprt);
-- 
2.27.0

