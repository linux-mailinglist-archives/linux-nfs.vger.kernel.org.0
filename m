Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DE22AC536
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgKITkY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbgKITkY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:40:24 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD3DC0613CF;
        Mon,  9 Nov 2020 11:40:23 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 7so2492910qtp.1;
        Mon, 09 Nov 2020 11:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=tZiyGwrA/U2qRY5Er4ZTvmCWX7cI7UkuFpiSNzAINWs=;
        b=HCB66DsW7QG7+z3rJgYiLrtMAjfEcptRTiMvhodOL5oUMXar/2XjN7kWsCADp1TW1H
         +riTEeI1ZHIg8NLTV1GIir/pG/G/WBNINaFlQOYv5FYYmCBrmbMzsOEHs7ipPy24WDUA
         qkBa0jJvKW0cjRbK/rv5YEn9YxLWfxTKVxXD3MDBO3/6ceEWjDW3Ayfj9KuJmFCadZnq
         yc2pzMpuAfWZ7YrjUKrmSpVoeStkb2wAI8O7VYk+iSf61Ta/UAgcn8xlLvLFOpdD05fy
         Bq56Rajl+mqMsQSsX8UYU/SCjXTgvoYUpu/3tzpWLixP6344FEzXU5Mlsan+laXb15kP
         ofVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=tZiyGwrA/U2qRY5Er4ZTvmCWX7cI7UkuFpiSNzAINWs=;
        b=IqN8lYI9sd3dSe1itpucK3Lde2+zNeaxySFJN3TZhg7YNINJR8Nfjn9XjRrzEJ3zz1
         QQAbnqoyC5It3VmdirJQp6mR6ltra+hwtODFhyYx6c4a4lPZU4WaTx8Zj0HUE/CxtNa5
         L3cKyoHcAIcXM8sFe+cJuog3GSmaIevv1R+sLFNyqowR5zWsnS+lRGu9nkTQGcHp7bC3
         7bep5kDnpT0Tn/NgqaJFk1Vx/ZUs3c7wJ2D0yFmhFKSOD/ysaw0VqR0DFAEqCtoYb2RX
         pFdOheMg4OhdwAwyXhukZYWqomc5ZgynJVqX7o0GPTWUS09rZIKxdfzYoZM5a2zOk/B6
         3Eww==
X-Gm-Message-State: AOAM532xZULUJE7TAWSZ27biRusk/m6vWhutlRUS3Q2AP6NBrUf5f6jZ
        TTt9mF+f5r9Lc8EBB4syx1A/1N0jTaA=
X-Google-Smtp-Source: ABdhPJxXeZdqAvdy03EdymlXrELK7hS8X/M6jknNHsQHsi9xhv8I8VexFtyWMJvxwl5s6aVYm4itRQ==
X-Received: by 2002:ac8:5c50:: with SMTP id j16mr6458333qtj.306.1604950822069;
        Mon, 09 Nov 2020 11:40:22 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y14sm5070796qkj.56.2020.11.09.11.40.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:40:20 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0A9JeJfm021838;
        Mon, 9 Nov 2020 19:40:19 GMT
Subject: [PATCH v1 13/13] xprtrdma: Micro-optimize MR DMA-unmapping
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 09 Nov 2020 14:40:19 -0500
Message-ID: <160495081970.2072548.8942608240215406369.stgit@manet.1015granger.net>
In-Reply-To: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
References: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that rpcrdma_ep is no longer part of rpcrdma_xprt, there are
four or five serial address dereferences needed to get to the
IB device needed for DMA unmapping.

Instead, let's use the same pattern that regbufs use: cache a
pointer to the device in the MR, and use that as the indication
that unmapping is necessary.

This also guarantees that the exact same device is used for DMA
mapping and unmapping, even if the r_xprt's ep has been replaced. I
don't think this can happen today, but future changes might break
this assumption.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   12 ++++++------
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index e93b3457b958..baca49fe83af 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -67,11 +67,11 @@ void frwr_release_mr(struct rpcrdma_mr *mr)
 
 static void frwr_mr_unmap(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 {
-	if (mr->mr_dir != DMA_NONE) {
+	if (mr->mr_device) {
 		trace_xprtrdma_mr_unmap(mr);
-		ib_dma_unmap_sg(r_xprt->rx_ep->re_id->device,
-				mr->mr_sg, mr->mr_nents, mr->mr_dir);
-		mr->mr_dir = DMA_NONE;
+		ib_dma_unmap_sg(mr->mr_device, mr->mr_sg, mr->mr_nents,
+				mr->mr_dir);
+		mr->mr_device = NULL;
 	}
 }
 
@@ -145,7 +145,7 @@ int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 
 	mr->mr_xprt = r_xprt;
 	mr->frwr.fr_mr = frmr;
-	mr->mr_dir = DMA_NONE;
+	mr->mr_device = NULL;
 	INIT_LIST_HEAD(&mr->mr_list);
 	init_completion(&mr->frwr.fr_linv_done);
 
@@ -330,6 +330,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 				  mr->mr_dir);
 	if (!dma_nents)
 		goto out_dmamap_err;
+	mr->mr_device = ep->re_id->device;
 
 	ibmr = mr->frwr.fr_mr;
 	n = ib_map_mr_sg(ibmr, mr->mr_sg, dma_nents, NULL, PAGE_SIZE);
@@ -356,7 +357,6 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 	return seg;
 
 out_dmamap_err:
-	mr->mr_dir = DMA_NONE;
 	trace_xprtrdma_frwr_sgerr(mr, i);
 	return ERR_PTR(-EIO);
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 6a45bf241ec0..94b28657aeeb 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -243,6 +243,7 @@ struct rpcrdma_req;
 struct rpcrdma_mr {
 	struct list_head	mr_list;
 	struct rpcrdma_req	*mr_req;
+	struct ib_device	*mr_device;
 	struct scatterlist	*mr_sg;
 	int			mr_nents;
 	enum dma_data_direction	mr_dir;


