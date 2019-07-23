Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE0072107
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2019 22:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbfGWUpi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jul 2019 16:45:38 -0400
Received: from fieldses.org ([173.255.197.46]:34464 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731769AbfGWUpi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Jul 2019 16:45:38 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 328781CE7; Tue, 23 Jul 2019 16:45:37 -0400 (EDT)
Date:   Tue, 23 Jul 2019 16:45:37 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 4/8] NFSD add COPY_NOTIFY operation
Message-ID: <20190723204537.GA19559@fieldses.org>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-5-olga.kornievskaia@gmail.com>
 <20190717230726.GA26801@fieldses.org>
 <CAN-5tyHmODP2+nMiinTEP5WZzXz=m=j9LBSWv=b=N3C211JaLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyHmODP2+nMiinTEP5WZzXz=m=j9LBSWv=b=N3C211JaLg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 22, 2019 at 04:17:44PM -0400, Olga Kornievskaia wrote:
> On Wed, Jul 17, 2019 at 7:07 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Mon, Jul 08, 2019 at 03:23:48PM -0400, Olga Kornievskaia wrote:
> > > @@ -726,24 +727,53 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
> > >  /*
> > >   * Create a unique stateid_t to represent each COPY.
> > >   */
> > > -int nfs4_init_cp_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
> > > +static int nfs4_init_cp_state(struct nfsd_net *nn, void *ptr, stateid_t *stid)
> > >  {
> > >       int new_id;
> > >
> > >       idr_preload(GFP_KERNEL);
> > >       spin_lock(&nn->s2s_cp_lock);
> > > -     new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, copy, 0, 0, GFP_NOWAIT);
> > > +     new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, ptr, 0, 0, GFP_NOWAIT);
> > >       spin_unlock(&nn->s2s_cp_lock);
> > >       idr_preload_end();
> > >       if (new_id < 0)
> > >               return 0;
> > > -     copy->cp_stateid.si_opaque.so_id = new_id;
> > > -     copy->cp_stateid.si_opaque.so_clid.cl_boot = nn->boot_time;
> > > -     copy->cp_stateid.si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
> > > +     stid->si_opaque.so_id = new_id;
> > > +     stid->si_opaque.so_clid.cl_boot = nn->boot_time;
> > > +     stid->si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
> > >       return 1;
> > >  }
> > >
> > > -void nfs4_free_cp_state(struct nfsd4_copy *copy)
> > > +int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
> > > +{
> > > +     return nfs4_init_cp_state(nn, copy, &copy->cp_stateid);
> > > +}
> >
> > This little bit of refactoring could go into a seperate patch.  It's
> > easier for me to review lots of smaller patches.
> >
> > But I don't understand why you're doing it.
> >
> > Also, I'm a little suspicious of code that doesn't initialize an object
> > till after it's been added to a global structure.  The more typical
> > pattern is:
> >
> >
> >         initialize foo
> >         take locks, add foo global structure, drop locks.
> >
> > This prevents anyone doing a lookup from finding "foo" while it's still
> > in a partially initialized state.
> 
> Let me try to explain the change. This change is due to the fact that
> now both COPY_NOTIFY and COPY both are generating unique stateid
> (COPY_NOTIFY needs a unique stateid to passed into the COPY and COPY
> is generating a unique stateid to be referred to by callbacks).
> Previously we had just the COPY generating the stateid (so it was
> stored in the nfs4_copy structure) but now we have the COPY_NOTIFY
> which doesn't create nfs4_copy when it's processing the operation but
> still needs a unique stateid (stored in the stateid structure).

The usual way to handle a situation like this is to store in the idr a
pointer to the stateid (copy->cp_stateid or cps->cp_stateid).  When you
do a lookup you do something like:

	st = idr_find(...);
	copy = container_of(st, struct nfsd4_copy, cp_stateid);

to get a copy to the larger structure.

By the way, in find_internal_cpntf_state, a buggy or malicious client
could cause idr_find to look up a copy (not a copy_notify) stateid.  The
code needs some way to distinguish the two cases.  You could use a
different cl_id for the two cases.  That might also be handy for
debugging.  And/or you could do as we do in the case of open, lock, and
other stateid's and embed a common structure that also includes a "type"
field.  (See nfs4_stid->sc_type).

> Let me see if I understand your suspicion and ask for guidance how to
> resolve it as perhaps I'm misusing the function. idr_alloc_cyclic()
> keeps track of the structure of the 2nd arguments with a value it
> returns. How do I initiate the structure with the value of the
> function without knowing the value which can only be returned when I
> call the function to add it to the list? what you are suggesting is to
> somehow get the value for the new_id but not associate anything then
> update the copy structure with that value and then call
> idr_alloc_cyclic() (or something else) to create that association of
> the new_id and the structure? I don't know how to do that.

You could move the initialization under the s2s_cp_lock.  But there's
additional initialization that's done in the caller.

So, either this needs more locking, or maybe some flag value set to
indicate that the object is initialized and safe to use.  (In the case
of open/lock/etc.  stateid's I think that is sc_type.  I'm not
completely convinced we've got that correct, though.)

--b.
