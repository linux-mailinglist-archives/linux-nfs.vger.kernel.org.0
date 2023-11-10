Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3F37E77AB
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 03:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjKJCnG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Nov 2023 21:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjKJCnG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Nov 2023 21:43:06 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6CE2126
        for <linux-nfs@vger.kernel.org>; Thu,  9 Nov 2023 18:43:03 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so2666551a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 09 Nov 2023 18:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699584182; x=1700188982; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+3Sqnx+jXKwWflr+tEii8VZs+0lyEig+kJmbkn5hcI=;
        b=lzR/RzrRTFTs/5bT3sNvhQ++GKIg7kNt+UeAzw4doPJaPmE7JZOqduLpYR6VJthKCQ
         Jzip/+aP71x0EOHUX32HgNSfkd7SWMQrn0ouNQnSSldofzWziUY6f9g+7x8uhYxTR58P
         UUjsXKFm8IYnfwm1jgwlF9EeAeb+AZKIUUivlEzUztqdDMkOnjWOLfaUuNXQ48yWClJN
         uQmV9qBd779AEnFLcDfPrVosIN6VKzPPtHXs2hB6QvSmDE49S5QPyAN3vl9QqBs2h447
         mxHYhKDeXVtmrx6Ek8D6zkYstQ3Mo+mPpNSfiAlk0/6QlSMMZtRUxMXdF2xapFRfZiWS
         URjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699584182; x=1700188982;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+3Sqnx+jXKwWflr+tEii8VZs+0lyEig+kJmbkn5hcI=;
        b=WaEai3Z+xJiRe4QXwOJY7/+WyUdfnubSmUzxfJ/DLNSfABAtoNjvqJpWy3Di0965qo
         yB6fMNkRXoWeCYyUMRW08bnPIbwZLPdo+N+pRh3szBEqYMNbhQepsH80wGtd3ToqUqew
         Z1qZnDtI0YJ62VvlCMJz8NBdXPC0rLsE8FBC8Cguzgc1XSJ8KpDM3ECPEsF+cho8LqbJ
         +2tJARYtu7jLq0tO7h+x2NnRWO9uncllJDR8IsxwsonxY42aZSNpWQHT5J/NpwgxqzV2
         /TPsLYimOEZNl2UT1MYgMy+y3QQ1EGnSPA+2dSHYV0vKYwM0czIjx+B0NXt7ztYVbEh7
         yvHg==
X-Gm-Message-State: AOJu0Yz7c3L6xmBcNOWykJgxg3LqqpW4Z2VSwu88VvLeVTxm5Qswopao
        JRYQw76IukQfezBMdtezfJVNj1jmdM8egiZ5XdzL22zRIkw=
X-Google-Smtp-Source: AGHT+IH1Nj6kCDJrX3g9gl2t5r3hHmoBqZRcxeEQvbvGvP/vyhqAc4F65JYTOi6oiODQ8emhU0p+I8eV7EaJtzBBRT4=
X-Received: by 2002:a50:cd5d:0:b0:543:7138:ca92 with SMTP id
 d29-20020a50cd5d000000b005437138ca92mr5809930edj.30.1699584181765; Thu, 09
 Nov 2023 18:43:01 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
 <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com> <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
 <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com>
In-Reply-To: <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com>
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Fri, 10 Nov 2023 03:42:25 +0100
Message-ID: <CALXu0Ud29m1vmx_QNH5SYHk=pMRohsxixBReXs71E-=VGypSRQ@mail.gmail.com>
Subject: Re: BUG in exports(5), no example for refer= Re: Examples for refer=
 in /etc/exports?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 10 Nov 2023 at 03:19, Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Nov 9, 2023, at 7:47 PM, Cedric Blancher <cedric.blancher@gmail.com> wrote:
