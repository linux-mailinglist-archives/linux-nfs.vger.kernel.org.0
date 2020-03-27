Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219971961D9
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 00:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgC0X1Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 19:27:24 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:12188 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgC0X1X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 19:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585351643; x=1616887643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=dHAisQGjucrPBVjEU+UobAo/lyUrFlNmtFS9ebaeBA4=;
  b=mh1RDa80WmkBUEHXGapXos04KgvEqvr/V5UYAry3DFN96ACeNqclYj61
   sdUGrSJsUxbh67Ym849AfUzn7FZqosIdOKRg+DJfVVvBqGyJ7Jt1h23Km
   UcJvhXHLJLLGiidj9be5BLSgO0eNthhUE4vqBcBCyrfY9QLhUSVrX4qEt
   0=;
IronPort-SDR: D9O8Bb9o/QlJdA3uTS8R7O+KPPpnY1fLhdOmEDEF3V5bOediiat5P2sgI8SiJ5aL6Vn20iPWK/
 fI0ILwJp6jrQ==
X-IronPort-AV: E=Sophos;i="5.72,314,1580774400"; 
   d="scan'208";a="33900230"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 Mar 2020 23:27:20 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 644EEA259C;
        Fri, 27 Mar 2020 23:27:19 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 27 Mar 2020 23:27:18 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Mar 2020 23:27:18 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Fri, 27 Mar 2020 23:27:17 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 3F795DEFB2; Fri, 27 Mar 2020 23:27:17 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 05/11] nfsd: add defines for NFSv4.2 extended attribute support
Date:   Fri, 27 Mar 2020 23:27:11 +0000
Message-ID: <20200327232717.15331-6-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200327232717.15331-1-fllinden@amazon.com>
References: <20200327232717.15331-1-fllinden@amazon.com>
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
2.17.2

