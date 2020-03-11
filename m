Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6739D1822E2
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 20:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbgCKT43 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 15:56:29 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:55622 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387438AbgCKT43 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 15:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956588; x=1615492588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=AB2sHwfB48VoNAyk/fQIiIR5sty+wUXgedDaBdNkRJs=;
  b=JvN+VuJ+vE/SSfVvb3iMSSErjd6SQiyD00r8BVh1L5MCQzbGRzxW6frq
   w8hOxN6bNklQMpvf6RXAbntjhwrspMMecnZDULwGyGkl1TVQxghtPusiZ
   5vac93QjPQOSsxbpjUU5bXgbUd8QnB3MGXQvzgLRBUHvZnXyl1GS3Zg+4
   E=;
IronPort-SDR: KCiRpmTAOzklcSArBg5syXBThYIsUdTMSq63y3HjIYOn1klPMivnB3j2PyhnfIPkr7VmWe7SP8
 najVeyXFmH1g==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="22301193"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 11 Mar 2020 19:56:27 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id EBCF0A2DB5;
        Wed, 11 Mar 2020 19:56:25 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:56:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:56:25 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:56:24 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 0265BDEF45; Wed, 11 Mar 2020 19:56:23 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 07/13] NFSv4.2: query the extended attribute access bits
Date:   Wed, 11 Mar 2020 19:56:07 +0000
Message-ID: <20200311195613.26108-8-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195613.26108-1-fllinden@amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
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
index a0b564781e3e..bd2606539299 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2646,6 +2646,10 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
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
index 47bbd7db9d18..da72237c6933 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1340,6 +1340,12 @@ static struct nfs4_opendata *nfs4_opendata_alloc(struct dentry *dentry,
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
2.16.6

