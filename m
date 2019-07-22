Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A37270A82
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2019 22:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbfGVUR4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jul 2019 16:17:56 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41747 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbfGVUR4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Jul 2019 16:17:56 -0400
Received: by mail-ua1-f67.google.com with SMTP id 34so15953984uar.8
        for <linux-nfs@vger.kernel.org>; Mon, 22 Jul 2019 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2VZ8MOaRKPe9ojbs+6zjHml1g6eEpiP1seQ57al7xE=;
        b=q+efHb1XA5iB4W+a2HYlAdPssqDEM9tO8N25X8PjslHsdsJwnDusSVJASZt/08t8DT
         RhBRVjlXgug9SyrsBCI75VA6ao036dZp0CtnET0LBRbyh92KUXJ7WaZ6QfUMMjbL2h1M
         BljdoFz3hgpm5++mvJ1mRfyH6oiUiUwKMVjB0ScPMgxn0RCP0kKycbatlIHAUs7f9nEQ
         J6atkNeDm4GmsBAuiJMOHLPnnpxGcfY8wEztW8oeYPKKC1Iw6d1rXbEILGmgDG+mPO2m
         1vdQOgH9W8bapM3UvniLy2vI0wPkdujGlXLpGX+SQPPCk+5XLlUpDmW3A7eW1489XvEi
         23eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2VZ8MOaRKPe9ojbs+6zjHml1g6eEpiP1seQ57al7xE=;
        b=IdFYIdSKuMSCVn52NV7eN4+v+D3qLnDTIT23jAw7W+JaKUc/WTUvT19UmZX7krqKvf
         H24nvFQoQjZfN3QVsADVoHdQ4zaIGJD1E/GD5dXjkra+4suunU9APIpBh+YqTEEXEhBH
         EbNj+CLpc6vhLWDTJsUTcDSRFhPBpR3tn0rqDed/XooQmjecJDf9IOFrKL6n7vpTSnTh
         9a9xvpEbYsG5Di7rXjognqIt8J3J+R5Fcnl0XpvOBteCLlkklNxNT7binHxd9/lqfMny
         LPfM+7xaBnJqz3RjUrqw6lqb4TwoYu5o/trqHuwchMbRj4hpijrh6kQ1WtpnXpfZFaBR
         VTGA==
X-Gm-Message-State: APjAAAWyzvFdxlAUjKWPhvj1xsP3VO2Kwp/Kq6qbwFM/M7bdw2vpPbUg
        Lgx53ID+Lo4zxdgUX1evPk71h1yr4CFqwQ93MPo=
X-Google-Smtp-Source: APXvYqziAegffZ7iKHVg/fQOoqRq44d/LJeu6W4EA+QZWlG87RYSD0VBvqQmqGnamsmM6KjBKjXlSX+dASns8wgsp3M=
X-Received: by 2002:ab0:5ea6:: with SMTP id y38mr44722484uag.40.1563826674769;
 Mon, 22 Jul 2019 13:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-5-olga.kornievskaia@gmail.com> <20190717230726.GA26801@fieldses.org>
In-Reply-To: <20190717230726.GA26801@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 22 Jul 2019 16:17:44 -0400
Message-ID: <CAN-5tyHmODP2+nMiinTEP5WZzXz=m=j9LBSWv=b=N3C211JaLg@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] NFSD add COPY_NOTIFY operation
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 17, 2019 at 7:07 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Mon, Jul 08, 2019 at 03:23:48PM -0400, Olga Kornievskaia wrote:
> > @@ -726,24 +727,53 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
> >  /*
> >   * Create a unique stateid_t to represent each COPY.
> >   */
> > -int nfs4_init_cp_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
> > +static int nfs4_init_cp_state(struct nfsd_net *nn, void *ptr, stateid_t *stid)
> >  {
> >       int new_id;
> >
> >       idr_preload(GFP_KERNEL);
> >       spin_lock(&nn->s2s_cp_lock);
> > -     new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, copy, 0, 0, GFP_NOWAIT);
> > +     new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, ptr, 0, 0, GFP_NOWAIT);
> >       spin_unlock(&nn->s2s_cp_lock);
> >       idr_preload_end();
> >       if (new_id < 0)
> >               return 0;
> > -     copy->cp_stateid.si_opaque.so_id = new_id;
> > -     copy->cp_stateid.si_opaque.so_clid.cl_boot = nn->boot_time;
> > -     copy->cp_stateid.si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
> > +     stid->si_opaque.so_id = new_id;
> > +     stid->si_opaque.so_clid.cl_boot = nn->boot_time;
> > +     stid->si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
> >       return 1;
> >  }
> >
> > -void nfs4_free_cp_state(struct nfsd4_copy *copy)
> > +int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
> > +{
> > +     return nfs4_init_cp_state(nn, copy, &copy->cp_stateid);
> > +}
>
> This little bit of refactoring could go into a seperate patch.  It's
> easier for me to review lots of smaller patches.
>
> But I don't understand why you're doing it.
>
> Also, I'm a little suspicious of code that doesn't initialize an object
> till after it's been added to a global structure.  The more typical
> pattern is:
>
>
>         initialize foo
>         take locks, add foo global structure, drop locks.
>
> This prevents anyone doing a lookup from finding "foo" while it's still
> in a partially initialized state.

Let me try to explain the change. This change is due to the fact that
now both COPY_NOTIFY and COPY both are generating unique stateid
(COPY_NOTIFY needs a unique stateid to passed into the COPY and COPY
is generating a unique stateid to be referred to by callbacks).
Previously we had just the COPY generating the stateid (so it was
stored in the nfs4_copy structure) but now we have the COPY_NOTIFY
which doesn't create nfs4_copy when it's processing the operation but
still needs a unique stateid (stored in the stateid structure).

Let me see if I understand your suspicion and ask for guidance how to
resolve it as perhaps I'm misusing the function. idr_alloc_cyclic()
keeps track of the structure of the 2nd arguments with a value it
returns. How do I initiate the structure with the value of the
function without knowing the value which can only be returned when I
call the function to add it to the list? what you are suggesting is to
somehow get the value for the new_id but not associate anything then
update the copy structure with that value and then call
idr_alloc_cyclic() (or something else) to create that association of
the new_id and the structure? I don't know how to do that.

>
> --b.
