Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0470A9A
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2019 22:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfGVUYU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jul 2019 16:24:20 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33497 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfGVUYU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Jul 2019 16:24:20 -0400
Received: by mail-vs1-f66.google.com with SMTP id m8so27313137vsj.0
        for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2019 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OyLY8vZGbNtKNzk8EZ6eo74FGjMtzBY30Su26WbZ/H4=;
        b=odKgsY/QIZDZ5z3Y0eRLl+oZ2H4jEjjtvXQtxfEuNd6oPqPQEN8kY1gSaMaAuiUwqs
         Wk46znlogXhsoV2FCet4Xz3WmM3vcerYzoTzFYP3M3p9i2kSmFKsD7QKU6VBKGOviXD1
         NeJBBsokUvTZRCFC2szqlHEhmGSWfYpzoJlPncUlsSTLSX3O53dHgUFhqC66yu+kKIOp
         Ue3jqTJa5A2/ehjk6ytxJV5ETxIfEGKRioSydOVmiFB+ZLBKC0U/vrS2JocgiXJS83h0
         EmZAaqz08K/dcGTQjnlama+KCnnDqQZV0hLLOdT2YmyT+/xC7H9tF7gb+SW4KpwQfhJy
         16rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OyLY8vZGbNtKNzk8EZ6eo74FGjMtzBY30Su26WbZ/H4=;
        b=k+A0z4N0hbbbmbTYiEfGnivB9d7EW/wwUz9ufGw86KVDV3AxlJ7xkiSgLKKfTaNJYk
         hjQd3avCp5nxBqEz7YpSp/ngPYtXNTPe7h0yhKp8b+jbTG3zKTmNqtd5TWF+Bwb30vf3
         yKhCKnTcSHsT2p1G1ZbhsACk2x38JoAEj49XTOFxDgqRvr8lMR06H1O6PpAVsx03hQqS
         fUH/zx9HeBJymnWBQofwnzVcXAzT/S7JrxDdrkrqDvDdJtLfsaVf9Mz9Endh2SQAegD0
         pdeNk9Sx5X7A7oQOJX4dnP2zYSK8ZSPA5UaTOFlwDLNes7FDoV8/EXc4p/k77hqR+Vit
         TiDw==
X-Gm-Message-State: APjAAAWAkvATeZodd2d16S+oSiysR0/IwnUqr7C99qKWvVLu1A9eKPdb
        RCjw+CknvKVa7XCFLkHFK0WatTTx/L6+iQXvSS4=
X-Google-Smtp-Source: APXvYqziUGmjkOnyHKV3nrORd8rguLUwGXg7x5OeXIrfif3oZQbd63v9CeIUoSAWp+4wQzsVqnIPu3WeQ9nm63BIBVg=
X-Received: by 2002:a67:79d4:: with SMTP id u203mr43895414vsc.85.1563827059016;
 Mon, 22 Jul 2019 13:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-6-olga.kornievskaia@gmail.com> <20190719220116.GA24373@fieldses.org>
In-Reply-To: <20190719220116.GA24373@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 22 Jul 2019 16:24:08 -0400
Message-ID: <CAN-5tyHdxBcEH0xPV2814nUMEHPCsQ9iD_A7K=W3ZeE6b4OJxg@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] NFSD check stateids against copy stateids
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 19, 2019 at 6:01 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Jul 08, 2019 at 03:23:49PM -0400, Olga Kornievskaia wrote:
> > Incoming stateid (used by a READ) could be a saved copy stateid.
> > On first use make it active and check that the copy has started
> > within the allowable lease time.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfsd/nfs4state.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 2555eb9..b786625 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5232,6 +5232,49 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
> >
> >       return 0;
> >  }
> > +/*
> > + * A READ from an inter server to server COPY will have a
> > + * copy stateid. Return the parent nfs4_stid.
> > + */
> > +static __be32 _find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
> > +                  struct nfs4_cpntf_state **cps)
> > +{
> > +     struct nfs4_cpntf_state *state = NULL;
> > +
> > +     if (st->si_opaque.so_clid.cl_id != nn->s2s_cp_cl_id)
> > +             return nfserr_bad_stateid;
> > +     spin_lock(&nn->s2s_cp_lock);
> > +     state = idr_find(&nn->s2s_cp_stateids, st->si_opaque.so_id);
> > +     if (state)
> > +             refcount_inc(&state->cp_p_stid->sc_count);
> > +     spin_unlock(&nn->s2s_cp_lock);
> > +     if (!state)
> > +             return nfserr_bad_stateid;
> > +     *cps = state;
> > +     return 0;
> > +}
> > +
> > +static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
> > +                            struct nfs4_stid **stid)
> > +{
> > +     __be32 status;
> > +     struct nfs4_cpntf_state *cps = NULL;
> > +
> > +     status = _find_cpntf_state(nn, st, &cps);
> > +     if (status)
> > +             return status;
> > +
> > +     /* Did the inter server to server copy start in time? */
> > +     if (cps->cp_active == false && !time_after(cps->cp_timeout, jiffies)) {
> > +             nfs4_put_stid(cps->cp_p_stid);
> > +             return nfserr_partner_no_auth;
>
> I wonder whether instead of checking the time we should instead be
> destroying copy stateid's as they expire, so the fact that you were
> still able to look up the stateid suggests that it's good.  Or would
> that result in returning the wrong error here?  Just curious.

In order to destroy copy stateid as they expire we need some thread
monitoring the copies and then remove the expired one. That seems like
a lot more work than what's currently there. The spec says that the
use of the copy has to start without a certain timeout and that's what
this is suppose to enforce. If the client took too long start the
copy, it'll get an error. I don't think it matters what error code is
returned BAD_STATEID or PARTNER_NO_AUTH both imply the stateid is bad.

>
> > +     } else
> > +             cps->cp_active = true;
> > +
> > +     *stid = cps->cp_p_stid;
>
> What guarantees that cp_p_stid still points to a valid stateid?  (E.g.
> if this is an open stateid that has since been closed.)

A copy (or copy_notify) stateid takes a reference on the parent, thus
we guaranteed that pointer is still a valid stateid.

>
> --b.
>
> > +
> > +     return nfs_ok;
> > +}
> >
> >  /*
> >   * Checks for stateid operations
> > @@ -5264,6 +5307,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
> >       status = nfsd4_lookup_stateid(cstate, stateid,
> >                               NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
> >                               &s, nn);
> > +     if (status == nfserr_bad_stateid)
> > +             status = find_cpntf_state(nn, stateid, &s);
> >       if (status)
> >               return status;
> >       status = nfsd4_stid_check_stateid_generation(stateid, s,
> > --
> > 1.8.3.1
