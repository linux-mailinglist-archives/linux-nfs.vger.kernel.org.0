Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61BEB7212C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2019 22:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389107AbfGWU6r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jul 2019 16:58:47 -0400
Received: from fieldses.org ([173.255.197.46]:34480 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389103AbfGWU6r (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Jul 2019 16:58:47 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 4E8B82011; Tue, 23 Jul 2019 16:58:46 -0400 (EDT)
Date:   Tue, 23 Jul 2019 16:58:46 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 5/8] NFSD check stateids against copy stateids
Message-ID: <20190723205846.GB19559@fieldses.org>
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-6-olga.kornievskaia@gmail.com>
 <20190719220116.GA24373@fieldses.org>
 <CAN-5tyHdxBcEH0xPV2814nUMEHPCsQ9iD_A7K=W3ZeE6b4OJxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyHdxBcEH0xPV2814nUMEHPCsQ9iD_A7K=W3ZeE6b4OJxg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 22, 2019 at 04:24:08PM -0400, Olga Kornievskaia wrote:
> On Fri, Jul 19, 2019 at 6:01 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Mon, Jul 08, 2019 at 03:23:49PM -0400, Olga Kornievskaia wrote:
> > > Incoming stateid (used by a READ) could be a saved copy stateid.
> > > On first use make it active and check that the copy has started
> > > within the allowable lease time.
> > >
> > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > ---
> > >  fs/nfsd/nfs4state.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 45 insertions(+)
> > >
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 2555eb9..b786625 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -5232,6 +5232,49 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
> > >
> > >       return 0;
> > >  }
> > > +/*
> > > + * A READ from an inter server to server COPY will have a
> > > + * copy stateid. Return the parent nfs4_stid.
> > > + */
> > > +static __be32 _find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
> > > +                  struct nfs4_cpntf_state **cps)
> > > +{
> > > +     struct nfs4_cpntf_state *state = NULL;
> > > +
> > > +     if (st->si_opaque.so_clid.cl_id != nn->s2s_cp_cl_id)
> > > +             return nfserr_bad_stateid;
> > > +     spin_lock(&nn->s2s_cp_lock);
> > > +     state = idr_find(&nn->s2s_cp_stateids, st->si_opaque.so_id);
> > > +     if (state)
> > > +             refcount_inc(&state->cp_p_stid->sc_count);
> > > +     spin_unlock(&nn->s2s_cp_lock);
> > > +     if (!state)
> > > +             return nfserr_bad_stateid;
> > > +     *cps = state;
> > > +     return 0;
> > > +}
> > > +
> > > +static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
> > > +                            struct nfs4_stid **stid)
> > > +{
> > > +     __be32 status;
> > > +     struct nfs4_cpntf_state *cps = NULL;
> > > +
> > > +     status = _find_cpntf_state(nn, st, &cps);
> > > +     if (status)
> > > +             return status;
> > > +
> > > +     /* Did the inter server to server copy start in time? */
> > > +     if (cps->cp_active == false && !time_after(cps->cp_timeout, jiffies)) {
> > > +             nfs4_put_stid(cps->cp_p_stid);
> > > +             return nfserr_partner_no_auth;
> >
> > I wonder whether instead of checking the time we should instead be
> > destroying copy stateid's as they expire, so the fact that you were
> > still able to look up the stateid suggests that it's good.  Or would
> > that result in returning the wrong error here?  Just curious.
> 
> In order to destroy copy stateid as they expire we need some thread
> monitoring the copies and then remove the expired one.

It would be just another thing to do in the laundromat thread.

So when do we free these things?  The only free_cpntf_state() caller I
can find is in nfsd4_offload_cancel, but I think the client only calls
those in case of interrupts or other unusual events.  What about a copy
that terminates normally?

> That seems like
> a lot more work than what's currently there. The spec says that the
> use of the copy has to start without a certain timeout and that's what
> this is suppose to enforce. If the client took too long start the
> copy, it'll get an error. I don't think it matters what error code is
> returned BAD_STATEID or PARTNER_NO_AUTH both imply the stateid is bad.
> 
> >
> > > +     } else
> > > +             cps->cp_active = true;
> > > +
> > > +     *stid = cps->cp_p_stid;
> >
> > What guarantees that cp_p_stid still points to a valid stateid?  (E.g.
> > if this is an open stateid that has since been closed.)
> 
> A copy (or copy_notify) stateid takes a reference on the parent, thus
> we guaranteed that pointer is still a valid stateid.

I only see a reference count taken when one is looked up, in
find_internal_cpntf_state.  That's too late.

--b.

> 
> >
> > --b.
> >
> > > +
> > > +     return nfs_ok;
> > > +}
> > >
> > >  /*
> > >   * Checks for stateid operations
> > > @@ -5264,6 +5307,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
> > >       status = nfsd4_lookup_stateid(cstate, stateid,
> > >                               NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
> > >                               &s, nn);
> > > +     if (status == nfserr_bad_stateid)
> > > +             status = find_cpntf_state(nn, stateid, &s);
> > >       if (status)
> > >               return status;
> > >       status = nfsd4_stid_check_stateid_generation(stateid, s,
> > > --
> > > 1.8.3.1
