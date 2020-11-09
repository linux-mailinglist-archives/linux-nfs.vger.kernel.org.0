Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA6F2AC70A
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 22:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgKIVUo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 16:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgKIVUn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 16:20:43 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83349C0613CF
        for <linux-nfs@vger.kernel.org>; Mon,  9 Nov 2020 13:20:43 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id v11so6725991qtq.12
        for <linux-nfs@vger.kernel.org>; Mon, 09 Nov 2020 13:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VVMQUbJ4iznq9ND4iOH8VfAwBPVr6YZBnHjxRO8Npmc=;
        b=isEGDJxBLKuwAPFwY3EanSDcpN7f12pclu407bvwfkQDK6HYIzcy9qfEcdBk5p6z9m
         9fBM1bHHGnfevGwEVjQJT+ZKZ0RBn6KRebScjXCD1NDQIh17q/Z1LTSUsPkP+LAX/iUd
         Sm1pm1/AV2bBQA5nnonLh79dFFth5IAX4PDg1A0zS1YifnTzwlfZgBF3xjOErVWuwzxp
         4KrSj8UWX3eISK2vg+L0gD4jRPxxpo3acDSbLOxV+aGpqkifND48drsUhARPmiv8M40K
         75/606afeoA6dtD8GkNMAlkybjASXmnYirRAnSFXJG/ZMH+/rN34eO7qrr22R/+vuHWA
         1HKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VVMQUbJ4iznq9ND4iOH8VfAwBPVr6YZBnHjxRO8Npmc=;
        b=jc7fhg6wiViY78759JjZRSwSE3hDs1Aog/8zPf99qUQhW83445z10IQ0yNRhxr/ySH
         ViQWtaZmD1bAo/t9cRXgZjaV6VRCmnFW2LCX56e+q8TvyZm2cPGGmsBJE/Mhtl3j/xsP
         q1XXTo8q79YUXap8YMds7joiZDJJ0aknYwY8a3Q2/3gdkyuD7wySN8RDu76UhDgPc07G
         gm/me9qWVz8rBFtO0zccgn640//2TgMlVTHQu1PVLlF2KsOCrgWhW95bDaMb3AHfIRCe
         0muXVSqDML7oG5JYa1QXiCbu/0P2XiFwc0DvH0RbxZXu0CLE6Mhv2WwMl1tdZTBJNfLl
         6OgA==
X-Gm-Message-State: AOAM531bldZY20qQLNi7X7mQH/2kRNb4i29WZBqxm6y3X3IrEyg4Md7Z
        HFzmtrpisNcAiknxXe5M+zYBTnuypivr
X-Google-Smtp-Source: ABdhPJxITZz/V5F+GMrOGI0ykE66yW+t5XFghupqPR/RclDQpibHlznT433m4cx3OyklIqFf3MEKNg==
X-Received: by 2002:ac8:46cb:: with SMTP id h11mr10060132qto.121.1604956842445;
        Mon, 09 Nov 2020 13:20:42 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id d188sm7025241qkb.10.2020.11.09.13.20.41
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:20:41 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/5] SUNRPC: xprt_load_transport() needs to support the netid "rdma6"
Date:   Mon,  9 Nov 2020 16:10:25 -0500
Message-Id: <20201109211029.540993-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201109211029.540993-1-trond.myklebust@hammerspace.com>
References: <20201109211029.540993-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

According to RFC5666, the correct netid for an IPv6 addressed RDMA
transport is "rdma6", which we've supported as a mount option since
Linux-4.7. The problem is when we try to load the module "xprtrdma6",
that will fail, since there is no modulealias of that name.

Fixes: 181342c5ebe8 ("xprtrdma: Add rdma6 option to support NFS/RDMA IPv6")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtrdma/module.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/xprtrdma/module.c b/net/sunrpc/xprtrdma/module.c
index 620327c01302..fb55983628b4 100644
--- a/net/sunrpc/xprtrdma/module.c
+++ b/net/sunrpc/xprtrdma/module.c
@@ -23,7 +23,9 @@ MODULE_AUTHOR("Open Grid Computing and Network Appliance, Inc.");
 MODULE_DESCRIPTION("RPC/RDMA Transport");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("svcrdma");
+MODULE_ALIAS("svcrdma6");
 MODULE_ALIAS("xprtrdma");
+MODULE_ALIAS("xprtrdma6");
 
 static void __exit rpc_rdma_cleanup(void)
 {
-- 
2.28.0

