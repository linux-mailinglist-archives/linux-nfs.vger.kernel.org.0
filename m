Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF131E918C
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgE3N3E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgE3N3E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:29:04 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE0FC03E969;
        Sat, 30 May 2020 06:29:04 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d7so2311249ioq.5;
        Sat, 30 May 2020 06:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9mmPVJ7AXhJKSRjZ7YCmZe+7ZE3UVCX5QvDqCSfsE+Y=;
        b=S9X9uWZKPnqkSF+Zopk/lhimL29CJL4dj7ceiwTmzGfAi74wgabSBN3060P8iBvIIC
         eJogzUvju3HRwVyvY54H9nhx9HaP9xZ0B6FGX83VPwwH+gew8ytlbJZle09URITYV6Rr
         u2111m6Tzujf8V55PGQcvyjg3ZGqA3Mj/Itdxt5SAmMQIiX+1fV7EtJZY5pdGOQTsayi
         I7WX14f0H0/ubDiz7JQTXOgYL4bXCwNKrsW3WlZYtlB4SUaJ+0RXoGLl1/Wm8NNdJRAS
         3sTiiAbDuIFpbxjIY7173ivccjYCUZc79BUasU/Veiq9/9L/NmePgXqNNg45GH2/qTGX
         5nQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=9mmPVJ7AXhJKSRjZ7YCmZe+7ZE3UVCX5QvDqCSfsE+Y=;
        b=MzGm80pDLgLnmbnXCgpdVyODx6T7/4EeyPywSeY1hWSvG2X5BMrt9iUW8JWnFCPrUZ
         n/YgCA7p5rdYvhJlJA3FOc8o0eGKGAf5cK42zmxTrDkwsMjLH2kYPH7B4FKvDk2O8Lr2
         P8nz83heSGLi0rTR2hLHbw+BK3pOSf33B5xXFhF2f3e4LhrQC6lFq/wZe16FmXC0hwt5
         jj8wl+XYEDbugOAA7g8gy6mEjEXVy1f8en626scUUBstPHBSaxN/Tfht78TAykh2zmwO
         IyGoKRiUGyUPrm0rOpvZL6QmnRoqSf0YeYz3lgHCrvjK7dpOz41ieA1MOCVZt8XvhqCA
         8kLA==
X-Gm-Message-State: AOAM533wdWExkM1SPOrR6jYbIC8xOy8dqctVKLhAK06JhZvF+1IEe/7u
        5T79shhXa/15ljYFVUqgeBxuVWc+
X-Google-Smtp-Source: ABdhPJyFRhFHs3jawJ/1JyJSTOI4AFL1jrWg5SgyG3M8PtvoBCrgZE1WTxSzrv1SlOO//ktuL+1nZw==
X-Received: by 2002:a5d:88c5:: with SMTP id i5mr10869401iol.137.1590845343437;
        Sat, 30 May 2020 06:29:03 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p69sm3039420ili.75.2020.05.30.06.29.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:29:03 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDT2OG001417;
        Sat, 30 May 2020 13:29:02 GMT
Subject: [PATCH v4 11/33] svcrdma: Displayed remote IP address should match
 stored address
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:29:02 -0400
Message-ID: <20200530132902.10117.78346.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: After commit 1e091c3bbf51 ("svcrdma: Ignore source port
when computing DRC hash"), the IP address stored in xpt_remote
always has a port number of zero. Thus, there's no need to display
the port number when displaying the IP address of a remote NFS/RDMA
client.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index ea54785db4f8..0a1125277a48 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -211,7 +211,12 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
 	newxprt->sc_ord = param->initiator_depth;
 
 	sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
-	svc_xprt_set_remote(&newxprt->sc_xprt, sa, svc_addr_len(sa));
+	newxprt->sc_xprt.xpt_remotelen = svc_addr_len(sa);
+	memcpy(&newxprt->sc_xprt.xpt_remote, sa,
+	       newxprt->sc_xprt.xpt_remotelen);
+	snprintf(newxprt->sc_xprt.xpt_remotebuf,
+		 sizeof(newxprt->sc_xprt.xpt_remotebuf) - 1, "%pISc", sa);
+
 	/* The remote port is arbitrary and not under the control of the
 	 * client ULP. Set it to a fixed value so that the DRC continues
 	 * to be effective after a reconnect.

