Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8ED90A76
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Aug 2019 23:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfHPVtN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Aug 2019 17:49:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41426 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfHPVtM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Aug 2019 17:49:12 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so9141824ioj.8;
        Fri, 16 Aug 2019 14:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/JfZ5SjXpt5gfI++vXcouK9eBbTLEP3XL3e3yy0wgJg=;
        b=b3arI/U8KPCR6LvOV4wkAX8KYrYfXqPCovnBwybZjQHVMXW9LSDnh3fp3bhIjmoqFE
         1ajvhmNEpmfrvWQaOXL2yKI7EA2JYcgALJDnfjM39qjvdRfx5KCm7Vhcvl8LTK5003lH
         puFBVPL9x7YFRXZ25DgtO+94Z31QznfKmqj0eqWlK3KIyfQrjOrJLOW3Am/2MD2G1Gaf
         OCCwwqK66LyKo/aH+L5lcCOxXykVYmk6FOAM35UThCDm714W6jON3pO7yQIKKFyLlErq
         SzxhrRLHnpphDq0/6dq3/u9RrHw6s4BMqMf+5M+le3X9kZYQnFr2ZD2+eQGWYsX4lMj8
         P1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/JfZ5SjXpt5gfI++vXcouK9eBbTLEP3XL3e3yy0wgJg=;
        b=hVuWV0rmHZjcpbfOV1+asXLJB3ObiRlD1c6nY/gm2qge2iV4Yq7XX3IDK+nXsbiTua
         TVlF/doEIBhae9sUUNaEC8BT6Me7stx53K6DRNj5wmS/0wAsuVy+BS0B81jDttWVXu2w
         Ee4n/7HSF9zGpw/u7PoG/G3Dc66T4zvNuSpyNVHfJqSVuIhMxTLzsAkLqaNY1rUCevE8
         rmCUclbL7rqWnvTBIYocM09HmAlmKj5tBedEJi+2xA0iXeIgsBBBtpuXpy2SkX4iGgST
         BXGreQvMmH5zLYksTjkQGKVMRCrvcjfyi76u2j7ccshdj+sVgHs/1aJ09AIHPgQuiYk7
         Lrjg==
X-Gm-Message-State: APjAAAVWHvSY/+OEtReoatBi7ueZ/3zyVZQMYolz5ru7y+O2uaifDQKo
        XQ7KmhYW+1ZgyCkG0g9Y+a1y2/9p
X-Google-Smtp-Source: APXvYqxCtNHcLOpbCeUvdMHuOB7Th1OP7QidASMJupP6Y/xTsu7D2A8n7qFxyadPbSO0twzJ45lyUg==
X-Received: by 2002:a05:6602:2585:: with SMTP id p5mr4728639ioo.183.1565992152194;
        Fri, 16 Aug 2019 14:49:12 -0700 (PDT)
Received: from seurat29.1015granger.net ([8.46.76.57])
        by smtp.gmail.com with ESMTPSA id y5sm6780214ioc.86.2019.08.16.14.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 14:49:11 -0700 (PDT)
Subject: [PATCH 1/2] svcrdma: Remove svc_rdma_wq
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 16 Aug 2019 17:48:36 -0400
Message-ID: <156599209136.1245.654792745471627630.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: the system workqueue will work just as well.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |    1 -
 net/sunrpc/xprtrdma/svc_rdma.c           |    7 -------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    3 ++-
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 981f0d726ad4..edb39900fe04 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -200,7 +200,6 @@ extern struct svc_xprt_class svc_rdma_bc_class;
 #endif
 
 /* svc_rdma.c */
-extern struct workqueue_struct *svc_rdma_wq;
 extern int svc_rdma_init(void);
 extern void svc_rdma_cleanup(void);
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index abdb3004a1e3..97bca509a391 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -73,8 +73,6 @@ atomic_t rdma_stat_rq_prod;
 atomic_t rdma_stat_sq_poll;
 atomic_t rdma_stat_sq_prod;
 
-struct workqueue_struct *svc_rdma_wq;
-
 /*
  * This function implements reading and resetting an atomic_t stat
  * variable through read/write to a proc file. Any write to the file
@@ -230,7 +228,6 @@ static struct ctl_table svcrdma_root_table[] = {
 void svc_rdma_cleanup(void)
 {
 	dprintk("SVCRDMA Module Removed, deregister RPC RDMA transport\n");
-	destroy_workqueue(svc_rdma_wq);
 	if (svcrdma_table_header) {
 		unregister_sysctl_table(svcrdma_table_header);
 		svcrdma_table_header = NULL;
@@ -246,10 +243,6 @@ int svc_rdma_init(void)
 	dprintk("\tmax_bc_requests  : %u\n", svcrdma_max_bc_requests);
 	dprintk("\tmax_inline       : %d\n", svcrdma_max_req_size);
 
-	svc_rdma_wq = alloc_workqueue("svc_rdma", 0, 0);
-	if (!svc_rdma_wq)
-		return -ENOMEM;
-
 	if (!svcrdma_table_header)
 		svcrdma_table_header =
 			register_sysctl_table(svcrdma_root_table);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 4d3db6ee7f09..30dbbc77ad16 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -630,8 +630,9 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 {
 	struct svcxprt_rdma *rdma =
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
+
 	INIT_WORK(&rdma->sc_work, __svc_rdma_free);
-	queue_work(svc_rdma_wq, &rdma->sc_work);
+	schedule_work(&rdma->sc_work);
 }
 
 static int svc_rdma_has_wspace(struct svc_xprt *xprt)

