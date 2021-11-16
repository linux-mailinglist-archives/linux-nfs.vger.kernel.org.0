Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53337453BBC
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 22:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhKPVip (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 16:38:45 -0500
Received: from mail-yb1-f179.google.com ([209.85.219.179]:35575 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhKPVip (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 16:38:45 -0500
Received: by mail-yb1-f179.google.com with SMTP id y3so940503ybf.2
        for <linux-nfs@vger.kernel.org>; Tue, 16 Nov 2021 13:35:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1SpRskeFlLe3sEj6EE1HDPVrSO5r9AqZLuR4xE7rQmk=;
        b=DuYfLIRjn7m16Z1TQAKByCNLRy4CZyUor/9IRCN1c0Dxnn/XG9uYh4rq8sdiPdrWyp
         BJLcNymuH5YEib0Q51y9X3+MgKrCeO5DEQEMe4sxDvyJ2KOp1wstOeasbM1+VFXelzG0
         zmvuZ7Ir3J8CjwBasZSm9tHUcasmf2XaGLt74ubKmxnCX2KwkJClDzgO+ns7/S6Xx9/a
         dEbczH+7h96UUOYxQNLOl+TBk4pfq3UykFkDfHMue/06yP0xW2sTvG8lSOVyFIk773cL
         ZKj0fzD9Pxv4PZh8nd9QDZN7u4SSoHE7RH1aYZiTPkQDdw5UZUfXs1zGO84U9XbIpcpU
         BvCg==
X-Gm-Message-State: AOAM533Aw1Fi9VRAOXyveliQBZGrF2KsaD4dOe+85OTS4AL5ydt/vqWV
        4OftzuCTdR7ZUSmggcVlM/MoFt8fuH7TuBpRuFM=
X-Google-Smtp-Source: ABdhPJyN2OIDlu6+BjXiV3buZ95mbja4WLoyEo4BrZCX0cZPxqlaith666Ltrr1AC5F2cLBf3hWWAwl5RsFYm7A7K6k=
X-Received: by 2002:a25:7146:: with SMTP id m67mr11760164ybc.353.1637098547356;
 Tue, 16 Nov 2021 13:35:47 -0800 (PST)
MIME-Version: 1.0
References: <163278643081.17728.10586733395858659759.stgit@noble.brown>
 <163709576284.13692.2252149084412844753@noble.neil.brown.name> <1b6b267598c8fcf5f50b6a118d88cf7ea938d076.camel@hammerspace.com>
In-Reply-To: <1b6b267598c8fcf5f50b6a118d88cf7ea938d076.camel@hammerspace.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 16 Nov 2021 16:35:31 -0500
Message-ID: <CAFX2Jfk78tjhoZ1G-APdvqQW4es-odNL-iuDBR5fDO6+1hgaQQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Don't store cred in nfs_access_entry
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "neilb@suse.de" <neilb@suse.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 16, 2021 at 3:58 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2021-11-17 at 07:49 +1100, NeilBrown wrote:
> >
> > Hi Trond/Anna,
> >  have you had a chance to look at these patches?
> >
>
> Oh crap... I did see those patches, and intended to pick them up for
> this last merge window, but somehow forgot to move them into my
> 'testing' branch.
>
> Anna, can you please queue them up for the next merge window?

Sure! I have them applied to my private testing branch now. I'll push
them out to a public linux-next sometime in the next few weeks.

Anna
>
> Apologies
>   Trond
>
> > Thanks,
> > NeilBrown
> >
> > On Tue, 28 Sep 2021, NeilBrown wrote:
> > > It turns out that storing a counted ref to 'struct cred' in
> > > nfs_access_entry wasn't a good choice.
> > > 'struct cred' contains counted references to 'struct key', and
> > > users
> > > have a quota on how many keys they can have.  Keeping a cred in a
> > > cache
> > > imposes on that quota.
> > >
> > > The nfs access cache can keep a large number of entries, and keep
> > > them
> > > indefinitely.  This can cause a user to go over-quota.
> > >
> > > This series removes the 'struct cred *' from nfs_access_entry and
> > > instead stores the uid, gid, and a pointer to the group info.
> > > This makes the nfs_access_entry 64 bits larger.
> > >
> > > Thanks,
> > > NeilBrown
> > >
> > > ---
> > >
> > > NeilBrown (3):
> > >       NFS: change nfs_access_get_cached to only report the mask
> > >       NFS: pass cred explicitly for access tests
> > >       NFS: don't store 'struct cred *' in struct nfs_access_entry
> > >
> > >
> > >  fs/nfs/dir.c            | 63 ++++++++++++++++++++++++++++++++++---
> > > ----
> > >  fs/nfs/nfs3proc.c       |  5 ++--
> > >  fs/nfs/nfs4proc.c       | 13 +++++----
> > >  include/linux/nfs_fs.h  |  6 ++--
> > >  include/linux/nfs_xdr.h |  2 +-
> > >  5 files changed, 67 insertions(+), 22 deletions(-)
> > >
> > > --
> > > Signature
> > >
> > >
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
