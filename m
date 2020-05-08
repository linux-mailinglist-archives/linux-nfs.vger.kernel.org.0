Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920F11CBAA0
	for <lists+linux-nfs@lfdr.de>; Sat,  9 May 2020 00:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEHWTf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 May 2020 18:19:35 -0400
Received: from fieldses.org ([173.255.197.46]:51030 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbgEHWTf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 8 May 2020 18:19:35 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 0772E20C8; Fri,  8 May 2020 18:19:35 -0400 (EDT)
Date:   Fri, 8 May 2020 18:19:35 -0400
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: fix NULL deference in nfs4_get_valid_delegation
Message-ID: <20200508221935.GA11225@fieldses.org>
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

We add the new state to the nfsi->open_states list, making it
potentially visible to other threads, before we've finished initializing
it.

That wasn't a problem when all the readers were also taking the i_lock
(as we do here), but since we switched to RCU, there's now a possibility
that a reader could see the partially initialized state.

Symptoms observed were a crash when another thread called
nfs4_get_valid_delegation() on a NULL inode.

Fixes: 9ae075fdd190 "NFSv4: Convert open state lookup to use RCU"
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfs/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index ac93715c05a4..a8dc25ce48bb 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -734,9 +734,9 @@ nfs4_get_open_state(struct inode *inode, struct nfs4_state_owner *owner)
 		state = new;
 		state->owner = owner;
 		atomic_inc(&owner->so_count);
-		list_add_rcu(&state->inode_states, &nfsi->open_states);
 		ihold(inode);
 		state->inode = inode;
+		list_add_rcu(&state->inode_states, &nfsi->open_states);
 		spin_unlock(&inode->i_lock);
 		/* Note: The reclaim code dictates that we add stateless
 		 * and read-only stateids to the end of the list */
-- 
2.26.2

