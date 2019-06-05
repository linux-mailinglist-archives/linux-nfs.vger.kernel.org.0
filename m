Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C00435C64
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2019 14:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfFEMPV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jun 2019 08:15:21 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54885 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfFEMPV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jun 2019 08:15:21 -0400
Received: by mail-it1-f195.google.com with SMTP id h20so3058229itk.4;
        Wed, 05 Jun 2019 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=zG4wigzJxgTAcavpBwrBFDzi/70vZq5e8SmdFpJmHBA=;
        b=CK/yeOnPR31/E2qmGJ51zZJ9SDfbyGyERsc35TS5TKkznYk8B52qwvgbqrxAA3rSq2
         Kv2sR04beYZ4IUSOnY8+0s5m0+ECXxVjt7n9cwKiSruh9Ci1Z7/loFlvgeELftx2XUm+
         rd06r0xrY2C1NG6w9QsUbVWChH9kMijR27MGL/ksDXzDjs7A+xst0FAPl9FxHuWwO0cF
         qE/Qq+Rsd9oIDoXsXxLaRFemUgj7uvEjid3GvsrvPchDK8T+clhuX0c9b7A63TJwX17I
         EPs7am/5oaZrxUT+g+wUT7f9Yhvj2rh99GVdpPFia3fXs6W6seTNMrUSTUz8D+jN1pAu
         SyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zG4wigzJxgTAcavpBwrBFDzi/70vZq5e8SmdFpJmHBA=;
        b=iE8Mtgf42etZA2Auwf8B6x9XAN2eiriPHQOgihK7U3Go23h8MaQHDargU++aGvCyiw
         rqd0LMh3iNRZhtmmE809w+uo6J2/DMf3qI0u66qF1QotT8RkhMSaUCYH3eM3+JKwiYUo
         jumJ8gBRqm28hwWRXv1JVtNeivQdH5j7g9tmeJblnX6M9hM2KesOm1Zp0qCnnpMNEMi0
         3p6qG4715xKmPIfxfPZLAKWbKmPVOsAs+VhzD8lwO06lk/9BQM8C2iLdCk8jplp0PP3o
         UIwYEqSvCkhUquVboFO9vlns33fhp+PaDwhMxkSXVlZZkGi+pFNUdh3g2kEIdM9np+9l
         Sqvg==
X-Gm-Message-State: APjAAAVVhFZK2jOHuAkiKqWyzBughi8NwZvipIInSrc1RFbmHhKez2t1
        PVS9D/oV0d3Ea83pWZcNDwkEkN5j
X-Google-Smtp-Source: APXvYqzvvU7DUt265d+O+Xkgx0ojPY1yXRqpTMol7sMznlzv6sq+r3nzNameVuoPiHMJ4uQVRAiE0A==
X-Received: by 2002:a24:720a:: with SMTP id x10mr5583791itc.161.1559736920487;
        Wed, 05 Jun 2019 05:15:20 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e188sm7221227ioa.3.2019.06.05.05.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 05:15:19 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x55CFImc004658;
        Wed, 5 Jun 2019 12:15:18 GMT
Subject: [PATCH RFC] svcrdma: Ignore source port when computing DRC hash
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 05 Jun 2019 08:15:18 -0400
Message-ID: <20190605121518.2150.26479.stgit@klimt.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The DRC is not working at all after an RPC/RDMA transport reconnect.
The problem is that the new connection uses a different source port,
which defeats DRC hash.

An NFS/RDMA client's source port is meaningless for RDMA transports.
The transport layer typically sets the source port value on the
connection to a random ephemeral port. The server already ignores it
for the "secure port" check. See commit 16e4d93f6de7 ("NFSD: Ignore
client's source port on RDMA transports").

I'm not sure why I never noticed this before.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 027a3b0..1b3700b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -211,9 +211,14 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
 	/* Save client advertised inbound read limit for use later in accept. */
 	newxprt->sc_ord = param->initiator_depth;
 
-	/* Set the local and remote addresses in the transport */
 	sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
 	svc_xprt_set_remote(&newxprt->sc_xprt, sa, svc_addr_len(sa));
+	/* The remote port is arbitrary and not under the control of the
+	 * ULP. Set it to a fixed value so that the DRC continues to work
+	 * after a reconnect.
+	 */
+	rpc_set_port((struct sockaddr *)&newxprt->sc_xprt.xpt_remote, 0);
+
 	sa = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
 	svc_xprt_set_local(&newxprt->sc_xprt, sa, svc_addr_len(sa));
 

