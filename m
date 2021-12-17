Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB6B47900C
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 16:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhLQPfC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 10:35:02 -0500
Received: from mail-yb1-f178.google.com ([209.85.219.178]:34741 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhLQPfB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 10:35:01 -0500
Received: by mail-yb1-f178.google.com with SMTP id y68so7601046ybe.1;
        Fri, 17 Dec 2021 07:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHvaBv4PYSAKLTFMldRjskrDRAXeDmdEOAfE2F2dx5g=;
        b=q5fQSd4+tSglIbXpMufyeDJwgS4OqXZXProwHGhmZBTb8LHTSW2A7SaeynvqD7SLDv
         Fij9EA4vX3+Kl5Zk/w7L964vcrNZTJGWiz1tNpjGuOZzcKigwKT4PGHw7dPoNd318PRT
         a5wX0dm3VfloD7K3l4w7573Y7n4xvtLC4Wh5s2tcGWuiKUSSj1SDhsT17lrsErlTWpZ6
         HnDj3l4S8UAHrW9uO692v0Fmowj1rIhd105w3vsXgTT2JgRi3pJcA5Pbz8vY5vyjLfiZ
         hIHFfa8/yqQUSWyy2kuQ0Sv7siQ5DAtUly9k5DFocZUHnECZlonFfWLC0klMojIeJsbB
         /eVQ==
X-Gm-Message-State: AOAM530lq82Omb5RmjTx/dCUmooShhNiLq5iytUghEW7JHVVt8KlgWPW
        iv5H4HGeUnJAjC+qS7FU0RIQS0qw6BnxRwqDZRc=
X-Google-Smtp-Source: ABdhPJz1fmLP/ELLYouLtz0roYyH+z2JKMMajZ2xQublLIzf/tlxoBLeXBqKhVGTV6sjgdAA6S177iBW6O57QEFUGV0=
X-Received: by 2002:a25:b9c7:: with SMTP id y7mr4955331ybj.276.1639755300615;
 Fri, 17 Dec 2021 07:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20211217113507.76f852f2@canb.auug.org.au> <CALF+zO=zDrRzPkpgjRQNYbxQ8j3qNVJjo9Ub=tCqFtT32sr-KQ@mail.gmail.com>
In-Reply-To: <CALF+zO=zDrRzPkpgjRQNYbxQ8j3qNVJjo9Ub=tCqFtT32sr-KQ@mail.gmail.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Fri, 17 Dec 2021 10:34:44 -0500
Message-ID: <CAFX2Jfk3bnVVEwPXghGLXL-Nw1bcb_g1asJ6eWPVv6j6iDCG8w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the nfs-anna tree with the fscache tree
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 17, 2021 at 10:34 AM David Wysochanski <dwysocha@redhat.com> wrote:
>
> On Thu, Dec 16, 2021 at 7:35 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > Today's linux-next merge of the nfs-anna tree got conflicts in:
> >
> >   fs/nfs/fscache.c
> >   fs/nfs/fscache.h
> >   fs/nfs/fscache-index.c
> >
> > between commit:
> >
> >   882ff66585ec ("nfs: Convert to new fscache volume/cookie API")
> >
> > from the fscache tree and commits:
> >
> >   e89edabcb3d4 ("NFS: Remove remaining usages of NFSDBG_FSCACHE")
> >   0d20bd7faac9 ("NFS: Cleanup usage of nfs_inode in fscache interface and handle i_size properly")
> >   4a0574909596 ("NFS: Rename fscache read and write pages functions")
> >   3b779545aa01 ("NFS: Convert NFS fscache enable/disable dfprintks to tracepoints")
> >   b9077ca60a13 ("NFS: Replace dfprintks with tracepoints in fscache read and write page functions")
> >   416de7e7eeb6 ("NFS: Remove remaining dfprintks related to fscache cookies")
> >   fcb692b98976 ("NFS: Use nfs_i_fscache() consistently within NFS fscache code")
> >
> Anna, feel free to drop these from your tree to avoid the conflicts
> with the rest of your tree and dhowells fscache-rewrite patchset.

Sounds good!

Anna
>
>
>
> > from the nfs-anna tree.
> >
> > I had no idea how to fix this all up, so I just dropped the nfs-anna
> > tree for today.   Please get together and coordinate thses changes.
> >
> > --
> > Cheers,
> > Stephen Rothwell
>
