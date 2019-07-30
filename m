Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34E367AD2D
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2019 18:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfG3QDu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Jul 2019 12:03:50 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33310 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfG3QDu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Jul 2019 12:03:50 -0400
Received: by mail-ua1-f67.google.com with SMTP id g11so3094791uak.0
        for <linux-nfs@vger.kernel.org>; Tue, 30 Jul 2019 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+RIiipzQh6DGkRPo+0Jmx4UpXxEWhGqT/V61j4TyjU=;
        b=ZrAQ8P8/yZmTRgcfl4cEW8qUp+vtl8BFz1k5P9xkwgt3u6L/SP6T/nD0MOeV8U3eXt
         d3WD4Gh7wtgjtQayidH6Du0v2m+uq/S+Fs2R8w9zyNXEi3oruGwI+or2p9/nNDC3IqpD
         /yExpJC4R6sMDbVZmo+QcIhmMNv3Er1ZYdtDNcQpKxikH43a5oaGKdzASjPrzrRyEI6P
         ZRLzYUJDj/sjPKD8MB96Io9DjjpbW7x5Fy6Kw7RL0oQPqce2s7VKP7HJDJG8ugkh7gYd
         KkyGfoT9ap6GccB4DiCWw4lmoq3Nguml11VZxcY7dREcQHjqw1U2NQjFWPiNgiFPHh5d
         S+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+RIiipzQh6DGkRPo+0Jmx4UpXxEWhGqT/V61j4TyjU=;
        b=TdJjsx4hnh9JJl30T1tB09A5pEuLXOpxMRkQqFjsmDHr3D816zHY+CfbTUJIX1F2MN
         GjcJ6LJpuZkPnfIiKx3P486AvsGKiscC+HOFJe5eDtIP4VSfjpEXXi9C8TtAKytbj2i3
         SVZEaqghQsVKOKmTkyU1bcvJRkzKJk+4ydXnS+IRPU2jTJOKiw5A/0BtLZECf1VjkL5v
         OsJZo6jU6lld9GZPwwbJmp7EgdlJgFeJtGxlSwSn4GBKyk51M5eUn8U9m+V9GxQcXG//
         Wgf8OKubrm/Zz1emFoTtDmtt7HDf+rQiaHA7lCZIWKdBF4vCGZiIYZkL4CkOBV2uKkOw
         cpkg==
X-Gm-Message-State: APjAAAVFmUqibo3UQnVzq6UJy/u1O/6Q6c7f87Hzgj1s4jCHjb/Rkth1
        izRZhaOXbladVGaeUEgtUjwMdIrscNrntj+5jrg=
X-Google-Smtp-Source: APXvYqxsYAgrMXJHRpxildGeQcbveqSoEbxNLHa8vYjN83lEwOI9eWqw0LCp1MZEv41mLcWiVFDEdNgZndhGYxFmx3s=
X-Received: by 2002:ab0:5ea6:: with SMTP id y38mr73395585uag.40.1564502629193;
 Tue, 30 Jul 2019 09:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-6-olga.kornievskaia@gmail.com> <20190719220116.GA24373@fieldses.org>
 <CAN-5tyHdxBcEH0xPV2814nUMEHPCsQ9iD_A7K=W3ZeE6b4OJxg@mail.gmail.com> <20190723205846.GB19559@fieldses.org>
