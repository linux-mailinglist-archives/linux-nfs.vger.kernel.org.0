Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50908835ED
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbfHFPzN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:55:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34715 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbfHFPzN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:55:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id l12so6657137oil.1;
        Tue, 06 Aug 2019 08:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3mABFgNoHsASDZ0kDY/9dAcX1XQsRjSu0yrLeB2U2Ks=;
        b=poIml5RC9BNZkVthDx8/COAKHnR4YTrvfc3CXMDx08wvr1xxJrJ2oSdI7LLUJbzfVf
         uzW/v1lhRd+7tYPr5b8ixICm5rADRAi9GurFORiXUaeGMl3aiF9bK6hCBwcLSsjS3/cs
         WzNYUXKPLdE3eO7Lod4W0mKjMlZXUK+t23L5Tj5kCTN+f0kbswLv6mH2I52ihc10YjLq
         fmoJy2vIVBYgImVakbeo+DlSqk1vgaeMLWdJzhwcTeBlIFObNvQMefpPeHIaIaZQR/I2
         8LwRmDrMgDySGQfJHyR3QtmoABIEZ0y4qEbwpTJyB2s8xCgXWE8Praf4r/DP517tPkGt
         3G4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=3mABFgNoHsASDZ0kDY/9dAcX1XQsRjSu0yrLeB2U2Ks=;
        b=R8eMO3K3AYcO7H74hCF3DgLqiwZGZc5lVZHjAPMXf18nVmeEV/yl4b5VHVziqcoxZY
         DlXy96/sLXhV1XeT/eIVL3N5EMaHpxyQhQiLt/quB9m1S093vUWy3oqj1Tprn89LJ/LH
         oQKUwazJVOJLlC5pmsCoMyCmwJZWS+PkYf9H6WXmnm7h8iC+eAsN1XOuyuY4nO467tXl
         cXWA28YQyWj893ijS1NmTdPlmElcavOEQYDnjC/7Yrm3fj24TkmT8wzqiuIopYNEJIMZ
         VX/Iz12Ik3KhRai+f29cFqwuNQyO+8H6fKKl7hNoG1CnGwryhtVqxC51mH0KbOuK/UHk
         SaAQ==
X-Gm-Message-State: APjAAAXYUKsdwQwcY+ZVpYAD1JWwRAd6/SMTkcfKqsHhHRSjrkXiIRb/
        XOZoNiW74s0Fprior46hiSJFolpF
X-Google-Smtp-Source: APXvYqwWVwPjjbhZFicJH0y2iI4hD8YurpZLhadum7jo6DUPhmhLmK7h9umXzkjLauRRnLbwvB2sdA==
X-Received: by 2002:a02:3b62:: with SMTP id i34mr4966874jaf.91.1565106912416;
        Tue, 06 Aug 2019 08:55:12 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p3sm133027554iom.7.2019.08.06.08.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:55:12 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76FtBZV011559;
        Tue, 6 Aug 2019 15:55:11 GMT
Subject: [PATCH v1 16/18] xprtdma: Fix bc_max_slots return value
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:55:11 -0400
Message-ID: <20190806155511.9529.93076.stgit@manet.1015granger.net>
In-Reply-To: <20190806155246.9529.14571.stgit@manet.1015granger.net>
References: <20190806155246.9529.14571.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For the moment the returned value just happens to be correct because
the current backchannel server implementation does not vary the
number of credits it offers. The spec does permit this value to
change during the lifetime of a connection, however.

The actual maximum is fixed for all RPC/RDMA transports, because
each transport instance has to pre-allocate the resources for
processing BC requests. That's the value that should be returned.

Fixes: 7402a4fedc2b ("SUNRPC: Fix up backchannel slot table ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/backchannel.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index 59e624b..50e075f 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -54,9 +54,7 @@ size_t xprt_rdma_bc_maxpayload(struct rpc_xprt *xprt)
 
 unsigned int xprt_rdma_bc_max_slots(struct rpc_xprt *xprt)
 {
-	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
-
-	return r_xprt->rx_buf.rb_bc_srv_max_requests;
+	return RPCRDMA_BACKWARD_WRS >> 1;
 }
 
 static int rpcrdma_bc_marshal_reply(struct rpc_rqst *rqst)

