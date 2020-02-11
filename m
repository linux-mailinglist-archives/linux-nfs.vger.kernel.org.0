Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA5E159A1A
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2020 20:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbgBKT6f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Feb 2020 14:58:35 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37267 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgBKT6e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Feb 2020 14:58:34 -0500
Received: by mail-yb1-f193.google.com with SMTP id k69so5996411ybk.4
        for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2020 11:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2VAKAcpr2MBf9aCgMT8aEt9dlXUjbR7WNAT7b1h4DfU=;
        b=IGKGQ8U3cBDlzKSlnhA0V67hzzRvIfMmkGn/ymxAOM3RjjQ5hiKnTkLVzEqdqnshQC
         /gHwaglw3UPDhyVEq20oiMw/6LVdy0adv3jkfjp5FSm3b53gny6KJpmCq0ySKIEL4dM+
         hFkIHQbQkXkwgjHuSg7Pec039lilWf+RX6nk/C0jqDzWplGreBV9XzkSEcObogDsrFaq
         l/XjbrP1AcBuLIzZO1anB9qhgezK3xMIoAAjlr709CASR/ppdU+nN/mi1AEk2QmjgV05
         EagoDGylukfGmBHqBlf6y0irlPLjOxZMAKJ7W1pZJuxoxhdU9RXplbHLeFvEg/paHSy8
         00Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2VAKAcpr2MBf9aCgMT8aEt9dlXUjbR7WNAT7b1h4DfU=;
        b=repzw9uCq2WE9nDOlCsqfLgRFxuLU5JhC8Na8w5NlgDBkI2kXX6FhrxRE+l5JqFOi2
         BsdZqxPH4GmJE3WMR7kq91tBwc1pdyWZM3/QhuLvjoYv1BPSr2965rxephUKOPECvCr/
         aiDc7yhOLtK/qr0xGuchQMHq2xS2H5A5hPRf2jcVjuzNJ9OH0xMRod6azESbEzWw14qj
         lmJvdtlVaK2T3PVq9KfYxZQEGqYEoEgabpzod6H4BEPNcs4uPi4BgyhYZ2w2jhgWl1q6
         cBE8vK61hODBeeqAPyfFgn0QztHeHwZzy7TgNJ3SabshWbQmdutDeyxyU184d1ekerrj
         8+oQ==
X-Gm-Message-State: APjAAAWli/gw/IgZ/aR0GIOBWBACSpHplkuhddL7KXRVChWeWLulXDF6
        Fs6LWfRQNpYsHw3ZOz/14Y4=
X-Google-Smtp-Source: APXvYqyR6tQBxznLio5WOdQRmoOf2A1BZj5rBYROoLsitL5AXXNMcSjYGvkkUATssKixsl6iBp178A==
X-Received: by 2002:a5b:88e:: with SMTP id e14mr7583149ybq.338.1581451113808;
        Tue, 11 Feb 2020 11:58:33 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y17sm2424561ywd.23.2020.02.11.11.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 11:58:33 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01BJwUkL018987;
        Tue, 11 Feb 2020 19:58:31 GMT
Subject: [PATCH v1] xprtrdma: Fix DMA scatter-gather list mapping imbalance
From:   Chuck Lever <chuck.lever@oracle.com>
To:     andre@tomt.net
Cc:     robin.murphy@arm.com, linux-nfs@vger.kernel.org,
        iommu@lists.linux-foundation.org
Date:   Tue, 11 Feb 2020 14:58:30 -0500
Message-ID: <158145102079.515252.3226617475691911684.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The @nents value that was passed to ib_dma_map_sg() has to be passed
to the matching ib_dma_unmap_sg() call. If ib_dma_map_sg() choses to
concatenate sg entries, it will return a different nents value than
it was passed.

The bug was exposed by recent changes to the AMD IOMMU driver.

Reported-by: Andre Tomt <andre@tomt.net>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Fixes: 1f541895dae9 ("xprtrdma: Don't defer MR recovery if ro_map fails")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Hey Andre, please try this out. It just reverts the bit of brokenness that
Robin observed this morning. I've done basic testing here with Intel
IOMMU systems, no change in behavior (ie, all good to go).

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 095be887753e..449bb51e4fe8 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -313,10 +313,9 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 			break;
 	}
 	mr->mr_dir = rpcrdma_data_dir(writing);
+	mr->mr_nents = i;
 
-	mr->mr_nents =
-		ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, i, mr->mr_dir);
-	if (!mr->mr_nents)
+	if (!ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, i, mr->mr_dir))
 		goto out_dmamap_err;
 
 	ibmr = mr->frwr.fr_mr;


