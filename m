Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7710D206754
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbgFWWoM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:12 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:14750 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387813AbgFWWoL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952250; x=1624488250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=T8VksW0pm5AuAE7Y+UdAVUTY3sd0x606eIgrKPc4zAA=;
  b=qQgwkRAEZxcgniJLQVK4Q4HhpAVD4otkse+rJc2E00t0m9hxcMNTJmvM
   x9buqbOuvKY/BNj2+RzvxdLHSGjdl98NQeYDQW6cU/ch+J4VAgDekLBkn
   TGf03fwn4pr/pqLEp4qSMMX1wnt4d0U6eZKS9jjVAHIr76Fp605fgG7O4
   A=;
IronPort-SDR: guV0u1XvlZRR1F+5sOmj3Iuf/3KDRYgybUjEl2/VAbyXEoeGQ98ITUT0YYduE2K4OSX78lQOGC
 zLPERBa/iLTA==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="53337231"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 23 Jun 2020 22:39:19 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id F0692A22A4;
        Tue, 23 Jun 2020 22:39:17 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:06 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:05 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:05 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id C83E7CD361; Tue, 23 Jun 2020 22:39:04 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 07/13] NFSv4.2: query the extended attribute access bits
Date:   Tue, 23 Jun 2020 22:38:58 +0000
Message-ID: <20200623223904.31643-8-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223904.31643-1-fllinden@amazon.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

RFC 8276 defines separate ACCESS bits for extended attribute checking.
Query them in nfs_do_access and opendata.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/dir.c      | 4 ++++
 fs/nfs/nfs4proc.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f04fc0f7843b..a12f42e7d8c7 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2673,6 +2673,10 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 	 * Determine which access bits we want to ask for...
 	 */
 	cache.mask = NFS_ACCESS_READ | NFS_ACCESS_MODIFY | NFS_ACCESS_EXTEND;
+	if (nfs_server_capable(inode, NFS_CAP_XATTR)) {
+		cache.mask |= NFS_ACCESS_XAREAD | NFS_ACCESS_XAWRITE |
+		    NFS_ACCESS_XALIST;
+	}
 	if (S_ISDIR(inode->i_mode))
 		cache.mask |= NFS_ACCESS_DELETE | NFS_ACCESS_LOOKUP;
 	else
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 64e081459327..c88351f8b18d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1341,6 +1341,12 @@ static struct nfs4_opendata *nfs4_opendata_alloc(struct dentry *dentry,
 				NFS4_ACCESS_MODIFY |
 				NFS4_ACCESS_EXTEND |
 				NFS4_ACCESS_EXECUTE;
+#ifdef CONFIG_NFS_V4_2
+			if (server->caps & NFS_CAP_XATTR)
+				p->o_arg.access |= NFS4_ACCESS_XAREAD |
+				    NFS4_ACCESS_XAWRITE |
+				    NFS4_ACCESS_XALIST;
+#endif
 		}
 	}
 	p->o_arg.clientid = server->nfs_client->cl_clientid;
-- 
2.17.2

