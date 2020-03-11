Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F90A182304
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 21:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbgCKUAC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 16:00:02 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:63729 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387473AbgCKUAB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 16:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956801; x=1615492801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=RxCprOBbhhDYGJakIc0s+JXnS0XmF+nCWgm968lVBs4=;
  b=vWWRj8gQVMnZDnay39KXt11kSasXyylrZZZ9xVYaCUqsdZLSujitQ6Va
   6if52yAygS5619vbjwm96pMiRV9c+MJC4dmcKjCLio5tCTB5z4X2oP9iI
   O2s1hnz5ajdOcSsbiGiyZmx9hXnvOeBYNriQ+Ihy5g/Er4rnJiDS3+YVT
   Q=;
IronPort-SDR: YI+WDTyGc3+zKWuCdteanxVnx2waXcJn9rnDuAvHbnpkDWDaM1f8Delz4Vuj6bJv/efuo3mwWF
 Qa3YF6JB70FQ==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="32054198"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 11 Mar 2020 20:00:00 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id BA01DA2B7C;
        Wed, 11 Mar 2020 19:59:57 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:59:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:59:55 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1236.3 via Frontend Transport; Wed, 11 Mar 2020 19:59:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 1BC8FDEF47; Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 09/14] nfsd: use kvmalloc in svcxdr_tmpalloc
Date:   Wed, 11 Mar 2020 19:59:49 +0000
Message-ID: <20200311195954.27117-10-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195954.27117-1-fllinden@amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For user extended attributes, temp allocations larger than one page
might be needed.

Use kvmalloc/kvfree to accommodate these larger allocations, while not
affecting the performance of the smaller ones.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4xdr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6e7fc6a9931e..f6322add2992 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -230,7 +230,7 @@ svcxdr_tmpalloc(struct nfsd4_compoundargs *argp, u32 len)
 {
 	struct svcxdr_tmpbuf *tb;
 
-	tb = kmalloc(sizeof(*tb) + len, GFP_KERNEL);
+	tb = kvmalloc(sizeof(*tb) + len, GFP_KERNEL);
 	if (!tb)
 		return NULL;
 	tb->next = argp->to_free;
@@ -4691,7 +4691,7 @@ void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 	while (args->to_free) {
 		struct svcxdr_tmpbuf *tb = args->to_free;
 		args->to_free = tb->next;
-		kfree(tb);
+		kvfree(tb);
 	}
 }
 
-- 
2.16.6

