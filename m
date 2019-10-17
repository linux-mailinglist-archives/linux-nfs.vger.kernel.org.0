Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC064DB36C
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 19:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503056AbfJQRiE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 13:38:04 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:41813 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503075AbfJQRiD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Oct 2019 13:38:03 -0400
Received: by mail-qt1-f175.google.com with SMTP id c17so1774237qtn.8
        for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2019 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6nPx5+WD2eQxDAhShqo1QNXmUCu31XjaRYCJQilSiyo=;
        b=HP9I2f/RkZM50A/eyovtdghhSCIf5EJTsUDLu697mlc4vMQ4bmY7syWvuMJXsE9uVF
         8sVDoTwUTz7vp1Mlxh65RFGK9TfzMFdnxDuBb7c4K9NDW7xiinP2Ky8+lrPs60xPzIPd
         vqgdtRqILdCooq3fZt4/KVToopyYiLZrLNP4/UYX92sLF7xYdMX2Lr9lRlTocjUV+/7T
         /RCmeCrQ9eTVYqLO/d6cj9xkyu///kxo3kx7JCP7CWgMyNKM4fAneaz7XyrbPI0YbLRV
         mhPGzEn3GgR+6K+Mr+DcwIeg71UexrWTRyb4NqL8Vdxn3lDo1T3SMXbEVpeM65w/ELqs
         OTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6nPx5+WD2eQxDAhShqo1QNXmUCu31XjaRYCJQilSiyo=;
        b=J43/h5/mAngbTntMRVRt4Zyo9pxouPBXGKMfyrpKzew82tocDG9QvseqsZbRx3zlnB
         fKtVIDzhNi25dSyQA6p1rDR3reuq1ehHEb9TZeNH0dJvxKIWwK+kpB+MkrbpxXMGOQNa
         +gc10F5oKkmHIiFJ82Kjpwh2Qi+PS/gNIP8hculc2QChdKbOS8cIkfZ7/exZfOyOhd2k
         aoz0Knb0Z35xSSW1nAdAD3IoHkx6Q1Du9IdoK5kuERlaH6PwT3Olg5NYOSxFjy+Ca/5b
         uTJ1Tt6+fwgSZ06JYI3KQcaYxQjy1O//c3SMsKXmA923X4vAg1qQmKkx9rSX8+EYCS8Z
         a5OA==
X-Gm-Message-State: APjAAAWkoxVYv70BHGoWZtQ3erYl8ADagNdVS972z6WRXJEUVcmnTNL4
        +piG80rONzWo6jei7sgTw09vcAc=
X-Google-Smtp-Source: APXvYqwA9350LMBEGkPX4rLtfjuXderFMaF39uNdZNeRXQZkjgAAek4+sp+P2yf3bPszfARfA+cdRA==
X-Received: by 2002:ac8:6782:: with SMTP id b2mr5031544qtp.143.1571333882237;
        Thu, 17 Oct 2019 10:38:02 -0700 (PDT)
Received: from localhost.localdomain ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id l185sm1768610qkd.20.2019.10.17.10.38.01
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 10:38:01 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/5] NFS/pnfs: Separate NFSv3 DS and MDS traffic
Date:   Thu, 17 Oct 2019 13:35:47 -0400
Message-Id: <20191017173548.105111-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017173548.105111-3-trond.myklebust@hammerspace.com>
References: <20191017173548.105111-1-trond.myklebust@hammerspace.com>
 <20191017173548.105111-2-trond.myklebust@hammerspace.com>
 <20191017173548.105111-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a NFSv3 server is being used as both a DS and as a regular NFSv3 server,
we may want to keep the IO traffic on a separate TCP connection, since
it will typically have very different timeout characteristics.

This patch therefore sets up a flag to separate the two modes of operation
for the nfs_client.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/client.c           | 6 ++++++
 fs/nfs/nfs3client.c       | 1 +
 include/linux/nfs_fs_sb.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index fa7d92328c72..bd6575ee3b8e 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -312,6 +312,12 @@ static struct nfs_client *nfs_match_client(const struct nfs_client_initdata *dat
 		/* Match nfsv4 minorversion */
 		if (clp->cl_minorversion != data->minorversion)
 			continue;
+
+		/* Match request for a dedicated DS */
+		if (test_bit(NFS_CS_DS, &data->init_flags) !=
+		    test_bit(NFS_CS_DS, &clp->cl_flags))
+			continue;
+
 		/* Match the full socket address */
 		if (!rpc_cmp_addr_port(sap, clap))
 			/* Match all xprt_switch full socket addresses */
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index 793fa4273edb..223904bc40a7 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -109,6 +109,7 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
 	__set_bit(NFS_CS_NOPING, &cl_init.init_flags);
+	__set_bit(NFS_CS_DS, &cl_init.init_flags);
 
 	/* Use the MDS nfs_client cl_ipaddr. */
 	nfs_init_timeout_values(&ds_timeout, ds_proto, ds_timeo, ds_retrans);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index a50dd432475b..69e80cef5a81 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -46,6 +46,7 @@ struct nfs_client {
 #define NFS_CS_NO_RETRANS_TIMEOUT	4	/* - Disable retransmit timeouts */
 #define NFS_CS_TSM_POSSIBLE	5		/* - Maybe state migration */
 #define NFS_CS_NOPING		6		/* - don't ping on connect */
+#define NFS_CS_DS		7		/* - Server is a DS */
 	struct sockaddr_storage	cl_addr;	/* server identifier */
 	size_t			cl_addrlen;
 	char *			cl_hostname;	/* hostname of server */
-- 
2.21.0

