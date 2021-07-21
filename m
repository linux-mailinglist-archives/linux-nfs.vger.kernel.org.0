Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3AC3D14E3
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jul 2021 19:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhGUQcr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Jul 2021 12:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGUQcr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Jul 2021 12:32:47 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8547EC061575
        for <linux-nfs@vger.kernel.org>; Wed, 21 Jul 2021 10:13:23 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id s193so2757414qke.4
        for <linux-nfs@vger.kernel.org>; Wed, 21 Jul 2021 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zvcx2JjoLNdSPbM4lUY1qn/nh450vILfONJu9nENnn8=;
        b=gLrM0/hwlqMF/fCXGD7otfxBrKVhoNRchlPpL9d7o3gWTVviHxF38U1Yw8qNuLG7+T
         /L26AAE4dDu2MRkAMBnp8rgJsxUTVrK4vZlF8a5pJlexOuyREIRZTcBDFBOYXyjH2R6e
         XW/jE9/Fq0AFX9AhgptICsIwLeNF0Am6o5Nlg06C8ZSOdJwHghvk7fOiqpvlEqXDJw95
         gDj799X1zNCRP/dtmy8zQDX7IXRVGQsRmq5WfJXSmv5bErokcH4mFkALcy1FyAn6QsCF
         0NaTfGUial1rM9QVFcFZ9Al9c05Rxuc8wC+HKvPjuyS1FZ6e2JJU82u+ORqXJ0d/0c4R
         0NcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=zvcx2JjoLNdSPbM4lUY1qn/nh450vILfONJu9nENnn8=;
        b=LM3Y3svaAdPmcYQZ3kLo5SZKJDZ25H6btYgVaaUiUGuQFTC4SZSfMiCoFlzNkxtNTO
         qw9BdoxdYLZt19hvFi43X+vTiirohJr8QHMf45UKzx3DYLYx8hRki/Kq5xmI6TjPrGZY
         YnY58CxxpkufUxOS2Lly6vgr1f1VDc9a9mWsRUABxFu3MMFnWn868zuJSDn82JgV0l/P
         vVWHka2XwnEOhj64t5ilXU3cEahzl3LO6swl51h1V7pidsAa60GV6v83oEZT1kAJMJAa
         rJGgiidte/ASPukdwaLLbrXCnYXkaKGGX6IUuV/FgTe02mGu08h0fm3ND1bIMqbXd8vL
         mnCw==
X-Gm-Message-State: AOAM532vRH3xknGL4ikugiBCM19BP9iRdjBIrQ1tEK1PaaI/hx2rOSi1
        dFDPqHb0mMAmjLoPngHu1+s=
X-Google-Smtp-Source: ABdhPJzZ9Wo2Etwy3agGO4DPEWa+cWAXzLLnBWC0Ag3MDi386sKdoxI95bVDti6P/XIRj6flzXqNiQ==
X-Received: by 2002:a05:620a:4089:: with SMTP id f9mr34998696qko.441.1626887602555;
        Wed, 21 Jul 2021 10:13:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id o17sm3550617qko.100.2021.07.21.10.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 10:13:22 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH] sunrpc: Fix return value of get_srcport()
Date:   Wed, 21 Jul 2021 13:13:20 -0400
Message-Id: <20210721171320.173876-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Since bc1c56e9bbe9 transport->srcport may by unset, causing
get_srcport() to return 0 when called. Fix this by querying the port
from the underlying socket instead of the transport.

Fixes: bc1c56e9bbe9 (SUNRPC: prevent port reuse on transports which don't request it)
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/xprtsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index e573dcecdd66..02b071dbdd22 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1656,7 +1656,7 @@ static int xs_get_srcport(struct sock_xprt *transport)
 unsigned short get_srcport(struct rpc_xprt *xprt)
 {
 	struct sock_xprt *sock = container_of(xprt, struct sock_xprt, xprt);
-	return sock->srcport;
+	return xs_sock_getport(sock->sock);
 }
 EXPORT_SYMBOL(get_srcport);
 
-- 
2.32.0

