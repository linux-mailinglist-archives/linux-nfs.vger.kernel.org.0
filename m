Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8ECF1D00AE
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgELVXC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728220AbgELVXB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:23:01 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E97CC061A0C;
        Tue, 12 May 2020 14:23:00 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id ep1so7228197qvb.0;
        Tue, 12 May 2020 14:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9mmPVJ7AXhJKSRjZ7YCmZe+7ZE3UVCX5QvDqCSfsE+Y=;
        b=IiHVmuBPFJNurHvTyLACuWwBuplaEqopBuK4HzwxEo0qaz6tWfjcjyurTY5RF6CDgu
         nZHwhKzyfl/RfkPlSalnhf/6pzRJ0bh1nzprfpK7obWZ8u65dg5hmuqVQKU/hTdMMJZp
         sLhQAoLAfyzj5hB2g6wSCEK0AvyGFMtxh58lOUGQyEVKVL7mJyafEC/Az6gOSQm/Zy7R
         2JTmyKlo0c2i5iMCTbBgjvcUjsH0TPOIabF5krgq4LQnRzBjCnrDEd8s/CzK+vioImrV
         6Fq2jrwSvegXwZCGTT7FT8XbHPvDQM7T3ThIfCi4TXl0dqiFxaGa4MEIRPbOXBIWNTc8
         OShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=9mmPVJ7AXhJKSRjZ7YCmZe+7ZE3UVCX5QvDqCSfsE+Y=;
        b=cZ5nl97xU2DimDh0XgBXt14SC+Rk6fQ/cVXS4g/jclUgXmW/5WoFtFVa8dUJWrZctR
         w60m9sGbyibEs+7hl0+3Zh4bLW5RJZaVParWzGlwvD1JsoEXPZKsZVDl6qkWFALXoLXT
         ZYjhDdfoa54MN2gtGaw5hdYATfBY6Qvt+/stZKbJ+JKysPJBN4WkMjZ3jkO0eCKiQWtL
         5WkoXQI6TpHBP3hGZ58HK7h1SieOfoC4BvZTA3K1XRunUQhhI/PvioP/8S2LiLzC6DIK
         6ki6KrjTeDte4mFeySqxx6kdpxDrS1i8DEWPni6lG2z1Rnx10YTonnbKKfNpNm9xwfYs
         VoDw==
X-Gm-Message-State: AGi0PuZJfibKORTrux627E9M3TZ/ta+XgqVmTGVtdB5jqEcmopnXLd/D
        dR7N2lWESL53qz35tj5Ce8rN4DXy
X-Google-Smtp-Source: APiQypK2i3sjMg6fCIhrGeSATLxzRvbjS7TMvawi+2aDKJQJ1q8i6Esh+bj3xbtPySH3NKAYBuZIUA==
X-Received: by 2002:ad4:4e4d:: with SMTP id eb13mr22377090qvb.169.1589318579123;
        Tue, 12 May 2020 14:22:59 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i24sm7622994qtm.85.2020.05.12.14.22.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:22:58 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLMv90009904;
        Tue, 12 May 2020 21:22:57 GMT
Subject: [PATCH v2 10/29] svcrdma: Displayed remote IP address should match
 stored address
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:22:57 -0400
Message-ID: <20200512212257.5826.13180.stgit@klimt.1015granger.net>
In-Reply-To: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
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

