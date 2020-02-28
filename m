Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 932AD172D43
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgB1Aat (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:30:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43080 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1Aas (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:30:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id s1so729873pfh.10;
        Thu, 27 Feb 2020 16:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7Tl6CT9IsO+dzMDBFGszYkcdJnK5mt31G6SnF6ZysW4=;
        b=ptFrkJODPhpYFuImd1f5SP/eycjHt4qP28j5fN7PCS0ILCa0gjSjU+8qq+sIyLO7NB
         0pnSy9k7coEEqx6QATEKziTM/UFvgHl6ia/unFaPX277Y/micfeonyqWXiWTM6pVj9q9
         E+h/ZWbyDCKe5kMRGmN6o8T1jg66CwJHtAf4J5iVz8H93GlE4APQ0HLABeKA/wjivM/M
         f1nN3tJ9X+dJRQGnB3ZmkMM1BU+DEwo00Nrup0wI7LWT118+ENl1JJrQgTjX4LdWxCYh
         nj8zmT5GO06th7hqjUOYLwfY9QlaB6sJqUPCI4l1j9NwyPwv3lm42TPq97dibZQN45su
         LrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=7Tl6CT9IsO+dzMDBFGszYkcdJnK5mt31G6SnF6ZysW4=;
        b=s1hjZUfudZ8S0o4ZG62i2V8AE3dLzOFIghTKkIizd+t7Pt/FGthCo87hNSvU/o7c2b
         nlg75pi6sOCzTb8LgIxcC2RWWAIz87FBkpxppBw3gHmt2IvYkBM02mH2wp0nWV3nVK/H
         L3JXR3icoFPJL8QXl9CMOhbffdb+LMMUGwp28hKhvBChKHa0UIxT9EiBNjrrdafEMnQT
         SOQfJmFvCaWpsamaoZPaBwjseGhDakTLXVKvxalOflN0M5iVT/kUmOAn+5ds1uv7wmgQ
         hPDke5JIWW0W88zgx3UjXgmbugGKqnc86GzgXJx7dN9PGRZTO4SPouITpx5k9/z+ZUCX
         N5dQ==
X-Gm-Message-State: APjAAAWSuhSlpAtEwtF1JY95wRNKqzCWNtQFhzcsxx5U3ywEekX84EkM
        ebfJD6h9SMG5nOgnGR7Fis8=
X-Google-Smtp-Source: APXvYqw91piUdOoAWzdxkAIyWZ4DZLV+/Dmtw6DtjtCrPnUPMvlkfetMmTA4pomV/qsZ1HqFp5D2Dw==
X-Received: by 2002:a63:cc4c:: with SMTP id q12mr1840352pgi.443.1582849847748;
        Thu, 27 Feb 2020 16:30:47 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id h2sm7826833pgv.40.2020.02.27.16.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:30:47 -0800 (PST)
Subject: [PATCH v1 03/16] svcrdma: Fix double svc_rdma_send_ctxt_put() in an
 error path
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:30:45 -0500
Message-ID: <158284984592.38468.654235622058128742.stgit@seurat29.1015granger.net>
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

This error path is almost never executed. Found by code inspection.

Fixes: 99722fe4d5a6 ("svcrdma: Persistently allocate and DMA-map Send buffers")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index a11983c2056f..354c5619176a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -786,7 +786,6 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 				   struct svc_rqst *rqstp)
 {
 	__be32 *p;
-	int ret;
 
 	p = ctxt->sc_xprt_buf;
 	trace_svcrdma_err_chunk(*p);
@@ -798,13 +797,7 @@ static int svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	svc_rdma_save_io_pages(rqstp, ctxt);
 
 	ctxt->sc_send_wr.opcode = IB_WR_SEND;
-	ret = svc_rdma_send(rdma, &ctxt->sc_send_wr);
-	if (ret) {
-		svc_rdma_send_ctxt_put(rdma, ctxt);
-		return ret;
-	}
-
-	return 0;
+	return svc_rdma_send(rdma, &ctxt->sc_send_wr);
 }
 
 /**

