Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F42195118
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfHSWqq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:46:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44619 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSWqq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:46:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id w4so3228847ote.11;
        Mon, 19 Aug 2019 15:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zxkSkyCfPKPerjvC8Yo1fxnGEm55eqARL6sFVpESOm0=;
        b=GYayVWd5fme4TfxOLU2G4rxKnQkHPAxdPsUemQfVkAca62EXfQqeN5wZUaWrL5BySY
         xsUYN3BRK7RxH3lEin8DU3VhDJ0p2VDELez/XQ6s8MJH8FVHZNuVVQB/E3i2D5vCZ+40
         Muue4m/hR1EvX2z0A/p3T9Xjim9GPSyJSFmlQ6q83O7kSFkdeOjB4opUDdq8n8tD9Tom
         VWms4jpW1DLxdsmuWUXtautlgaO7Ah2+dY03ClNQO8ENXpecZepaTXb4tXdTV6i/tiDG
         Jq5n/dGcmZ8geaPWQkvbjwFFCwQDkzDYMKxGiRVNZa3EK2ehVARYnly55ZK4fiX/A4su
         sTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zxkSkyCfPKPerjvC8Yo1fxnGEm55eqARL6sFVpESOm0=;
        b=R1/HZALtUTrBWp53aZag9iv4XqPI4P1bXqYlEz3HjxtSkHHOpUiPs9CoWdFFUz2R7C
         cdT0kwHqlQMgMtScvFt83C6lECJ6tZL/+rPlVRQcV02scBEnvlPznU/aklQvpZFB16wj
         NSX435kGcVIRuT3vT2Q4dnlugC1ZYBQk0GQ2JlsxUQlrgb4CAWUYrn/SRoe1V4QFboip
         m4iCQddXZIf0bsKFHMfJA0FWWKKM4RBh8ex7cU9tS+Xji2+yqMUuyGaHZ+IAgCVYpftJ
         1nQj54dUH9qLdBI5qsf5sk7D7CWBUin5zaSWkBQzc4zzLcP0jgqHreeKHUpMki9QcJPO
         X+zQ==
X-Gm-Message-State: APjAAAVR4z+6Y7Wo7GBcC3iCns2sj/aQNsSHJnMB4wM2fd2fXoV3ct7n
        AyLEEXpU2+oTPiXYXYvKeD6wAAGm
X-Google-Smtp-Source: APXvYqxyX6nHvwLzrUHw/fGny6/uJjEjBphGXTRI/KDlYoIr5ohX5fBWJJoyCyiJiSD/0FR62u+2Ng==
X-Received: by 2002:a9d:d51:: with SMTP id 75mr20439529oti.46.1566254805327;
        Mon, 19 Aug 2019 15:46:45 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id f84sm4732118oig.43.2019.08.19.15.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:46:44 -0700 (PDT)
Subject: [PATCH v2 14/21] xprtrdma: Ensure creating an MR does not trigger
 FS writeback
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:46:24 -0400
Message-ID: <156625476397.8161.12423510142910031118.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Probably would be good to also pass GFP flags to ib_alloc_mr.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c |    7 ++++---
 net/sunrpc/xprtrdma/verbs.c    |    2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 362056f4f48d..1f2e3dda7401 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -147,11 +147,14 @@ int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr)
 	struct ib_mr *frmr;
 	int rc;
 
+	/* NB: ib_alloc_mr and device drivers typically allocate
+	 *     memory with GFP_KERNEL.
+	 */
 	frmr = ib_alloc_mr(ia->ri_pd, ia->ri_mrtype, depth);
 	if (IS_ERR(frmr))
 		goto out_mr_err;
 
-	sg = kcalloc(depth, sizeof(*sg), GFP_KERNEL);
+	sg = kcalloc(depth, sizeof(*sg), GFP_NOFS);
 	if (!sg)
 		goto out_list_err;
 
@@ -171,8 +174,6 @@ int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr)
 	return rc;
 
 out_list_err:
-	dprintk("RPC:       %s: sg allocation failure\n",
-		__func__);
 	ib_dereg_mr(frmr);
 	return -ENOMEM;
 }
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index c9fa0f27b10a..cb6df58488bb 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -949,7 +949,7 @@ rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt)
 		struct rpcrdma_mr *mr;
 		int rc;
 
-		mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+		mr = kzalloc(sizeof(*mr), GFP_NOFS);
 		if (!mr)
 			break;
 

