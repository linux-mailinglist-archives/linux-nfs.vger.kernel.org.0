Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C030057D684
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 00:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiGUWH2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 18:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbiGUWH1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 18:07:27 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7196293C25
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:26 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 125so2433485iou.6
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSEshAwV3+BcDMr8M3DYQ/arl+CSUkr59U4M5IHghNU=;
        b=h5xLaWgUJAUeqOue6mbiGcqKgetp6P/L1mJm4x40rfHTDSeIvRE6rzw8GOj+hNr6UG
         uzTVhZktYktUb0m/cOHr8PX+QCwDpP+7RNRXMnT+gOkkrlm0WR74fDvcUgdO2oTggTWy
         w8Dcp8t+/ENr+qv+jgJawy4yLFykYpGGdlVnSFUUSJtTPvbH4yNpv99a7bVDSyX9xsoP
         Rpn2vInZg2lnMxjizG9mXvs0d1JY5NmfzgUIe/4rS3fDeCgg48E9PbgP5ep3+Gn2M/Ar
         GGs0SxdmnbgvZXMFmVJ5+QKaDSedpL84ap5BLV1Wf7T+q1cXo86wMX/WAu6cTcX/we32
         ByGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSEshAwV3+BcDMr8M3DYQ/arl+CSUkr59U4M5IHghNU=;
        b=YMYrk9nQtGUBsFmFnWOMeFsJ84idISgePuzBfwJHYQFCIuGjL7oeM9M+QZD8xgsWjM
         +JWwd8RMrcDfQwG4IAx9oj+ls9O+/xmXOVDhRN+vdvmhg4W8jmeF6zWBuxUauCJoFheI
         CrY70fgUuV6HH2WUURtLtrUxdDchnAm3Pb7LaftPqWcocXyDau/5SrSQVwfbyi/9v9tV
         /+WH/Yctox/z7jGm2IL65T88h+s1Awg8Mt5W4quXfjD210iIG0ySoMIV4uJFg1dYIbS3
         /dhskKV8RYPL1zX6J8gQAVHe0jScTSW5Cq6b8qIKHso6miIte1sfUBjfVvgAItiiSedy
         EyYQ==
X-Gm-Message-State: AJIora+pItoysyl61fEA6XQm6X6Kj4gQ+d373GvwlJKrNWwYSz6I5hwO
        As9yiAPYSceDtHFtOBRKU/ef+tMAkYo=
X-Google-Smtp-Source: AGRyM1uYalwvI40y0Nx78USfAOZQ7jMCMj3VgXabJv5iQPRgoI99puxhT1ZGulqXP0EPMjSpB97k7w==
X-Received: by 2002:a05:6638:348c:b0:33f:82b2:7441 with SMTP id t12-20020a056638348c00b0033f82b27441mr301734jal.296.1658441245795;
        Thu, 21 Jul 2022 15:07:25 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id g11-20020a05663811cb00b00341668383cfsm1281105jas.33.2022.07.21.15.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:07:25 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 08/11] SUNRPC restructure rpc_clnt_setup_test_and_add_xprt
Date:   Thu, 21 Jul 2022 18:07:11 -0400
Message-Id: <20220721220714.22620-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
References: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
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
index 82a829798d96..c226025dbe97 100644
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

