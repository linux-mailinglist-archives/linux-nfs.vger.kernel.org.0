Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 370FC10A618
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Nov 2019 22:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfKZVnl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Nov 2019 16:43:41 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40903 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKZVnl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Nov 2019 16:43:41 -0500
Received: by mail-yw1-f65.google.com with SMTP id n82so7537691ywc.7
        for <linux-nfs@vger.kernel.org>; Tue, 26 Nov 2019 13:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VbKxFY0uUX2h9j8O347r3fIZXI3UFNSdmwwfgo++oMA=;
        b=P0YRae2oDgKm91kolyp28+QhTUwQdWKnuvQVoe0UMI8ejICaBeOb4d+BigDz4LBTBi
         IWKr3ytJdbHE6exKYFRGNnietJQs4PgyGhuRDiHPdUHANHy1gHSve2rKjliW5sN82RXP
         O09Gnq7RZoW5QQSUeUUvAYRg8yIkkYHZ2hwRYB+02WNvodCwFPeTexHkZTfYU30EALLZ
         euD5vhSFOJ2RKwTejuLb4nWaHoImCBdKk+/ZIqZ03TQovg9VvEncK/7uD6eWE0YJFamR
         IBqWdo2WWa9l3ffEUVNTdrDaULMaQx/iwbFYZAuPjcKL6eOAhb2CBUhHu4NsLQPlcNRh
         Q+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VbKxFY0uUX2h9j8O347r3fIZXI3UFNSdmwwfgo++oMA=;
        b=aSzd2a+wRh2n3jxDwLqYXb9hjvHbwNrLnBssFzHN8snwhzUZy7BLU1bslC3sMzU5ms
         paKv6hAK9n2t0KKbXEK0cuxcpdDH5LOOGmwr4kw3mklXDTLRZGKzGkcF7o+/Dj2aKKsA
         n0DTBTvNc6j2sQtPx1fW6jnMZD4cd9VBTarctT5mELVw83mYzL9dgl4NRS+UBBynyc7O
         J5xaWVjtwESkH2Gl3uq5X1G5iw9l0tYah3lx/LHYSwaeChKdxWl0eKmMsn01vKNupjZo
         SIGw+3uBHwauXPxEct3kvt8AJbdXGtc/H806MKOPApAvaLWxv5WEeOXnXcWWAPmHqadq
         3SIQ==
X-Gm-Message-State: APjAAAUEiTn+/E3ar2fplweFmbpy2xYpASfgch98dN/pCLtIC70h4xkT
        HgXVp3f0KOV2hHSPHpHD7ukyBQIe
X-Google-Smtp-Source: APXvYqz8i9PCkk+tzHaJOsr3BlTFThNUpvupnpF32Zp+vuZUUfRyMyq5TjM+DwTNJNnbCPBONZ3A7w==
X-Received: by 2002:a0d:ead1:: with SMTP id t200mr608672ywe.1.1574804619233;
        Tue, 26 Nov 2019 13:43:39 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id j79sm5880122ywa.100.2019.11.26.13.43.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Nov 2019 13:43:38 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/1] NFS: allow deprecation of NFS UDP protocol
Date:   Tue, 26 Nov 2019 16:43:36 -0500
Message-Id: <20191126214336.9067-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Add a kernel config CONFIG_NFS_DISABLE_UDP_SUPPORT to disallow NFS
UDP mounts and enable it by default.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/Kconfig  | 9 +++++++++
 fs/nfs/client.c | 4 ++++
 fs/nfs/super.c  | 9 +++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 295a7a2..651a9ad 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -196,3 +196,12 @@ config NFS_DEBUG
 	depends on NFS_FS && SUNRPC_DEBUG
 	select CRC32
 	default y
+
+config NFS_DISABLE_UDP_SUPPORT
+	bool "NFS: Disable NFS UDP protocol support"
+	depends on NFS_FS
+	default y
+	help
+	  Choose Y here to disable the use of NFS over UDP. NFS over UDP
+	  on modern networks (1Gb+) can lead to data corruption caused by
+	  fragmentation during high loads.
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 02110a3..45f1374c 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -474,6 +474,7 @@ void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
 			to->to_maxval = to->to_initval;
 		to->to_exponential = 0;
 		break;
+#ifndef CONFIG_NFS_DISABLE_UDP_SUPPORT
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
+#ifndef CONFIG_NFS_DISABLE_UDP_SUPPORT
 		case XPRT_TRANSPORT_UDP:
 			nlm_init.protocol = IPPROTO_UDP;
+#endif
 	}
 
 	host = nlmclnt_init(&nlm_init);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index a84df7d6..f6ad74f 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2204,6 +2204,10 @@ static int nfs_validate_text_mount_data(void *options,
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
@@ -2220,11 +2224,12 @@ static int nfs_validate_text_mount_data(void *options,
 out_v4_not_compiled:
 	dfprintk(MOUNT, "NFS: NFSv4 is not compiled into kernel\n");
 	return -EPROTONOSUPPORT;
-#else
+#endif /* !CONFIG_NFS_V4 */
+#if IS_ENABLED(CONFIG_NFS_DISABLE_UDP_SUPPORT) || IS_ENABLED(CONFIG_NFS_V4)
 out_invalid_transport_udp:
 	dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
 	return -EINVAL;
-#endif /* !CONFIG_NFS_V4 */
+#endif
 
 out_no_address:
 	dfprintk(MOUNT, "NFS: mount program didn't pass remote address\n");
-- 
1.8.3.1

