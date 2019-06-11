Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5993D01A
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390815AbfFKPBT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:01:19 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51537 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390957AbfFKPBT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:01:19 -0400
Received: by mail-it1-f195.google.com with SMTP id m3so5464997itl.1;
        Tue, 11 Jun 2019 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=b4a9DkrCCwe6w246gNCpjHh4zXaKH+i/tvnha2k8DNU=;
        b=m5T1aSrKiMohZ0hSRKEKCRublrH+/Gyx7hSrFrskpQ1IFDYh0yVghEy9+Q0yTFKrHE
         JU/ffa3FyI2+bOqs6S8//eVcgHBy9YvUQUX1CUBuHIDrymXYnOt8zsRQfGU1G6jQvngO
         7Y4E0MUcVfzQDgGUEyOddnx0iwFwBVkYKjTkYPtymYbW6i0sc9BKm76syczKpKAOArgc
         WWFuO8vagEZSByllaVuu7CXKWQ5LgNu+jMbcrpFAoQg7IQ5edevNkcK3OEeaBVxokp37
         xy4NiCdAIF7Cxn5eojki7IYE7vX585SKX5xjAVht+ezeykzOsNb+vMaUs72Q5nu+8pPo
         J5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=b4a9DkrCCwe6w246gNCpjHh4zXaKH+i/tvnha2k8DNU=;
        b=R50oHyAjICp8RGa0n3oQOg89RlbS5XGg0ABUxnXxdFxDawIwJWYBgzfTkKk4yMiQeN
         NT3n1qNio7kL964Mt4gwvlVV/Cfne1eMvaQ6Yh92GWwgYn/DtC27yrqIU1A3ceyO17e7
         fn445doHmahYmSGnuqjL/E9ouANqDhgX+iv7+eFm4MS88czdedincuLjpIcNsM6YXrLo
         pIwy0ceYqhiRC2bHXPTYDAakDezYeVqgr5gQGR6/nHLDbt45uQJlxyQecMmwQdxgwyKy
         XDiicythxq+JE9IxMvxAlFnX1vtESQ/TTF+0jvFT+2/Y4tbZwGPy0U+DuxprS+4j00xI
         mK+A==
X-Gm-Message-State: APjAAAX8bcVItQTflO6xG0hpNY5PxVYXqkJc5/GwCC+0hE7G8W7cx9eu
        7T9cshzFrMbV1BAEfAeQ5a0yb6gj
X-Google-Smtp-Source: APXvYqwjLIPjBgeKBC3vBYq6YnRwuRXRZxjRYsF/FZu1h4oB7sLsVDbtWquBP3Wr3AQoqKvAw8rw/w==
X-Received: by 2002:a02:380c:: with SMTP id b12mr29958240jaa.85.1560265278302;
        Tue, 11 Jun 2019 08:01:18 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m129sm1326052itd.6.2019.06.11.08.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:01:17 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF1GrR021712;
        Tue, 11 Jun 2019 15:01:16 GMT
Subject: [PATCH v2] svcrdma: Ignore source port when computing DRC hash
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:01:16 -0400
Message-ID: <20190611150116.4209.63309.stgit@klimt.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The DRC appears to be effectively empty after an RPC/RDMA transport
reconnect. The problem is that each connection uses a different
source port, which defeats the DRC hash.

Clients always have to disconnect before they send retransmissions
to reset the connection's credit accounting, thus every retransmit
on NFS/RDMA will miss the DRC.

An NFS/RDMA client's IP source port is meaningless for RDMA
transports. The transport layer typically sets the source port value
on the connection to a random ephemeral port. The server already
ignores it for the "secure port" check. See commit 16e4d93f6de7
("NFSD: Ignore client's source port on RDMA transports").

The Linux NFS server's DRC resolves XID collisions from the same
source IP address by using the checksum of the first 200 bytes of
the RPC call header.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org # v4.14+
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 027a3b0..0004535 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -211,9 +211,14 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
 	/* Save client advertised inbound read limit for use later in accept. */
 	newxprt->sc_ord = param->initiator_depth;
 
-	/* Set the local and remote addresses in the transport */
 	sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
 	svc_xprt_set_remote(&newxprt->sc_xprt, sa, svc_addr_len(sa));
+	/* The remote port is arbitrary and not under the control of the
+	 * client ULP. Set it to a fixed value so that the DRC continues
+	 * to be effective after a reconnect.
+	 */
+	rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
+
 	sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
 	svc_xprt_set_local(&newxprt->sc_xprt, sa, svc_addr_len(sa));
 

