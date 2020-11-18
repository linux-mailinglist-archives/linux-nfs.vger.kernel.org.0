Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E522B7300
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Nov 2020 01:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgKRAYk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Nov 2020 19:24:40 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:22958 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKRAYj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Nov 2020 19:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605659079; x=1637195079;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gFlZ38MwH8yQdiFbxPN+HVi8DqXGDlanSljdPiGUeDM=;
  b=ORMuFMU+AatopXViHUN422do7kWLj/Z7Q2lEi1cOnvIypb5XFeDIkIPr
   5j8QEOuMjcOCu2XbtjuYTGZL3eiYx1HJE9eJCF5kdRqFslT/HmxeJOeGU
   DsIpZpPT2MHn+C4VbNLeGBlfwAEL9Nes28IoWFUgLLDfK6ED+pDIfZnE6
   M=;
X-IronPort-AV: E=Sophos;i="5.77,486,1596499200"; 
   d="scan'208";a="95133538"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 18 Nov 2020 00:24:33 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 1A887A220A;
        Wed, 18 Nov 2020 00:24:33 +0000 (UTC)
Received: from EX13D07UWB003.ant.amazon.com (10.43.161.66) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Nov 2020 00:24:32 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D07UWB003.ant.amazon.com (10.43.161.66) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Nov 2020 00:24:32 +0000
Received: from dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com
 (172.22.96.68) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Wed, 18 Nov 2020 00:24:31 +0000
Received: by dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com (Postfix, from userid 4335130)
        id 7BE4440E2D; Wed, 18 Nov 2020 00:24:31 +0000 (UTC)
Date:   Wed, 18 Nov 2020 00:24:31 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anchalag@amazon.com>
Subject: [PATCH] NFS: Retry the CLOSE if the embedded GETATTR is rejected
 with ERR_STALE
Message-ID: <20201118002431.GA6941@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If our CLOSE RPC call is rejected with an ERR_STALE error, then we
should remove the GETATTR call from the compound RPC and retry.
This could happen in a scenario where two clients tries to access
the same file. One client opens the file and the other client removes
the file while it's opened by first client. When the first client
attempts to close the file the server returns ESTALE and the file ends
up being leaked on the server. This depends on how nfs server is
configured and is not reproducible if running against nfsd.

Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
---
 fs/nfs/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9e0ca9b2b210..40e4259bc83e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3548,6 +3548,7 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
 			res_stateid = &calldata->res.stateid;
 			renew_lease(server, calldata->timestamp);
 			break;
+		case -ESTALE:
 		case -NFS4ERR_ACCESS:
 			if (calldata->arg.bitmask != NULL) {
 				calldata->arg.bitmask = NULL;
-- 
2.16.6

