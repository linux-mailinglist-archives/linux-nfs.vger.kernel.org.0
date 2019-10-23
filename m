Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B497E1D94
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2019 16:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406294AbfJWOBz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 10:01:55 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35037 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406291AbfJWOBz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 10:01:55 -0400
Received: by mail-il1-f195.google.com with SMTP id p8so9283130ilp.2;
        Wed, 23 Oct 2019 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=8xOtVfElgegdlYVCvXxCRw3XNeazMIod/nhi4MX7A4U=;
        b=Kb4UayIufqSlyYCYcOplCa/avWF3PxxNSKJTLdZ+zP7CBJ+TToVKlGDKW5gP33D9Pb
         m5Td+6sHTNce9hKuy4VZ/zcpM+ppr4/K60w/YmoLQI/XOLAuvf9FFl06SQ6dZ44aq0Ei
         mQVtH6P5Z+QU1uZ3yaVdiZ45D/2g5q7FaeyHkziZNfeDOrKb9hjfHOYSSqtnRvLvPFAo
         zTVK4DPJ2bDi9jVM3BYFlXLgDdKWHVlyJkgSc5VFMIhWRRsXCMykRQM0w+bn4iNnp6yR
         7oPoh+6F/+B7Ga6uDhbj+iVVW9GyzkJ+txyN8UURYCTQLn150RagfmIj6lj2Trx1uFi2
         6pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=8xOtVfElgegdlYVCvXxCRw3XNeazMIod/nhi4MX7A4U=;
        b=UZBBBxRMPDKpbix9yOcP6vXJcDyG6C1bxkltwrXXt9QNt/xYrupdLTknRvinBXsx0Y
         sErNb2g/26LvN0pKZNCKWjE3e175QeP9JkR7J807ENw3tvSV3XFkTdHs8wm1D/H2DZj/
         E0IeH8xf91xj36hwyZTKnKleyHCih/k7r7WipryHMU1nh13BrhwtnuBRWC6H4TiY8vTj
         Pk7+N9XOcNVV5F5wpt4RZSZwgrygwFCTCHgkuoFpl9TL51vkszfh23FIAphfIxj+iTIr
         wNLwzHLOSzyhYePfXGYBYl63jxpwV81O/El4EC2LamIPe6HIXtTCU52ksaaGTHymDso4
         zC0g==
X-Gm-Message-State: APjAAAWkE9PIEQNkHfnAUvVAi6GJ9u02Rv3DcLtZ+0v98SPyo5Du1j3c
        RPVkfFDOz2hpY0w1icd6OJgeI/ev
X-Google-Smtp-Source: APXvYqwRij65gXo5jaXP12YCgHvXUoAqyNPun+iiNc0w541eFX7OR2EFIL2I3d3y4DyX0M+wrfpCbw==
X-Received: by 2002:a92:502:: with SMTP id q2mr38394179ile.44.1571839313833;
        Wed, 23 Oct 2019 07:01:53 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f1sm9492363ile.77.2019.10.23.07.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 07:01:53 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x9NE1q9Y012541;
        Wed, 23 Oct 2019 14:01:52 GMT
Subject: [PATCH v1 1/5] xprtrdma: Wake tasks after connect worker fails
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 23 Oct 2019 10:01:52 -0400
Message-ID: <20191023140152.3992.17041.stgit@manet.1015granger.net>
In-Reply-To: <20191023135907.3992.69010.stgit@manet.1015granger.net>
References: <20191023135907.3992.69010.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Pending tasks are currently never awoken when the connect worker
fails. The reason is that XPRT_CONNECTED is always clear after a
failure return of rpcrdma_ep_connect, thus the
xprt_test_and_clear_connected() check in xprt_rdma_connect_worker()
always fails.

- xprt_rdma_close always clears XPRT_CONNECTED.

- rpcrdma_ep_connect always clears XPRT_CONNECTED.

After reviewing the TCP connect worker, it appears that there's no
need for extra test_and_set paranoia in xprt_rdma_connect_worker.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/transport.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 0711308..361e591 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -243,16 +243,13 @@
 	rc = rpcrdma_ep_connect(&r_xprt->rx_ep, &r_xprt->rx_ia);
 	xprt_clear_connecting(xprt);
 	if (r_xprt->rx_ep.rep_connected > 0) {
-		if (!xprt_test_and_set_connected(xprt)) {
-			xprt->stat.connect_count++;
-			xprt->stat.connect_time += (long)jiffies -
-						   xprt->stat.connect_start;
-			xprt_wake_pending_tasks(xprt, -EAGAIN);
-		}
-	} else {
-		if (xprt_test_and_clear_connected(xprt))
-			xprt_wake_pending_tasks(xprt, rc);
+		xprt->stat.connect_count++;
+		xprt->stat.connect_time += (long)jiffies -
+					   xprt->stat.connect_start;
+		xprt_set_connected(xprt);
+		rc = -EAGAIN;
 	}
+	xprt_wake_pending_tasks(xprt, rc);
 }
 
 /**

