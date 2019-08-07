Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACE985144
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Aug 2019 18:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfHGQmV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Aug 2019 12:42:21 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:39957 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbfHGQmU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Aug 2019 12:42:20 -0400
Received: by mail-ua1-f45.google.com with SMTP id s4so35258390uad.7
        for <linux-nfs@vger.kernel.org>; Wed, 07 Aug 2019 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1lHuxtLOgSJEJ1WU8wknw2L4Ff4Fm0om2s31/P03jQ=;
        b=XUYhQ5tfndW9eJN5gFkuvV3LmUHOcMN6i2YkcWlzufQrvpBFK6LJlkz6u6tAoQoudQ
         cQF35T3/TYvcOpRfvnwtAMposS5sE0CmmZfFnFsuaG30N4zQODAV7hn22eS8DgWbuuxx
         d40eglTx8VADxyz038XlGKJBjARgxTW2u5uu7OKPS4VWNH8f7ESpTQo4pNOdk9IuWxTn
         3kkV754gem/2sco2tn/oCTp4CMgria4pKg6UO89r3UKYk//lnEmQC74D3WWlOUFMpmdT
         CtQVvf+nfPBVJWF1XF6o/A8tceCH3j60roIaQz23LQpEYcuDIWPhZuEQSue2By0kr68i
         YFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1lHuxtLOgSJEJ1WU8wknw2L4Ff4Fm0om2s31/P03jQ=;
        b=tJrZc3tDuA1/3dhsb5wFKNxN7l4TJPzxc/CmCfLgFdJVE3KIctF2mnMAoHC3N86Ex5
         WelPOH3YE/1v115wNq32fyZzwWObtyi+JMjB3TbCEXgaeFSrWr/lK6FYJsSZOF+FsK0g
         t7fxAcK/XqpTiYnYcHMWfJN8wrjG2eOhk/281qPWJDAaFWXTacOo6fLuaoqpO9DW/fUJ
         prO64WWZ2DtJneYsGTu8iJnZnrdpgoUjuPbQ+fAWEHwYPj9UrMeM/6ZEQ5rjlYOjioPp
         jxqiIE0KMqwDDjoDgQYPQ27xkxF0RiHYw60oc+PIchi5xGk3mhukTheA0ilZh8eu7RFW
         5vYQ==
X-Gm-Message-State: APjAAAV5aM820kmH3Gxk5IG5hAqdGaUk5LYtW90YRD3ibvsPijNL9G6C
        3CeUcAQpNHpm2z6xbpnie65SWcdzaT2QtONhq/da4Q==
X-Google-Smtp-Source: APXvYqx+nu8yyWdE/8WiTSFzL0/HFvfRuH0YWhqItqVjGkJc7X8w9EncjzjiDGcHpZg2WU3ssBEcgMoAZf7e+3ehOsA=
X-Received: by 2002:ab0:6881:: with SMTP id t1mr6211268uar.65.1565196139582;
 Wed, 07 Aug 2019 09:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyEbwjPNbXKWXv+3=geisjH-i=xKWRqgyXa3v9Xk=OvdEw@mail.gmail.com>
 <20190731215118.GA13311@parsley.fieldses.org> <CAN-5tyGz5M1eMFC=CJUEdTB7cAq-PRis8SJMEnrcr4Svmmy03w@mail.gmail.com>
 <20190801151239.GC17654@fieldses.org> <CAN-5tyE8xdJhs5C_bOo0a9yLRUAvkKi7OLOq47He5P0OR8PGyQ@mail.gmail.com>
 <CAN-5tyEx7-kddfgsvSGAsCD3amMXq-iGLkQN2GdmaXOc19GwkA@mail.gmail.com>
 <20190801181158.GC19461@fieldses.org> <CAN-5tyEiO=kBQC=pLu_aeVfV+3f3KWFbz_1ooG8qBLoBqFaehQ@mail.gmail.com>
 <20190801193654.GA12211@parsley.fieldses.org> <CAN-5tyFSRcnOT5kuF_1iKZDu=KyjEj+3tcq0ARSNOeuSmJMYGQ@mail.gmail.com>
 <20190807160843.GD24728@fieldses.org>
