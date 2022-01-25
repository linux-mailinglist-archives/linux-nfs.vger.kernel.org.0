Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0B349BCB0
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 21:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiAYUHD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 15:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiAYUGu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 15:06:50 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC68C06173B
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 12:06:49 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id f17so21931707wrx.1
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jan 2022 12:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rln4rWzvCej/YAv0AvXkJ8OfIT+mtQHHPMzyqYlpo6E=;
        b=AHaWSJa+s8WkvaZwiapwK3WUMTVv2lqpkkpsQeR8K25JujH/WQE+t99AWLHI1b9NEt
         9ZChqFPvHj01Gyb/j/khsYiMqLwx4ro6qPWoYlm2VcQ8x2MN6ejptfLglwsjCtSA+gZW
         CB646NLBq8c13jR/tkdmcUe/yHoj55knWfTcmBXG0CH1RYjiYZFldQQmU86Qvs9o2n8t
         /cjap10gRHNsReyVMeILTjRIKtGmL43QbZy3qt7ZFo7ID/7dTZnHnrBcBaVg/uPQso/H
         p4AAFK/wfErmXIFmJofxnzPBNRbOc4J9qcrybpWix9Wu6cNUvplpPkX7uy4QSkm/516C
         cOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rln4rWzvCej/YAv0AvXkJ8OfIT+mtQHHPMzyqYlpo6E=;
        b=3ex6YkMpbZuyxJ8GpLttXTgMyRllkfxsPhbBwISG+mRfagG84F4Gu3L9A6mSeD+lcU
         x5B5Teq1gPY4RatUc17n6LJ0RruyQK9PsVUrAel35oyIekCurW+ScsWlO6IvTc9esNFc
         WDwzjK+IIOSfqW+QIfoS+xkqeMP6Hcd9X2N+w23wTMmjwBTZ7nvTy9XY8qJUnj80B6DS
         zpw1Uf4M9WYLbd5vu5Ba1P3vqgy5M8pjVZsB/MVeBxdqXv6KjpQ6J5u6e5ysDivOINWc
         zjPHVujMAFx20w5L9uq2dmeGeL02quME9PT8Qr9/4O4qdxMJ9kiRVlYx8qJyCTNJJiSN
         1pAw==
X-Gm-Message-State: AOAM533CNOVYKyHwLN5/GUg5jU2Dt3C2TazOye4YA+2oxwc3W8zgv/J+
        wgM5d1xtwcEvZLIKfMnmp9JEonpXidpxxw==
X-Google-Smtp-Source: ABdhPJyX6UcEBahzMjM+n/DdT6j9tpZeqg1gGAQeuDBhjyuCOmofuuxzCoo9xG0jEKUz/Pda08JmCA==
X-Received: by 2002:adf:fc8e:: with SMTP id g14mr19527855wrr.260.1643141208504;
        Tue, 25 Jan 2022 12:06:48 -0800 (PST)
Received: from jupiter.lan ([77.125.69.23])
        by smtp.gmail.com with ESMTPSA id 31sm22133924wrl.27.2022.01.25.12.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 12:06:48 -0800 (PST)
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] xprtrdma: fix pointer derefs in error cases of rpcrdma_ep_create
Date:   Tue, 25 Jan 2022 22:06:46 +0200
Message-Id: <20220125200646.3002061-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <48846140-72B7-4B4A-8948-6F35F1670FCD@oracle.com>
References: <48846140-72B7-4B4A-8948-6F35F1670FCD@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If there are failures then we must not leave the non-NULL pointers with
the error value, otherwise `rpcrdma_ep_destroy` gets confused and tries
free them, resulting in an Oops.

Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 net/sunrpc/xprtrdma/verbs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 3d3673ba9e1e..2a2e1514ac79 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -436,6 +436,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 					      IB_POLL_WORKQUEUE);
 	if (IS_ERR(ep->re_attr.send_cq)) {
 		rc = PTR_ERR(ep->re_attr.send_cq);
+		ep->re_attr.send_cq = NULL;
 		goto out_destroy;
 	}
 
@@ -444,6 +445,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 					      IB_POLL_WORKQUEUE);
 	if (IS_ERR(ep->re_attr.recv_cq)) {
 		rc = PTR_ERR(ep->re_attr.recv_cq);
+		ep->re_attr.recv_cq = NULL;
 		goto out_destroy;
 	}
 	ep->re_receive_count = 0;
@@ -482,6 +484,7 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	ep->re_pd = ib_alloc_pd(device, 0);
 	if (IS_ERR(ep->re_pd)) {
 		rc = PTR_ERR(ep->re_pd);
+		ep->re_pd = NULL;
 		goto out_destroy;
 	}
 
-- 
2.23.0

