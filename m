Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B461961D8
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 00:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgC0X1X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 19:27:23 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:12196 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgC0X1X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 19:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585351642; x=1616887642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Sc47dVGeG9l2EzZMt96GZfJiGra1WZdIAH1k8ZziYHk=;
  b=J8kcQ1utCuNwiDs8rB09hcoI+oJS9Jo3yLFngtXSbLpXGkgwlbTlSh63
   hySVcfZLmv3dIkQNRi9tUXkC5R+gU8kOeg48PiBuC+3pkHPWnjZXeWoyk
   bILYxGPsDb7XaJkIh0cMZCleqaSbh9rXD/HAXW6z5xejp+p2T4yWUh1xJ
   k=;
IronPort-SDR: TXS0bMmzyWcra5LagtksD0FMpp7DXFUowcXqiZ62VZmyJM6CxPEuqiXTE6CdUU3TpmsLzywCsy
 SmRW4vhCE8fw==
X-IronPort-AV: E=Sophos;i="5.72,314,1580774400"; 
   d="scan'208";a="33900229"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 Mar 2020 23:27:19 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 27468A259C;
        Fri, 27 Mar 2020 23:27:19 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 27 Mar 2020 23:27:18 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Mar 2020 23:27:18 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Fri, 27 Mar 2020 23:27:17 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 49FFADEFB5; Fri, 27 Mar 2020 23:27:17 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 08/11] nfsd: add structure definitions for xattr requests / responses
Date:   Fri, 27 Mar 2020 23:27:14 +0000
Message-ID: <20200327232717.15331-9-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200327232717.15331-1-fllinden@amazon.com>
References: <20200327232717.15331-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add the structures used in extended attribute request / response handling.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/xdr4.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index db63d39b1507..66499fb6b567 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -224,6 +224,32 @@ struct nfsd4_putfh {
 	bool		no_verify;	    /* represents foreigh fh */
 };
 
+struct nfsd4_getxattr {
+	char		*getxa_name;		/* request */
+	u32		getxa_len;		/* request */
+	void		*getxa_buf;
+};
+
+struct nfsd4_setxattr {
+	u32		setxa_flags;		/* request */
+	char		*setxa_name;		/* request */
+	char		*setxa_buf;		/* request */
+	u32		setxa_len;		/* request */
+	struct nfsd4_change_info  setxa_cinfo;	/* response */
+};
+
+struct nfsd4_removexattr {
+	char		*rmxa_name;		/* request */
+	struct nfsd4_change_info  rmxa_cinfo;	/* response */
+};
+
+struct nfsd4_listxattrs {
+	u64		lsxa_cookie;		/* request */
+	u32		lsxa_maxcount;		/* request */
+	char		*lsxa_buf;		/* unfiltered buffer (reply) */
+	u32		lsxa_len;		/* unfiltered len (reply) */
+};
+
 struct nfsd4_open {
 	u32		op_claim_type;      /* request */
 	struct xdr_netobj op_fname;	    /* request - everything but CLAIM_PREV */
@@ -649,6 +675,11 @@ struct nfsd4_op {
 		struct nfsd4_offload_status	offload_status;
 		struct nfsd4_copy_notify	copy_notify;
 		struct nfsd4_seek		seek;
+
+		struct nfsd4_getxattr		getxattr;
+		struct nfsd4_setxattr		setxattr;
+		struct nfsd4_listxattrs		listxattrs;
+		struct nfsd4_removexattr	removexattr;
 	} u;
 	struct nfs4_replay *			replay;
 };
-- 
2.17.2

