Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF4B30CA52
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 19:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbhBBSpG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 13:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbhBBSnd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 13:43:33 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B07C06178C
        for <linux-nfs@vger.kernel.org>; Tue,  2 Feb 2021 10:42:51 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id c1so15728548qtc.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 Feb 2021 10:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SW9sK2N6g/Ta8eXWJeE/yuBYQzAt4OFHO0Wdl6GzXf4=;
        b=Z0n6cm6RGORANB+uPMJVaqhKT7lNKEZI84TzlWz40f9cyfMSBdR4Vp1NOXtIVZFFXI
         fJG2ytMI0yfcJc6hCn8yJCiD1pqems3K/o1W9ngHDJEEr/g6CghQR9zRxkp4MM4O4hVK
         /4Z7s2K+bFo0Vged3xpdfEzcne3o5ed/rGYKNmwBqV0+Bd/YGiYXx5/bHZdZ2CugFV2E
         REvRQ+mVjHHJ8Y1QklzqTh2FGfwX1xmwNjaBLEqsob+JNdU6RevGYZNCG0mGfA6s81b6
         k+gsTtiBkr+bOWLETO28dSKbcdHOcwwLNcgms5iepYZlYLEW/tEJVAUGNbtZzxF+eif5
         wuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SW9sK2N6g/Ta8eXWJeE/yuBYQzAt4OFHO0Wdl6GzXf4=;
        b=cK0OHda0PKTA3nNaf4x847DBtEXvLKu/GFJU9MMDEgiES9qBHCJJlHHdeS/p477ZoL
         qZs31drtLcBV9DAsA74Z/yXzKHmVc+Jl0AbQH20sq9nZGltKc5YRi1OPDMiE514Yg6sJ
         +5CdK1UwQ4EX4P4BUt+aLbQPgmozuMz60+4OUkSVRc93ci6Mrf6lvVQ9teBp8W4mMib1
         YeOY58dyfNHun2lDZ3S3LzatNMDpnGUaNaPn4rDqQ0n7Zur8dcWHptj4WpvzC4YS9EN1
         ZSIkD0egksrees9A2zmR26MVDXJkYPzQPUGx36Q8CYDcXgF+9xiE/8K0/g7G1OS1aQJv
         vPkg==
X-Gm-Message-State: AOAM5300H4WuCYGvTsu5tNG3rYNC2GZwzQq427ZdtxmR70T1/M/j3J/p
        O6ZHTHP5yd8ZMDcbM4BcPQgm7xCU91AR7g==
X-Google-Smtp-Source: ABdhPJyFKHzGvoAAyhoqD5qaQwJtNJkyuktVjwBfG8PLIPKw7WbRCVCLVP5Mt9Vd7vHsHWct1+fH2g==
X-Received: by 2002:ac8:7c95:: with SMTP id y21mr21743576qtv.199.1612291370907;
        Tue, 02 Feb 2021 10:42:50 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id k4sm7415906qtq.13.2021.02.02.10.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:42:50 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 4/5] sunrpc: Prepare xs_connect() for taking NULL tasks
Date:   Tue,  2 Feb 2021 13:42:43 -0500
Message-Id: <20210202184244.288898-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We won't have a task structure when we go to change IP addresses, so
check for one before calling the WARN_ON() to avoid crashing.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/xprtsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c56a66cdf4ac..250abf1aa018 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2311,7 +2311,8 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
 	unsigned long delay = 0;
 
-	WARN_ON_ONCE(!xprt_lock_connect(xprt, task, transport));
+	if (task)
+		WARN_ON_ONCE(!xprt_lock_connect(xprt, task, transport));
 
 	if (transport->sock != NULL) {
 		dprintk("RPC:       xs_connect delayed xprt %p for %lu "
-- 
2.29.2

