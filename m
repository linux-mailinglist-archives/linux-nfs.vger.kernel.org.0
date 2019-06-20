Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 436124D0E0
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2019 16:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfFTOvV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jun 2019 10:51:21 -0400
Received: from fieldses.org ([173.255.197.46]:43452 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfFTOvV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 Jun 2019 10:51:21 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 17DBB1CE6; Thu, 20 Jun 2019 10:51:21 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 05/16] nfsd: make client/ directory names small ints
Date:   Thu, 20 Jun 2019 10:51:04 -0400
Message-Id: <1561042275-12723-6-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561042275-12723-1-git-send-email-bfields@redhat.com>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

We want clientid's on the wire to be randomized for reasons explained in
ebd7c72c63ac "nfsd: randomize SETCLIENTID reply to help distinguish
servers".  But I'd rather have mostly small integers for the clients/
directory.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/netns.h     | 1 +
 fs/nfsd/nfs4state.c | 2 +-
 fs/nfsd/nfsctl.c    | 5 +++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index cee843e8e440..190d5a71415a 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -124,6 +124,7 @@ struct nfsd_net {
 	 */
 	unsigned int max_connections;
 
+	u32 clientid_base;
 	u32 clientid_counter;
 	u32 clverifier_counter;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index cf081a8d6b6b..370ee6f6b246 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2242,7 +2242,7 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	clp->cl_cb_session = NULL;
 	clp->net = net;
 	clp->cl_nfsd_dentry = nfsd_client_mkdir(nn, &clp->cl_nfsdfs,
-						clp->cl_clientid.cl_id);
+			clp->cl_clientid.cl_id - nn->clientid_base);
 	if (!clp->cl_nfsd_dentry) {
 		free_client(clp);
 		return NULL;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 638a25648dcb..50c103c1aa13 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1212,7 +1212,7 @@ struct dentry *nfsd_client_mkdir(struct nfsd_net *nn, struct nfsdfs_client *ncl,
 {
 	char name[11];
 
-	sprintf(name, "%d", id++);
+	sprintf(name, "%u", id);
 
 	return nfsd_mkdir(nn->nfsd_client_dir, ncl, name);
 }
@@ -1348,7 +1348,8 @@ static __net_init int nfsd_init_net(struct net *net)
 	nn->somebody_reclaimed = false;
 	nn->track_reclaim_completes = false;
 	nn->clverifier_counter = prandom_u32();
-	nn->clientid_counter = prandom_u32();
+	nn->clientid_base = prandom_u32();
+	nn->clientid_counter = nn->clientid_base + 1;
 	nn->s2s_cp_cl_id = nn->clientid_counter++;
 
 	atomic_set(&nn->ntf_refcnt, 0);
-- 
2.21.0

