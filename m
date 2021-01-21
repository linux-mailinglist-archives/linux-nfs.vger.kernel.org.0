Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B641A2FF3E8
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 20:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbhAUTLR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 14:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbhAUTLH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 14:11:07 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5C3C061788
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 11:10:27 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c128so2445257wme.2
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 11:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g8P88sp+8apegiLqVYCkvxoqom/NYU/MhhmjOAc/rTA=;
        b=GAsQTs9ZnU4o9blg0z/z0aXltgvyeUgVzMbD7Ee2z2ippHLkSbvsqxNZ5jYDSpbOxm
         B94q4VchO39YK3oFa1mRIAbBs+DyxyNhGcRDKPOoBF14ZjCDE21aE7N93FKGTMHg+dPM
         OBgtueZE1W9SQVZ7P32YNHfqMWAFNiRnvaZ9gl/R1HfCysWCtyNOO+PGG1GrnjOsTdHK
         E63yobWtq9z/a1R/WxpJugAMhSnrhCoFP6vvGhEwiSTI5VP6rlkoahTf1iLIQfesOkeB
         IvuvJK0lroARDtsjK7rkWCTlemrjWUm3etABKxeXmVYlz+JtM89HiH/U5hz9SXDo2SgP
         izBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g8P88sp+8apegiLqVYCkvxoqom/NYU/MhhmjOAc/rTA=;
        b=jAlBmzdBAsMmw6ErGjUOVSXmJBiOj3suNZngEFk3xX1dsgNA/FnNcGcCOHd2q3dGpY
         Xzp5Fu4ZIfL6lSRS3anvRiBB0K3fNRc7ct9H2jsNgI0JoGLvCw1kF0zBebNA/yXYIz0+
         AKk2USxY/BEHdGO13M5AI5Fcy9EvleNkNMmC2BeVScZhgtX72vDA4F1v1f7Ka0ja0x/z
         lIdRFpr0VVcbnkiSP/TH6jWf/tQB4RzDXEl0tfWOCI5NgMsr8DW3qP45OMOe5lHpBP8s
         VU8JYqh1k/s8+iAyBNMyIMAt39N0mTclXbsgtw5y3rLDvtNlA5+uQws89u0CfFkh17rP
         DB3Q==
X-Gm-Message-State: AOAM5332N5lwUM0//YKbweZzh7s1enraeLwlRc88aUL1yM4BMyY7luL6
        Paw5g3hekmhym7R+JnfguG+yCnVyp0SN3Qgl
X-Google-Smtp-Source: ABdhPJwACOKj9H9l0tt0km8LiGBmGFjsCkykdBfgZ9FikpY0aRMort2CWvui2jh0+qSLkFRmU3vGrg==
X-Received: by 2002:a1c:a90f:: with SMTP id s15mr756035wme.154.1611256225810;
        Thu, 21 Jan 2021 11:10:25 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id d30sm11160353wrc.92.2021.01.21.11.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:10:25 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: [PATCH v1 2/5] xprtrdma: Bind to a local address if requested
Date:   Thu, 21 Jan 2021 21:10:17 +0200
Message-Id: <20210121191020.3144948-3-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121191020.3144948-1-dan@kernelim.com>
References: <20210121191020.3144948-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Until now, rpcrdma did not make use of the local address when binding a
QP. For subnets where the local machine has multiple IP addresses that
are all connected to the same subnet, it may be desired to tell from
which interface a QP is going out.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 net/sunrpc/xprtrdma/transport.c |  7 +++++++
 net/sunrpc/xprtrdma/verbs.c     | 15 ++++++++++++++-
 net/sunrpc/xprtrdma/xprt_rdma.h |  2 ++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 78d29d1bcc20..45726ab5f13a 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -355,6 +355,13 @@ xprt_setup_rdma(struct xprt_create *args)
 	xprt_rdma_format_addresses(xprt, sap);
 
 	new_xprt = rpcx_to_rdmax(xprt);
+
+	/* Copy source address if specified */
+	if (args->srcaddr) {
+		new_xprt->rx_has_srcaddr = true;
+		memcpy(&new_xprt->rx_saddr, args->srcaddr, args->addrlen);
+	}
+
 	rc = rpcrdma_buffer_create(new_xprt);
 	if (rc) {
 		xprt_rdma_free_addresses(xprt);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index ec912cf9c618..64476161cf92 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -314,6 +314,7 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
 	unsigned long wtimeout = msecs_to_jiffies(RDMA_RESOLVE_TIMEOUT) + 1;
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
 	struct rdma_cm_id *id;
+	struct sockaddr *saddr = NULL;
 	int rc;
 
 	init_completion(&ep->re_done);
@@ -324,7 +325,19 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
 		return id;
 
 	ep->re_async_rc = -ETIMEDOUT;
-	rc = rdma_resolve_addr(id, NULL, (struct sockaddr *)&xprt->addr,
+	if (r_xprt->rx_has_srcaddr) {
+		char buf[0x50] = {0, };
+		saddr = (struct sockaddr *)&r_xprt->rx_saddr;
+
+		rpc_ntop(saddr, buf, sizeof(buf));
+
+		dprintk("xprt=%p, source address port %s\n", xprt, buf);
+	}
+
+	dprintk("xprt=%p, %s:%s resolving addr\n", xprt,
+		rpcrdma_addrstr(r_xprt), rpcrdma_portstr(r_xprt));
+
+	rc = rdma_resolve_addr(id, saddr, (struct sockaddr *)&xprt->addr,
 			       RDMA_RESOLVE_TIMEOUT);
 	if (rc)
 		goto out;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 94b28657aeeb..cb4539d4740a 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -421,6 +421,8 @@ struct rpcrdma_stats {
  */
 struct rpcrdma_xprt {
 	struct rpc_xprt		rx_xprt;
+	struct sockaddr_storage rx_saddr;
+	bool			rx_has_srcaddr;
 	struct rpcrdma_ep	*rx_ep;
 	struct rpcrdma_buffer	rx_buf;
 	struct delayed_work	rx_connect_worker;
-- 
2.26.2

