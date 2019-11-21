Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20B6E10567E
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2019 17:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKUQGz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Nov 2019 11:06:55 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36776 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKUQGy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Nov 2019 11:06:54 -0500
Received: by mail-il1-f196.google.com with SMTP id s75so3814771ilc.3
        for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2019 08:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7OlZLVlc3SucUWuwfNvUJikaY8FSZWyWSWTZJnxy6OY=;
        b=oIfetlAgfHNgLwk8oo7R5ie8FoGzdL53QfvpKJEAZmGPaAHdN+MmSu73racsJj4zqt
         GQYF9tWAVNIwBTF0AuF1jxbAlAhypsHAu4tJpPujibeBK02AP/XzQekNIgWDN0p/yNNG
         tpYObpdbsYVcbzEAXlLxNhaI10w56X5LLYCKpmKwvgnlxxk/uKMg/l7iS8fknTmTQBdk
         rn4PwUXpH9URQGl1UsPrJq8O8/FxBs+Tx7wE/P0JWJ/a8zmGORyz/u1BJR1GoOMv3Kg4
         nP11X/BUAMSNgTW8HJkhnkk2UYeadKiYbcqBRVwfqZvb+6Vz8gG8VOFRl3NeL3aewcRb
         ZEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7OlZLVlc3SucUWuwfNvUJikaY8FSZWyWSWTZJnxy6OY=;
        b=ZbaZv7jw94oGPpg0qLcr9na45kj3jE/QR8AdLGtAmsuGIozICOetRS3zSlp1FyRU/T
         By5khHC06kHzJpHmy+Ht9vz9S1qkYAcGjMb4QyRvL577jSnMcsbUXxPQD+lk4MGpX/2B
         zAU/AxZdKBIsA/hTZG/ul/N+QVfK8v4AAvmo2TuE6f9odU1EOfjiTgQp3FG6BV+ka5uR
         14c/0YuH2tqvcLKG09CFj0BhZW1DoQAQ0B3t1fn4YK0w7EkX1md2K4a/WfmbIO9+jRb+
         Bc9Xs/rzUXvAcLy+TfGSo9qYfUK6LoKiuN3sKsEcz82wGu2cYELoFMos1j/WVObp/3EY
         +New==
X-Gm-Message-State: APjAAAXLOGQsev/Gdg7Tv+EvKzfgblXb5tWMuapGvekjGGoctbWW6X7+
        xLPJtNElbB9x3rEI+C3xAiBwkqkQ
X-Google-Smtp-Source: APXvYqxPh2XpBzFAdFOsOUHVIN5gYR1T2dy7db7g/aZsNut5rVS6vD2oYSAB+YSKE8j43GS0eQ3dJQ==
X-Received: by 2002:a92:cb0d:: with SMTP id s13mr10822090ilo.195.1574352413795;
        Thu, 21 Nov 2019 08:06:53 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id z10sm1349654ill.73.2019.11.21.08.06.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 21 Nov 2019 08:06:53 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFS: allow deprecation of NFS UDP protocol
Date:   Thu, 21 Nov 2019 11:06:51 -0500
Message-Id: <20191121160651.5317-1-olga.kornievskaia@gmail.com>
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
 fs/nfs/Kconfig  | 10 ++++++++++
 fs/nfs/client.c |  4 ++++
 fs/nfs/super.c  |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 295a7a2..ba5a681 100644
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
+	default y
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
index a84df7d6..f68346d 100644
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
-- 
1.8.3.1

