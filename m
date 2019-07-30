Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1157ACAE
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2019 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfG3Psk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Jul 2019 11:48:40 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37452 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfG3Psj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Jul 2019 11:48:39 -0400
Received: by mail-ua1-f66.google.com with SMTP id z13so25633073uaa.4
        for <linux-nfs@vger.kernel.org>; Tue, 30 Jul 2019 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cg8JdDEDQWaT/QH98aqbdhPiXBsEqe0H2hAiXSt/Gpw=;
        b=pnt4Edz4L4dahGNogw8BECc1M/GE9VmfyTIEl2RDgbLO/LC34WODtKtiCXvNHvfv83
         B3VDJTYDznhknsXCnuja8+UQHYUp9oCAk3ni5CiTUUeIjyaCkMvx6KwFRvkA+jh7TivK
         qWNNPBqjS9cjIZIaemkwiArUn9WwfCzGCh+IqU/gor/wBMg11lfuPmCQGr8WHK1soaIn
         GpcIsi7CCLQwM7JIOZPlgMexTZDx5sy0Kj/Mjz1+cjTQc/nuT1QnQ6LW0UrpVInHCQyL
         dhyCqJuNrFZXOKY+F3/IXKIYQ2JwGhlWRVPsexlq+MDcnNDpLyWpjXZ09vIqKRyJo7F7
         MqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cg8JdDEDQWaT/QH98aqbdhPiXBsEqe0H2hAiXSt/Gpw=;
        b=YAN53m0X7osJ3isRsC3Xk9ps1EcB9wYzsS34lCGx3yBVHyaH8+foRzmkGT24xUNKh6
         uRtt7W3VvsBqaEnzTMZKQfQwwxiTtgJjnda86WvfC/W4LIiRo498FdrbwTc5Fkknhddh
         6FgfCzRRlFIwTZPEhJqGYsNld4u1C4U1mtUvor7XoA0SOXhpX04O0EIwHvkRl8It7xNF
         0zfEqaWcb8iQ3M4XBPvQ/hVAvpd8lFaM0JaHr3R911jlfqhdAzrx39rvTYuOiAC9AIjB
         1xNrSALgqyRz4Hi7tERW0mrYtAkYzppFj88FvrARiDX61FqL1kEo9IzUmQFRP4SKNXwM
         9Lkg==
X-Gm-Message-State: APjAAAUfmOjXJfRNIO1tq8v/Xi3/t//crZ3n+jbcT0Yt6KrjsZzM4cF7
        F7CV2+qAjTeD2WwL+jj6Ud+Hn/IzbK3HCce0587JDQ==
X-Google-Smtp-Source: APXvYqzy1i7O5wU2Ud9Z3XwyScd9v1RTYHVADcIrQEGu7gjbE5VUL9nU4WVFlTrMfbPUTp68SyMBCfUHdWeRz19gCH8=
X-Received: by 2002:ab0:5ea6:: with SMTP id y38mr73307514uag.40.1564501718297;
 Tue, 30 Jul 2019 08:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-5-olga.kornievskaia@gmail.com> <20190717230726.GA26801@fieldses.org>
 <CAN-5tyHmODP2+nMiinTEP5WZzXz=m=j9LBSWv=b=N3C211JaLg@mail.gmail.com> <20190723204537.GA19559@fieldses.org>
