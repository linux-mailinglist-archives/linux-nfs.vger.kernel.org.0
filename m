Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B5157FFE9
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 15:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiGYNcy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 09:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiGYNcq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 09:32:46 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B721FDEB3
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:44 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id c3so10670869vsc.6
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxWsksLwNP5augzEl67LHViorzikGGB1fkSMEHJ+uOs=;
        b=NAyrBMObTiAPltvvN6HLt4OUF8MmoCGTCzy6st2Bu8AjvhlRm1Q5ItErtqBqYiwaky
         EmAr2vogwb0kwyXGQ12l4GMLuba3gaY7ws7uBf4CAXOlOh+Kmd6e96mVQCMa1/poijqH
         rUh9j0biZyT6WINVaEuVRCvVRrWkP+vQFb5xMVKPx0zgmvCNMKBv6IKPJPX6cuh/r1U6
         tbo/a1gyUJzU0MG40V67vdY8tgQgWx/MvuMGQqRl5VmLQCIdGaa/U8bwc8DIfoOJj+7I
         GcwSf9osOuErOpynZkkjHD56pwzqHhK5zkmS3Gf8lRGF+he2IED9Y4r8rb7/UTmN7xkx
         D8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxWsksLwNP5augzEl67LHViorzikGGB1fkSMEHJ+uOs=;
        b=N6iW4Pmkv8K5q1fJiDT2vet/k89um0MoVOucHMAzkK3/0N7HpTbb2yRB+ECfqbThq1
         lpRbgl2QAIFVRjl/Y5bQ/gqVZALqaC/QH9/IFKmtSm0A2/BoQONh4iLCcYlmgGFuJLO8
         iOpU8MBFO5rDbQ1HWtIW4PxPtaTmgK1tjyTJ7JwJ795FhcW7e/J4AvVeZtfZgFOFUjyU
         1OpSo9MxhUEb12lG0ns6BildzHvxgcCDHinpLtr2TuCh0q4If5G3hZZte6hsCoCJUeGM
         RA+8+m4H2GGTAheYHyX2FffPJ/oqR+rq/DJl+WNf+U09scQU8Ewh+CYARjPV0ylExoBr
         TB7A==
X-Gm-Message-State: AJIora8A0ztQu0jzPkctKAvJQrPVGvrUrSdvjpiy1GW2NngYDcMctMdc
        QcXfDfFymIhODecS0Ma3gDaL3TQQUFk=
X-Google-Smtp-Source: AGRyM1snSM9hF/9BenODIijQ4iLcS33i59NJpVcGhttshKD/SrExPt6IX8rjH5tvhOQHXGEU6/CUog==
X-Received: by 2002:a67:edc5:0:b0:358:6a1f:552a with SMTP id e5-20020a67edc5000000b003586a1f552amr94249vsp.53.1658755963492;
        Mon, 25 Jul 2022 06:32:43 -0700 (PDT)
Received: from localhost.localdomain (071-047-011-047.res.spectrum.com. [71.47.11.47])
        by smtp.gmail.com with ESMTPSA id a6-20020ab06306000000b00383aeb53100sm2128826uap.16.2022.07.25.06.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:42 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 08/11] SUNRPC restructure rpc_clnt_setup_test_and_add_xprt
Date:   Mon, 25 Jul 2022 09:32:28 -0400
Message-Id: <20220725133231.4279-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
References: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In preparation for code re-use, pull out the part of the
rpc_clnt_setup_test_and_add_xprt() portion that sends a NULL rpc
and then calls a session trunking function into a helper function.

Re-organize the end of the function for code re-use.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/clnt.c | 52 ++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 26f3102500bb..9c9712274ca8 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2874,6 +2874,30 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_test_and_add_xprt);
 
+static int rpc_clnt_add_xprt_helper(struct rpc_clnt *clnt,
+				    struct rpc_xprt *xprt,
+				    struct rpc_add_xprt_test *data)
+{
+	struct rpc_task *task;
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
+	data->add_xprt_test(clnt, xprt, data->data);
+
+	return 0;
+}
+
 /**
  * rpc_clnt_setup_test_and_add_xprt()
  *
@@ -2897,8 +2921,6 @@ int rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *clnt,
 				     struct rpc_xprt *xprt,
 				     void *data)
 {
-	struct rpc_task *task;
-	struct rpc_add_xprt_test *xtest = (struct rpc_add_xprt_test *)data;
 	int status = -EADDRINUSE;
 
 	xprt = xprt_get(xprt);
@@ -2907,31 +2929,19 @@ int rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *clnt,
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

