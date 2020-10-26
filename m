Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7F52995EE
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790978AbgJZSyJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:54:09 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36390 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790972AbgJZSyG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:54:06 -0400
Received: by mail-qv1-f68.google.com with SMTP id ev17so4819997qvb.3;
        Mon, 26 Oct 2020 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sEDE7+ACL+xJFfG4qz46x0tNWG9y9S9DlLiy1LgVxXw=;
        b=DTIoIjAFwkf5REDTKO4hGxNtQX2IqCp28VxAIQa8ATyCOdg06T7pmKA6GyygUBchvr
         Xcl5BRHyaAIsj//r6vt4c2WRrOVl2U5zy+Eqozmcr6uqVTokoH1zBh9R0Gwr+sV7RMP7
         +j7nJUesCoUcVudL/1kORVbB1uQLmI5MV4y+X8OBej/8k4BiTehx0m+3DpriPHCCteGC
         j/trTUt94bu3ma6UwPLpwL1zBG+ncSlsG2S+eE8gUJIz8OiKOklNx2aaS/xdvBT0TjFQ
         5xGzwKK8ZBjzJk77azqUR7114vQP2udPaAhXKjuaVzSr30xzGko1286CQJXJoyg/hLAr
         wufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=sEDE7+ACL+xJFfG4qz46x0tNWG9y9S9DlLiy1LgVxXw=;
        b=e6HMhjCz1Yo96f/R+OVLLE/OQIdzYUzNlAS0V7KGk6K88cCHbHWOMlzG/5yxqR+WYr
         XQdCb29ulw8zJA5D7Kl3VLUOuwyvb5SWOlVH26GTrM1BytbX3ppz2eHK4fHyvyIT2sjq
         LD/Yu2dj6O+grJYkYsJIGgVMmOJLU/JgGY8dPFPC3jBwZWH0rNBBXHv3K/1MmDYjX1dW
         M2znNrcgaX1hEomB1mDSqO9xtsD6g8Y0r6PmOoYne2TSDuJl57H7N7LONeIhKuXwsX42
         dvMVJ3Urax5K8BSTriou+pVwJh5wMtj1/vma2WUEA3QYtA2++rSKgSM/oTl4IysKRqhK
         uZYA==
X-Gm-Message-State: AOAM530wHLN4iRmUrH811xokdfrBjKPHC/eDU6j9kH/hMNJG9qsPKEPg
        c1TX+DSc2qsmt/b2gE72oyN+QQasYmM=
X-Google-Smtp-Source: ABdhPJwS0xdtI+/pG1erCjV8nwW7lK7gR8pk7s54k8P1HLMb077j+eEGW+xaRZcyta1OldWs2r6G3g==
X-Received: by 2002:ad4:45ca:: with SMTP id v10mr15245143qvt.48.1603738445317;
        Mon, 26 Oct 2020 11:54:05 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v14sm6996695qta.44.2020.10.26.11.54.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:54:04 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QIs3Cu013619;
        Mon, 26 Oct 2020 18:54:03 GMT
Subject: [PATCH 02/20] svcrdma: Const-ify the xdr_buf arguments
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:54:03 -0400
Message-ID: <160373844359.1886.5240330169912563769.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Ensure the code in rw.c does not modify the argument, and
enable callers to also use "const struct xdr_buf *".

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 80a0c0e87590..d8b2e22c56c1 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -197,7 +197,7 @@ struct svc_rdma_write_info {
 	__be32			*wi_segs;
 
 	/* SGL constructor arguments */
-	struct xdr_buf		*wi_xdr;
+	const struct xdr_buf	*wi_xdr;
 	unsigned char		*wi_base;
 	unsigned int		wi_next_off;
 
@@ -405,7 +405,7 @@ static void svc_rdma_pagelist_to_sg(struct svc_rdma_write_info *info,
 				    struct svc_rdma_rw_ctxt *ctxt)
 {
 	unsigned int sge_no, sge_bytes, page_off, page_no;
-	struct xdr_buf *xdr = info->wi_xdr;
+	const struct xdr_buf *xdr = info->wi_xdr;
 	struct scatterlist *sg;
 	struct page **page;
 


