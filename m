Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 941B572005
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2019 21:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbfGWTVN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jul 2019 15:21:13 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44457 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbfGWTVM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jul 2019 15:21:12 -0400
Received: by mail-ua1-f66.google.com with SMTP id 8so17421832uaz.11;
        Tue, 23 Jul 2019 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=uuVV5Bzj1+ed+zYOSSjrRJ4SQAKc7kcdflVmOgtoRHc=;
        b=f6ME7pCGpRCXx0sxMNLrM9/tj23/PD1rUUpLDekxxHMuF1VvL6OEpb1Q753el+9KDd
         X/tLlPCxH1tlkwvvl95t2fyDOu5ib7UP6sSK3Or+MpD0x7R1iG6QLyzHx18jTudBcxnl
         pD0Hp8y/4RSGyrJgr8QR3TusAHaLfwmk75qy5xM02nNhgx4onhmElFKBEq77FTo4nBPv
         NtmeU7HJHnnrD+RvS9ogAbnBC1O2OMvfFmDyLvDmq+Q0ltjXV35sOQQ7+rsKMwK7fmMN
         L2A46cQKjEpl/LybdkIihzGv/EC7vZ3BYu/exHkov5uBw/45Iy/0MCi0mhFteX44Jaus
         6T5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=uuVV5Bzj1+ed+zYOSSjrRJ4SQAKc7kcdflVmOgtoRHc=;
        b=F6VKmbLdvlgyAsPX/0rQuMDiX1YMmDRveITAXWrbk8apzo1chz9ldmwjK9ivjy/nAj
         n3FtifZ1lt3Sma3qQZ58nyiiQ0LcOuUFV+3zdhSDrVG9mLeHq7WBGGaUFgJRUHvywa5r
         kqE+aMtvLph5REWhWo4RqPGddGQRnDv/svq8G+UWT83Ylhw1O0rHAWoKrfLfqjQ+6m42
         TuyM8ZbBeMcTcanIgwZGhTXkpcZEdk+x3Vrm5UxGza9oxWqEKZswS6AZeY9rN3NJdKL2
         D7hrQQ0bSKlsqkxTbBjQH2OpqkgvbI6nQDigXKh9j05OT2lU86EhW/2p0Vq6n8haOrFH
         yFFg==
X-Gm-Message-State: APjAAAX46P5mCd2gJboDPcdU5jV+ylSvLpSaoeGLt6iQbJg/WrKSur6g
        StCkp3sp6i7tXZlU279///XQnz1gOI8oNw==
X-Google-Smtp-Source: APXvYqxx0zgSUEWKfp2lQKg2Ac4IGPijsue7PnSm2js5uNlckYdN2Wi9V7iXY0M0GulFjHrep332PA==
X-Received: by 2002:ab0:3484:: with SMTP id c4mr50433023uar.51.1563909671652;
        Tue, 23 Jul 2019 12:21:11 -0700 (PDT)
Received: from seurat29.1015granger.net (dhcp-82c9.meeting.ietf.org. [31.133.130.201])
        by smtp.gmail.com with ESMTPSA id o5sm5032911uar.4.2019.07.23.12.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 12:21:11 -0700 (PDT)
Subject: [PATCH v1 1/2] svcrdma: Remove svc_rdma_wq
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 23 Jul 2019 15:20:50 -0400
Message-ID: <156390963067.6811.7659055442275585873.stgit@seurat29.1015granger.net>
In-Reply-To: <156390950940.6811.3316103129070572088.stgit@seurat29.1015granger.net>
References: <156390950940.6811.3316103129070572088.stgit@seurat29.1015granger.net>
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
index 7df6de6e9162..f8e48d6824a0 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -632,8 +632,9 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 {
 	struct svcxprt_rdma *rdma =
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
+
 	INIT_WORK(&rdma->sc_work, __svc_rdma_free);
-	queue_work(svc_rdma_wq, &rdma->sc_work);
+	schedule_work(&rdma->sc_work);
 }
 
 static int svc_rdma_has_wspace(struct svc_xprt *xprt)

