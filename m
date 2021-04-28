Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E774836E0F7
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Apr 2021 23:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhD1VdA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Apr 2021 17:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhD1Vc6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Apr 2021 17:32:58 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58681C06138B
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:12 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d12so9732017qtr.4
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x4DaaU9yOVKZrRAH+MhLqkl5WKTJPjX+1LKTHN+yRCk=;
        b=E+5PFuATJjSEb/vCbBLge8pIklofmRdlu4cXcOqP//n6DCuGpOBn1TLPnNYyYpgsPM
         vjplPmbxQPI41OsZkW3x4LlyKtv5FwEcuJKAGL34HN+PBeV4USrqhQIo8Zz0NZnlEIAW
         YAoVMcxjKm10uMmiVr7dQdku3PW+m9j3CThN3QSDbRFiSWf6nV8+mEJG50eG5T5mxBkO
         5Huj8apzoNcrEG1OOns5eYsblAa82dU7xK5hV/dLg5DASsXZ1ymvruixIrgzt9gXmUbo
         Jx14K3R3INjNihKmt2jtSHgT//pRbbR1vv72FYnW4pUX5aFeq8BD96EBsx2SVGuFS1mr
         v/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4DaaU9yOVKZrRAH+MhLqkl5WKTJPjX+1LKTHN+yRCk=;
        b=fN/RKWjivc3HsJcHzYah+jA3c0na+V1Z1hJhy6XeGewb/SbOfKZcy5H82ZP4Z3TPQM
         pbq+0MXdEKb2tu8QvKMk7SGJ+gt3Kc1/y+yeB4t8JVKmSGGsaUkKC9Wlnb9OVkW9sBYz
         CbuKEkkWDh9kYQ7pvaYW2s59iQQM2SasKQYWUPoc+y11wzzfl7oUvWsYxuJ5JcB54RJp
         BfJ4h7YHYE01FpCD8J/A3kPpp9Vj/D46V+VY01HXp4X5sAXuqJCPHLOLLJ9Bjr656YIf
         6ridCjBfj1lO/kdL3zx6xBQuN95AjqzghS0BFd/5WA9I6KzGq9Mzh7ur1xHIljfx/aRs
         rhrw==
X-Gm-Message-State: AOAM532rclschSOTZT5x2TF5aG0PBpzmya5bVwVE/Vc8L+6SGVVoxEr8
        ZUoUXaMcLSKPNWlMCh1AfpU=
X-Google-Smtp-Source: ABdhPJwLF2gDuySxFoouKsh/hExFhCHDI/IbvaWouKvoMUARk+ZAmTgZA0f3gw91pdCBeZYOLUaz5Q==
X-Received: by 2002:a05:622a:3cf:: with SMTP id k15mr27568448qtx.282.1619645531630;
        Wed, 28 Apr 2021 14:32:11 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-11.netapp.com. [216.240.30.11])
        by smtp.gmail.com with ESMTPSA id v3sm710269qkb.124.2021.04.28.14.32.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 14:32:11 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 04/13] sunrpc: Prepare xs_connect() for taking NULL tasks
Date:   Wed, 28 Apr 2021 17:31:54 -0400
Message-Id: <20210428213203.40059-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
References: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
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

