Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FD61CE26E
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2020 20:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgEKSSQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 May 2020 14:18:16 -0400
Received: from fieldses.org ([173.255.197.46]:54828 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729768AbgEKSSQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 11 May 2020 14:18:16 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id F407B709; Mon, 11 May 2020 14:18:15 -0400 (EDT)
Date:   Mon, 11 May 2020 14:18:15 -0400
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd4: remove "client testing stateid" log spam
Message-ID: <20200511181815.GK8629@fieldses.org>
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

I try not to log even buggy client behavior by default, as I'd rather
not give malicious clients a way to spam the logs.

But this condition isn't even a sign of a buggy client--in recovery
cases it's normal to test stateid's from a no-longer-active clientid.

I'd be open to dprintk's or tracing here if people think it's necessary.
For now, just remove this.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 65cfe9ab47be..e7a592f0a27e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5521,15 +5521,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
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
2.26.2

