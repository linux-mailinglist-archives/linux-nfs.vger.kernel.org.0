Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 514141961DF
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 00:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgC0X1d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 19:27:33 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:24673 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgC0X1d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 19:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585351654; x=1616887654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=YiiUVE6C1TdzAUkxlQ7KEAurqDcrRhjnoh86i7WR7Iw=;
  b=MVgvuCpFmpFTmHGMUChbT4iXeKVjfd3mn/4HpaSByDVBD8M4glfF6zBm
   DrUdipQgidG31hxW+wpVRnNbYbvHsqjvv2bsfqaQi8XQs5/yeOnE91h3i
   gpw5f8NJRKLwfNps2OVnoAxoDouix9bWkBu9rl6VVn+m6q5/ckpYlna/+
   Y=;
IronPort-SDR: DI7utHEgWNWpuTXjuCcXHj43N9KJtBb6U8JRNqICSxR68qDXO3ZU247faaysl9FtR0SeiJTVZk
 +Xb6rRYmcr2g==
X-IronPort-AV: E=Sophos;i="5.72,314,1580774400"; 
   d="scan'208";a="23508668"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 27 Mar 2020 23:27:20 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 2A916A20A9;
        Fri, 27 Mar 2020 23:27:19 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 27 Mar 2020 23:27:18 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Mar 2020 23:27:18 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1236.3 via Frontend Transport; Fri, 27 Mar 2020 23:27:17 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 3BD93DEFB1; Fri, 27 Mar 2020 23:27:17 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 04/11] nfsd: split off the write decode code in to a separate function
Date:   Fri, 27 Mar 2020 23:27:10 +0000
Message-ID: <20200327232717.15331-5-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200327232717.15331-1-fllinden@amazon.com>
References: <20200327232717.15331-1-fllinden@amazon.com>
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
2.17.2

