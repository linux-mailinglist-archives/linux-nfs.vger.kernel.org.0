Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823AE45C990
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Nov 2021 17:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242747AbhKXQNt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Nov 2021 11:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242698AbhKXQNs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Nov 2021 11:13:48 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F05C06173E
        for <linux-nfs@vger.kernel.org>; Wed, 24 Nov 2021 08:10:38 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 57E52685A; Wed, 24 Nov 2021 11:10:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 57E52685A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1637770238;
        bh=ls1XPshGNJYTiWTgddj+jV+m/DrE966XCWybr9nN8Vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ScTUEPt0DyS+atW9yzexdyuSNYxTLAUqK3oS8o5OHKLzaZ8biWZL1ebgKqQPstRWM
         U/nv+JKbVpJ6EB+W9kA0ZtsbtfZQttE6DEjm6nZOPNFeYCZ8/bfHqp1Xp4ob5VyDTs
         8HttKa8o42yxLQyC11AG7x3Q6u+rESlpBU1fZOaw=
Date:   Wed, 24 Nov 2021 11:10:38 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "olivier@bm-services.com" <olivier@bm-services.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "carnil@debian.org" <carnil@debian.org>
Subject: Re: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Message-ID: <20211124161038.GC30602@fieldses.org>
References: <20201011075913.GA8065@eldamar.lan>
 <20201012142602.GD26571@fieldses.org>
 <20201012154159.GA49819@eldamar.lan>
 <20201012163355.GF26571@fieldses.org>
 <20201018093903.GA364695@eldamar.lan>
 <YV3vDQOPVgxc/J99@eldamar.lan>
 <3899037dd7d44e879d77bba67b3455ee@bm-services.com>
 <DACA385D-5BBF-46D0-890D-71572BD0CB8A@oracle.com>
 <20211124152947.GA30602@fieldses.org>
 <0dbe620703eb27f36c02b4e001e74d67390bce9e.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dbe620703eb27f36c02b4e001e74d67390bce9e.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 24, 2021 at 03:59:47PM +0000, Trond Myklebust wrote:
> On Wed, 2021-11-24 at 10:29 -0500, Bruce Fields wrote:
> > On Mon, Nov 22, 2021 at 03:17:28PM +0000, Chuck Lever III wrote:
> > > 
> > > 
> > > > On Nov 22, 2021, at 4:15 AM, Olivier Monaco
> > > > <olivier@bm-services.com> wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > I think my problem is related to this thread.
> > > > 
> > > > We are running a VMware vCenter platform running 9 groups of
> > > > virtual machines. Each group includes a VM with NFS for file
> > > > sharing and 3 VMs with NFS clients, so we are running 9
> > > > independent file servers.
> > > 
> > > I've opened https://bugzilla.linux-nfs.org/show_bug.cgi?id=371
> > > 
> > > Just a random thought: would enabling KASAN shed some light?
> > 
> > In fact, we've gotten reports from Redhat QE of a KASAN use-after-
> > free
> > warning in the laundromat thread, which I think might be the same
> > bug.
> > We've been getting occasional reports of problems here for a long
> > time,
> > but they've been very hard to reproduce.
> > 
> > After fooling with their reproducer, I think I finally have it.
> > Embarrasingly, it's nothing that complicated.  You can make it much
> > easier to reproduce by adding an msleep call after the vfs_setlease
> > in
> > nfs4_set_delegation.
> > 
> > If it's possible to run a patched kernel in production, you could try
> > the following, and I'd definitely be interested in any results.
> > 
> > Otherwise, you can probably work around the problem by disabling
> > delegations.  Something like
> > 
> >         sudo echo "fs.leases-enable = 0" >/etc/sysctl.d/nfsd-
> > workaround.conf
> > 
> > should do it.
> > 
> > Not sure if this fix is best or if there's something simpler.
> > 
> > --b.
> > 
> > commit 6de51237589e
> > Author: J. Bruce Fields <bfields@redhat.com>
> > Date:   Tue Nov 23 22:31:04 2021 -0500
> > 
> >     nfsd: fix use-after-free due to delegation race
> >     
> >     A delegation break could arrive as soon as we've called
> > vfs_setlease.  A
> >     delegation break runs a callback which immediately (in
> >     nfsd4_cb_recall_prepare) adds the delegation to del_recall_lru. 
> > If we
> >     then exit nfs4_set_delegation without hashing the delegation, it
> > will be
> >     freed as soon as the callback is done with it, without ever being
> >     removed from del_recall_lru.
> >     
> >     Symptoms show up later as use-after-free or list corruption
> > warnings,
> >     usually in the laundromat thread.
> >     
> >     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index bfad94c70b84..8e063f49240b 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5159,15 +5159,16 @@ nfs4_set_delegation(struct nfs4_client *clp,
> > struct svc_fh *fh,
> >                 locks_free_lock(fl);
> >         if (status)
> >                 goto out_clnt_odstate;
> > +
> >         status = nfsd4_check_conflicting_opens(clp, fp);
> > -       if (status)
> > -               goto out_unlock;
> >  
> >         spin_lock(&state_lock);
> >         spin_lock(&fp->fi_lock);
> > -       if (fp->fi_had_conflict)
> > +       if (status || fp->fi_had_conflict) {
> > +               list_del_init(&dp->dl_recall_lru);
> > +               dp->dl_time++;
> >                 status = -EAGAIN;
> > -       else
> > +       } else
> >                 status = hash_delegation_locked(dp, fp);
> >         spin_unlock(&fp->fi_lock);
> >         spin_unlock(&state_lock);
> 
> Why won't this leak a reference to the stid?

I'm not seeing it.

> Afaics nfsd_break_one_deleg() does take a reference before launching
> the callback daemon, and that reference is released when the
> delegation is later processed by the laundromat.

Right.  Basically, there are two "long-lived" references, one taken as
long as the callback's using it, one taken as long as it's "hashed" (see
hash_delegation_locked/unhash_delegation_locked).

In the -EAGAIN case above, we're holding a temporary reference which
will be dropped on exit from this function; if a callback's in progress,
it will then drop the final reference.

> Hmm... Isn't the real bug here rather that the laundromat is corrupting
> both the nn->client_lru and nn->del_recall_lru lists because it is
> using list_add() instead of list_move() when adding these objects to
> the reaplist?

If that were the problem, I think we'd be hitting it all the time.
Looking....  No, unhash_delegation_locked did a list_del_init().

(Is the WARN_ON there too ugly?)

--b.
