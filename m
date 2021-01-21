Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0D62FF3E7
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 20:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbhAUTLP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 14:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbhAUTLG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 14:11:06 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1032EC061786
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 11:10:26 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c128so2445212wme.2
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 11:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIv4doyMamsrAkZ+XiCAT/k8Wh6Lzr5DiAqhvZAFiGU=;
        b=kG/RbXYvqpUzLqz5NEtIbmb58eS/WnaQSqsdjt1V80/cY+PAot2fvDeBkzjcA6F0/1
         siLoG+LFqKeY1Z6j28ZgC7U9P3F1ElN7KTCe+jACH3dIfbrfirk59+gy+nyvhhr8lXX0
         m8k/88JCkQ3KGsy4Tk0HZI38VuL+Gc1r4PvlziWX1wFYu1FYAbSHM387GWRJnLXMP0rq
         cmW+KXaeqnWCKFnJ7lxWS7ER1s9tZucvlR4ksrdUyuz0KKXSoSfkUtXmu7J/3v24vw+H
         Beaiwe0TSiDyp+lTRDLVW1dB4KURfIUC6QeN4ZxlBehPp4FEVaWRUjBdnIKEmvc3fUSb
         7jBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIv4doyMamsrAkZ+XiCAT/k8Wh6Lzr5DiAqhvZAFiGU=;
        b=as8erSpyzAyLbI3J4QKhEX2eHv8Rvb/7n81/TJA/dVRr/phX4jZEplM1dXCAiNNqY5
         ZvbHrWN/MiKU7ZEl4g+UogPULkfmFdn/WtQAvX3U9osRZL2zo2Ur8y/lNoTu8BJg2GEb
         EDycpkomi/U287PO0aIruBoAF74ZJduxCI14JjIKpKPjg5UzfyYYL8zUxIwmy24VcySs
         XaLmEc54m3ZV61p3pyTCpN71FWgJJY2pwU5YfteTqnO5L4jQNlkAsI5yPmQGhy9s6QZX
         riESO3a2MQ9I6CoRQFWdoKZ7jtdVvjpgzPqxd42Q1PnJ4Ke3BUlyCc84WCvyDYsjPM+Z
         3BsA==
X-Gm-Message-State: AOAM531GkwyK2/0FqDzpjTSBJ6NZBYEeHRufWFiF3+EhdrYH9Ui7N7XI
        9okAQqyOGOGfJLoEj0IrC6+RKVWs2haK/7ja
X-Google-Smtp-Source: ABdhPJx1E6tyGU/GLSdzcN47Ef0TBrFPZUrQ+w4h3tWDByHLflSPGNPv48ZgH2Y5E/E1zsrJl4aqPA==
X-Received: by 2002:a1c:5456:: with SMTP id p22mr724938wmi.81.1611256224409;
        Thu, 21 Jan 2021 11:10:24 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id d30sm11160353wrc.92.2021.01.21.11.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:10:23 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: [PATCH v1 1/5] sunrpc: Allow specifying a vector of IP addresses for nconnect
Date:   Thu, 21 Jan 2021 21:10:16 +0200
Message-Id: <20210121191020.3144948-2-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121191020.3144948-1-dan@kernelim.com>
References: <20210121191020.3144948-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This adds an `rpc_portgroup` structure to describe a group of IP
addresses comprising one logical server with multiple ports. The remote
endpoint can be in a single server exposing multiple network interfaces,
or multiple remote machines implementing a distributed server architecture.

Combined with nconnect, the multiple transports try to make use of the
multiple addresses given so that the connections are spread across the
ports.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 include/linux/sunrpc/clnt.h |  9 +++++++
 net/sunrpc/clnt.c           | 47 +++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 02e7a5863d28..f8c0c33281a8 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -115,12 +115,21 @@ struct rpc_procinfo {
 	const char *		p_name;		/* name of procedure */
 };
 
+#define RPC_MAX_PORTS 64
+
+struct rpc_portgroup {
+	int nr;
+	struct sockaddr_storage addrs[RPC_MAX_PORTS];
+};
+
 struct rpc_create_args {
 	struct net		*net;
 	int			protocol;
 	struct sockaddr		*address;
 	size_t			addrsize;
 	struct sockaddr		*saddress;
+	struct rpc_portgroup    *localports;    /* additional local addresses */
+	struct rpc_portgroup    *remoteports;   /* additional remote addresses */
 	const struct rpc_timeout *timeout;
 	const char		*servername;
 	const char		*nodename;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 612f0a641f4c..5f335a873f03 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -500,6 +500,44 @@ static struct rpc_clnt *rpc_create_xprt(struct rpc_create_args *args,
 	return clnt;
 }
 
+struct rpc_clnt_portgroup_iter {
+	struct rpc_portgroup *pg;
+	int idx;
+};
+
+static void take_iter_portgroup_addr(struct rpc_clnt_portgroup_iter *iter,
+				struct sockaddr	**address)
+{
+	struct rpc_portgroup *pg = iter->pg;
+	struct sockaddr	*existing = *address;
+	struct sockaddr	*new;
+
+	if (!pg || pg->nr == 0)
+		return;
+	if (iter->idx >= pg->nr)
+		iter->idx = 0;
+
+	/* Take port from existing address, or use autobind (0) */
+	new = (struct sockaddr *)&pg->addrs[iter->idx++];
+
+	switch (new->sa_family) {
+	case AF_INET:
+		((struct sockaddr_in *)new)->sin_port =
+			existing ? ((struct sockaddr_in *)existing)->sin_port
+			         : 0;
+		break;
+	case AF_INET6:
+		((struct sockaddr_in6 *)new)->sin6_port =
+			existing ? ((struct sockaddr_in6 *)existing)->sin6_port
+			         : 0;
+		break;
+	default:
+		return;
+	}
+
+	*address = new;
+}
+
 /**
  * rpc_create - create an RPC client and transport with one call
  * @args: rpc_clnt create argument structure
@@ -522,6 +560,8 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 		.servername = args->servername,
 		.bc_xprt = args->bc_xprt,
 	};
+	struct rpc_clnt_portgroup_iter iter_localports = { .pg = args->localports };
+	struct rpc_clnt_portgroup_iter iter_remoteports = { .pg = args->remoteports };
 	char servername[48];
 	struct rpc_clnt *clnt;
 	int i;
@@ -573,6 +613,10 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 		xprtargs.servername = servername;
 	}
 
+	/* If localports or remoteports are specified, first entry overrides */
+	take_iter_portgroup_addr(&iter_localports, &xprtargs.srcaddr);
+	take_iter_portgroup_addr(&iter_remoteports, &xprtargs.dstaddr);
+
 	xprt = xprt_create_transport(&xprtargs);
 	if (IS_ERR(xprt))
 		return (struct rpc_clnt *)xprt;
@@ -595,6 +639,9 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 		return clnt;
 
 	for (i = 0; i < args->nconnect - 1; i++) {
+		take_iter_portgroup_addr(&iter_localports, &xprtargs.srcaddr);
+		take_iter_portgroup_addr(&iter_remoteports, &xprtargs.dstaddr);
+
 		if (rpc_clnt_add_xprt(clnt, &xprtargs, NULL, NULL) < 0)
 			break;
 	}
-- 
2.26.2

