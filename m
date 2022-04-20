Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0827508F4D
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Apr 2022 20:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353882AbiDTSYO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Apr 2022 14:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiDTSYN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Apr 2022 14:24:13 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46260369F7
        for <linux-nfs@vger.kernel.org>; Wed, 20 Apr 2022 11:21:26 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id i14so1921244qvk.13
        for <linux-nfs@vger.kernel.org>; Wed, 20 Apr 2022 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bVFP1gGjko/YJi0nbJpTtGAq5TvC3VumTUjcBAwlTNE=;
        b=d6gSUYNXbuKckgW+ap7hqiYT1Yh8xGJWqO29rnp/76z48eezBIhE7VXobrcbjMdMWN
         21nFfbn7z03zH3btcTiUWcwbvAO4T7Z9c7qxqB7dFk70LZb0XD7htwdvsXNQKvbxOHRU
         rgZE3MMFuhUmWlhiAlMo9v9sX6TXu4obqYGOF7fgEHKPsATnjs1fECz6iIITUnEsa/aJ
         elb7SArs4cYsDPx0OajZOJHucfJfu+WiHwrFo+odqcW5lRBFwBcC7D3ck+mzS0DoEuYd
         1x26weqEpHte0vJiJB+m1P30ajEvZfJQ0y695SggcY5W5P97Bv86JWPFt6gna9F3lPpi
         sw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bVFP1gGjko/YJi0nbJpTtGAq5TvC3VumTUjcBAwlTNE=;
        b=KYtpQWwzXOMFdZ4h3kD6AZbp98MzWOnxehV/Dy1MhY93CMPqifaw017Z4Rxh2oiX15
         4xDva9EYQLXtvO2r3c5sA2dTPQVmHhc7Aibm/kdzNqDBNL6OhxWmJ8NUr5icdRR/MDfG
         O8cuk6dzgQCOzK5msVUEL8mQX5DfsaigD4s0ngk7iE+DY/OGZ1kP54Sjf90O1Rluammk
         wiO1ecGH8f9EFHM8OCJDVNEaPawdNiaqjTP+Lzk8rgoh9JGHqVbTOL43KHp1I9h1TbG1
         nioqEGYYUjT/pneiMcqy0HWBm5+TA2p7bTYNaeaxq1Zq3e/iJ2wRaGFLOIm/ZIcDUEzX
         VI/A==
X-Gm-Message-State: AOAM532HP14jpoplzAkaJx4+OAEyZSNlnG/FAwhbXwj2QH1gwsQ8Lpc9
        1hhz+JIfU94BcZEpB5az1wCNrdA+mkw=
X-Google-Smtp-Source: ABdhPJwkeAGo8F+Zx3syxGRvOykdEAZWmHNy5zgbwmniwdJoOn8tOx3DDv1ewXuZPa3Z1sdEP2wxmQ==
X-Received: by 2002:ad4:4a07:0:b0:444:4bf6:3571 with SMTP id m7-20020ad44a07000000b004444bf63571mr16570990qvz.47.1650478885103;
        Wed, 20 Apr 2022 11:21:25 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:7d70:fdbf:14d0:5acc])
        by smtp.gmail.com with ESMTPSA id e15-20020a05622a110f00b002f33d65b065sm2111907qty.73.2022.04.20.11.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 11:21:24 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] SUNRPC release the transport of a relocated task with an assigned transport
Date:   Wed, 20 Apr 2022 14:21:21 -0400
Message-Id: <20220420182121.87341-1-olga.kornievskaia@gmail.com>
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
 net/sunrpc/clnt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index af0174d7ce5a..95de454a858b 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1067,8 +1067,10 @@ void rpc_task_set_transport(struct rpc_task *task, struct rpc_clnt *clnt)
 {
 	if (task->tk_xprt &&
 			!(test_bit(XPRT_OFFLINE, &task->tk_xprt->state) &&
-                        (task->tk_flags & RPC_TASK_MOVEABLE)))
+			(task->tk_flags & RPC_TASK_MOVEABLE))) {
+			xprt_release_write(task->tk_xprt, task);
 		return;
+	}
 	if (task->tk_flags & RPC_TASK_NO_ROUND_ROBIN)
 		task->tk_xprt = rpc_task_get_first_xprt(clnt);
 	else
-- 
2.27.0

