Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8EE1DCFDC
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgEUOej (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgEUOei (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:34:38 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE7DC061A0E;
        Thu, 21 May 2020 07:34:38 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 4so7307281ilg.1;
        Thu, 21 May 2020 07:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9mmPVJ7AXhJKSRjZ7YCmZe+7ZE3UVCX5QvDqCSfsE+Y=;
        b=IbeldQmX/1KhF5MO26MMYXbpLuxUygK0jtz+DZEP7VrLOT10AoLyFWLBXSqBpopA4w
         +VVPbeuLTGIBf3X79AUsYmbf7R+vNxLCzZOKkerEafqZTtAqfIS5acBNm6xym1FPbAVk
         68Sq334nr0GSX8Ez1ox059TOVFSvgsIzpskyNBJy1i2c1yTdH4TG/Vj2k6e/pqSEvTwP
         +15ryS8dB6IEjYfcAQSJufE6pehfcsAiOxqiqPsoWkfP/sU+t0lv0GWWNxaFl1qNQdSy
         nkU10nL1O9BGw81x+MZqXqsWVDVCOljxpOaYECI9K9Kd7o4q0E73JMsHlNCpHYWwQBug
         pAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=9mmPVJ7AXhJKSRjZ7YCmZe+7ZE3UVCX5QvDqCSfsE+Y=;
        b=DJ22o0HxEFYcdZCPIhsv6DGWESMFpcx88KwXu771bI5a/IL6VkXSfRUpzsB+K+0tnG
         3Negd1B1HeFvrPam7CCZ/aJ3i73M2aTv+Eg3HlDj1R6KYZpXWwBAAwipJ5AYaJfT1IZ8
         LRvuL/R4Sjgk4NqubwzNy7PnE4XPIRw9twMNLntdnuK4yBrgZ1vP7r6T42803su5EY0I
         QuFakybMK2sGFjUBi0dA1dr9GQRfOKlHXVDfLRuEhjoHg2J44Qz+lcCgwV5ny31xQ5km
         IMlBm3N5SPeo7ooIoxBdYs2u723t0svfRZbwO7q7Z/DRC9Zj262knAuMon+Bx4J2CmHM
         /yhA==
X-Gm-Message-State: AOAM5325CaweN9Z67VE8NgqQCfsdoCIoz2mxVFc7u2MBBuRhEfMCXAIo
        U+DORc1rBRQZ0NtfcT28Wd6I5LBe
X-Google-Smtp-Source: ABdhPJyYWt8qBWtUE1NB2lYhmNQGMHUCYscb+F2vO5KU+N7r63nqX8/zzEtif+agAggCOf/17nG5jA==
X-Received: by 2002:a92:cac6:: with SMTP id m6mr8995589ilq.1.1590071677822;
        Thu, 21 May 2020 07:34:37 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y12sm3177751ilk.16.2020.05.21.07.34.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:34:37 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEYaYx000849;
        Thu, 21 May 2020 14:34:36 GMT
Subject: [PATCH v3 10/32] svcrdma: Displayed remote IP address should match
 stored address
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:34:36 -0400
Message-ID: <20200521143436.3557.71314.stgit@klimt.1015granger.net>
In-Reply-To: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
References: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
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

