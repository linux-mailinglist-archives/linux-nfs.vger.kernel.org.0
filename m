Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D4018B92E
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 15:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCSOSt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 10:18:49 -0400
Received: from fieldses.org ([173.255.197.46]:46672 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgCSOSt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Mar 2020 10:18:49 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 1361CBD1; Thu, 19 Mar 2020 10:18:49 -0400 (EDT)
Date:   Thu, 19 Mar 2020 10:18:49 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd4: kill warnings on testing stateids with mismatched
 clientids
Message-ID: <20200319141849.GB1546@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

It's normal for a client to test a stateid from a previous instance,
e.g. after a network partition.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

I'm not a fan of printk's even on buggy client behavior.  I guess it
could be a dprintk.  I'm not sure it adds much over information you
could get at some other layer, e.g. from a network trace.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c1f347bbf8f4..927cfb9d2204 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5522,15 +5522,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return status;
-	/* Client debugging aid. */
-	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid)) {
-		char addr_str[INET6_ADDRSTRLEN];
-		rpc_ntop((struct sockaddr *)&cl->cl_addr, addr_str,
-				 sizeof(addr_str));
-		pr_warn_ratelimited("NFSD: client %s testing state ID "
-					"with incorrect client ID\n", addr_str);
+	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid))
 		return status;
-	}
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s)
-- 
2.25.1

