Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB71ADB386
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 19:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503066AbfJQRiC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 13:38:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46215 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503067AbfJQRiC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Oct 2019 13:38:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so4733613qtq.13
        for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2019 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=91Ar9njuxszKzAtWm4iDPtBww2kCOTgcm5S5GW0aWZc=;
        b=rVqaAC49daRLXAQctza0v0VkpoWK3Zj2mQs9MBffkAZCdrrWlqq985FIFSp9KaM3GC
         UwXkOvtpQL6yVQgLebgLVtfV+XCW2RSfnQ4tTJzOasJNLZCyQJ3vveBYfWVPMGXUUT9m
         o0XknNHIqjHWOYq9rMjGr+rok5Cso7DIe6BsIqazKhH8j4h3mZ3coAMe56MgccVUCuxn
         17vfmZVo5+/PTtQurpYkAvNPXAWzoo1hbimXdqqgEVLIEsWx0IjIi2XFDCYhohF3M25E
         b9cbmfpdLMWj8EkF7hv5Q6WzXc9GM1IcCpuDVHyK7AffJmxLPyg9nvJmpqfOjRbyGeyg
         CqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91Ar9njuxszKzAtWm4iDPtBww2kCOTgcm5S5GW0aWZc=;
        b=nDcNPPI6fkCZE58oZAXXsuo7SN+Dk+4BvheGc2gzkEz1iCLvGzh1E7cqQG/kCIuO0N
         oCHR/Owc5vozdFUmHtNz7DwhnnY5xId6va90teq87TFORugUhH3vBcdTAlIt1wNMCEdy
         fismInf7SBFAHMIa78fAC4JXoqmfxTS1RPOWHEwdmIRDAJfqdyWJhVaN3p/WzCga80IL
         Y/H2wnvR3YKrAgb7K5szExabXsLkIIMMr4oE7AQJ6e23GTQbepC+b2Y3a7RD9iNpXhfP
         ZeAXxlJavkeRXLUMbCKnCeWRNJ1sG6QsWDsEVn9fby7/gMGb923P46njMBuTQecNSusc
         K8Gw==
X-Gm-Message-State: APjAAAUQrA0bIhFxY+o14hljKBS2GX16V06GXA6QXfIsaL9DBHMUPTd9
        E7NqNMF6ofntdixlQcjT7KDu8Gk=
X-Google-Smtp-Source: APXvYqz6pw4XRIGO03N/bXIyNwLevWHgWy0bqGoJY4k5hmDInbdvObll3Nl0YEtwOpDouDDDZaKzpg==
X-Received: by 2002:a0c:b454:: with SMTP id e20mr5030457qvf.14.1571333880558;
        Thu, 17 Oct 2019 10:38:00 -0700 (PDT)
Received: from localhost.localdomain ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id l185sm1768610qkd.20.2019.10.17.10.37.59
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 10:38:00 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/5] NFS: Add a flag to tell nfs_client to set RPC_CLNT_CREATE_NOPING
Date:   Thu, 17 Oct 2019 13:35:45 -0400
Message-Id: <20191017173548.105111-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017173548.105111-1-trond.myklebust@hammerspace.com>
References: <20191017173548.105111-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a flag to tell the nfs_client it should set RPC_CLNT_CREATE_NOPING when
creating the rpc client.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/client.c           | 2 ++
 include/linux/nfs_fs_sb.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 30838304a0bf..fa7d92328c72 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -515,6 +515,8 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 		args.flags |= RPC_CLNT_CREATE_NONPRIVPORT;
 	if (test_bit(NFS_CS_INFINITE_SLOTS, &clp->cl_flags))
 		args.flags |= RPC_CLNT_CREATE_INFINITE_SLOTS;
+	if (test_bit(NFS_CS_NOPING, &clp->cl_flags))
+		args.flags |= RPC_CLNT_CREATE_NOPING;
 
 	if (!IS_ERR(clp->cl_rpcclient))
 		return 0;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 47266870a235..a50dd432475b 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -45,6 +45,7 @@ struct nfs_client {
 #define NFS_CS_INFINITE_SLOTS	3		/* - don't limit TCP slots */
 #define NFS_CS_NO_RETRANS_TIMEOUT	4	/* - Disable retransmit timeouts */
 #define NFS_CS_TSM_POSSIBLE	5		/* - Maybe state migration */
+#define NFS_CS_NOPING		6		/* - don't ping on connect */
 	struct sockaddr_storage	cl_addr;	/* server identifier */
 	size_t			cl_addrlen;
 	char *			cl_hostname;	/* hostname of server */
-- 
2.21.0

