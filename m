Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27623EABFA
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Aug 2021 22:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbhHLUmM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Aug 2021 16:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbhHLUmK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Aug 2021 16:42:10 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCB2C0617AE
        for <linux-nfs@vger.kernel.org>; Thu, 12 Aug 2021 13:41:45 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 92A601BE2; Thu, 12 Aug 2021 16:41:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 92A601BE2
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/2] nfsd4: Fix forced-expiry locking
Date:   Thu, 12 Aug 2021 16:41:43 -0400
Message-Id: <1628800903-10760-3-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628800903-10760-1-git-send-email-bfields@redhat.com>
References: <1628800903-10760-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

This should use the network-namespace-wide client_lock, not the
per-client cl_lock.

You shouldn't see any bugs unless you're actually using the
forced-expiry interface introduced by 89c905beccbb.

Fixes: 89c905beccbb "nfsd: allow forced expiration of NFSv4 clients"
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 212f43fa5cba..1b6a7f48982e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2687,9 +2687,9 @@ static void force_expire_client(struct nfs4_client *clp)
 
 	trace_nfsd_clid_admin_expired(&clp->cl_clientid);
 
-	spin_lock(&clp->cl_lock);
+	spin_lock(&nn->client_lock);
 	clp->cl_time = 0;
-	spin_unlock(&clp->cl_lock);
+	spin_unlock(&nn->client_lock);
 
 	wait_event(expiry_wq, atomic_read(&clp->cl_rpc_users) == 0);
 	spin_lock(&nn->client_lock);
-- 
2.31.1

