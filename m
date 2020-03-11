Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 959A7182301
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 21:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbgCKUAA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 16:00:00 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:21948 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387463AbgCKUAA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 16:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956800; x=1615492800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=6qiAtbom8sWGtv53ltUBs+gBP2p6c6TlVosvwWopK0g=;
  b=ambZ6a0pw1QqCEw6ZGjN31mcdCVlfjXRlFmNHr42SKnzXoBUpEl8xmIx
   V8IUXBjzpFOEbxKZAR8UujXnxBz6N/YlmLjuEXk3HwMBM7SNGP0eFh+GB
   WXVYE4r3s4avusOXzGWglGKfkFz4xU3tHYT8bJY1fvb4lJznYS55oZEmm
   I=;
IronPort-SDR: GfS9mFJhmqg5ZuUZJq84opFpwZEMoP0H+NwuJvFr98MOIfxU39nrfYRjLCky2JFZeUc+pC52mt
 BlGN4vGZ4Ibw==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="30664623"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 11 Mar 2020 19:59:57 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 6A293A33FF;
        Wed, 11 Mar 2020 19:59:57 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:59:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:59:55 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1236.3 via Frontend Transport; Wed, 11 Mar 2020 19:59:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 112FADEC15; Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 05/14] nfsd: add defines for NFSv4.2 extended attribute support
Date:   Wed, 11 Mar 2020 19:59:45 +0000
Message-ID: <20200311195954.27117-6-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195954.27117-1-fllinden@amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add defines for server-side extended attribute support. Most have
already been added as part of client support, but these are
the network order error codes for the noxattr and xattr2big errors,
and the addition of the xattr support to the supported file
attributes (if configured).

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfsd.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 2ab5569126b8..362d481b28c9 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -281,6 +281,8 @@ void		nfsd_lockd_shutdown(void);
 #define nfserr_wrong_lfs		cpu_to_be32(NFS4ERR_WRONG_LFS)
 #define nfserr_badlabel			cpu_to_be32(NFS4ERR_BADLABEL)
 #define nfserr_file_open		cpu_to_be32(NFS4ERR_FILE_OPEN)
+#define nfserr_xattr2big		cpu_to_be32(NFS4ERR_XATTR2BIG)
+#define nfserr_noxattr			cpu_to_be32(NFS4ERR_NOXATTR)
 
 /* error codes for internal use */
 /* if a request fails due to kmalloc failure, it gets dropped.
@@ -382,7 +384,8 @@ void		nfsd_lockd_shutdown(void);
 	(NFSD4_1_SUPPORTED_ATTRS_WORD2 | \
 	FATTR4_WORD2_CHANGE_ATTR_TYPE | \
 	FATTR4_WORD2_MODE_UMASK | \
-	NFSD4_2_SECURITY_ATTRS)
+	NFSD4_2_SECURITY_ATTRS | \
+	FATTR4_WORD2_XATTR_SUPPORT)
 
 extern const u32 nfsd_suppattrs[3][3];
 
-- 
2.16.6

