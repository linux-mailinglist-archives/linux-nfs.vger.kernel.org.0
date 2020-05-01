Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4D41C1BC6
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgEARdl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728495AbgEARdk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:33:40 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00210C061A0E;
        Fri,  1 May 2020 10:33:39 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ck5so5039291qvb.11;
        Fri, 01 May 2020 10:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DBCaK7pbCwMuwP6HQRx0Jo8MIPjemXKq5oiMN0wKyEc=;
        b=YvGTyLYHhAJD4VrOP3i08HZMyTysOSxIbiKY7KXwB8OqEPJMA5vZAyuQf5+09QEtKG
         A/rKWiKq7Qts/Pk/qktKda6OVcLsoulSDUOHxEoHcTgvkvbuSwnYj6MBspKpwLRmOWR7
         +oeM9mpOomnVpDJmdzGEqSjIn8OeLp7flHCsxPjh8GP58zNietveM2YrWlOXv19a6e1M
         p3K+8OazJMCiiZY8MMwl0wwpToB1sqveRYwq+BNgDiCrdPSi1/tTbXsGkwdGrSuw0fNl
         FWjGdGgy5FmD6lLTM75Ir/G7i7PQrXOdfgvOGyp5//C5OapSoCs/5Ex/m8O+7ReH+frS
         gfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=DBCaK7pbCwMuwP6HQRx0Jo8MIPjemXKq5oiMN0wKyEc=;
        b=unM7svCe6XoXvaNyh1cTCJhHa8uUhcnd0hYGS8npFN0xNIP2KwKqGV/UR3GmqGmQGO
         hc4VXDuxwGcVjr67PVUceaOP4rkTZ4Y6RKHEf6OpB2XSe7HlvwDfGUSRPaSJdqsot8lB
         P+Db3Hc13SaSO4ClmWirIIywa8bLsIls37Pifw7x/3dxga+uL9t/qDElzFEVbWq4fHzO
         ktltG+70kINIM05rOP6JaAt1STfPWvQPPmIoNiOgKGKdF3wgfWkFvzXtn6OutnqBUUXR
         KwueT4/JimdhgmltjuT/1TGoPEwvO4NyFuSEINlkYHgr93aLt83JedvMpnlczDmpc0o0
         0yeg==
X-Gm-Message-State: AGi0Pua9ME4IAERiV7xPtOvH3a645igwmXWEYVo5zKHN+bsUh85qjVWr
        tq1sijxHehoc5D4G0QoSSskwGY1P
X-Google-Smtp-Source: APiQypKTHdxR3b23BoTUslj+SlqCsA/irFvUJbdGu9w1jsizPCK62ezHEaJsvT+J0HDMhWQHWYCuVQ==
X-Received: by 2002:ad4:45ac:: with SMTP id y12mr4950493qvu.227.1588354419080;
        Fri, 01 May 2020 10:33:39 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e8sm3013948qkl.57.2020.05.01.10.33.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:33:38 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HXbfh026709;
        Fri, 1 May 2020 17:33:37 GMT
Subject: [PATCH v1 3/7] svcrdma: Displayed remote IP address should match
 stored address
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 01 May 2020 13:33:37 -0400
Message-ID: <20200501173337.3798.58834.stgit@klimt.1015granger.net>
In-Reply-To: <20200501172849.3798.75190.stgit@klimt.1015granger.net>
References: <20200501172849.3798.75190.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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

