Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADD9206764
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbgFWWoV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:21 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:57642 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388066AbgFWWoT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952260; x=1624488260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=VB2CKwBUB3FuzbBjlN7ED8LarlYO41SLlR/2s07gEi0=;
  b=YQleDS2fRiPyzDQczxhaVHVotK+tiEXALhT/Ng+lMayCtCGtAUMqXWnL
   y+eJ3mthJE9oTJp2xH3UPjsuHdgv0iOMX0DfSGqJn/YvRv47g3jpXJPW1
   EJc7H9Alp1CLIT066rd1DcjQ3p/4/fqSX4zAfZWgCs0ReINqBU5UNll9u
   o=;
IronPort-SDR: yhDEZqBr/vgCF8vcJP99fv/HsP0467sa2KKXZA8VLpB630xtM50PirQgx9HY1ALMnKpiVy+bEF
 JUePSiGP46AQ==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="46390854"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 23 Jun 2020 22:39:38 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id A8392A26E6;
        Tue, 23 Jun 2020 22:39:37 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:29 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:29 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:28 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 1BD3DCD361; Tue, 23 Jun 2020 22:39:28 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 07/10] nfsd: take xattr bits in to account for permission checks
Date:   Tue, 23 Jun 2020 22:39:24 +0000
Message-ID: <20200623223927.31795-8-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223927.31795-1-fllinden@amazon.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
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
index a09c35f0f6f0..841aad772798 100644
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
index b1dd8690e25d..8e223b3bf26f 100644
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
2.17.2

