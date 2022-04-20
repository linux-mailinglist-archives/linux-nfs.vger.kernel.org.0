Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1067850915F
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Apr 2022 22:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382097AbiDTU0Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Apr 2022 16:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382095AbiDTU0Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Apr 2022 16:26:24 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDE52E9D2
        for <linux-nfs@vger.kernel.org>; Wed, 20 Apr 2022 13:23:37 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id c1so2207765qvl.3
        for <linux-nfs@vger.kernel.org>; Wed, 20 Apr 2022 13:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9TfcF3PgNLhATTMMYSmaJKpNmSjCgi4unxrYXNfWBPM=;
        b=XPyBzOOistWV7+aVsRm8M+fjub8Tj8GQ/0FLx6RLMA0rEqbS1GumD7oWp4Uz8aItzI
         owaU96nGtYfKc7TJI+qb/qWjo8KqB04F8zhPOfVP44SIyVxUjFGlaa89GHYSzmmYTEMQ
         VpQadKYgjmxuDy66k2KcfEEFf96WNqNSOmIRVuAiUc28WhDR257Sq6mFvvpHa2z1ByBo
         aiG4iSSS99bnFgcmnz6i0ru1IyoeZspKo1BRV4A0ztZUt29xAXbkazHlGbA8mOxP7a0x
         ikiA6TFYZ0/lRLfbXC0Eo2MUzGcLsfwHxRnXR/im3EmqS/QJ5T0x1T/1UEEYpHANwUGL
         eNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9TfcF3PgNLhATTMMYSmaJKpNmSjCgi4unxrYXNfWBPM=;
        b=E2roA5v2oXyYhrjGSGE80uxWglR5ZvRmmpH+orsR7tG274QwKsYqakxvGmqI6uHZdq
         dmj00zIkftSr/IZHZFnt2xPw3vLMBcrcj1oa+9qnOuhkcrGXyzJJ4tV6QX/sTUvRrF11
         oYkj30yPJPAl2mmwnN5WNqT94rT2ImNRckUd31eP3rwsb7CNZtlSUDWH6Vvyd0hWBfBf
         xWgHt9J5qJJQUzRoHE2owpW4wzTGOg+KxdNnJqkVD1UMYPgHMQFKxlN9KYLh9FTlZFnT
         gL/iD4sttrG/f4PPam536KzbtFr3y3h9rULbIsFAVnQd0p08bigHgnvbHNJHL/kVGmNT
         dzKw==
X-Gm-Message-State: AOAM5305p8FMSLzlSQOlAkkKgO8Khqj1EIbJnLMhTKKuQhuzIIfsuYb5
        FE6DYgDafTKtFtpIvitg5Cs=
X-Google-Smtp-Source: ABdhPJwgbneofZqA14D30Oe8gsX9iElWXlkGSpQGB8C+GoBQtqXkQczPAvp9J8YV/F93bVmxkgOGiQ==
X-Received: by 2002:ad4:4dca:0:b0:446:2153:a29 with SMTP id cw10-20020ad44dca000000b0044621530a29mr17073341qvb.69.1650486216923;
        Wed, 20 Apr 2022 13:23:36 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:7d70:fdbf:14d0:5acc])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a424a00b00680c0c0312dsm2059163qko.30.2022.04.20.13.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:23:36 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] SUNRPC release the transport of a relocated task with an assigned transport
Date:   Wed, 20 Apr 2022 16:23:33 -0400
Message-Id: <20220420202333.90903-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
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

From: Olga Kornievskaia <kolga@netapp.com>

A relocated task must release its previous transport.

Fixes: 82ee41b85cef1 ("SUNRPC don't resend a task on an offlined transport")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/clnt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index af0174d7ce5a..7fb3cdef2a60 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1065,10 +1065,14 @@ rpc_task_get_next_xprt(struct rpc_clnt *clnt)
 static
 void rpc_task_set_transport(struct rpc_task *task, struct rpc_clnt *clnt)
 {
-	if (task->tk_xprt &&
-			!(test_bit(XPRT_OFFLINE, &task->tk_xprt->state) &&
-                        (task->tk_flags & RPC_TASK_MOVEABLE)))
+	if (task->tk_xprt) {
+		if (!(test_bit(XPRT_OFFLINE, &task->tk_xprt->state) &&
+			(task->tk_flags & RPC_TASK_MOVEABLE))) {
+			xprt_release(task);
+			xprt_put(task->tk_xprt);
+		}
 		return;
+	}
 	if (task->tk_flags & RPC_TASK_NO_ROUND_ROBIN)
 		task->tk_xprt = rpc_task_get_first_xprt(clnt);
 	else
-- 
2.27.0

