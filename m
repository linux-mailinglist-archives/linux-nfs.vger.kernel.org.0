Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA46172D5A
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgB1Abp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:31:45 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53331 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1Abp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:31:45 -0500
Received: by mail-pj1-f68.google.com with SMTP id i11so443819pju.3;
        Thu, 27 Feb 2020 16:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WwqATJFNRY0o8CWDMEbkFwK645hrNctY2DMp0A7motM=;
        b=C0cRiBpqhONdb/MMZ8K9mptrhhXFYIQ0cBesvpz+Mifh7bYWwlokuGkFZ2VE9LdAMD
         Djbk1KkDxUWXaiPqIJFq+wlMQn2HZWRGWqsdFqxAmXOC+SoAhWF1Z3u78uL5ISxUUlV/
         DQngqUHNupej9AC2G8rX6oC1qfGPQdxk+4n+FtvkUCXOJ7aP+xCB3jLCUwCq8FSoDQt3
         SpUgE2bwwmrxjQgsU+LSo7pVUG9Dwzq2QoGkz7iqGaWJzjozAfS4RfdXJtH0vqpZxi86
         3rVAbvnkuXjV3WeeEwW7hM5+J6eC0u3uAKo19Io4QnH59J3MWwCTmjgi1PVmJRGk/X/d
         SNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=WwqATJFNRY0o8CWDMEbkFwK645hrNctY2DMp0A7motM=;
        b=IlAS2g1+8Ks+OZS5kacoUOgAhLxDK7Lkxd9A2yCdfIWgKgO97R/t7HUF8vM0piwWL7
         Su28w0cGtH85lleWKRPvmsBu72VFH8td9jc9vogRohymCdIHJ3cAfBdTDjlVQoMM3Jw4
         uxwPOS5GM3R5WAIkAJA+1j4+txBARj3mDGeeHlIyh3zU5pHiWngWdl2MUmrith1jiDuM
         Ncxbcr7UiFRPUmHISxldjz65WIyvo33r9Gn21c4D1eOUHxiVPWRXmMLpeflYkqPNpwMt
         8keWa89iyv1XNkzyRk6/g+PrZRH+q2r0VcOdK/Dv4VomrCM3Rm0LBn1BDFOIkFngMyaJ
         +jlQ==
X-Gm-Message-State: APjAAAURGYD2LdiW3QG0VFTdZ3nLtGz7F2f7ZZ2Om8b67KkZ8F9/6lFs
        PzZTya5Cz6KAl3QOweFwKqI=
X-Google-Smtp-Source: APXvYqzLGHLHGKTKihOAy2200HvS/YysMw35F2hSIcCLGDURi/hEqGs5Ybw0dCcijw+Wy94ZZ5+0qA==
X-Received: by 2002:a17:902:ac97:: with SMTP id h23mr1418492plr.237.1582849903095;
        Thu, 27 Feb 2020 16:31:43 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id 199sm8522333pfu.71.2020.02.27.16.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:31:42 -0800 (PST)
Subject: [PATCH v1 11/16] svcrdma: Update synopsis of
 svc_rdma_send_reply_msg()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:31:41 -0500
Message-ID: <158284990128.38468.15361957366190048084.stgit@seurat29.1015granger.net>
In-Reply-To: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
References: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Preparing for subsequent patches, no behavior change expected.

Pass the RPC Call's svc_rdma_recv_ctxt deeper into the sendto()
path. This enables passing more information about Requester-
provided Write and Reply chunks into those lower-level functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index bc8863342878..1035df3a3b5c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -729,13 +729,12 @@ static void svc_rdma_save_io_pages(struct svc_rqst *rqstp,
  */
 static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 				   struct svc_rdma_send_ctxt *sctxt,
-				   struct svc_rdma_recv_ctxt *rctxt,
-				   struct svc_rqst *rqstp,
-				   __be32 *wr_lst, __be32 *rp_ch)
+				   const struct svc_rdma_recv_ctxt *rctxt,
+				   struct svc_rqst *rqstp)
 {
 	int ret;
 
-	if (!rp_ch) {
+	if (!rctxt->rc_reply_chunk) {
 		ret = svc_rdma_map_reply_msg(rdma, sctxt, rctxt,
 					     &rqstp->rq_res);
 		if (ret < 0)
@@ -856,8 +855,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	}
 
 	svc_rdma_sync_reply_hdr(rdma, sctxt, svc_rdma_reply_hdr_len(rdma_resp));
-	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp,
-				      wr_lst, rp_ch);
+	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)
 		goto err1;
 	ret = 0;

