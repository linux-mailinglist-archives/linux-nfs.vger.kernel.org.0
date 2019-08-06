Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71BEB835E4
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733105AbfHFPyr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:54:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38446 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732676AbfHFPyr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:54:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id d17so93766374oth.5;
        Tue, 06 Aug 2019 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Bgbym9xTfXEVhRW+oUKs5J0eA8pub+HjcsvnUQuPTag=;
        b=QLQmCDFJ/5RbFfXBkrBIMIRd/k1GZxw8GTnshIpYJCJmcdwKNYnRQ/hrsk7d/6QgRP
         FO0pkxGiGFDerqpMwGwV+3vAzjOIKCBAJ+d1+JF0C67FLbxxwMsO1tq0Z8viLojkK1uD
         PZWUcTmKJZTQzAMEowOp1Au7jnTYarf27VEyKrNH72dfpE0gsAeAcIXR/7ZiSWEuSGLR
         gi68EB59osjoA3vVFJ7RA+426PETYZw3CuP05fUDBaoUBcvjxO9YhD7Ey9MU0kW4VgfM
         iunNNCUbYiMP4rmUtHlM+gGLhW96dMHu3JgqTZ2oQgvEgcc+nUpXvQKpngzBKfMpGHgg
         hGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Bgbym9xTfXEVhRW+oUKs5J0eA8pub+HjcsvnUQuPTag=;
        b=CZ/Se64VaE2be9cofX+to6Qr7PPB34RYOAgSMBu2TYIyyiwXtiuesP7BYjyL5wKtuZ
         p8lOzv+CbGgw9RQRoAMkxT7J5U5nu84XpA1T1pRtHkPAWow5pz9Hw0HiJCUVUtewQQ38
         T41N9xsHh7WOvJy1K+rNv7SoOWFlVb1piTr25uOd4/F70evzzhNMw44BOpbl9XlAydRo
         X1yCtfZJ6+3a4Ik2D+OPDIJmt803wbbP67eHUJksjtCgjndscLnd2lIfKP7x0uCVXI2l
         RnoCfuoXD+jZoaoTYpT5Q12AcZBf5tw1IDL0Sh4AQqA/mgTzAaOGt6QJ3zZIqoEZT6F1
         60pg==
X-Gm-Message-State: APjAAAVK1exgMxxfRMqZU82KKgYKzHeSG+UwbyggHfjmgqC/g8hP0KGh
        2USF++gBm21o41six+W7SoirBK5A
X-Google-Smtp-Source: APXvYqy6/smgDcHyTrx5qawCxlmYxH9DYC6W6ZD3Ew03t6vrKKOh71HWxAGwV348HPNjOstgLmGHUQ==
X-Received: by 2002:a5d:8a06:: with SMTP id w6mr4383218iod.267.1565106886089;
        Tue, 06 Aug 2019 08:54:46 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s10sm185719310iod.46.2019.08.06.08.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:54:45 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76FsiRE011544;
        Tue, 6 Aug 2019 15:54:44 GMT
Subject: [PATCH v1 11/18] xprtrdma: Ensure creating an MR does not trigger
 FS writeback
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:54:44 -0400
Message-ID: <20190806155444.9529.13811.stgit@manet.1015granger.net>
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

Probably would be good to also pass GFP flags to ib_alloc_mr.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c |    7 ++++---
 net/sunrpc/xprtrdma/verbs.c    |    2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 362056f..1f2e3dd 100644
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
index 0d6c3b6..1fcbe92 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -947,7 +947,7 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
 		struct rpcrdma_mr *mr;
 		int rc;
 
-		mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+		mr = kzalloc(sizeof(*mr), GFP_NOFS);
 		if (!mr)
 			break;
 

