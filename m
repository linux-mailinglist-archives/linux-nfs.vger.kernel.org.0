Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 835E41822F9
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 20:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbgCKT76 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 15:59:58 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:58410 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731123AbgCKT76 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 15:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956798; x=1615492798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=qJTJHD1CTWEOyy5G47yBhltgHAntap4FlRSHEOJxImM=;
  b=TjkcZpcskl1vYJuSKqVTh3KyQq6WyoIaPr+PFwCmlfPcDLOAai/bqNph
   xE3VlAWutbq2as9fmA5N9i3XRFVBWQ/Qo7OO30x0cBInAQ2Kc2IsUHJ5F
   lphKHI/U9SLTnWinbIm7Mv65+5N+Oh46N2xkDbXA9pB6NnuIvyZfGLdbZ
   4=;
IronPort-SDR: +5236ghas3eaRMki9QP+3hez4MkwZ5GKnJDuMg0b6V+eV55GYvb+2SoH3LAjeLn8nbXrmw1jWR
 tGRpxqeVjT7w==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="20833428"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 11 Mar 2020 19:59:58 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 1A5E628388C;
        Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
Received: from EX13D13UWA003.ant.amazon.com (10.43.160.181) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:59:55 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWA003.ant.amazon.com (10.43.160.181) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:59:55 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:59:54 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 192D1DEF46; Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 08/14] nfsd: add structure definitions for xattr requests / responses
Date:   Wed, 11 Mar 2020 19:59:48 +0000
Message-ID: <20200311195954.27117-9-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195954.27117-1-fllinden@amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
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
2.16.6

