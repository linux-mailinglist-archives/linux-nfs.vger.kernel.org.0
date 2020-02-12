Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3591215ACE7
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 17:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgBLQMe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Feb 2020 11:12:34 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43334 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLQMe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Feb 2020 11:12:34 -0500
Received: by mail-yw1-f67.google.com with SMTP id f204so1079408ywc.10;
        Wed, 12 Feb 2020 08:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jkVD74TOI8uxcLB4a4v8Z5S2OlpN0NYU3g2ZixiN5wg=;
        b=oSvknZ1nCr42GGZ80TatTRSOJ3k+W4kt+GuUFTzPwDAckqRbFw5ghJ+jbyYnKRSzSk
         SVTFErrNHjVYlCYY4f4sFpV8nVga/dQzSpAFqv76Mxex2w9YQX2YS5Gp0A+nS3oHirjy
         G/kg/oh+iidtrZZBYrJF6222wMPeRZpEf5ZL1XKBofBPt+EUMIF6t5Ie2+3J2f15JGL6
         PNfDV9dcSTC5nhZHKD0M4BuXrsacIWSNopgOS0pSyD2N/kHLznXhTRVA0TsLZqs7JSzq
         W+t8lU5s9KtvcGlJGG29ssVllIFU8kOx9ZP/kSGr67dECNI3S3ryv+i2TFeHcIFjfK/Z
         Rubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jkVD74TOI8uxcLB4a4v8Z5S2OlpN0NYU3g2ZixiN5wg=;
        b=EO3QAl2LI2idcl39AfC7R+0GVgUezx6a7BtOZ9C0sQg1L5Do3JXWmgRI9dmPGs1uF9
         KuAEZcqEfu7uN1wMM/QWu9KaMpzmabj15yiNeW7zpzI/70yZoT2JfnP8yUmIisXTYeI1
         yUuJPwuh7QNjxoVsDOAFvLmbv4tWkBRZt9DdmIRuo4QyIIqu5N8assC5aOCyMWXTewwX
         PjpJcJ21YgcvWYZ0/WxXyHyeAC7qQ5auJVMLzalZIu4QDZIWMnalFTYA7Ewcffim0sgR
         y7XjXU+4rHOMkkg7LkFrojTSPMm2FG76MPtXTYnjGsgZqXK4k789Y1Ad3BfguTYCszHO
         N81A==
X-Gm-Message-State: APjAAAXpZlU7ucXDrH+b+9mXh9oSIRjmfdaBQjap8UONNefRmyBp/dNj
        Zj4VBFdXGFjGBh1p5fJ+GCnT/H9V
X-Google-Smtp-Source: APXvYqzzYAbqK66kHxLemlbcOn3i8z89g4zHix7n7lxgNXexbnsBdg5Y3cUXXxmx36VX08rpBvy/cw==
X-Received: by 2002:a81:6c04:: with SMTP id h4mr11175385ywc.431.1581523953280;
        Wed, 12 Feb 2020 08:12:33 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q62sm355660ywg.76.2020.02.12.08.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 08:12:30 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01CGCUdb022126;
        Wed, 12 Feb 2020 16:12:30 GMT
Subject: [PATCH v3 1/2] xprtrdma: Fix DMA scatter-gather list mapping
 imbalance
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 12 Feb 2020 11:12:30 -0500
Message-ID: <158152394998.433502.5623790463334839091.stgit@morisot.1015granger.net>
In-Reply-To: <158152363458.433502.7428050218198466755.stgit@morisot.1015granger.net>
References: <158152363458.433502.7428050218198466755.stgit@morisot.1015granger.net>
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

The bug was exposed by recent changes to the AMD IOMMU driver, which
enabled sg entry concatenation.

Looking all the way back to commit 4143f34e01e9 ("xprtrdma: Port to
new memory registration API") and reviewing other kernel ULPs, it's
not clear that the frwr_map() logic was ever correct for this case.

Reported-by: Andre Tomt <andre@tomt.net>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org # v5.5
---
 net/sunrpc/xprtrdma/frwr_ops.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 095be887753e..125297c9aa3e 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -288,8 +288,8 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 {
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	struct ib_reg_wr *reg_wr;
+	int i, n, dma_nents;
 	struct ib_mr *ibmr;
-	int i, n;
 	u8 key;
 
 	if (nsegs > ia->ri_max_frwr_depth)
@@ -313,15 +313,16 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 			break;
 	}
 	mr->mr_dir = rpcrdma_data_dir(writing);
+	mr->mr_nents = i;
 
-	mr->mr_nents =
-		ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, i, mr->mr_dir);
-	if (!mr->mr_nents)
+	dma_nents = ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, mr->mr_nents,
+				  mr->mr_dir);
+	if (!dma_nents)
 		goto out_dmamap_err;
 
 	ibmr = mr->frwr.fr_mr;
-	n = ib_map_mr_sg(ibmr, mr->mr_sg, mr->mr_nents, NULL, PAGE_SIZE);
-	if (unlikely(n != mr->mr_nents))
+	n = ib_map_mr_sg(ibmr, mr->mr_sg, dma_nents, NULL, PAGE_SIZE);
+	if (n != dma_nents)
 		goto out_mapmr_err;
 
 	ibmr->iova &= 0x00000000ffffffff;


