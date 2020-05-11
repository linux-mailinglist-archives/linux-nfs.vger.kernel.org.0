Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBE91CDC72
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2020 16:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgEKOCs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 May 2020 10:02:48 -0400
Received: from fieldses.org ([173.255.197.46]:54488 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729279AbgEKOCs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 11 May 2020 10:02:48 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 3E53528E6; Mon, 11 May 2020 10:02:48 -0400 (EDT)
Date:   Mon, 11 May 2020 10:02:48 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfs: fix NULL deference in nfs4_get_valid_delegation
Message-ID: <20200511140248.GE8629@fieldses.org>
References: <20200508221935.GA11225@fieldses.org>
 <20200511121054.l2j34vnwqxhvd2ao@gabell>
 <20200511131637.GA8629@fieldses.org>
 <8f9f84f11df6f5caf054d1eada2d91ea158a6882.camel@hammerspace.com>
 <20200511135745.GB8629@fieldses.org>
 <20200511140158.GD8629@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511140158.GD8629@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
nfs4_get_valid_delegation() on a NULL inode, resulting in an oops like:

	BUG: unable to handle page fault for address: ffffffffffffffb0 ...
	RIP: 0010:nfs4_get_valid_delegation+0x6/0x30 [nfsv4] ...
	Call Trace:
	 nfs4_open_prepare+0x80/0x1c0 [nfsv4]
	 __rpc_execute+0x75/0x390 [sunrpc]
	 ? finish_task_switch+0x75/0x260
	 rpc_async_schedule+0x29/0x40 [sunrpc]
	 process_one_work+0x1ad/0x370
	 worker_thread+0x30/0x390
	 ? create_worker+0x1a0/0x1a0
	 kthread+0x10c/0x130
	 ? kthread_park+0x80/0x80
	 ret_from_fork+0x22/0x30

Fixes: 9ae075fdd190 "NFSv4: Convert open state lookup to use RCU"
Reviewed-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
Tested-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfs/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

> I do have a patch including the tags and oops provided by Masayoshi
> Mizuma, if you'd like to take that instead.  See followup.--b.

Here you go.

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index f7723d221945..459c7fb5d103 100644
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

