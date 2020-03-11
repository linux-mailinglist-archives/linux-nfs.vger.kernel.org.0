Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 038F61822FA
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 21:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbgCKT77 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 15:59:59 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:21948 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731165AbgCKT76 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 15:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956797; x=1615492797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=O97YRg8xTKVNLX0Bt23R4Gp6o7/2FpRmJtAjQredx1I=;
  b=hHZqOrSpS5roBrl3Ma0zx4f/DvX3bdLGuVjnLZIewkJHUQ5hJVyuRXrn
   0Byykt4m0augH93I6pYxZI+HixYrKl7zv5IRXfdmGZ22ky6Vbn2GppbpO
   1CwfFLZAifFe4nF4Hr5Ri6pkCKnoz5ORM9iOamewe267oV6RFaVuXh9H6
   I=;
IronPort-SDR: GMk410Y7D4qQ/BD/yAqqtETauutyvU66ngyfSgdnJp0oCXZsy4E/Q2DT4feiNndAoZbs2/Ag5y
 mJgsZcqyJcdQ==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="30664617"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 11 Mar 2020 19:59:56 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id D0EF0A19C3;
        Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:59:55 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:59:54 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:59:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 0BB20DEC13; Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 03/14] nfsd: split off the write decode code in to a separate function
Date:   Wed, 11 Mar 2020 19:59:43 +0000
Message-ID: <20200311195954.27117-4-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195954.27117-1-fllinden@amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs4_decode_write has code to parse incoming XDR write data in to
a kvec head, and a list of pages.

Put this code in to a separate function, so that it can be used
later by the xattr code, for setxattr. No functional change.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4xdr.c | 72 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9761512674a0..6e7fc6a9931e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -257,6 +257,44 @@ svcxdr_dupstr(struct nfsd4_compoundargs *argp, void *buf, u32 len)
 	return p;
 }
 
+static __be32
+svcxdr_construct_vector(struct nfsd4_compoundargs *argp, struct kvec *head,
+			struct page ***pagelist, u32 buflen)
+{
+	int avail;
+	int len;
+	int pages;
+
+	/* Sorry .. no magic macros for this.. *
+	 * READ_BUF(write->wr_buflen);
+	 * SAVEMEM(write->wr_buf, write->wr_buflen);
+	 */
+	avail = (char *)argp->end - (char *)argp->p;
+	if (avail + argp->pagelen < buflen) {
+		dprintk("NFSD: xdr error (%s:%d)\n",
+			       __FILE__, __LINE__);
+		return nfserr_bad_xdr;
+	}
+	head->iov_base = argp->p;
+	head->iov_len = avail;
+	*pagelist = argp->pagelist;
+
+	len = XDR_QUADLEN(buflen) << 2;
+	if (len >= avail) {
+		len -= avail;
+
+		pages = len >> PAGE_SHIFT;
+		argp->pagelist += pages;
+		argp->pagelen -= pages * PAGE_SIZE;
+		len -= pages * PAGE_SIZE;
+
+		next_decode_page(argp);
+	}
+	argp->p += XDR_QUADLEN(len);
+
+	return 0;
+}
+
 /**
  * savemem - duplicate a chunk of memory for later processing
  * @argp: NFSv4 compound argument structure to be freed with
@@ -1265,8 +1303,6 @@ nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify
 static __be32
 nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 {
-	int avail;
-	int len;
 	DECODE_HEAD;
 
 	status = nfsd4_decode_stateid(argp, &write->wr_stateid);
@@ -1279,34 +1315,10 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 		goto xdr_error;
 	write->wr_buflen = be32_to_cpup(p++);
 
-	/* Sorry .. no magic macros for this.. *
-	 * READ_BUF(write->wr_buflen);
-	 * SAVEMEM(write->wr_buf, write->wr_buflen);
-	 */
-	avail = (char*)argp->end - (char*)argp->p;
-	if (avail + argp->pagelen < write->wr_buflen) {
-		dprintk("NFSD: xdr error (%s:%d)\n",
-				__FILE__, __LINE__);
-		goto xdr_error;
-	}
-	write->wr_head.iov_base = p;
-	write->wr_head.iov_len = avail;
-	write->wr_pagelist = argp->pagelist;
-
-	len = XDR_QUADLEN(write->wr_buflen) << 2;
-	if (len >= avail) {
-		int pages;
-
-		len -= avail;
-
-		pages = len >> PAGE_SHIFT;
-		argp->pagelist += pages;
-		argp->pagelen -= pages * PAGE_SIZE;
-		len -= pages * PAGE_SIZE;
-
-		next_decode_page(argp);
-	}
-	argp->p += XDR_QUADLEN(len);
+	status = svcxdr_construct_vector(argp, &write->wr_head,
+					 &write->wr_pagelist, write->wr_buflen);
+	if (status)
+		return status;
 
 	DECODE_TAIL;
 }
-- 
2.16.6