> >
> > On Fri, 10 Nov 2023 at 01:37, Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>
> >>> On Nov 9, 2023, at 7:05 PM, Cedric Blancher <cedric.blancher@gmail.com> wrote:
> >>>
> >>> On Thu, 2 Nov 2023 at 10:51, Cedric Blancher <cedric.blancher@gmail.com> wrote:
> >>>>
> >>>> Good morning!
> >>>>
> >>>> Does anyone have examples of how to use the refer= option in /etc/exports?
> >>>
> >>> Short answer:
> >>> To redirect an NFS mount from local machine /ref/baguette to
> >>> /export/home/baguette on host 134.49.22.111 add this to Linux
> >>> /etc/exports:
> >>>
> >>> /ref *(no_root_squash,refer=/export/home@134.49.22.111)
> >>>
> >>> This is basically an exports(5) manpage bug, which does not provide
> >>> ANY examples.
> >>
> >> That's because setting up a referral this way is deprecated.
> >
> > Why did you do that?
>
> The nfsref command on Linux matches the same command on Solaris.

That does not answer my question. Why did you declare the refer option
in exports(8) depreciated, where it works, and is a much simpler way
than nfsref. nfsref information has to be maintained in yet another
configuration file, and nfsd on Linux already has TOO MANY of them.
Leave alone the fact that there is no Solaris-style INTRO manpage,
which systematically links all config files for nfsd, and all daemons
like rpc.gssd.

The all-in-one /etc/exports and /etc/exports.d/ sounds like a better solution.

>
> nfsref was added years ago to manage junctions, as part of FedFS.
> The "refer=" export option can't do that... and FedFS has gone
> the way of the dodo.

Can NFSv4 clients create junctions? Or just tools on the server side?

> >> The
> >> preferred way to do it is to use nfsref(8).
> >
> > nfsref(8) is not shipped by ANY Linux distribution.
>
> It is installed on all of my Fedora systems, and it's on my
> only RHEL 8 system. That suggests, though I can't immediately
> confirm it, that nfsref is packaged also for CentOS, Oracle
> Linux, and any other distro that is based on RedHat Enterprise.
>
>
> > The configure switch in nfs-utils to build it is OFF by default,
>
> You're talking about
>
>   --enable-junction       enable support for NFS junctions [default=no]

YES, that nightmare.

Nightmare, as it suddenly makes nfs-common depend on libidn11-dev
libcap-dev libldap-dev libsqlite3-dev libxml2-dev liburiparser-dev
libconfig-dev libdevmapper-dev and other packages. Package maintainer
hell.

> Perhaps that default should change -- it's been part of
> nfs-utils for five years now. However, that drags in
> dependencies for the xml libraries... maybe someone thinks
> that's a hazard?

Adding eight new package dependencies (libidn11-dev  libcap-dev
libldap-dev libsqlite3-dev libxml2-dev liburiparser-dev libconfig-dev
libdevmapper-dev...) is a problem, especially the LDAP one.

> > and the
> > distribution maintainers refuse to enable it because it can be
> > "dangerous", or may be "experimental". I got many excuses why they
> > dont want to enable that damn configure option.
> >
> > Also, stable and oldstable Debian do not have it enabled either.
>
> This is an upstream mailing list. We can't answer for what
> Linux distributors decide to enable or not.
>
> I've never heard that it was a dangerous feature. If a
> distro maintainer has a concern, they should bring it to
> upstream.
>
>
> > Seriously, why was refer= in exports(5) depreciated? There is no
> > realistic replacement, unless you fix every damn Linux distro first.
>
> Again, all the RHEL based distros package nfsref, as far
> as I am aware. And as you found, refer= still works. It's
> simply not documented.
>
> If your distro has decided not to support referrals, there's
> not much we can do about that except gently suggest that you
> switch to a distro that properly supports them.
>
>
> > PS: Sorry for being moody, but I tried to get nfsref(5) working for a
> > month on Debian bullseye, and it just didn't work.
>
> Did you report problems or ask for help?

yes

>
> If getting it working is that difficult, perhaps your distro's
> nfs-utils maintainer couldn't get it working either.

Maybe.

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
