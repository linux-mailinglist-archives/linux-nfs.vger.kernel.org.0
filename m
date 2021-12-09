Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B49546F456
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Dec 2021 20:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhLIT5W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Dec 2021 14:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhLIT5T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Dec 2021 14:57:19 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AC6C061746
        for <linux-nfs@vger.kernel.org>; Thu,  9 Dec 2021 11:53:45 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id j21so6438558ila.5
        for <linux-nfs@vger.kernel.org>; Thu, 09 Dec 2021 11:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikQR/pBQ4nY3PwJ+F4JPe7aDRKbicW62aNksWPUjyb0=;
        b=NqJgr0wtbLMCusmW2zg0fz8duuhDIiciPyyzimpoVehfjdQJ2GzruKaAgQs09/xPy2
         4mR2NJKgnvJNFtyLntaboWz7wApKLLrVigo9SpfkuxsTHirtGK5k/Nx7+gJ17aGrcC0f
         46D68vMtXIzngMIlLYD84TZ8tEuFTcNFE2jix5uqYwTfKxh1Krhc6mCN38hMm97qjvrQ
         fniyR5biQLhqw2T9A/eO0ZrLbTSwmi/1WdaSyRjEGvTbsb/LhddJB6rUv/Web7VsYPdp
         YXkxMN4ntkXVQxV/rL/ijWsGWZdZz6lv8AVsrZ5TBowjqre1sAzvpOZx6sWouonENoLb
         9ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikQR/pBQ4nY3PwJ+F4JPe7aDRKbicW62aNksWPUjyb0=;
        b=xa/q0KkSBRMuJgkfr+NaEhmL8wF9iZDq0QWMCRZ4Ii0Nm3hA3DADyrhLw2F4++vTm/
         3KvqKXxfat82ogFNR+gO4xwpduMLOLjPel8gSPdFjwXuxoBc7rr8V1A5U4iKOchy5OTz
         /iFR7K7W042OjSabkH0AOpJ+Zm6AtTjOJtaPrd1/6JQ+0yqjMDY4wdeNWKYnE6R6UPiB
         zt6I6fZkxqd53jR92nGpMaNuL0jgPpSkEKswffouJhoPfNbTn5ra+o6fd+Z6Jp1JODNK
         gjLeq5HpoMu0n7+XiPq0eZgjpzc37RxAGsuY2PeYiNCacJvn7ToflnXNlP/5+k2VxhLF
         8oxg==
X-Gm-Message-State: AOAM533zNQSWjusFFK9SXrlHGQDFkMTZRbbpm/jJML1dLClN2UBVSQc9
        4321Mu4h1KL4JjZnVaHv1RzN2STjU3U=
X-Google-Smtp-Source: ABdhPJz1nnhgrzGSlFZgoMMQJn5BpIFpBD9rLpkRiZtnyV4agXqdEDEUBQTf83Qe52b04E69R6xx0Q==
X-Received: by 2002:a05:6e02:b2a:: with SMTP id e10mr18282739ilu.80.1639079625045;
        Thu, 09 Dec 2021 11:53:45 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:554d:272f:69a0:1745])
        by smtp.gmail.com with ESMTPSA id k9sm383541ilv.61.2021.12.09.11.53.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 11:53:44 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/7] SUNRPC allow for unspecified transport time in rpc_clnt_add_xprt
Date:   Thu,  9 Dec 2021 14:53:34 -0500
Message-Id: <20211209195335.32404-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
References: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

If the supplied argument doesn't specify the transport type, use the
type of the existing rpc clnt and its existing transport.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/clnt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index a312ea2bc440..c83fe618767c 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2900,7 +2900,7 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 	unsigned long connect_timeout;
 	unsigned long reconnect_timeout;
 	unsigned char resvport, reuseport;
-	int ret = 0;
+	int ret = 0, ident;
 
 	rcu_read_lock();
 	xps = xprt_switch_get(rcu_dereference(clnt->cl_xpi.xpi_xpswitch));
@@ -2914,8 +2914,11 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 	reuseport = xprt->reuseport;
 	connect_timeout = xprt->connect_timeout;
 	reconnect_timeout = xprt->max_reconnect_timeout;
+	ident = xprt->xprt_class->ident;
 	rcu_read_unlock();
 
+	if (!xprtargs->ident)
+		xprtargs->ident = ident;
 	xprt = xprt_create_transport(xprtargs);
 	if (IS_ERR(xprt)) {
 		ret = PTR_ERR(xprt);
-- 
2.27.0

