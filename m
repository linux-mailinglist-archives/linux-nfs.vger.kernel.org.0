Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7D1C8CF2
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Oct 2019 17:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfJBPcU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Oct 2019 11:32:20 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41516 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBPcU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Oct 2019 11:32:20 -0400
Received: by mail-ua1-f68.google.com with SMTP id l13so6817567uap.8
        for <linux-nfs@vger.kernel.org>; Wed, 02 Oct 2019 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+YJSMPJRH7nOeF8OBD74P5sauFLqufCCpmx4IWND1g=;
        b=jg0ySS0qDhbxVJ4D0JncsLkaDZzKTsICwXObdwsFXpVB5EVPkk6ydNEp2M8LGOkGvA
         esZtgFmCfu9XvO9CtW8TA+JLhHyyT5quT/X7vfAbgEOLdRAO3KB+7TbB+tAz+E47qTQ9
         BzJxRGUOfKUe3UTRsj76AzS0H0Q6kWS+jy3E+hTEuWAmiD7PELicV88ymTMu1cNg9ezY
         mL6JwJvNqUmpv4F08beSB+kMnqojA9R9YhWUHpQWrl897qNGH1GREy27xmsJ1ObTB+dg
         JGg2KINogM6FiOAHapEnJGRSr160OoiyP2YzsUR6Al3N5SQ1H3tr7eTwTnnbKvlIzlVq
         R4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+YJSMPJRH7nOeF8OBD74P5sauFLqufCCpmx4IWND1g=;
        b=Ff2VwIrtT521NZgVCXDUi7hf8gxPms2kVJJo8CrDTHbWFRFnwXitsw+zYf7BsrGydB
         8KsG9sN0EwS1TLYPi6T6AdWyaEHwqiBYIgkjdJEKujiAYMb3sXmLB252z/bEeUnd/bnt
         ZfvTCgmurUYrl8XohanxUPqd6jUTq5Vjf2kGSklK7MltotN9nvL2Is5xe7WuKcxIqG+f
         RjPsidE7nNYcQ0ec6J8Pw1MEw1ar6F1pbytaoUWDSbz/auFMNzx7ZSIorqb+21ZEOgt+
         wMn/LpEFiba6+dPZkcDhNDUW5346CkqizlgpswPYq5FJK6BlbQBZW/ycbV+mevi8TVl3
         KUhQ==
X-Gm-Message-State: APjAAAUZ/hEzhDhtep9IwekuJnjYv9n4D7m4s0D9fT1PebqMDuBo6WQV
        HUgr+aAI4oXNHCf7gzR0gRyPxHxz6z5MaCgMSao=
X-Google-Smtp-Source: APXvYqwJAveHq+ONyqNqtGOViqr/5RP4KPAEyYAZhBYPUIBmpIs01Mz0J8jHZbzdGVq8/Wqz07HQT+oAa6YwGRkBuRc=
X-Received: by 2002:ab0:1e3:: with SMTP id 90mr1939609ual.93.1570030338821;
 Wed, 02 Oct 2019 08:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
 <20190916211353.18802-16-olga.kornievskaia@gmail.com> <20191001205900.GB4926@fieldses.org>
 <CAN-5tyGmMVU7grQq=cAEngHLhKy2yCn2k8U0h7-hRnwx9iScNw@mail.gmail.com> <20191002013523.GA9000@fieldses.org>
In-Reply-To: <20191002013523.GA9000@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 2 Oct 2019 11:32:07 -0400
Message-ID: <CAN-5tyF6L1wtsxa4BbKvd+VJk0k=AdVpq11s==HmvH33PeW7ow@mail.gmail.com>
Subject: Re: [PATCH v7 15/19] NFSD add COPY_NOTIFY operation
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 1, 2019 at 9:35 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, Oct 01, 2019 at 08:14:39PM -0400, Olga Kornievskaia wrote:
> > On Tue, Oct 1, 2019 at 4:59 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > On Mon, Sep 16, 2019 at 05:13:49PM -0400, Olga Kornievskaia wrote:
> > > > @@ -2914,7 +2983,8 @@ static bool client_has_state(struct nfs4_client *clp)
> > > >  #endif
> > > >               || !list_empty(&clp->cl_delegations)
> > > >               || !list_empty(&clp->cl_sessions)
> > > > -             || !list_empty(&clp->async_copies);
> > > > +             || !list_empty(&clp->async_copies)
> > > > +             || client_has_copy_notifies(clp);
> > >
> > > Sorry, remind me--how is the copy_notify stateid cleaned up?  Is it just
> > > timed out by the laundromat thread, or is our client destroying it when
> > > the copy is done?
> >
> > Copy_notify stateid in most cases should be removed by
> > nfs4_put_stid()/ the "parent" stateid going away (close, unlock,
> > delegreturn)
>
> Oh, right, the parent stateid going away will be enough, good.
>
> But doesn't that mean the client_has_copy_notifies() check here is
> redundant?  If it's true, then the earlier client_has_openowner() check
> was also true.