In-Reply-To: <20190807160843.GD24728@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 7 Aug 2019 12:42:08 -0400
Message-ID: <CAN-5tyGzbvmSfw2=KF_4_q+nyv1=L0Chz2bBUjsPiqg+3qoJ8Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] NFSD check stateids against copy stateids
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 7, 2019 at 12:09 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Wed, Aug 07, 2019 at 12:02:40PM -0400, Olga Kornievskaia wrote:
> > On Thu, Aug 1, 2019 at 3:36 PM J. Bruce Fields <bfields@redhat.com> wrote:
> > >
> > > On Thu, Aug 01, 2019 at 02:24:04PM -0400, Olga Kornievskaia wrote:
> > > > i was just looking at close_lru and delegation_lru but I guess that's
> > > > not a list of delegation or open stateids but rather some complex of
> > > > not deleting the stateid right away but moving it to nfs4_ol_stateid
> > > > and the list on the nfsd_net. Are you looking for something similar
> > > > for the copy_notify state or can I just keep a global list of the
> > > > nfs4_client and add and delete of that (not move to the delete later)?
> > >
> > > A global list seems like it should work if the locking's OK.
> >
> > I'm having issues taking a reference on a parent stateid and being
> > able to clean it. Let me try to explain.
>
> With other stateid parent relationships I believe what we do is: instead
> of the child taking a reference on the parent, we ensure that the child
> is destroyed, and that nobody can be holding a pointer to it, before we
> destroy the parent.

I don't think we can get away from not taking a reference on the
parent. When a READ comes with the copy_notify stateid, it's used to
lookup the parent state because the nfs4_preprocess_stateid_op() that
checks the validity of the stateid for a given operation needs to
check validity of that parent stateid). Otherwise, we'd have to
special case the READ calling nfs4_preprocess_stateid_op() and special
call that function to when called from READ and finding a copy_notify
stateid will forego the other checks. Do you want me to that instead
of what I proposed below?

>
> --b.
>
> > Since I take a reference on the stateid, then during what would have
> > been the last put (due to say a close operation), stateid isn't
> > released. Now that stateid is sticking around. I personally would have
> > liked on what would have been a close and release of the stateid to
> > release the copy notify state(s) (which was being done before but
> > having a reference makes it hard? i want to count number of copy
> > notify states and if then somehow if the num_copies-1 is going to make
> > it 0, then decrement by num_copies (and the normal -1) but if it's not
> > the last reference then it shouldn't be decremented.
> >
> > Now say no fancy logic happens on close so we have these stateids left
> > over . What to do on unmount? It will error with err_client_busy since
> > there are non-zero copy notify states and only after a lease period it
> > will release the resources (when the close of the file should have
> > removed any copy notify state)?
> >
> > Question: would it be acceptable to do something like this on freeing
> > of the parent stateid?
> >
> > @@ -896,8 +931,12 @@ static void block_delegations(struct knfsd_fh *fh)
> >         might_lock(&clp->cl_lock);
> >
> >         if (!refcount_dec_and_lock(&s->sc_count, &clp->cl_lock)) {
> > -               wake_up_all(&close_wq);
> > -               return;
> > +               if (!refcount_sub_and_test_checked(s->sc_cp_list_size,
> > +                               &s->sc_count)) {
> > +                       refcount_add_checked(s->sc_cp_list_size, &s->sc_count);
> > +                       wake_up_all(&close_wq);
> > +                       return;
> > +               }
> >         }
> >         idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
> >         spin_unlock(&clp->cl_lock);
> >
> > then free the copy notify stateids associated with stateid.
> >
> > Laundromat would still be checking the copy_notify stateids for
> > anything that's been not active for a while (but not closed).
> >
> >
> >
> >
> >
> > >
> > > --b.
