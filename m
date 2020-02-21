Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA121689B2
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2020 23:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgBUWAh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Feb 2020 17:00:37 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41260 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgBUWAh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Feb 2020 17:00:37 -0500
Received: by mail-yw1-f68.google.com with SMTP id l22so1787840ywc.8;
        Fri, 21 Feb 2020 14:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=O4FivVr9PbqTlv/QDZKVxg6MRB0GIjWsbe4eUEx1HeY=;
        b=i6g6NU66VRNR/Bl2ORCNzdWyhI7GtAVAZf6MLR0USPThfGOe9A4MpC6MHxjRTRpLe2
         pwBLjnqm7ZqFTTNh3qSRHb9HGcZnoIFPC+gUY1O7+gbrzqQ0tqyjraNMPqHz3wxI6rWG
         93Ar+x5Y1Vp1SdLLwXd+fZ4zVWJbddRkwWk68hLLBuPUVS/On1vSobEjvIzOPKPnjuQp
         nzVOyDge47yiFAjnQoPrbmftbvaJ68YAHDjzT4HMyZLO58JJmpFFI7FSpNG2dXFgNovM
         DRI5tu85LYo9e84d+JygVAFXuiqumUQEZc20Atzh2h9Nv0ujEJbeCVhAh2yS0AzbVydP
         qKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=O4FivVr9PbqTlv/QDZKVxg6MRB0GIjWsbe4eUEx1HeY=;
        b=bnPxPgYRzjhlXLRlQC2Hj+Xm3s3Y5+w4Jre5XWm6bq9jwBGUe86wevTpfZSgBcLg7Q
         LRs5Qb8umyqDNxrhGUw8fgGkUfao9qtfeQ0MIqQgmrvETc+FtXmNne0VRNCe0O260vbx
         cxOSbc1C6SnOhoYSZ7WA3HB/HHxnTKRvmeyk+/2WUBfAPce2BIZQSBx1+7eFM00OEbL0
         +bpkJrVuGpXep4P+/UBcl7RbrMfNLkLd7aROqZaED2+MZTzPni2S5KDMTCy614E/1cOQ
         Fdz/IbGKlS0KTtRnd+mZIY3u1TfoG5719N5vbVKGfOxKIIsXwF5wz7fHxujESQnzPpsF
         HN0Q==
X-Gm-Message-State: APjAAAVfGvbdeZpGcWuvwDxCcWMLF9K6QvkHx7ZVV0JfYBuDXTxUi8S0
        mFbZH8Ty/uY79e6++S930WJQ7foN
X-Google-Smtp-Source: APXvYqziC2d1WDa5CK/ixPrLgQ6gk7rVA0ze9YYu1Pz+bcb9yO/Y827I6SGYKYOZr51ZeusMsmM02g==
X-Received: by 2002:a81:b38a:: with SMTP id r132mr33448970ywh.114.1582322434878;
        Fri, 21 Feb 2020 14:00:34 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w132sm1606647ywc.51.2020.02.21.14.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 14:00:34 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01LM0X7Z018991;
        Fri, 21 Feb 2020 22:00:33 GMT
Subject: [PATCH v1 05/11] xprtrdma: Allocate Protection Domain in
 rpcrdma_ep_create()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 21 Feb 2020 17:00:33 -0500
Message-ID: <20200221220033.2072.22880.stgit@manet.1015granger.net>
In-Reply-To: <20200221214906.2072.32572.stgit@manet.1015granger.net>
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Make a Protection Domain (PD) a per-connection resource rather than
a per-transport resource. In other words, when the connection
terminates, the PD is destroyed.

Thus there is one less HW resource that remains allocated to a
transport after a connection is closed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |   26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index f361213a8157..36fe7baea014 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -363,14 +363,6 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 		rc = PTR_ERR(ia->ri_id);
 		goto out_err;
 	}
-
-	ia->ri_pd = ib_alloc_pd(ia->ri_id->device, 0);
-	if (IS_ERR(ia->ri_pd)) {
-		rc = PTR_ERR(ia->ri_pd);
-		pr_err("rpcrdma: ib_alloc_pd() returned %d\n", rc);
-		goto out_err;
-	}
-
 	return 0;
 
 out_err:
@@ -403,9 +395,6 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 
 	rpcrdma_ep_destroy(r_xprt);
 
-	ib_dealloc_pd(ia->ri_pd);
-	ia->ri_pd = NULL;
-
 	/* Allow waiters to continue */
 	complete(&ia->ri_remove_done);
 
@@ -423,11 +412,6 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 	if (ia->ri_id && !IS_ERR(ia->ri_id))
 		rdma_destroy_id(ia->ri_id);
 	ia->ri_id = NULL;
-
-	/* If the pd is still busy, xprtrdma missed freeing a resource */
-	if (ia->ri_pd && !IS_ERR(ia->ri_pd))
-		ib_dealloc_pd(ia->ri_pd);
-	ia->ri_pd = NULL;
 }
 
 static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt,
@@ -514,6 +498,12 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt,
 	ep->rep_remote_cma.flow_control = 0;
 	ep->rep_remote_cma.rnr_retry_count = 0;
 
+	ia->ri_pd = ib_alloc_pd(id->device, 0);
+	if (IS_ERR(ia->ri_pd)) {
+		rc = PTR_ERR(ia->ri_pd);
+		goto out_destroy;
+	}
+
 	rc = rdma_create_qp(id, ia->ri_pd, &ep->rep_attr);
 	if (rc)
 		goto out_destroy;
@@ -540,6 +530,10 @@ static void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt)
 	if (ep->rep_attr.send_cq)
 		ib_free_cq(ep->rep_attr.send_cq);
 	ep->rep_attr.send_cq = NULL;
+
+	if (ia->ri_pd)
+		ib_dealloc_pd(ia->ri_pd);
+	ia->ri_pd = NULL;
 }
 
 /* Re-establish a connection after a device removal event.