Honestly, I didn't remove it because I didn't know if I was missing
some weird case where on clientid destruction we'd still have copy
notify left and thus need to delay it. But as you see nfs4_put_stid()
calls nfs4_free_cpntf_statelist() which iterates the list of the
copy_notify states and deletes them. Sounds like I should just remove
the client_has_copy_notifies() check.

>
> --b.
>
> > (or in unlikely case, if the client sent an
> > OFFLOAD_CANCEL to the stateid, say if copy was canceled). Otherwise,
> > copy notify stateid will time out and be removed by the laundromat
> > thread. So if a client didn't send a close/unlock/delegreturn and
> > quickly tries to delete a clientid, it will get ERR_CLID_INUSE but I
> > think if there was no close, the server will have an issue of having
> > an open stateid state.
> >
> > > I'm just wondering if this can result in NFSERR_CLID_INUSE just because
> > > a copy was done recently.
> > >
> > > --b.
> > >
> > > >  }
> > > >
> > > >  static __be32 copy_impl_id(struct nfs4_client *clp,
> > > > @@ -5192,6 +5262,9 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
> > > >       struct list_head *pos, *next, reaplist;
> > > >       time_t cutoff = get_seconds() - nn->nfsd4_lease;
> > > >       time_t t, new_timeo = nn->nfsd4_lease;
> > > > +     struct nfs4_cpntf_state *cps;
> > > > +     copy_stateid_t *cps_t;
> > > > +     int i;
> > > >
> > > >       dprintk("NFSD: laundromat service - starting\n");
> > > >
> > > > @@ -5202,6 +5275,17 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
> > > >       dprintk("NFSD: end of grace period\n");
> > > >       nfsd4_end_grace(nn);
> > > >       INIT_LIST_HEAD(&reaplist);
> > > > +
> > > > +     spin_lock(&nn->s2s_cp_lock);
> > > > +     idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
> > > > +             cps = container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
> > > > +             if (cps->cp_stateid.sc_type == NFS4_COPYNOTIFY_STID &&
> > > > +                             !time_after((unsigned long)cps->cpntf_time,
> > > > +                             (unsigned long)cutoff))
> > > > +                     _free_cpntf_state_locked(nn, cps);
> > > > +     }
> > > > +     spin_unlock(&nn->s2s_cp_lock);
> > > > +
> > > >       spin_lock(&nn->client_lock);
> > > >       list_for_each_safe(pos, next, &nn->client_lru) {
> > > >               clp = list_entry(pos, struct nfs4_client, cl_lru);
> > > > @@ -5577,6 +5661,24 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
> > > >  out:
> > > >       return status;
> > > >  }
> > > > +static void
> > > > +_free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
> > > > +{
> > > > +     WARN_ON_ONCE(cps->cp_stateid.sc_type != NFS4_COPYNOTIFY_STID);
> > > > +     if (!refcount_dec_and_test(&cps->cp_stateid.sc_count))
> > > > +             return;
> > > > +     list_del(&cps->cp_list);
> > > > +     idr_remove(&nn->s2s_cp_stateids,
> > > > +                cps->cp_stateid.stid.si_opaque.so_id);
> > > > +     kfree(cps);
> > > > +}
> > > > +
> > > > +void nfs4_put_cpntf_state(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
> > > > +{
> > > > +     spin_lock(&nn->s2s_cp_lock);
> > > > +     _free_cpntf_state_locked(nn, cps);
> > > > +     spin_unlock(&nn->s2s_cp_lock);
> > > > +}
> > > >
> > > >  /*
> > > >   * Checks for stateid operations
> > > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > > index d9e7cbd..967b937 100644
> > > > --- a/fs/nfsd/state.h
> > > > +++ b/fs/nfsd/state.h
> > > > @@ -56,6 +56,14 @@
> > > >       stateid_opaque_t        si_opaque;
> > > >  } stateid_t;
> > > >
> > > > +typedef struct {
> > > > +     stateid_t               stid;
> > > > +#define NFS4_COPY_STID 1
> > > > +#define NFS4_COPYNOTIFY_STID 2
> > > > +     unsigned char           sc_type;
> > > > +     refcount_t              sc_count;
> > > > +} copy_stateid_t;
> > > > +
> > > >  #define STATEID_FMT  "(%08x/%08x/%08x/%08x)"
> > > >  #define STATEID_VAL(s) \
> > > >       (s)->si_opaque.so_clid.cl_boot, \
> > > > @@ -96,6 +104,7 @@ struct nfs4_stid {
> > > >  #define NFS4_REVOKED_DELEG_STID 16
> > > >  #define NFS4_CLOSED_DELEG_STID 32
> > > >  #define NFS4_LAYOUT_STID 64
> > > > +     struct list_head        sc_cp_list;
> > > >       unsigned char           sc_type;
> > > >       stateid_t               sc_stateid;
> > > >       spinlock_t              sc_lock;
> > > > @@ -104,6 +113,17 @@ struct nfs4_stid {
> > > >       void                    (*sc_free)(struct nfs4_stid *);
> > > >  };
> > > >
> > > > +/* Keep a list of stateids issued by the COPY_NOTIFY, associate it with the
> > > > + * parent OPEN/LOCK/DELEG stateid.
> > > > + */
> > > > +struct nfs4_cpntf_state {
> > > > +     copy_stateid_t          cp_stateid;
> > > > +     struct list_head        cp_list;        /* per parent nfs4_stid */
> > > > +     stateid_t               cp_p_stateid;   /* copy of parent's stateid */
> > > > +     clientid_t              cp_p_clid;      /* copy of parent's clid */
> > > > +     time_t                  cpntf_time;     /* last time stateid used */
> > > > +};
> > > > +
> > > >  /*
> > > >   * Represents a delegation stateid. The nfs4_client holds references to these
> > > >   * and they are put when it is being destroyed or when the delegation is
> > > > @@ -624,8 +644,10 @@ __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> > > >                    struct nfs4_stid **s, struct nfsd_net *nn);
> > > >  struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *slab,
> > > >                                 void (*sc_free)(struct nfs4_stid *));
> > > > -int nfs4_init_cp_state(struct nfsd_net *nn, struct nfsd4_copy *copy);
> > > > -void nfs4_free_cp_state(struct nfsd4_copy *copy);
> > > > +int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy);
> > > > +void nfs4_free_copy_state(struct nfsd4_copy *copy);
> > > > +struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
> > > > +                     struct nfs4_stid *p_stid);
> > > >  void nfs4_unhash_stid(struct nfs4_stid *s);
> > > >  void nfs4_put_stid(struct nfs4_stid *s);
> > > >  void nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid);
> > > > @@ -655,6 +677,8 @@ extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name
> > > >  extern void nfs4_put_copy(struct nfsd4_copy *copy);
> > > >  extern struct nfsd4_copy *
> > > >  find_async_copy(struct nfs4_client *clp, stateid_t *staetid);
> > > > +extern void nfs4_put_cpntf_state(struct nfsd_net *nn,
> > > > +                              struct nfs4_cpntf_state *cps);
> > > >  static inline void get_nfs4_file(struct nfs4_file *fi)
> > > >  {
> > > >       refcount_inc(&fi->fi_ref);
> > > > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > > > index 8231fe0..2937e06 100644
> > > > --- a/fs/nfsd/xdr4.h
> > > > +++ b/fs/nfsd/xdr4.h
> > > > @@ -542,7 +542,7 @@ struct nfsd4_copy {
> > > >       struct nfsd_file        *nf_src;
> > > >       struct nfsd_file        *nf_dst;
> > > >
> > > > -     stateid_t               cp_stateid;
> > > > +     copy_stateid_t          cp_stateid;
> > > >
> > > >       struct list_head        copies;
> > > >       struct task_struct      *copy_task;
> > > > --
> > > > 1.8.3.1
