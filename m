Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F347E7E55
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 18:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbjKJRny (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 12:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344168AbjKJRnb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 12:43:31 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084439EDE
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 00:30:25 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1f00b95dc43so989317fac.3
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 00:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699605024; x=1700209824; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5GrnlX3g1MjaWruiwBKs1huqws5/+qo9PrFjIDL1Q0=;
        b=MB4OUaZhJqlkdabEPyk5aKbCCuc3fzkFTOFTaD9A8m8/dTmhdQP9vsjGkZaDgZmtAS
         wscasqFXj6iymRG97SrjnPW0hNdCrURGDragO+qG8sdUxFg8E0QhMHW4Hww7ij3ZQD/u
         BfoCeTYivKRS6O9AI0apy5OAiCMBvpvt1oelbvmNiKhVkidE6QNOOHQRiCZ9WEHOTumm
         XV/686IsEj/7DeG40xKxq9pCjK91eF8GFsymaCPasxEEURX3yzYyOPeuxw74dPFE2iUs
         dNsvLqD2IfJssE59wjGoZqldbWQ+0OHVvv0Nm8vcQEZ7+SA3/TMhbKSV3Z4/6LBxoXAj
         0+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699605024; x=1700209824;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5GrnlX3g1MjaWruiwBKs1huqws5/+qo9PrFjIDL1Q0=;
        b=VYEB9QRlyBfzUZXhJWfsMjPLtCoYZZs+uGNcxTXtiL8+DOqYh5/W3nxv4tUcLN5rUf
         kWraU/W+0Jk9l6GbJcqqlPmlgcnhKxsO542ThSj8vdUjAqlziW0fiPI6N295O1XwqbRX
         8R/ZGOzs7MVGB+fDXGP9YWPv9zC1GUZieqKpgrtRsq9CScrRE/AreF7+F7/V83sg6gDN
         Ye9xrjaPc7BzR6shOnv0+opcp7P1zN+4TyNpgvWlDqVaw5mh36nQC1a3iZ8uxKyPqiWT
         1NmuU1El876F8ub21xlUE4uijbAvxmMwCS8rNKxWBmgRI3450RgDJbQCTMRh3sHeIdNT
         wF3A==
X-Gm-Message-State: AOJu0YzHdpegxMiQKHl0MS33rg7YrPN5xS1qlYuXTwDUd3HTkRiQsJbk
        6WdHFZAIRYnGoe70EnfbFqBKzPoMfZvBXrc2vdZg73Cy
X-Google-Smtp-Source: AGHT+IGOD+FxZySfAKEaJjz38iDSpiE8Rp8BkXH/SDpT0NPaSpxT3EW8FHtLSJ9yd/lqjbo37LLzvoaHahaVvIlj4RA=
X-Received: by 2002:a05:6871:7244:b0:1f0:5543:6048 with SMTP id
 ml4-20020a056871724400b001f055436048mr10094724oac.49.1699605023941; Fri, 10
 Nov 2023 00:30:23 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
 <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com> <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
 <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com>
In-Reply-To: <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com>
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Fri, 10 Nov 2023 09:30:00 +0100
Message-ID: <CANH4o6O=ihW7ENc-BTBXR4d4JL0QJjZa5YdYaKAdoHdq9vwGcA@mail.gmail.com>
Subject: Re: BUG in exports(5), no example for refer= Re: Examples for refer=
 in /etc/exports?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 10, 2023 at 3:20=E2=80=AFAM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Nov 9, 2023, at 7:47 PM, Cedric Blancher <cedric.blancher@gmail.com>=
 wrote:
> >
> > On Fri, 10 Nov 2023 at 01:37, Chuck Lever III <chuck.lever@oracle.com> =
wrote:
> >>
> >>> On Nov 9, 2023, at 7:05 PM, Cedric Blancher <cedric.blancher@gmail.co=
m> wrote:
> >>>
> >>> On Thu, 2 Nov 2023 at 10:51, Cedric Blancher <cedric.blancher@gmail.c=
om> wrote:
> >>>>
> >>>> Good morning!
> >>>>
> >>>> Does anyone have examples of how to use the refer=3D option in /etc/=
exports?
> >>>
> >>> Short answer:
> >>> To redirect an NFS mount from local machine /ref/baguette to
> >>> /export/home/baguette on host 134.49.22.111 add this to Linux
> >>> /etc/exports:
> >>>
> >>> /ref *(no_root_squash,refer=3D/export/home@134.49.22.111)
> >>>
> >>> This is basically an exports(5) manpage bug, which does not provide
> >>> ANY examples.
> >>
> >> That's because setting up a referral this way is deprecated.
> >
> > Why did you do that?
>
> The nfsref command on Linux matches the same command on Solaris.
>
> nfsref was added years ago to manage junctions, as part of FedFS.
> The "refer=3D" export option can't do that...

Where in the kernel is the code for the refer=3D option? I'd like to get
some of my students to contribute support for custom NFS ports.

I would seriously suggest keeping it for "simple" use cases. nfsref(8)
has ZERO deployment outside RHEL&RHEL clones

> and FedFS has gone
> the way of the dodo.

Why did that happen? ;(

>
> >> The
> >> preferred way to do it is to use nfsref(8).
> >
> > nfsref(8) is not shipped by ANY Linux distribution.
>
> It is installed on all of my Fedora systems, and it's on my
> only RHEL 8 system. That suggests, though I can't immediately
> confirm it, that nfsref is packaged also for CentOS, Oracle
> Linux, and any other distro that is based on RedHat Enterprise.

That are all RHEL clones...

>
> > The configure switch in nfs-utils to build it is OFF by default,
>
> You're talking about
>
>   --enable-junction       enable support for NFS junctions [default=3Dno]
>
> Perhaps that default should change -- it's been part of
> nfs-utils for five years now. However, that drags in
> dependencies for the xml libraries... maybe someone thinks
> that's a hazard?

I would consider it a hazard when the kernel support code drags in XML.
>
>
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
> > Seriously, why was refer=3D in exports(5) depreciated? There is no
> > realistic replacement, unless you fix every damn Linux distro first.
>
> Again, all the RHEL based distros package nfsref, as far
> as I am aware. And as you found, refer=3D still works. It's
> simply not documented.

Then please document it. You have real world users for that one, who
would be grateful if you don't pull away the floor under their feet.

>
> If your distro has decided not to support referrals, there's
> not much we can do about that except gently suggest that you
> switch to a distro that properly supports them.

You could turn on --enable-junctions by default. And maybe get rid of
the XML dependencies.

Thanks,
Martin
