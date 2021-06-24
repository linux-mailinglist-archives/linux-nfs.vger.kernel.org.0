Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1AD3B257C
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 05:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhFXDbW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 23:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFXDbW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 23:31:22 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAE9C061574
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:29:04 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id v5so4704108ilo.5
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1TGSDioUL5W9prSNZhTqw+0YOv25eoLuadjd+CUCHc=;
        b=jEDi9v7l8NruJ/19hLaddZDDbqLH8WyBe8sPCfyc7nd4GT8gN4U0n8v3uo38ADdA24
         2LKiKfy1hG6OaJPNS5DhpfGN/gwDQyrCG8Ir+L1UgChDrZ4wUdnwiw2VM9OfGLVosb9P
         ReBAsz1NCA49b2A8OUCPlvCZI9qj1f3waWJA9MYBIhCrH4D4q9WNeCxiYZw8baf6g1IV
         aJopW2Cqnr9Q5+S1+Tjy8W1dapefFIo53VZ1H/4Z8DxfEUzX8TGU+VZFyg1D4lkhqOLt
         4GUOXLnimfT10TFl8DPxUipGnqd5sj3jBwb/3Rzg9PBCF5bJJPoyYYoxq2YA8QRa/ehA
         0rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1TGSDioUL5W9prSNZhTqw+0YOv25eoLuadjd+CUCHc=;
        b=aMyq3gWv5WMLLalkK0CC4MBLBVZVHtzgUKgcb3ykDNQRmRObUBb3eRPnky/g02bA+7
         K+v+ejb9KP9WqUfP+JKYxKZFJVuMa8NjjMBgQUafq/oaB/hnDGl7EOj4J2uLoGEbE9xA
         jgiLiKrG7E3SrK5YhPuiJzNyesA9Y8HZMEcJjvm9zinzOZ7qg/0JkKRbUVGm4kv3tRx0
         jAKx4FLB868O8O1nqermv469XuyqGqhr7IG1ipOLX/YU0vzRrCeBRFSZMw+TyljRmv/J
         huYEA7CdIGSguVlbs2d66pNcPCQg9tMncS9bSd9Rb+iLPtQYdG1RhfnoGZluyrMEJVz6
         TD6w==
X-Gm-Message-State: AOAM5305+YeYzafQlPpMGVf1IbiHu4/AU+i656uxetwBbpUQjYStwQ4t
        OXY4DOwMuu8C+DKWH6zYH0w=
X-Google-Smtp-Source: ABdhPJx3dZwjSOZrNCMFhZ5v7c3pt+guCOB1k7bcfboNboWUOSCWiu9OW7Yohql19hVX/iWhWa14vQ==
X-Received: by 2002:a92:d852:: with SMTP id h18mr1880001ilq.299.1624505343444;
        Wed, 23 Jun 2021 20:29:03 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:fd18:15dc:e0e4:e39e])
        by smtp.gmail.com with ESMTPSA id g4sm1026780ilk.37.2021.06.23.20.29.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jun 2021 20:29:02 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 7/8] sunrpc: display xprt's queuelen of assigned tasks via sysfs
Date:   Wed, 23 Jun 2021 23:28:52 -0400
Message-Id: <20210624032853.4776-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
References: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Once a task grabs a trasnport it's reflected in the queuelen of
the rpc_xprt structure. Add display of that value in the xprt's
info file in sysfs.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index e66888cc4c14..754bd010ea29 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -113,13 +113,15 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 	ret = sprintf(buf, "last_used=%lu\ncur_cong=%lu\ncong_win=%lu\n"
 		       "max_num_slots=%u\nmin_num_slots=%u\nnum_reqs=%u\n"
 		       "binding_q_len=%u\nsending_q_len=%u\npending_q_len=%u\n"
-		       "backlog_q_len=%u\nmain_xprt=%d\nsrc_port=%u\n",
+		       "backlog_q_len=%u\nmain_xprt=%d\nsrc_port=%u\n"
+		       "tasks_queuelen=%ld\n",
 		       xprt->last_used, xprt->cong, xprt->cwnd, xprt->max_reqs,
 		       xprt->min_reqs, xprt->num_reqs, xprt->binding.qlen,
 		       xprt->sending.qlen, xprt->pending.qlen,
 		       xprt->backlog.qlen, xprt->main,
 		       (xprt->xprt_class->ident == XPRT_TRANSPORT_TCP) ?
-		       get_srcport(xprt) : 0);
+		       get_srcport(xprt) : 0,
+		       atomic_long_read(&xprt->queuelen));
 	xprt_put(xprt);
 	return ret + 1;
 }
-- 
2.27.0

