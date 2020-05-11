Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0811D1CDC47
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2020 15:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgEKN5q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 May 2020 09:57:46 -0400
Received: from fieldses.org ([173.255.197.46]:54464 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbgEKN5q (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 11 May 2020 09:57:46 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A9AA38A6; Mon, 11 May 2020 09:57:45 -0400 (EDT)
Date:   Mon, 11 May 2020 09:57:45 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: fix NULL deference in nfs4_get_valid_delegation
Message-ID: <20200511135745.GB8629@fieldses.org>
References: <20200508221935.GA11225@fieldses.org>
 <20200511121054.l2j34vnwqxhvd2ao@gabell>
 <20200511131637.GA8629@fieldses.org>
 <8f9f84f11df6f5caf054d1eada2d91ea158a6882.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f9f84f11df6f5caf054d1eada2d91ea158a6882.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 11, 2020 at 01:43:30PM +0000, Trond Myklebust wrote:
> On Mon, 2020-05-11 at 09:16 -0400, J. Bruce Fields wrote:
> > Thanks, applying.--b.
> > 
> 
> You're applying? So should I remove it from the NFS client bugfixes?

No.  Sorry, I responded to the wrong email!

--b.

> 
> > On Mon, May 11, 2020 at 08:10:54AM -0400, Masayoshi Mizuma wrote:
> > > On Fri, May 08, 2020 at 06:19:35PM -0400, J. Bruce Fields wrote:
> > > > From: "J. Bruce Fields" <bfields@redhat.com>
> > > > 
> > > > We add the new state to the nfsi->open_states list, making it
> > > > potentially visible to other threads, before we've finished
> > > > initializing
> > > > it.
> > > > 
> > > > That wasn't a problem when all the readers were also taking the
> > > > i_lock
> > > > (as we do here), but since we switched to RCU, there's now a
> > > > possibility
> > > > that a reader could see the partially initialized state.
> > > > 
> > > > Symptoms observed were a crash when another thread called
> > > > nfs4_get_valid_delegation() on a NULL inode.
> > > > 
> > > > Fixes: 9ae075fdd190 "NFSv4: Convert open state lookup to use RCU"
> > > > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > > > ---
> > > >  fs/nfs/nfs4state.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> > > > index ac93715c05a4..a8dc25ce48bb 100644
> > > > --- a/fs/nfs/nfs4state.c
> > > > +++ b/fs/nfs/nfs4state.c
> > > > @@ -734,9 +734,9 @@ nfs4_get_open_state(struct inode *inode,
> > > > struct nfs4_state_owner *owner)
> > > >  		state = new;
> > > >  		state->owner = owner;
> > > >  		atomic_inc(&owner->so_count);
> > > > -		list_add_rcu(&state->inode_states, &nfsi->open_states);
> > > >  		ihold(inode);
> > > >  		state->inode = inode;
> > > > +		list_add_rcu(&state->inode_states, &nfsi->open_states);
> > > >  		spin_unlock(&inode->i_lock);
> > > >  		/* Note: The reclaim code dictates that we add
> > > > stateless
> > > >  		 * and read-only stateids to the end of the list */
> > > > -- 
> > > 
> > > Thank you for posting the patch! It works for our box.
> > > Please feel free to add:
> > > 
> > >         Reviewed-by: Seiichi Ikarashi <s.ikarashi@fujitsu.com>
> > >         Tested-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> > >         Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > > 
> > > Without the patch, the system which is a NFSv4 client has been
> > > crashed randomly. The panic log is such as:
> > > 
> > >    BUG: unable to handle page fault for address: ffffffffffffffb0
> > >    ...
> > >    RIP: 0010:nfs4_get_valid_delegation+0x6/0x30 [nfsv4]
> > >    ...
> > >    Call Trace:
> > >     nfs4_open_prepare+0x80/0x1c0 [nfsv4]
> > >     __rpc_execute+0x75/0x390 [sunrpc]
> > >     ? finish_task_switch+0x75/0x260
> > >     rpc_async_schedule+0x29/0x40 [sunrpc]
> > >     process_one_work+0x1ad/0x370
> > >     worker_thread+0x30/0x390
> > >     ? create_worker+0x1a0/0x1a0
> > >     kthread+0x10c/0x130
> > >     ? kthread_park+0x80/0x80
> > >     ret_from_fork+0x22/0x30
> > > 
> > > After applied the patch, the panic is gone.
> > > 
> > > Thanks!
> > > Masa
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
