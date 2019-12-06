Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA9E111571F
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2019 19:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfLFSYP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Dec 2019 13:24:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfLFSYP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Dec 2019 13:24:15 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CEC02173E;
        Fri,  6 Dec 2019 18:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575656654;
        bh=1adZ1AgCodi3yfl22ybU9XywdoW/YwynEVekYlf8iyg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bip68FgbFhzD7abAaLaKKwmZ/PlKrEsoPog/fOBXd3A8vVVSJLOwL3Z7hM5oDt28X
         x5kk2JXh6nTEpwuKmeqQ8tRKqP41kLhRJm3X7IeKrf82/z9NeEQ/FhP+pgtJaVl8en
         eFj15Rtqf0hFVJJ8Lrw1ZuQAtrha5zryvGXnkMkk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 662B035206AB; Fri,  6 Dec 2019 10:24:14 -0800 (PST)
Date:   Fri, 6 Dec 2019 10:24:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "madhuparnabhowmik04@gmail.com" <madhuparnabhowmik04@gmail.com>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fs: nfs: dir.c: Fix sparse error
Message-ID: <20191206182414.GH2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191206151640.10966-1-madhuparnabhowmik04@gmail.com>
 <20191206160238.GE2889@paulmck-ThinkPad-P72>
 <2ec21ec537144bb3c0d5fbdaf88ea022d07b7ff8.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec21ec537144bb3c0d5fbdaf88ea022d07b7ff8.camel@hammerspace.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 06, 2019 at 05:52:10PM +0000, Trond Myklebust wrote:
> Hi Paul,
> 
> On Fri, 2019-12-06 at 08:02 -0800, Paul E. McKenney wrote:
> > On Fri, Dec 06, 2019 at 08:46:40PM +0530, 
> > madhuparnabhowmik04@gmail.com wrote:
> > > From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > > 
> > > This patch fixes the following errors:
> > > fs/nfs/dir.c:2353:14: error: incompatible types in comparison
> > > expression (different address spaces):
> > > fs/nfs/dir.c:2353:14:    struct list_head [noderef] <asn:4> *
> > > fs/nfs/dir.c:2353:14:    struct list_head *
> > > 
> > > caused due to directly accessing the prev pointer of
> > > a RCU protected list.
> > > Accessing the pointer using the macro list_prev_rcu() fixes this
> > > error.
> > > 
> > > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > > ---
> > >  fs/nfs/dir.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > > index e180033e35cf..2035254cc283 100644
> > > --- a/fs/nfs/dir.c
> > > +++ b/fs/nfs/dir.c
> > > @@ -2350,7 +2350,7 @@ static int nfs_access_get_cached_rcu(struct
> > > inode *inode, const struct cred *cre
> > >  	rcu_read_lock();
> > >  	if (nfsi->cache_validity & NFS_INO_INVALID_ACCESS)
> > >  		goto out;
> > > -	lh = rcu_dereference(nfsi->access_cache_entry_lru.prev);
> > > +	lh = rcu_dereference(list_prev_rcu(&nfsi-
> > > >access_cache_entry_lru));
> > 
> > And as noted in the earlier email, what is preventing concurrent
> > insertions into  and deletions from this list?
> > 
> > o	This use of list_move_tail() is OK because it does not poison.
> > 	Though it isn't being all that friendly to lockless access to
> > 	->prev -- no WRITE_ONCE() in list_move_tail().
> > 
> > o	The use of list_add_tail() is not safe with RCU readers, though
> > 	they do at least partially compensate via use of smp_wmb()
> > 	in nfs_access_add_cache() before calling
> > nfs_access_add_rbtree().
> > 
> > o	The list_del() near the end of nfs_access_add_rbtree() will
> > 	poison the ->prev pointer.  I don't see how this is safe given
> > the
> > 	possibility of a concurrent call to
> > nfs_access_get_cached_rcu().
> 
> The pointer nfsi->access_cache_entry_lru is the head of the list, so it
> won't get poisoned. Furthermore, the objects it points to are freed
> using kfree_rcu(), so they will survive as long as we hold the rcu read
> lock. The object's cred pointers also points to something that is freed
> in an rcu-safe manner.
> 
> The problem here is rather that a racing list_del() can cause nfsi-
> >access_cache_entry_lru to be empty, which is presumably why Neil added
> that check plus the empty cred pointer check in the following line.
> 
> The barrier semantics may be suspect, although the spin unlock after
> list_del() should presumably guarantee release semantics?

Ah, OK, so you are only ever using ->prev only from the head of the list,
and presumably never do list_del() on the head itself.  (Don't laugh,
this does really happen as a way to remove the entire list, though
perhaps with list_del_init() rather than list_del().)

Maybe we should have a list_tail_rcu() that is only expected to work
on the head of the list?

							Thanx, Paul
