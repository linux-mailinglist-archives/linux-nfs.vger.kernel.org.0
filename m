Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC22A1822FC
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 21:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbgCKUAA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 16:00:00 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:63729 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387470AbgCKT77 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 15:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956800; x=1615492800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=MxZUeMtvslhuCCeNpgdjSRNmpihAqBC7fBmalBylM2I=;
  b=EfArnopWuC3EsyslRCkCNlUazjGVPCtcY2GMNhSZrXDMos6xymSk13PP
   Dhev4DEt9if9QYjgR7cXLzgliQnmX+L0miIN4UFdpHLXe9MKDqSurGahL
   6ch32pgneGI0ecXY2phHWNIqiAcEnngQ2niASGAsWl63GBzZ+fXUDWnUA
   U=;
IronPort-SDR: Lqq7f1/mqR34ZzCtDRed6sA/2jQyhBD/j+QvzyE84N34VUv4b4kfg63wHpBDvgq/ex8Oxk1etA
 tIcL2wGXtCIQ==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="32054196"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 11 Mar 2020 19:59:59 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id F23B3A2AC5;
        Wed, 11 Mar 2020 19:59:56 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:59:55 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:59:55 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:59:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 1EA93DEF48; Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 10/14] nfsd: implement the xattr procedure functions.
Date:   Wed, 11 Mar 2020 19:59:50 +0000
Message-ID: <20200311195954.27117-11-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195954.27117-1-fllinden@amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Implement the main entry points for the *XATTR operations.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4proc.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c  |  2 ++
 2 files changed, 75 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b573ae1121af..a76b9025a357 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2098,6 +2098,79 @@ nfsd4_layoutreturn(struct svc_rqst *rqstp,
 }
 #endif /* CONFIG_NFSD_PNFS */
 
+static __be32
+nfsd4_getxattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	       union nfsd4_op_u *u)
+{
+	struct nfsd4_getxattr *getxattr = &u->getxattr;
+
+	return nfsd_getxattr(rqstp, &cstate->current_fh,
+			     getxattr->getxa_name, getxattr->getxa_buf,
+			     &getxattr->getxa_len);
+}
+
+static __be32
+nfsd4_setxattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	   union nfsd4_op_u *u)
+{
+	struct nfsd4_setxattr *setxattr = &u->setxattr;
+	int ret;
+
+	if (opens_in_grace(SVC_NET(rqstp)))
+		return nfserr_grace;
+
+	ret = nfsd_setxattr(rqstp, &cstate->current_fh, setxattr->setxa_name,
+			    setxattr->setxa_buf, setxattr->setxa_len,
+			    setxattr->setxa_flags);
+
+	if (!ret)
+		set_change_info(&setxattr->setxa_cinfo, &cstate->current_fh);
+
+	return ret;
+}
+
+static __be32
+nfsd4_listxattrs(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	   union nfsd4_op_u *u)
+{
+	int ret, len;
+
+	/*
+	 * Get the entire list, then copy out only the user attributes
+	 * in the encode function. lsxa_buf was previously allocated as
+	 * tmp svc space, and will be automatically freed later.
+	 */
+	len = XATTR_LIST_MAX;
+
+	ret = nfsd_listxattr(rqstp, &cstate->current_fh, u->listxattrs.lsxa_buf,
+			     &len);
+	if (ret)
+		return ret;
+
+	u->listxattrs.lsxa_len = len;
+
+	return nfs_ok;
+}
+
+static __be32
+nfsd4_removexattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	   union nfsd4_op_u *u)
+{
+	struct nfsd4_removexattr *removexattr = &u->removexattr;
+	int ret;
+
+	if (opens_in_grace(SVC_NET(rqstp)))
+		return nfserr_grace;
+
+	ret = nfsd_removexattr(rqstp, &cstate->current_fh,
+	    removexattr->rmxa_name);
+
+	if (!ret)
+		set_change_info(&removexattr->rmxa_cinfo, &cstate->current_fh);
+
+	return ret;
+}
+
 /*
  * NULL call.
  */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f6322add2992..b12d7ac6f52c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -41,6 +41,8 @@
 #include <linux/pagemap.h>
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/addr.h>
+#include <linux/xattr.h>
+#include <uapi/linux/xattr.h>
 
 #include "idmap.h"
 #include "acl.h"
-- 
2.16.6

