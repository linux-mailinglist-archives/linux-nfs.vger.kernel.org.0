Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97814ADAA9
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2019 16:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405122AbfIIODS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Sep 2019 10:03:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32848 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405066AbfIIODS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Sep 2019 10:03:18 -0400
Received: by mail-io1-f66.google.com with SMTP id m11so28948406ioo.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2019 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mT/Rzj/K1U6LEdiuCQ0lI11+dkVn7b9E0XXmRpME0Iw=;
        b=Vgl0lQkv2LzLw82kw3EkWUhkQXg+WGCe42683LJIRYDKBcP8vKAvGL+8gIWbVUil3+
         F3sTA3QQqls4LWDiExM46hg1To8fWMMIYwWcdelaihBdtdKpIziBF4ClxiHGuosVN8Yh
         NYz7GQj0fUHNCkH3sXiKW3Tzg5+twBp4HWCQ3iUSjYCIL/yABX40NlSVyrEHbvZfaJ2K
         5s6Jqd/E4r9RyHPtvGIJDRHmAqsBiSCQ5abmujabiobGaQXYHR39IVz5agxp8fjAXMcx
         olXAygYeE0bMREJXjPs397/rb5pGoGHI8mdL92tdYEVdBmb+ryXzUEY0Hswq/ASgFP4K
         Tkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mT/Rzj/K1U6LEdiuCQ0lI11+dkVn7b9E0XXmRpME0Iw=;
        b=mtehkzgp8W7tnwadi8sZ2aKxkuPjTGDzwRceANOlYRDJAJoNuRmYxVaWi0IEjqs8v9
         972opgARmcBUhqUFyo+C/xXgwH1n3kXj2CaCBaWZh5xwH27p7zrXgIubjMqLM32jOQ9B
         ae5q1GU/GTLNrO/kDleRLa1hWp2H0chM6IHxwqEtHYZHu8ZKZifswOndha6cocjb3wTY
         j+67sAIrRo9F2Hw1YFJTSR525jJ+3S6M9SeMJVCkV1VIzPYncyGT31nVskyP1MrDFmP4
         zPx5lJj5XKbdBbbPvIxLZ2k5a24OH8JLJY+pilZAQhYx46M0oxDIvTAvvzRMPZeSSl0F
         X6yQ==
X-Gm-Message-State: APjAAAUPi9Ae35JmLoAgHh+e6JfKxwcsnFZaWlEI181LSBsR6wj5BBXM
        U5JAwqOGgDwm3zSskyafCB9LmLXleQ==
X-Google-Smtp-Source: APXvYqyskAmMygM+ZQXCBUvrxVeqUjjDY5IDPKtSwB0FP48ceAeL/KRd1HOzLrD6KhmkpHJbfPEI2w==
X-Received: by 2002:a02:a513:: with SMTP id e19mr13734612jam.56.1568037795805;
        Mon, 09 Sep 2019 07:03:15 -0700 (PDT)
Received: from localhost.localdomain (50-36-167-63.alma.mi.frontiernet.net. [50.36.167.63])
        by smtp.gmail.com with ESMTPSA id h70sm33727176iof.48.2019.09.09.07.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:03:15 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/9] NFSv4: Handle RPC level errors in LAYOUTRETURN
Date:   Mon,  9 Sep 2019 10:00:59 -0400
Message-Id: <20190909140104.78818-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909140104.78818-3-trond.myklebust@hammerspace.com>
References: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
 <20190909140104.78818-2-trond.myklebust@hammerspace.com>
 <20190909140104.78818-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Handle RPC level errors by assuming that the RPC call was successful.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c |  9 +++++++++
 fs/nfs/pnfs.c     | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index fcdfddfd3ab4..a5deb00b5ad1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9057,6 +9057,15 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
 	if (!nfs41_sequence_process(task, &lrp->res.seq_res))
 		return;
 
+	/*
+	 * Was there an RPC level error? Assume the call succeeded,
+	 * and that we need to release the layout
+	 */
+	if (task->tk_rpc_status != 0 && RPC_WAS_SENT(task)) {
+		lrp->res.lrs_present = 0;
+		return;
+	}
+
 	server = NFS_SERVER(lrp->args.inode);
 	switch (task->tk_status) {
 	case -NFS4ERR_OLD_STATEID:
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 6436047dc999..abc7188f1853 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1455,6 +1455,21 @@ int pnfs_roc_done(struct rpc_task *task, struct inode *inode,
 	case 0:
 		retval = 0;
 		break;
+	case -NFS4ERR_NOMATCHING_LAYOUT:
+		/* Was there an RPC level error? If not, retry */
+		if (task->tk_rpc_status == 0)
+			break;
+		/* If the call was not sent, let caller handle it */
+		if (!RPC_WAS_SENT(task))
+			return 0;
+		/*
+		 * Otherwise, assume the call succeeded and
+		 * that we need to release the layout
+		 */
+		*ret = 0;
+		(*respp)->lrs_present = 0;
+		retval = 0;
+		break;
 	case -NFS4ERR_DELAY:
 		/* Let the caller handle the retry */
 		*ret = -NFS4ERR_NOMATCHING_LAYOUT;
-- 
2.21.0

