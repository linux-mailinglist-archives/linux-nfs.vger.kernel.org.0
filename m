Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD4115AA41
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 14:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgBLNoB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Feb 2020 08:44:01 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:32789 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgBLNoB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Feb 2020 08:44:01 -0500
Received: by mail-yb1-f195.google.com with SMTP id b6so1090868ybr.0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2020 05:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=rgnLcOWtBG7HmNFyjA8xmyYMT1AlY0pRvxs1/WLvyMQ=;
        b=CZDlKb8sMfjdD8cyZVlg48ZpXDyUM7tS4WYvHuJCP1q8F4nxvJ5d8ksvSRzmvyzH5S
         XM3bfmn6RZvzRHZ1+1s+fZpQzMU7YV7oA5SPnX54cgT43bOLKr7YMTauG0vEDgzckwyo
         i06mDuAAOBuJI83tH819CoZiBbwzwH+J2ziofgA+J1/Dck3EBWjDHshfp/NwpL7iLkix
         BMvYhAKS2QQh6YO/4oMLk0Ao0eCXUSru6A6c6C1cpVwy/YYm6IbHsVS+EtGUa7Pw+PO1
         v2nFzJ4YWiY5yOfkev1j4vKV0oEMzmdx4DDKFjefhT3ulJpkw3TRA/acTmmy7uyJeGth
         54Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rgnLcOWtBG7HmNFyjA8xmyYMT1AlY0pRvxs1/WLvyMQ=;
        b=MiHeomAVHzKKRzAWUt0FWhjgoAaPjPFYi7UNJeAvjuDhdap4loMemW4cm8KIBwznUN
         KuiVKisHcJR2tDKmsm8n7zMUBr/no2hitIidJoVZ3xuPLH18MDb6V86pzdM1GC9yaQsw
         DPrBFpuI1DASQ1b+SyiPk97kO/yUw20rzYImuDu9EUHd83aIGj2Kqreq1geTN1z2ivMv
         v2Fbn/bQIJLi2Ms6DOQyud22E/SYD9La85ZwQkcI6NAfaegj56CLQYamq1aW518P86o8
         8B0It/grOsHn9T2egrT8ck3tFHS55S9xePAPL+R+TaMG4HfalXAziy//Yz69hjr3TEjk
         4f6g==
X-Gm-Message-State: APjAAAV0hQkL1mlDe4y9Wqnk3jG/xB/IUGOKkrify8+Lk+QEjTDhz5GQ
        biNRrD2LniFlW74GEeRcuxLqsT1s
X-Google-Smtp-Source: APXvYqwt4z5HURrT2jThj6VGGkhDoQ0o5YnLK6cuBi3g1HRh740JQAAT7rq0AXnPOrpkFmQgMTKk3Q==
X-Received: by 2002:a05:6902:709:: with SMTP id k9mr11385084ybt.121.1581515040074;
        Wed, 12 Feb 2020 05:44:00 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p6sm177786ywi.63.2020.02.12.05.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 05:43:59 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01CDhuSb021777;
        Wed, 12 Feb 2020 13:43:57 GMT
Subject: [PATCH v2] xprtrdma: Fix DMA scatter-gather list mapping imbalance
From:   Chuck Lever <chuck.lever@oracle.com>
To:     andre@tomt.net
Cc:     linux-nfs@vger.kernel.org, iommu@lists.linux-foundation.org
Date:   Wed, 12 Feb 2020 08:43:56 -0500
Message-ID: <158151473332.515306.1111360128438553868.stgit@morisot.1015granger.net>
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

Looking all the way back to 4143f34e01e9 ("xprtrdma: Port to new
memory registration API") and reviewing other kernel ULPs, it's not
clear that the frwr_map() logic was ever correct for this case.

Reported-by: Andre Tomt <andre@tomt.net>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |    6 ++++--
 net/sunrpc/xprtrdma/frwr_ops.c |   13 +++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

Hi Andre, here's take 2, based on the trace data you sent me.
Please let me know if this one fares any better.

Changes since v1:
- Ensure the correct nents value is passed to ib_map_mr_sg
- Record the mr_nents value in the MR trace points

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index c0e4c93324f5..023c5da45999 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -275,6 +275,7 @@ DECLARE_EVENT_CLASS(xprtrdma_mr,
 
 	TP_STRUCT__entry(
 		__field(const void *, mr)
+		__field(unsigned int, nents)
 		__field(u32, handle)
 		__field(u32, length)
 		__field(u64, offset)
@@ -283,14 +284,15 @@ DECLARE_EVENT_CLASS(xprtrdma_mr,
 
 	TP_fast_assign(
 		__entry->mr = mr;
+		__entry->nents = mr->mr_nents;
 		__entry->handle = mr->mr_handle;
 		__entry->length = mr->mr_length;
 		__entry->offset = mr->mr_offset;
 		__entry->dir    = mr->mr_dir;
 	),
 
-	TP_printk("mr=%p %u@0x%016llx:0x%08x (%s)",
-		__entry->mr, __entry->length,
+	TP_printk("mr=%p %d %u@0x%016llx:0x%08x (%s)",
+		__entry->mr, __entry->mr_nents, __entry->length,
 		(unsigned long long)__entry->offset, __entry->handle,
 		xprtrdma_show_direction(__entry->dir)
 	)
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 095be887753e..75617646702b 100644
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
+	dma_nents = ib_dma_map_sg(ia->ri_id->device, mr->mr_sg,
+				  mr->mr_nents, mr->mr_dir);
+	if (!dma_nents)
 		goto out_dmamap_err;
 
 	ibmr = mr->frwr.fr_mr;
-	n = ib_map_mr_sg(ibmr, mr->mr_sg, mr->mr_nents, NULL, PAGE_SIZE);
-	if (unlikely(n != mr->mr_nents))
+	n = ib_map_mr_sg(ibmr, mr->mr_sg, dma_nents, NULL, PAGE_SIZE);
+	if (n != dma_nents)
 		goto out_mapmr_err;
 
 	ibmr->iova &= 0x00000000ffffffff;


