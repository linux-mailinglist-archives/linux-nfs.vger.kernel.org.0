Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2293E33922A
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 16:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhCLPqJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 10:46:09 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:42968 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbhCLPqA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 10:46:00 -0500
Received: by mail-ej1-f51.google.com with SMTP id c10so54125251ejx.9;
        Fri, 12 Mar 2021 07:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1HpxgHYTFg/Fiy9HzFnN5aYrg8PdK4Zz6eNMkByZOQ=;
        b=ZrAPaEwWBHF9ZTjyxisxeO6fCV9jOuA4NbZcM8ejc9lZsVgK/66NJ9rSn7ZHk5sWZz
         g4b9GEnFWtbZh+mtWkphj+bI934MoBwfUVaeX+LAQ177w7/j4j3nbQihlDVgsMXsI4ZW
         GRgzeHjGE41oMhGJEh4pS1TMtpg7Ahn2aDKu2pCJLzvVb9gSy5h2xF6e61latQvM9qB/
         qtlNfxjDpGIQESkC2vRP16emnaQekGQmQabdJCgEKL0kyFwdWVbNLt2Y5VBtmwjkOAHS
         cSrcPTiwEEyix/DK8tNnhi2/id6ZWLDEFn85t6oOYgkO02MREaeNFCOeJkhl5j+/HSBF
         u23w==
X-Gm-Message-State: AOAM531hM0dom4lp2WJsLg0VI/KiX1SMYYvo3qZLRU0VbJIm3Tbw3091
        CZaOB8bZK8S8/IhQWnO+2uno6NusmF0OMyAdTltPHtjtGh8=
X-Google-Smtp-Source: ABdhPJzSxuuHpVvuY/3fx7VuVAza8CeQXKqJM7E6/bn3Tg/YFxUIAenXMt+sKbScJmPABZa6Duhd/VeUZoKutXD5WHI=
X-Received: by 2002:a17:906:4e17:: with SMTP id z23mr9318713eju.439.1615563958756;
 Fri, 12 Mar 2021 07:45:58 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
 <20210227033755.24460-1-olga.kornievskaia@gmail.com> <CAFX2Jfk--KwkAss1gqTPnQt-bKvUUapNdHbuicu=m+jOtjrMyQ@mail.gmail.com>
 <f8f5323c-cdfd-92e8-b359-43caaf9d7490@schaufler-ca.com> <CAHC9VhR=+uwN8U17JhYWKcXSc9=ExCrG4O9-y+DPJg6xZ=WoYA@mail.gmail.com>
In-Reply-To: <CAHC9VhR=+uwN8U17JhYWKcXSc9=ExCrG4O9-y+DPJg6xZ=WoYA@mail.gmail.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Fri, 12 Mar 2021 10:45:42 -0500
Message-ID: <CAFX2JfnT49o-CkaAE3=c0KW9SDS1U+scP0RD++nmWwyKoBDWkA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] [security] Add new hook to compare new mount to an
 existing mount
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 4, 2021 at 8:34 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Mar 2, 2021 at 10:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 3/2/2021 10:20 AM, Anna Schumaker wrote:
> > > Hi Casey,
> > >
> > > On Fri, Feb 26, 2021 at 10:40 PM Olga Kornievskaia
> > > <olga.kornievskaia@gmail.com> wrote:
> > >> From: Olga Kornievskaia <kolga@netapp.com>
> > >>
> > >> Add a new hook that takes an existing super block and a new mount
> > >> with new options and determines if new options confict with an
> > >> existing mount or not.
> > >>
> > >> A filesystem can use this new hook to determine if it can share
> > >> the an existing superblock with a new superblock for the new mount.
> > >>
> > >> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > Do you have any other thoughts on this patch? I'm also wondering how
> > > you want to handle sending it upstream.
> >
> > James Morris is the maintainer for the security sub-system,
> > so you'll want to send this through him. He will want you to
> > have an ACK from Paul Moore, who is the SELinux maintainer.
>
> In the past I've pulled patches such as this (new LSM hook, with only
> a SELinux implementation of the new hook) in via the selinux/next tree
> after the other LSMs have ACK'd the new hook.  This helps limit merge
> problems with other SELinux changes and allows us (the SELinux folks)
> to include it in the ongoing testing that we do during the -rcX
> releases.
>
> So Anna, if you or anyone else on the NFS side of the house want to
> add your ACKs/REVIEWs/etc. please do so as I don't like merging
> patches that cross subsystem boundaries without having all the
> associated ACKs.  Casey, James, and other LSM folks please do the
> same.

Sure:
Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

Are you also going to take patch 3/3 that uses the new hook, or should
that go through the NFS tree? Patch 2/3 is a cleanup that can go
through the NFS tree.

Anna

>
> --
> paul moore
> www.paul-moore.com