In-Reply-To: <20190723205846.GB19559@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 30 Jul 2019 12:03:38 -0400
Message-ID: <CAN-5tyFTRr9KPYAzq-EaOMqDeJU31-qHGsLyCmEtd18OMxCFNQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] NFSD check stateids against copy stateids
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 23, 2019 at 4:59 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Jul 22, 2019 at 04:24:08PM -0400, Olga Kornievskaia wrote:
> > On Fri, Jul 19, 2019 at 6:01 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > On Mon, Jul 08, 2019 at 03:23:49PM -0400, Olga Kornievskaia wrote:
> > > > Incoming stateid (used by a READ) could be a saved copy stateid.
> > > > On first use make it active and check that the copy has started
> > > > within the allowable lease time.
> > > >
> > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > ---
> > > >  fs/nfsd/nfs4state.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 45 insertions(+)
> > > >
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index 2555eb9..b786625 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -5232,6 +5232,49 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
> > > >
> > > >       return 0;
> > > >  }
> > > > +/*
> > > > + * A READ from an inter server to server COPY will have a
> > > > + * copy stateid. Return the parent nfs4_stid.
> > > > + */
> > > > +static __be32 _find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
> > > > +                  struct nfs4_cpntf_state **cps)
> > > > +{
> > > > +     struct nfs4_cpntf_state *state = NULL;
> > > > +
> > > > +     if (st->si_opaque.so_clid.cl_id != nn->s2s_cp_cl_id)
> > > > +             return nfserr_bad_stateid;
> > > > +     spin_lock(&nn->s2s_cp_lock);
> > > > +     state = idr_find(&nn->s2s_cp_stateids, st->si_opaque.so_id);
> > > > +     if (state)
> > > > +             refcount_inc(&state->cp_p_stid->sc_count);
> > > > +     spin_unlock(&nn->s2s_cp_lock);
> > > > +     if (!state)
> > > > +             return nfserr_bad_stateid;
> > > > +     *cps = state;
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
> > > > +                            struct nfs4_stid **stid)
> > > > +{
> > > > +     __be32 status;
> > > > +     struct nfs4_cpntf_state *cps = NULL;
> > > > +
> > > > +     status = _find_cpntf_state(nn, st, &cps);
> > > > +     if (status)
> > > > +             return status;
> > > > +
> > > > +     /* Did the inter server to server copy start in time? */
> > > > +     if (cps->cp_active == false && !time_after(cps->cp_timeout, jiffies)) {
> > > > +             nfs4_put_stid(cps->cp_p_stid);
> > > > +             return nfserr_partner_no_auth;
> > >
> > > I wonder whether instead of checking the time we should instead be
> > > destroying copy stateid's as they expire, so the fact that you were
> > > still able to look up the stateid suggests that it's good.  Or would
> > > that result in returning the wrong error here?  Just curious.
> >
> > In order to destroy copy stateid as they expire we need some thread
> > monitoring the copies and then remove the expired one.
>
> It would be just another thing to do in the laundromat thread.

This still seems simpler. You'd need to traverse the list and do more
work? What's the advantage of laundry vs this? Given that laundry
thread doesn't run all the time, there might still be a gap with it
was last run and stateid expiring before the next run.

>
> So when do we free these things?  The only free_cpntf_state() caller I
> can find is in nfsd4_offload_cancel,

There is a caller in the nfs4_put_stid. Copy notify state is freed
when the associated stateid going away.

> but I think the client only calls
> those in case of interrupts or other unusual events.  What about a copy
> that terminates normally?

At this point, are you asking about a copy state or a copy_notify
state? When the copy is done, then the destination server will free
the copy state. However, source server doesn't keep track of when the
source server is done with the copy (I don't think we want to do that
to store how much is read and state of the file seems like
unnecessary).

>
> > That seems like
> > a lot more work than what's currently there. The spec says that the
> > use of the copy has to start without a certain timeout and that's what
> > this is suppose to enforce. If the client took too long start the
> > copy, it'll get an error. I don't think it matters what error code is
> > returned BAD_STATEID or PARTNER_NO_AUTH both imply the stateid is bad.
> >
> > >
> > > > +     } else
> > > > +             cps->cp_active = true;
> > > > +
> > > > +     *stid = cps->cp_p_stid;
> > >
> > > What guarantees that cp_p_stid still points to a valid stateid?  (E.g.
> > > if this is an open stateid that has since been closed.)
> >
> > A copy (or copy_notify) stateid takes a reference on the parent, thus
> > we guaranteed that pointer is still a valid stateid.
>
> I only see a reference count taken when one is looked up, in
> find_internal_cpntf_state.  That's too late.

Hm, right so this is tricky. With copy_notify, if I were to take a
reference on the parent when copy_notify is processed, there is no way
to free this reference because the source server never knows when the
copy was done.



>
> --b.
>
> >
> > >
> > > --b.
> > >
> > > > +
> > > > +     return nfs_ok;
> > > > +}
> > > >
> > > >  /*
> > > >   * Checks for stateid operations
> > > > @@ -5264,6 +5307,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
> > > >       status = nfsd4_lookup_stateid(cstate, stateid,
> > > >                               NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
> > > >                               &s, nn);
> > > > +     if (status == nfserr_bad_stateid)
> > > > +             status = find_cpntf_state(nn, stateid, &s);
> > > >       if (status)
> > > >               return status;
> > > >       status = nfsd4_stid_check_stateid_generation(stateid, s,
> > > > --
> > > > 1.8.3.1
