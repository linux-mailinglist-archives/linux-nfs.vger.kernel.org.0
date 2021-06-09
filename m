Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B0A3A1F6D
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 23:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhFIVzX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 17:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhFIVzV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Jun 2021 17:55:21 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2453BC061760
        for <linux-nfs@vger.kernel.org>; Wed,  9 Jun 2021 14:53:26 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id k5so14673019iow.12
        for <linux-nfs@vger.kernel.org>; Wed, 09 Jun 2021 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K/Jq3HAYXNGdn+LtxxcKe5mHX2msEUoBvTHdlrtw9RU=;
        b=DGblcGY4OFekTORnk76L9JfrXCwEQrGselmRl+3TCRhHgKrmvQMyFVqXDm1SHogCnb
         LlcZ95u0fVVteAQFrf6u7g+GJRz5oJyL7MSKwabljjaBK2ZVxAO9O+y4E/ZUmau38EcW
         0ms7VcdDu/FKVVKO5niDY5nPKwRXERCb8piWtScOt32bxUnqEEQE3z6mmkDrc7hL3FK7
         GGPH/l2uoJemQXAlW3w8BysqDGW/eIB7ZgBPlO/0mR2xGrLvZcXAZlP4fRyTF/WXpsvx
         L8CE/oo8BJx2xg0RpKtgBsteUdSjK8KVrQKV7XuFB1ANqrgOMm8SZUKjHXXQ7ul2hCi2
         kyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K/Jq3HAYXNGdn+LtxxcKe5mHX2msEUoBvTHdlrtw9RU=;
        b=Z6tKPn52Syd8cl0RWHNgl+A5f742RxVFehSNCYg51zMOOAL2/jPPPoS1zzcdVqNw1V
         TI7UWL8T87f9mydrIkhPUDDFxRF5MsiaN2aBrogD5IS7feJyapBwcwr/D2EXdiYcG5d5
         /53pSjrFXPRcTFX9a2iH0umGhu2MZCuUGToIn0qHvzaAIm5tU14F1rZGBmrO2V57UeEr
         eG/DHV0Qij2vuyE5NU2itPtHB6N3xbjcKFIaKG3kRrT/y/9L6uK4Jz9kWLWGRPtltBUM
         mMcf37JKIwxV+oZv6xalhmutDkxvQzaskFe5m2i5UZS7DI17228MfgwcAq/Bleq69iRF
         f6cw==
X-Gm-Message-State: AOAM532hCejeyXp4L9X7i5jrQsHKZVjx0bBLpo9jJ3Yftqdoc2FtgYAa
        orBwMBhh+fSL5ZB4OZfG8sI=
X-Google-Smtp-Source: ABdhPJyyjY3rW901cQDVQpg4WJwliz0rXL9CQdtNQ8VzeRs9PXL2bvjOhRcbpFPjP0Jc9Imjl8MeNw==
X-Received: by 2002:a5e:8d02:: with SMTP id m2mr1187514ioj.9.1623275605577;
        Wed, 09 Jun 2021 14:53:25 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id w25sm619743iox.18.2021.06.09.14.53.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 14:53:25 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/3] NFSv4.1+ add trunking when server trunking detected
Date:   Wed,  9 Jun 2021 17:53:19 -0400
Message-Id: <20210609215319.5518-4-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

After trunking is discovered in nfs4_discover_server_trunking(),
add the transport to the old client structure if the allowed limit
of transports has not been reached.

An example: there exists a multi-homed server and client mounts
one server address and some volume and then doest another mount to
a different address of the same server and perhaps a different
volume. Previously, the client checks that this is a session
trunkable servers (same server), and removes the newly created
client structure along with its transport. Now, the client
adds the connection from the 2nd mount into the xprt switch of
the existing client (it leads to having 2 available connections).

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4client.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 640c8235d817..ece283cd45c8 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -361,6 +361,33 @@ static int nfs4_init_client_minor_version(struct nfs_client *clp)
 	return nfs4_init_callback(clp);
 }
 
+static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
+{
+	struct sockaddr_storage clp_addr, old_addr;
+	struct sockaddr *clp_sap = (struct sockaddr *)&clp_addr;
+	struct sockaddr *old_sap = (struct sockaddr *)&old_addr;
+	size_t clp_salen;
+	struct xprt_create xprt_args = {
+		.ident = old->cl_proto,
+		.net = old->cl_net,
+		.servername = old->cl_hostname,
+	};
+
+	if (clp->cl_proto != old->cl_proto)
+		return;
+	clp_salen = rpc_peeraddr(clp->cl_rpcclient, clp_sap, sizeof(clp_addr));
+	rpc_peeraddr(old->cl_rpcclient, old_sap, sizeof(old_addr));
+
+	if (clp_addr.ss_family != old_addr.ss_family)
+		return;
+
+	xprt_args.dstaddr = clp_sap;
+	xprt_args.addrlen = clp_salen;
+
+	rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
+			  rpc_clnt_test_and_add_xprt, NULL);
+}
+
 /**
  * nfs4_init_client - Initialise an NFS4 client record
  *
@@ -434,6 +461,10 @@ struct nfs_client *nfs4_init_client(struct nfs_client *clp,
 		 * won't try to use it.
 		 */
 		nfs_mark_client_ready(clp, -EPERM);
+		if (old->cl_mvops->session_trunk &&
+		    (rpc_clnt_xprt_switch_nactive(old->cl_rpcclient) <
+		    old->cl_max_connect))
+			nfs4_add_trunk(clp, old);
 	}
 	clear_bit(NFS_CS_TSM_POSSIBLE, &clp->cl_flags);
 	nfs_put_client(clp);
-- 
2.27.0

