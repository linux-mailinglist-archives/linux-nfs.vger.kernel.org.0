Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA381961D5
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 00:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC0X1W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 19:27:22 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:31504 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgC0X1W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 19:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585351641; x=1616887641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Dfdpo+8rRqByfVx41/1teOaOK+FCgk8LcsP5WXXEn4Q=;
  b=FlGxhRs/g7y19VlWFcPVbl+LdUw/QKTJPJYpn0NTkfbHw8bV1TMhHbTz
   LcdArgW62UcabvhCeHUUQ2cN3PBwGRJ94rTR/mqEqqvHrshNud+KFWdIT
   upvNldMfypokFHO0e9YU30PsiXkJufVP7AHkryMiQ5jfB3cmp10bcVUXR
   E=;
IronPort-SDR: HkeB1GcqfWvvZmoWlryjBYoZhXwDFcJ10dm8+wW24fXaROYJ7D++gWOF+DLLYghgNY88pJiWHA
 kJEphU7d5U+Q==
X-IronPort-AV: E=Sophos;i="5.72,314,1580774400"; 
   d="scan'208";a="35299128"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 27 Mar 2020 23:27:18 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id E5BCBA2A2B;
        Fri, 27 Mar 2020 23:27:17 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 27 Mar 2020 23:27:17 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Mar 2020 23:27:17 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Fri, 27 Mar 2020 23:27:17 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 46923DEFB4; Fri, 27 Mar 2020 23:27:17 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 07/11] nfsd: take xattr bits in to account for permission checks
Date:   Fri, 27 Mar 2020 23:27:13 +0000
Message-ID: <20200327232717.15331-8-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200327232717.15331-1-fllinden@amazon.com>
References: <20200327232717.15331-1-fllinden@amazon.com>
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
index 0e75f7fb5fec..ee317ae0b609 100644
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
2.17.2

