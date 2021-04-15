Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141B7360000
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 04:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhDOC2f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 22:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhDOC2d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 22:28:33 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724C1C061756
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:10 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e186so22726871iof.7
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x4DaaU9yOVKZrRAH+MhLqkl5WKTJPjX+1LKTHN+yRCk=;
        b=CY4WgIkVwhx8UoXNsevCGV0ooJ7wJ1aCm+Tv5V1bkHqCfCnhs13JkPdTOnhl5tXh2J
         hJRkhY50o3wVCHrvjraxkB3Ije6+bhxaeW6HHp14GL5lrxSdNQRZC00XC4Bh/RItHhoR
         SXOmTICHhUbVrU7sOFxE0VD2l5zZi2a0BHjvEFTHOcNWNoogmHHsdHJ9XYJiyU841VKR
         ynBZLEHYWXbZ9k8Tm3J6FaCEK/pBHjiKv0QfEQq1mgop7RSqpwUl8aU5/pdP6St1n3VL
         4jhyu7cYZkfvq1BZjxcW2lisHEzT4sxU9Wh86+vTYtqPiDNzodb9SY5Xn6hmf7NWDQAS
         i/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4DaaU9yOVKZrRAH+MhLqkl5WKTJPjX+1LKTHN+yRCk=;
        b=HKpQy5mox8p6TDjzJcDEuzHm1dOnGRZeqigWjNNGPuZ+livoxxQw0mYDdcyw7UY+5R
         B2lyMyA8OlAYcrLiXiYf0fXmSF0AZT1nck7mLj3EObX8ipVCh/aJBIqNThgA9nkaWAxF
         sRomPJx4lE6al7XvyiBSxyJpwh1a7ZeGfIj0t/RZDn7Z44I0vFFJ0oPGWs3R/ur0N8YC
         V5sbc5gPVVompTiOxhzzmdtntQZKJPn8Bf5irgDnuGUHvkMIIVxx99QyCdGl+fIM/qCn
         pzCLfPwve9n7OXCfxBP2w2zORwcaABsNfkzYfVKBaKuo5psoSj13+o128aa52zRkoPIs
         uPgg==
X-Gm-Message-State: AOAM533Nx5WERtpNZBx7AGPpxt0qnLO9STi71Yg022Rnp+wC3aRuLsip
        AOMX4oRuAZ3siUyziGEVDnY=
X-Google-Smtp-Source: ABdhPJybj4HJ6BqMoKPlssFSVnGR8nm4dQ6OQ5nqF8d4IHHQUBa9LQqXTOC0EkGYyoSdBcp0cyYsQQ==
X-Received: by 2002:a02:a915:: with SMTP id n21mr906116jam.22.1618453689900;
        Wed, 14 Apr 2021 19:28:09 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s11sm608917ilh.47.2021.04.14.19.28.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 19:28:09 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 04/13] sunrpc: Prepare xs_connect() for taking NULL tasks
Date:   Wed, 14 Apr 2021 22:27:53 -0400
Message-Id: <20210415022802.31692-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
References: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
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

