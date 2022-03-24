Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6274E6501
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Mar 2022 15:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243093AbiCXOYh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242197AbiCXOYg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 10:24:36 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B03E10DA
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 07:23:01 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id k125so3636338qkf.0
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 07:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wl/C4bdA0G1G7MCnnmirSJK412VxKJz47VnoOf/ENww=;
        b=FJk3bGBO9DJzK2siYeW/qhl3KFUOjeRMqs7kzgSqX3cIQckgrMj4/DW0aQzGMp2hFD
         cHHrwwETBVIa3BSugEz8UrzQHPqtXAlUMsWVuNtnzNjeSzUWou3KDXY9igJZWEkXJPDb
         ii3BSQ7BTHv2Oo0jtXCDlJzpxTKMlcNh+AfIEvxfpoKno0rchfAZEF7qKlVn1BeOAuAd
         p45e2toqdPanWm06zGZ9eGAUPZqyut4odsJIVVxpfMBYJa/wCjentgUfyaghcH4tR7ne
         /JBFhkpdNDIX/EMLOo5nXkszTDu7DPCLFn4GBGZe/NTXw3m3CbO5WyIBcphXV0+sB+E5
         Mvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wl/C4bdA0G1G7MCnnmirSJK412VxKJz47VnoOf/ENww=;
        b=NWhJNlYDNv+F1GDrnBxdkA1iHr9RfbkkI81RKClA9SyAdAF69bbHtIVWD4f1ImEpZo
         HRcKe1/UIWkngy4tICgG/QWFgmJKf7j4uf9JVXmjp4X0ahDdKZXYJg0c5E3hbeZ4FiQb
         znJaYU9pr7wLgSOOisKrNBuu6FbGUqvjCriDNjVt+qA/pXpFOX2WVGgYqmQZitE3qkvJ
         U4A+irYLd6lWaZ7sPvPEDjMFErcrmiugmdvYkAXdaxMcMJJdzr/WCVm048TFPyAXi6JF
         bF7td+Z/lmqE7JWIBpndtITn9Ucn+Y8H34NIBMpVVkcuNT0sUIzlHG3n4Mc6NqAAzJKr
         GG/Q==
X-Gm-Message-State: AOAM5336oNA823GnY1PvpIuaNF05p3UrFbPtdiGfOWseO1sJDskug10T
        qBmU70xxrPOd6LyPrt3XiPc3coQroLI=
X-Google-Smtp-Source: ABdhPJwni1wWBHZDpDy9xZtdAntOw98HcKhkKbhNYyigVoxqSZNYvFJXGt1caHcWAZN4hjNMtDBTrA==
X-Received: by 2002:a05:620a:2293:b0:600:2b7b:2a19 with SMTP id o19-20020a05620a229300b006002b7b2a19mr3462505qkh.408.1648131780674;
        Thu, 24 Mar 2022 07:23:00 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id u21-20020ae9c015000000b0067d4b2e1050sm1587107qkk.55.2022.03.24.07.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:23:00 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] SUNRPC don't resend a task on an offlined transport
Date:   Thu, 24 Mar 2022 10:22:58 -0400
Message-Id: <20220324142258.63552-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
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

When a task is being retried, due to an NFS error, if the assigned
transport has been put offline and the task is relocatable pick a new
transport.

Fixes: 6f081693e7b2b ("sunrpc: remove an offlined xprt using sysfs")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/clnt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 0f54a56d19d2..8bf2af8546d2 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1065,7 +1065,9 @@ rpc_task_get_next_xprt(struct rpc_clnt *clnt)
 static
 void rpc_task_set_transport(struct rpc_task *task, struct rpc_clnt *clnt)
 {
-	if (task->tk_xprt)
+	if (task->tk_xprt &&
+			!(test_bit(XPRT_OFFLINE, &task->tk_xprt->state) &&
+                        (task->tk_flags & RPC_TASK_MOVEABLE)))
 		return;
 	if (task->tk_flags & RPC_TASK_NO_ROUND_ROBIN)
 		task->tk_xprt = rpc_task_get_first_xprt(clnt);
-- 
2.27.0

