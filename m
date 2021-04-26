Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904B836B7F6
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Apr 2021 19:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbhDZRUq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Apr 2021 13:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbhDZRUj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Apr 2021 13:20:39 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54895C06138E
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:19:55 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id v123so5703179ioe.10
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yV4RoRoB2tILS34+fpesh6cjG3ew0tRbFeD0KUnY3Ss=;
        b=efleueftMbvfq6GbbGowcTszLdcy9tL57Gsfv8uMljO2H7KHjjomUyi/dsKlfRahas
         RvGL6vfyE6QlM3Z1TE/lthIN6E5+00GIcuWx/UKxZ9pC23ruoOa1rD0tjFTxi+oT7bNm
         07d5EaBXRODLGtKDHnAv2vKDSOKBVCGwlEC0k0iuWRlgi7D4tSYSXdiq8D1/TlSfVUi4
         g5IXawvPM93arR2v57sQ2x90kiSDvpgK/Y3/r1NeQtQ32lSHrJD/ytwTKWkqS/OO5m3Q
         R1ziAPb26/iMPLNiZYKnaB8ml01z6M6TM19X4BTOJx1uC8XeUMwSQCOut8a4FoKmMDC1
         UmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yV4RoRoB2tILS34+fpesh6cjG3ew0tRbFeD0KUnY3Ss=;
        b=jGyZws0g1v7Z7V+POJmJzU7JVuDmdDgrHTD6vyB8JHiHlxqt+yGiWi79yhbEKXZqI0
         coPXDOhNUJKpzabqHGgAVWMRqe9q90KgX3/XpT0+NJi0i+AOAMxmp6nNGXfS6w1rFF4C
         enQ+c7GL/nx0gvBysODMkyGHJHdOlQ4TsMJOrtGEioOpanyP9/NnHdupg0dP7EJhpgxY
         2jLx36Eolib3DnieBaHx479Qh3mAp0s+7tYoXyDVqLXzpNlx1qQy6ANckF2N11RuTIzz
         NVqfQX+k4JMsdElr0DaefOlrk+sRXlUBVtVMemS1bkrpRU8SvdmJmI3JxVtMk/j4Agy1
         hssA==
X-Gm-Message-State: AOAM530B+nPMCWzC4Iqfe3gi1QltNQ7p9797W80TytlBnLtEDbzJGoXl
        Ic8oh7peT+yYOQ9N19O5Mlc=
X-Google-Smtp-Source: ABdhPJyGSEa2BSX7IWk4ICuLQWSX1EouL1b4Y/qLx+xwOVuwNlNagbbwussFgaa7eLQ8KB4SkdvVNw==
X-Received: by 2002:a05:6602:1da:: with SMTP id w26mr15446047iot.170.1619457594779;
        Mon, 26 Apr 2021 10:19:54 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id x13sm207297ilq.85.2021.04.26.10.19.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Apr 2021 10:19:54 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 04/13] sunrpc: Prepare xs_connect() for taking NULL tasks
Date:   Mon, 26 Apr 2021 13:19:38 -0400
Message-Id: <20210426171947.99233-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We won't have a task structure when we go to change IP addresses, so
check for one before calling the WARN_ON() to avoid crashing.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/xprtsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 47aa47a2b07c..2bcb80c19339 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2317,7 +2317,7 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
 	unsigned long delay = 0;
 
-	WARN_ON_ONCE(!xprt_lock_connect(xprt, task, transport));
+	WARN_ON_ONCE(task && !xprt_lock_connect(xprt, task, transport));
 
 	if (transport->sock != NULL) {
 		dprintk("RPC:       xs_connect delayed xprt %p for %lu "
-- 
2.27.0

