Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC031D00AC
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbgELVWz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731270AbgELVWz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:22:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08618C061A0C;
        Tue, 12 May 2020 14:22:55 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id y22so2627185qki.3;
        Tue, 12 May 2020 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WhwomO42XDAEJPW2/cr+MUt5RrB/mfN0Bet2spmrCJc=;
        b=VfQiSHcCV1VsVyv8uNIgf9kLYQGVQlvA1DkXDXOUj0rl4EGXOYiu24m9bRKc6d9f16
         C/iqqIqg1/3nmSeaiU3opAJyMoIQNqYjAV+AVzoV+qkcQ3rdnDs2fGVI1/ukJ48DGmlX
         hvzlQRoMP9nq9ar4ljo8ErmRZUcPQEjb6AG0fO7rNZgcLViTSgwaBueTa/2EkNm2eyF+
         FMWmlSzEMkparbHwEMmKCtU5LfzK+MUkmHuy2YyTI1pY2Ec63mPfYWdCG0UkW/Yvf4P2
         O/dZj8FfC2mEumMAfiJccyOAUMM6FnD/13iCPTcZt0kW8qgiRLJHusBottUDxsNGNN+c
         vrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=WhwomO42XDAEJPW2/cr+MUt5RrB/mfN0Bet2spmrCJc=;
        b=fRkh6rl+8lfUVd6dlmQbzWqOUzGDN4K78/rcfcE7xX+ozRiRC72wqvPF8w18tQcxQj
         jl+S7w+AMIt/TPK1O+t4uHQ9A1Ky0EQeflIRTguTGBTtaV2M+koyMe+bhg/1FL81DN31
         0WRKiEa13EthExxm/xd2yrSHQHtS0l1I+mXr0KTZPZRX7wGKTkbCCjvD4h+3IzJEQgXT
         ZSkMvdljtvRkkzNjTLUbjwTzkpyhXUol9xIbdUATnzuDxfoA36M84KjFNxftyG25Ikes
         aOfZ0iUg6Gr/uUMcgoy4xVn8Cxg02KB03v18KtlwO5XOoboOuuUIbvK+XZIV3wEPkV73
         h5tg==
X-Gm-Message-State: AGi0PuauzhjMyLeurUotqr/kGYXqBKsAjQhLZS/veOF8nALk73BYo6Mx
        AI2O7lpt8bYxhF/QdUIXN/j3+Kop
X-Google-Smtp-Source: APiQypLqHDqJwzbgIgamZ05xjhcVawPKDfZSdyK/JSy+EAPuOgrHmUbAJTslTXiG//fUTJDY9k9Xig==
X-Received: by 2002:a37:5bc4:: with SMTP id p187mr9646830qkb.97.1589318573688;
        Tue, 12 May 2020 14:22:53 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l8sm13738519qtl.86.2020.05.12.14.22.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:22:53 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLMq3d009901;
        Tue, 12 May 2020 21:22:52 GMT
Subject: [PATCH v2 09/29] svcrdma: Remove the SVCRDMA_DEBUG macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:22:52 -0400
Message-ID: <20200512212252.5826.81631.stgit@klimt.1015granger.net>
In-Reply-To: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Commit d21b05f101ae ("rdma: SVCRMDA Header File")
introduced the SVCRDMA_DEBUG macro, but it doesn't seem to have been
used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 8518c3f37e56..7ed82625dc0b 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -48,7 +48,6 @@
 #include <linux/sunrpc/rpc_rdma.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/rdma_cm.h>
-#define SVCRDMA_DEBUG
 
 /* Default and maximum inline threshold sizes */
 enum {