In-Reply-To: <20190723204537.GA19559@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 30 Jul 2019 11:48:27 -0400
Message-ID: <CAN-5tyGL+BR+1E1N-HzH3-mmjze8AkBHpYAm0k3i0Dt+iP1ORQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] NFSD add COPY_NOTIFY operation
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 23, 2019 at 4:46 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Jul 22, 2019 at 04:17:44PM -0400, Olga Kornievskaia wrote:
> > On Wed, Jul 17, 2019 at 7:07 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > On Mon, Jul 08, 2019 at 03:23:48PM -0400, Olga Kornievskaia wrote:
> > > > @@ -726,24 +727,53 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
> > > >  /*
> > > >   * Create a unique stateid_t to represent each COPY.
> > > >   */
> > > > -int nfs4_init_cp_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
> > > > +static int nfs4_init_cp_state(struct nfsd_net *nn, void *ptr, stateid_t *stid)
> > > >  {
> > > >       int new_id;
> > > >
> > > >       idr_preload(GFP_KERNEL);
> > > >       spin_lock(&nn->s2s_cp_lock);
> > > > -     new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, copy, 0, 0, GFP_NOWAIT);
> > > > +     new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, ptr, 0, 0, GFP_NOWAIT);
> > > >       spin_unlock(&nn->s2s_cp_lock);
> > > >       idr_preload_end();
> > > >       if (new_id < 0)
> > > >               return 0;
> > > > -     copy->cp_stateid.si_opaque.so_id = new_id;
> > > > -     copy->cp_stateid.si_opaque.so_clid.cl_boot = nn->boot_time;
> > > > -     copy->cp_stateid.si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
> > > > +     stid->si_opaque.so_id = new_id;
> > > > +     stid->si_opaque.so_clid.cl_boot = nn->boot_time;
> > > > +     stid->si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
> > > >       return 1;
> > > >  }
> > > >
> > > > -void nfs4_free_cp_state(struct nfsd4_copy *copy)
> > > > +int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
> > > > +{
> > > > +     return nfs4_init_cp_state(nn, copy, &copy->cp_stateid);
> > > > +}
> > >
> > > This little bit of refactoring could go into a seperate patch.  It's
> > > easier for me to review lots of smaller patches.
> > >
> > > But I don't understand why you're doing it.
> > >
> > > Also, I'm a little suspicious of code that doesn't initialize an object
> > > till after it's been added to a global structure.  The more typical
> > > pattern is:
> > >
> > >
> > >         initialize foo
> > >         take locks, add foo global structure, drop locks.
> > >
> > > This prevents anyone doing a lookup from finding "foo" while it's still
> > > in a partially initialized state.
> >
> > Let me try to explain the change. This change is due to the fact that
> > now both COPY_NOTIFY and COPY both are generating unique stateid
> > (COPY_NOTIFY needs a unique stateid to passed into the COPY and COPY
> > is generating a unique stateid to be referred to by callbacks).
> > Previously we had just the COPY generating the stateid (so it was
> > stored in the nfs4_copy structure) but now we have the COPY_NOTIFY
> > which doesn't create nfs4_copy when it's processing the operation but
> > still needs a unique stateid (stored in the stateid structure).
>
> The usual way to handle a situation like this is to store in the idr a
> pointer to the stateid (copy->cp_stateid or cps->cp_stateid).  When you

Ok I'll store the stateid directly.

> do a lookup you do something like:
>
>         st = idr_find(...);
>         copy = container_of(st, struct nfsd4_copy, cp_stateid);
>
> to get a copy to the larger structure.
>
> By the way, in find_internal_cpntf_state, a buggy or malicious client
> could cause idr_find to look up a copy (not a copy_notify) stateid.  The
> code needs some way to distinguish the two cases.  You could use a
> different cl_id for the two cases.  That might also be handy for
> debugging.  And/or you could do as we do in the case of open, lock, and
> other stateid's and embed a common structure that also includes a "type"
> field.  (See nfs4_stid->sc_type).

I'll add 2 new sc_types and make sure that during the look up the
entry retrieved is of the appropriate type.


> > Let me see if I understand your suspicion and ask for guidance how to
> > resolve it as perhaps I'm misusing the function. idr_alloc_cyclic()
> > keeps track of the structure of the 2nd arguments with a value it
> > returns. How do I initiate the structure with the value of the
> > function without knowing the value which can only be returned when I
> > call the function to add it to the list? what you are suggesting is to
> > somehow get the value for the new_id but not associate anything then
> > update the copy structure with that value and then call
> > idr_alloc_cyclic() (or something else) to create that association of
> > the new_id and the structure? I don't know how to do that.
>
> You could move the initialization under the s2s_cp_lock.  But there's
> additional initialization that's done in the caller.

I still don't understand what you are looking for here and why. I'm
following what the normal stid allocation does. There is no extra code
there to see if it initiated or not. nfs4_alloc_stid() calls
idr_alloc_cyclic() creates an association between the stid pointer and
at the time uninitialized nfs4_stid structure which is then filled in
with the return of the idr_alloc_cyclic(). That's exactly what the new
code is doing (well accept that i'll change it to store the
stateid_t).

> So, either this needs more locking, or maybe some flag value set to
> indicate that the object is initialized and safe to use.  (In the case
> of open/lock/etc.  stateid's I think that is sc_type.  I'm not
> completely convinced we've got that correct, though.)
>
> --b.
