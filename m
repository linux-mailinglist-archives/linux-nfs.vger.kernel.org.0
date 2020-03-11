Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 525CA1822FD
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 21:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbgCKUAA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 16:00:00 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:62469 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731097AbgCKT77 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 15:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956799; x=1615492799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Avs3f41otSzfQ86/sYqqug83F1D5nKGvDFpTQ0ACv30=;
  b=aV8nJ4e36fnD/b9I4Ko7U4V43sm8LUUigqP/fjSUbxw6nQa6N7/s7xTv
   mBxVRI1MutefPcWAGKN7GaYaq9760Rfu3VnyBe8tEfxRveuHFTmIADZtB
   P3nheunJA2tqcV/jD9wlAo7XnqjtbNtM7jYXFNepOZySVcr1EW5d+UU+x
   Y=;
IronPort-SDR: ssxCV5ie9HivBGaQTCTlQafH5ls4MmS6GEfGnwIyNF2AjACzkro+BlaEtQRn+zCszJjoEqOYP/
 o1ZIqBSJ9VmA==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="21101077"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 11 Mar 2020 19:59:58 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 08B69A1ED5;
        Wed, 11 Mar 2020 19:59:56 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:59:55 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:59:55 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:59:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 168BFDEF45; Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 07/14] nfsd: take xattr bits in to account for permission checks
Date:   Wed, 11 Mar 2020 19:59:47 +0000
Message-ID: <20200311195954.27117-8-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195954.27117-1-fllinden@amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since the NFSv4.2 extended attributes extension defines 3 new access
bits for xattr operations, take them in to account when validating
what the client is asking for, and when checking permissions.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4proc.c |  8 +++++++-
 fs/nfsd/vfs.c      | 12 ++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5de6449e6ff8..b573ae1121af 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -566,8 +566,14 @@ nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
 {
 	struct nfsd4_access *access = &u->access;
+	u32 access_full;
 
-	if (access->ac_req_access & ~NFS3_ACCESS_FULL)
+	access_full = NFS3_ACCESS_FULL;
+	if (cstate->minorversion >= 2)
+		access_full |= NFS4_ACCESS_XALIST | NFS4_ACCESS_XAREAD |
+			       NFS4_ACCESS_XAWRITE;
+
+	if (access->ac_req_access & ~access_full)
 		return nfserr_inval;
 
 	access->ac_resp_access = access->ac_req_access;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 115449009bc0..19608e690069 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -612,6 +612,12 @@ static struct accessmap	nfs3_regaccess[] = {
     {	NFS3_ACCESS_MODIFY,	NFSD_MAY_WRITE|NFSD_MAY_TRUNC	},
     {	NFS3_ACCESS_EXTEND,	NFSD_MAY_WRITE			},
 
+#ifdef CONFIG_NFSD_V4
+    {	NFS4_ACCESS_XAREAD,	NFSD_MAY_READ			},
+    {	NFS4_ACCESS_XAWRITE,	NFSD_MAY_WRITE			},
+    {	NFS4_ACCESS_XALIST,	NFSD_MAY_READ			},
+#endif
+
     {	0,			0				}
 };
 
@@ -622,6 +628,12 @@ static struct accessmap	nfs3_diraccess[] = {
     {	NFS3_ACCESS_EXTEND,	NFSD_MAY_EXEC|NFSD_MAY_WRITE	},
     {	NFS3_ACCESS_DELETE,	NFSD_MAY_REMOVE			},
 
+#ifdef CONFIG_NFSD_V4
+    {	NFS4_ACCESS_XAREAD,	NFSD_MAY_READ			},
+    {	NFS4_ACCESS_XAWRITE,	NFSD_MAY_WRITE			},
+    {	NFS4_ACCESS_XALIST,	NFSD_MAY_READ			},
+#endif
+
     {	0,			0				}
 };
 
-- 
2.16.6

