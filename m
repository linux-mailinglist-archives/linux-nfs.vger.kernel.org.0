Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BBC49BBEA
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 20:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiAYTRX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 14:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiAYTRV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 14:17:21 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF67C06173D
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:17:20 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s18so21711095wrv.7
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 11:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SmvWx14eAhy3pe3g3Tx/t4BuExsjjc5XxE2U64XG7T8=;
        b=LuEM7YNmtZzEJWdGuYQA8ha6rk0vHFi0F67a0JH+91/b+j2BwnIImJm/wZoeDLznbl
         luOUJLZU3bIRC4znGmPQBYBeKwulcGyW1hXkPkt1Zq62CAWzV907Lk+r30e4jyJvHRnx
         Cz8lhcpT7KFg765nC7EGu5gOZIkuxuxvHFONZjZN9s8/qhufwhaiqRA3ay6Al6rwGzHu
         8u8KxmD0xyu6jF7g2Q9p0XG3cva0F/3GtoqACM6EcUpkccZ3tmciHb8qLrGnbMBbPiQ3
         2vYGX4t6PRg+ymkiZydfSkoeC5Mpdn5vbbtUDxLCSQNpt1Xx9BfmhrWqDYhRH8abaEBh
         CjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SmvWx14eAhy3pe3g3Tx/t4BuExsjjc5XxE2U64XG7T8=;
        b=s9tRMwYG9V3ikDyYlDuY4SOGk3mM1LZyWFclcr8/RE5GUgxfzuDkkc7DgyEUq5jHMf
         3MPTDf8gQFXQnof5I3F6dERwDESPuUPirPqOymv/KSTJja0JJrEBtzSpc3Yont//Yu8+
         moupYzCXfhq7LE2RWDsP9CEwFspVxVvGTrEVuUMd/PtkUFbISTz7gBE5C+yQWt4FpUG9
         tfyA6Z5fGQ4AvNxt1nkKakzro3+9e7688fWgH/JlpWHcBjre5ajqcNEo77UoXjz/BJsu
         7UPesabx8jmwP78j3O/1uDC42tNpdh1H2+kRYnkJL/A5Mz7+12Wji1JBzp2xEYnaA1wl
         gPLQ==
X-Gm-Message-State: AOAM532/4LvjOedVWrUXZ6EJxzvadBstX7vZYKGYDjpcdHTLNbvl8Ae5
        0UIciKwQGWasoXLNnajoo2vcsjSfCOWc+w==
X-Google-Smtp-Source: ABdhPJy0xF2Nms0x9uxvfJv3r321RpYZaioY6aGOpfgnDwAdsAnsCNaJQS+y/BymVndyfBKtlt9+Sw==
X-Received: by 2002:a5d:4944:: with SMTP id r4mr19725863wrs.550.1643138239522;
        Tue, 25 Jan 2022 11:17:19 -0800 (PST)
Received: from jupiter.lan ([2a0d:6fc2:4951:4400:aa5e:45ff:fee1:90a8])
        by smtp.gmail.com with ESMTPSA id t17sm17847069wrs.10.2022.01.25.11.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:17:19 -0800 (PST)
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] xrpcrdma: add missing error checks in rpcrdma_ep_destroy
Date:   Tue, 25 Jan 2022 21:17:17 +0200
Message-Id: <20220125191717.2945308-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These pointers can be non-NULL and contain errors if initialization is
aborted early.  This is similar to how `__svc_rdma_free` takes care of
it.

Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 net/sunrpc/xprtrdma/verbs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index f172d1298013..7f3173073e72 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -336,14 +336,14 @@ static void rpcrdma_ep_destroy(struct kref *kref)
 		ep->re_id->qp = NULL;
 	}
 
-	if (ep->re_attr.recv_cq)
+	if (ep->re_attr.recv_cq && !IS_ERR(ep->re_attr.recv_cq))
 		ib_free_cq(ep->re_attr.recv_cq);
 	ep->re_attr.recv_cq = NULL;
-	if (ep->re_attr.send_cq)
+	if (ep->re_attr.send_cq && !IS_ERR(ep->re_attr.send_cq))
 		ib_free_cq(ep->re_attr.send_cq);
 	ep->re_attr.send_cq = NULL;
 
-	if (ep->re_pd)
+	if (ep->re_pd && !IS_ERR(ep->re_pd))
 		ib_dealloc_pd(ep->re_pd);
 	ep->re_pd = NULL;
 
-- 
2.23.0

