Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0DB206769
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbgFWWoZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:25 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:57655 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388094AbgFWWoU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952261; x=1624488261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=w5i0QAAghGXMlECQTAgQn486Cz/40q5srW8pGuMBErY=;
  b=AX8+20ol5z4R0yDb//6fLCSw67yTcVi+XIkrvyE9eUPxfyMWZKK5Evrf
   twvyP79toNsFqDPghhG+NlVORjj67pv0OzO/qhnD2HOOH/NmhbYCwtTFc
   R6QkCKYx80wHjvydjngajVulMdCg85MtFLUWBNLcVakUl0HmKxqeCdtyA
   I=;
IronPort-SDR: g+YBL08MgOEwVpgrSRP4OpFscZYkv82KA6bDIkVc9pCCjlNjWi6GCKztz9sVjinInu1XhJgzo8
 opc5v+91KOwA==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="46390856"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 23 Jun 2020 22:39:38 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id E53EAA26E6;
        Tue, 23 Jun 2020 22:39:37 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:29 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:29 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:29 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 2697ECD363; Tue, 23 Jun 2020 22:39:28 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 10/10] nfsd: add fattr support for user extended attributes
Date:   Tue, 23 Jun 2020 22:39:27 +0000
Message-ID: <20200623223927.31795-11-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223927.31795-1-fllinden@amazon.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Check if user extended attributes are supported for an inode,
and return the answer when being queried for file attributes.

An exported filesystem can now signal its RFC8276 user extended
attributes capability.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4xdr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8bacc0ceae19..259d5ad0e3f4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3213,6 +3213,15 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	}
 #endif
 
+	if (bmval2 & FATTR4_WORD2_XATTR_SUPPORT) {
+		p = xdr_reserve_space(xdr, 4);
+		if (!p)
+			goto out_resource;
+		err = xattr_supported_namespace(d_inode(dentry),
+						XATTR_USER_PREFIX);
+		*p++ = cpu_to_be32(err == 0);
+	}
+
 	attrlen = htonl(xdr->buf->len - attrlen_offset - 4);
 	write_bytes_to_xdr_buf(xdr->buf, attrlen_offset, &attrlen, 4);
 	status = nfs_ok;
-- 
2.17.2

