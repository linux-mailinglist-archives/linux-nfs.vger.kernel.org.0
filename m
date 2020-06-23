Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666F620675C
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387795AbgFWWoR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:17 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:16538 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387938AbgFWWoO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952254; x=1624488254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Sc47dVGeG9l2EzZMt96GZfJiGra1WZdIAH1k8ZziYHk=;
  b=cnToCiMfKKtLtudpju2OrCyGyVPCXboEhzkHYhazv5Un+Hu563RmiApj
   Wh3ijjbCdEk6trf/Z77uSje1+lKzClNCNtBgE/Edc0bckpLRACiY/Lz4m
   cThsB9s/HDtyRR6unR6bzvjL3cWbNVuQqMnHLi/nELd1HxXqfH9fT19S2
   s=;
IronPort-SDR: GnCI5tZwdUtj3voEeC9b40WorJE74ozhpN3uWfJqtLKEwC/ww0JAD6aMZeBR5aPErp0VZ6kKwO
 nNm8jKf2I2kg==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="39410376"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 23 Jun 2020 22:39:31 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 5948AA17BE;
        Tue, 23 Jun 2020 22:39:29 +0000 (UTC)
Received: from EX13D13UWA003.ant.amazon.com (10.43.160.181) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:29 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWA003.ant.amazon.com (10.43.160.181) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:29 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:28 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 1F5E3CD362; Tue, 23 Jun 2020 22:39:28 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 08/10] nfsd: add structure definitions for xattr requests / responses
Date:   Tue, 23 Jun 2020 22:39:25 +0000
Message-ID: <20200623223927.31795-9-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223927.31795-1-fllinden@amazon.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
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

