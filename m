Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3704FD9385
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2019 16:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392276AbfJPOR7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Oct 2019 10:17:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37105 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730937AbfJPOR7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Oct 2019 10:17:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id u184so22902633qkd.4
        for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2019 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HDETNY7WK9PJBRVGF2Wq3OyOQEyyC9mkVXUUeP9/L9o=;
        b=Xtk6Olq4TjBdfm8dEJi0Ty3kIAg1risZ49Iw/vG1qGLuHM8jWEA9Pc75UbUQoH3w1E
         pYaB0YOG4Sa7f22PzA3NPBryD/ZvEReJ2kz5F2LA5K2nu2dqhAPh5kChNyn6LC+/dRzJ
         yBTrDM+LBhjS8cma4d6A80qeL2BUMpFL1Rj9tPKBSZqFA9hCPGmvYa0D/OghQStz7yqc
         4oNJWf+8iAamcx/zgthhB123FZrpFC/TK/zrx1GqqSKNsfqVkHZN9+N2kGEgbVKOsxfk
         RQeMxEXh46T5Mrym52ov8Q5kQ8LfyB/NHd8n93qUJDLfxExSUs268R+0g0V823RFICIU
         NXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HDETNY7WK9PJBRVGF2Wq3OyOQEyyC9mkVXUUeP9/L9o=;
        b=VM7xmBTNRkrrRCTPXmePyvjtpSf0UyHRZ+x/hFifREHR8OjdgZFVbtvItMXrCZloVq
         7YlSZpwWvJd/ha6BVaOLAvXq1LsbJTm+l0zhOYNtE8UsO2RzdQEc6/ilCo70bZq65fzj
         s8ubCB5GOUuQWrGm8yx6tMNmBrM0guK2UAJEForAmPD2gevxnf22CydbyJjdkAlrD0wt
         unBwczgtk2Td9Vu6vrt1LidrcknwJSxFwfe8myosHoyJAszrGaJ8WbcObrllIS84gRsS
         otjTj2lINWMbypu9j0ashXay0+a7YD2ZNlxJOP6pU+w0FZQchXKDB7mneYTpoZ8JEx8U
         bWbA==
X-Gm-Message-State: APjAAAUDzI333hYX8Blduv3BpvIBcANYy2X0s8TZjKBSccgC+OyOtBh1
        J0AZdqa6lpRWFaW5YwOJFGL3aGg=
X-Google-Smtp-Source: APXvYqw0Je+fp6MT1VQL90vkyOeK/ulUL48b365qxVR2HKQS8Il4v/vwPOb0e3qCuk4U3xGydLztyw==
X-Received: by 2002:a37:9904:: with SMTP id b4mr39869163qke.499.1571235477996;
        Wed, 16 Oct 2019 07:17:57 -0700 (PDT)
Received: from localhost.localdomain ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id g31sm14925361qte.78.2019.10.16.07.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 07:17:57 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Cc:     Neil Brown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/3] SUNRPC: The RDMA back channel mustn't disappear while requests are outstanding
Date:   Wed, 16 Oct 2019 10:15:45 -0400
Message-Id: <20191016141546.32277-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016141546.32277-1-trond.myklebust@hammerspace.com>
References: <20191016141546.32277-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If there are RDMA back channel requests either being processed by the
server threads, then we should hold a reference to the transport
to ensure it doesn't get freed from underneath us.

Reported-by: Neil Brown <neilb@suse.de>
Fixes: 63cae47005af ("xprtrdma: Handle incoming backward direction RPC calls")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtrdma/backchannel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index 50e075fcdd8f..b458bf53ca69 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -163,6 +163,7 @@ void xprt_rdma_bc_free_rqst(struct rpc_rqst *rqst)
 	spin_lock(&xprt->bc_pa_lock);
 	list_add_tail(&rqst->rq_bc_pa_list, &xprt->bc_pa_list);
 	spin_unlock(&xprt->bc_pa_lock);
+	xprt_put(xprt);
 }
 
 static struct rpc_rqst *rpcrdma_bc_rqst_get(struct rpcrdma_xprt *r_xprt)
@@ -259,6 +260,7 @@ void rpcrdma_bc_receive_call(struct rpcrdma_xprt *r_xprt,
 
 	/* Queue rqst for ULP's callback service */
 	bc_serv = xprt->bc_serv;
+	xprt_get(xprt);
 	spin_lock(&bc_serv->sv_cb_lock);
 	list_add(&rqst->rq_bc_list, &bc_serv->sv_cb_list);
 	spin_unlock(&bc_serv->sv_cb_lock);
-- 
2.21.0

