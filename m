Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E85206761
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbgFWWoT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:19 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:16532 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387848AbgFWWoQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952255; x=1624488255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=PYZZIRQVQvMvYw/RAGnIhD0NhAB3GAQRrP27LEPwuaI=;
  b=oCQXX/O+raETK6Ezh/xX7qMQyPC3ct/22jFcazG2FipA/QDbTT3++Pnl
   qtsZMmk1NCmNLLcL4olUDU+4nAW8QWkgSctpoA/vUQL5CSTflnkS9PGeT
   7uLNVi3f+SrgTQwtqhmiAYkqEuq85nQ0GmKlPcscWr6PtIP4Zdi27xmLE
   k=;
IronPort-SDR: 7p81VCXoQia3e3t7U+rPX0Pp3gQZoYDAa6t/79PhhafWOjK2eoDENglrmWKe0/N0/Yztj0PR0t
 VzYai8Mgxr2A==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="39410393"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 23 Jun 2020 22:39:37 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 74335A1DBB;
        Tue, 23 Jun 2020 22:39:37 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:29 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:29 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:28 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 10E4CCD35E; Tue, 23 Jun 2020 22:39:28 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 04/10] nfsd: split off the write decode code in to a separate function
Date:   Tue, 23 Jun 2020 22:39:21 +0000
Message-ID: <20200623223927.31795-5-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223927.31795-1-fllinden@amazon.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
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
 fs/nfsd/nfs4xdr.c | 72 +++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 996ac01ee977..48806b493eba 100644
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
2.17.2

