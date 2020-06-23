Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED91120675B
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388035AbgFWWoQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:16 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:16544 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387795AbgFWWoP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952254; x=1624488254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=FW9ez1I7F6tDNaPMy5TdxWz3uH0YE3oupg7CG0pdo50=;
  b=skQOpHeSviVOfe4svDSNrb8JIEatCl++BkboNDvsKvwX9rMsKqdsIUDj
   EPyO3zFMFfLO2+AMeDsFGfXSEfV4Y4+jGDI0p0wVvPp/90X9ktCGSir5z
   qvuxz1gChfZZp4mm9k0MAfxZ60fo4RMQWzbfvj1R4AbQzt+9eFnfBnCi3
   k=;
IronPort-SDR: G8rvoTOx/Y4vIdoIYkZeZXWrWbiQaQcAORGSeYY/J8dd9Ty/iI6ABLfuDcpkRlMFYebDAh/PB9
 laNWTt9kwsyQ==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="39410390"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 23 Jun 2020 22:39:37 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id AE1161A0D7B;
        Tue, 23 Jun 2020 22:39:36 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:28 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:28 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:28 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 1493BCD35F; Tue, 23 Jun 2020 22:39:28 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 05/10] nfsd: add defines for NFSv4.2 extended attribute support
Date:   Tue, 23 Jun 2020 22:39:22 +0000
Message-ID: <20200623223927.31795-6-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223927.31795-1-fllinden@amazon.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
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
index 36cdd81b6688..5343c771da18 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -283,6 +283,8 @@ void		nfsd_lockd_shutdown(void);
 #define nfserr_wrong_lfs		cpu_to_be32(NFS4ERR_WRONG_LFS)
 #define nfserr_badlabel			cpu_to_be32(NFS4ERR_BADLABEL)
 #define nfserr_file_open		cpu_to_be32(NFS4ERR_FILE_OPEN)
+#define nfserr_xattr2big		cpu_to_be32(NFS4ERR_XATTR2BIG)
+#define nfserr_noxattr			cpu_to_be32(NFS4ERR_NOXATTR)
 
 /* error codes for internal use */
 /* if a request fails due to kmalloc failure, it gets dropped.
@@ -384,7 +386,8 @@ void		nfsd_lockd_shutdown(void);
 	(NFSD4_1_SUPPORTED_ATTRS_WORD2 | \
 	FATTR4_WORD2_CHANGE_ATTR_TYPE | \
 	FATTR4_WORD2_MODE_UMASK | \
-	NFSD4_2_SECURITY_ATTRS)
+	NFSD4_2_SECURITY_ATTRS | \
+	FATTR4_WORD2_XATTR_SUPPORT)
 
 extern const u32 nfsd_suppattrs[3][3];
 
-- 
2.17.2

