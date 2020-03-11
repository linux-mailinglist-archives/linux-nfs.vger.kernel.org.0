Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31521182300
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 21:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbgCKUAB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 16:00:01 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:21960 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387472AbgCKUAA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 16:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956799; x=1615492799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=w5924BLjvK9xOh+f33l2Ca6xPmSWbO+4fZb9a5nmBDA=;
  b=hNT+U4KfIRDVQ+UBDyPHkyrn8MVBDRzhlw+008O4a23rVz/zRovQHCTk
   ZUNsLK+OWRk6W2JHlfUGO0Mv5VEJyk0A3mYB+7pjcOsk34ZyVR7Gd8RqF
   HDeBaGq0+6RREc5nFfoRciW4j9ZIMNL+316KIj0EfR897tl1SkCc8HxZd
   k=;
IronPort-SDR: VudzbNoglLPgTeknLZhV+IeHgr/pRYZNDmR/5Jeg0iTQ7wtQDE2nN1aDMIfi+IN6aZrTTFltuq
 NzUjEeG5mtlg==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="30664621"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 11 Mar 2020 19:59:57 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 9114024247B;
        Wed, 11 Mar 2020 19:59:56 +0000 (UTC)
Received: from EX13D13UWB001.ant.amazon.com (10.43.161.156) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:59:55 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB001.ant.amazon.com (10.43.161.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:59:55 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:59:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 2922EDEF4C; Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 14/14] nfsd: add fattr support for user extended attributes
Date:   Wed, 11 Mar 2020 19:59:54 +0000
Message-ID: <20200311195954.27117-15-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195954.27117-1-fllinden@amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
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
index 41c8b95ca1c5..d4a45cfefb86 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3229,6 +3229,15 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
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
2.16.6

