Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D2DF59E9
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2019 22:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfKHVcI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Nov 2019 16:32:08 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44769 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfKHVcH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Nov 2019 16:32:07 -0500
Received: by mail-yb1-f195.google.com with SMTP id g38so3409411ybe.11
        for <linux-nfs@vger.kernel.org>; Fri, 08 Nov 2019 13:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kY/SzJUCIsYRSiw736CwKmHg2w2sLucgkoqiohoP+mw=;
        b=j3VWAyjrk2Xivm9bbbHp8k+e36eu5asrCex9MnOcfmr/MAboL1Di7R283Iz18s25MV
         HQ20cwUMg/f2IHJqb62gGw57azlHNZM2XpY1Cl0PWoJxfSArzKILOVOMbsYrP0N41Bi+
         kHoS7LRyvxSHgcuTQShDJZ50iXowsx3LqBABoFuWd66i+u+Ksa4aAEvYIiQXDxdOnj7c
         sRp3JgAUjuzn4psTnud1t0EC2rF5S1E2o+5GU40ELnHQWOE4nlCuoGGOp11b4myqRDsw
         i3E3N8NcT6ndy1S2dL2Ckora+jMaHatxvMWjyfeqqCZVm1IJl27hND6taDEaihbHOKux
         xkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kY/SzJUCIsYRSiw736CwKmHg2w2sLucgkoqiohoP+mw=;
        b=HS9pFwK8no/yZ/8dZOGe2JYKK9FuQRVtV11yP0LArKq7varmngSJohihYq8QlhM/yL
         FaWHogBVVfuRKT9wV/AxmGukmcEV79lfY4HdYArIl0UITzniG6bOsyWrrqC9kcpkc5Xt
         XHN7YfZwBRNuFPveRnNoM10/TsITroLNUXbX94AWETR/KJVfOpVjiVKn/U4yZ0BL+szG
         YBsGntCxptbZn5RCA4oJZ3/eTCym1r6s71Syswb2YQD8a+MzERIvSTvsX4sP/AQZ6dNr
         7e3Rxh+P0pit54lixYhL1OsoUowj19QDYRiGkvM5iyUKdASwvrwuRkYBm0oW1YcvLKUl
         HPOw==
X-Gm-Message-State: APjAAAUs9eMBy3LkiXtLHvzwXUaQ1AxM5tY/q3zxKYOgHZ7GCQhsLwbu
        9owC4z5c89BG16BCDAHXOTtr6JfK
X-Google-Smtp-Source: APXvYqx4TXuaigwkdx0/QJgqJlJBDq4HjEZDCJSs5K1BbuAxc3NNEdy5bjJ9C593zv0HkFVdOuMM7A==
X-Received: by 2002:a25:7383:: with SMTP id o125mr11163048ybc.8.1573248726590;
        Fri, 08 Nov 2019 13:32:06 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id d4sm3226748ywl.0.2019.11.08.13.32.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 08 Nov 2019 13:32:05 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH] NFS: allow deprecation of NFS UDP protocol
Date:   Fri,  8 Nov 2019 16:32:01 -0500
Message-Id: <20191108213201.66194-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a kernel config CONFIG_NFS_DISABLE_UDP_SUPPORT to disallow NFS
UDP mounts.

I took the same approach as Chuck's deprecation of DES enc types
to start with default to still allow but I think the ultimate
goal is to disable

Question: how do we have folks trying this unless we set it to false?

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/Kconfig  | 10 ++++++++++
 fs/nfs/client.c |  4 ++++
 fs/nfs/super.c  |  8 ++++++++
 3 files changed, 22 insertions(+)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 295a7a2..6320113 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -196,3 +196,13 @@ config NFS_DEBUG
 	depends on NFS_FS && SUNRPC_DEBUG
 	select CRC32
 	default y
+
+config NFS_DISABLE_UDP_SUPPORT
+	bool "NFS: Disable NFS UDP protocol support"
+	depends on NFS_FS
+	default n
+	help
+	  Choose Y here to disable the use of NFS over UDP. NFS over UDP
+	  on modern networks (1Gb+) can lead to data corruption caused by
+	  fragmentation during high loads.
+	  The default is N because many deployments still use UDP.
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 02110a3..24ca314 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -474,6 +474,7 @@ void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
 			to->to_maxval = to->to_initval;
 		to->to_exponential = 0;
 		break;
+#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
 	case XPRT_TRANSPORT_UDP:
 		if (retrans == NFS_UNSPEC_RETRANS)
 			to->to_retries = NFS_DEF_UDP_RETRANS;
@@ -484,6 +485,7 @@ void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
 		to->to_maxval = NFS_MAX_UDP_TIMEOUT;
 		to->to_exponential = 1;
 		break;
+#endif
 	default:
 		BUG();
 	}
@@ -580,8 +582,10 @@ static int nfs_start_lockd(struct nfs_server *server)
 		default:
 			nlm_init.protocol = IPPROTO_TCP;
 			break;
+#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
 		case XPRT_TRANSPORT_UDP:
 			nlm_init.protocol = IPPROTO_UDP;
+#endif
 	}
 
 	host = nlmclnt_init(&nlm_init);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index a84df7d6..21e59da 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1011,7 +1011,9 @@ static void nfs_set_port(struct sockaddr *sap, int *port,
 static void nfs_validate_transport_protocol(struct nfs_parsed_mount_data *mnt)
 {
 	switch (mnt->nfs_server.protocol) {
+#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
 	case XPRT_TRANSPORT_UDP:
+#endif
 	case XPRT_TRANSPORT_TCP:
 	case XPRT_TRANSPORT_RDMA:
 		break;
@@ -1033,8 +1035,10 @@ static void nfs_set_mount_transport_protocol(struct nfs_parsed_mount_data *mnt)
 			return;
 	switch (mnt->nfs_server.protocol) {
 	case XPRT_TRANSPORT_UDP:
+#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
 		mnt->mount_server.protocol = XPRT_TRANSPORT_UDP;
 		break;
+#endif
 	case XPRT_TRANSPORT_TCP:
 	case XPRT_TRANSPORT_RDMA:
 		mnt->mount_server.protocol = XPRT_TRANSPORT_TCP;
@@ -2204,6 +2208,10 @@ static int nfs_validate_text_mount_data(void *options,
 #endif /* CONFIG_NFS_V4 */
 	} else {
 		nfs_set_mount_transport_protocol(args);
+#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
+		if (args->nfs_server.protocol == XPRT_TRANSPORT_UDP)
+			goto out_invalid_transport_udp;
+#endif
 		if (args->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
 			port = NFS_RDMA_PORT;
 	}
-- 
1.8.3.1

