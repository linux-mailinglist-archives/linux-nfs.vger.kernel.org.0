Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D9D339957
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 22:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbhCLVzQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 16:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbhCLVzL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 16:55:11 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91435C061762
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 13:55:10 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ci14so55997665ejc.7
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 13:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Yu+3WtjZJFNN7iqcDPjrgTHYecSIT+nbgpA6AtNWKQ=;
        b=x13yyZJmzbMrEVCHpmcnGoC2lyJyY1Gu5t1/FqRXdJRT6NmWNk+s7qwQnU40keBU3f
         /eW29oVPvJWWg9ZeYg06UgESqM3r6IHwRVM0EZOD5cFQ3Asp49XBf2lydLZbNaSDNNVh
         rERbfCohO2WDq/TOCZehd9z2tfCLROLrrs+2EmkIo+j8t9vm4DcDI1IwO0IkgotNlvfH
         U8MkIfZBk7Reh6NalYvSfdxpbD3bBq78CsAjx/kVafqOwVmsWd1q/n1qcFFFsOoEesFc
         JCQW1+83tgDN1DmkTjupAdcWXPixyPJYSJEddgjqJlt3SlLBK/lyGbbsxkD8NPtVwW6r
         n4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Yu+3WtjZJFNN7iqcDPjrgTHYecSIT+nbgpA6AtNWKQ=;
        b=M37b6rRg+pgs9QuBanLxWHaCk+sh6KPJ6dnnb0XoBlvJFdLvEursJn/M3WzqxzW0ws
         3LPFR4swEgeA3rSBbo2QN6byAe/9t1GXMy0H+Jv/rs89HQwssr/a9styZge7PMp9PQI4
         PlMTFfcqk98Q78vJAKiaSnS7K9Rvk92YaMHlZv6IEe2+W0uYbTBX6yjrGnXYMZzgswC6
         zrWc0n+2Re/L70QjwQ5g2kATo1uTt6DA3p3ZnMUnCpqervU64y5fHQ/tokAp1GzBvWfa
         4SWmGHGWJTwt9N7tiEGV99Am9yy6Egcc1Yx+5h3vKMwWjmhwxUP56InRINN50RZN6NCx
         CdHw==
X-Gm-Message-State: AOAM532GjJYcP8lwc6UK+mqXpfAjsUqSzusKyVRBZDrujbZ0ca5dYz8s
        Rd5Uud8YFT9coR2zzi/E7SZwiaoa6Y9u0XRcfa0z
X-Google-Smtp-Source: ABdhPJx/r2LPJxhnkP5OkwX7KIRS/TErPw1DulH9L3bH9xCetBaBfA/cyUiVYJQEGuk4mkQlQfODRAjlmpsw9ZaWkI0=
X-Received: by 2002:a17:906:3d62:: with SMTP id r2mr10660838ejf.488.1615586109189;
 Fri, 12 Mar 2021 13:55:09 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
 <20210227033755.24460-1-olga.kornievskaia@gmail.com> <CAFX2Jfk--KwkAss1gqTPnQt-bKvUUapNdHbuicu=m+jOtjrMyQ@mail.gmail.com>
 <f8f5323c-cdfd-92e8-b359-43caaf9d7490@schaufler-ca.com> <CAHC9VhR=+uwN8U17JhYWKcXSc9=ExCrG4O9-y+DPJg6xZ=WoYA@mail.gmail.com>
 <CAFX2JfnT49o-CkaAE3=c0KW9SDS1U+scP0RD++nmWwyKoBDWkA@mail.gmail.com>
In-Reply-To: <CAFX2JfnT49o-CkaAE3=c0KW9SDS1U+scP0RD++nmWwyKoBDWkA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 12 Mar 2021 16:54:58 -0500
Message-ID: <CAHC9VhQNp-GQ6SMABNdN00RcDz30Os5SK217W-5swS8quakxPA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] [security] Add new hook to compare new mount to an
 existing mount
To:     Anna Schumaker <anna.schumaker@netapp.com>
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

On Fri, Mar 12, 2021 at 10:45 AM Anna Schumaker
<anna.schumaker@netapp.com> wrote:
> On Thu, Mar 4, 2021 at 8:34 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Mar 2, 2021 at 10:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > On 3/2/2021 10:20 AM, Anna Schumaker wrote:
> > > > Hi Casey,
> > > >
> > > > On Fri, Feb 26, 2021 at 10:40 PM Olga Kornievskaia
> > > > <olga.kornievskaia@gmail.com> wrote:
> > > >> From: Olga Kornievskaia <kolga@netapp.com>
> > > >>
> > > >> Add a new hook that takes an existing super block and a new mount
> > > >> with new options and determines if new options confict with an
> > > >> existing mount or not.
> > > >>
> > > >> A filesystem can use this new hook to determine if it can share
> > > >> the an existing superblock with a new superblock for the new mount.
> > > >>
> > > >> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > Do you have any other thoughts on this patch? I'm also wondering how
> > > > you want to handle sending it upstream.
> > >
> > > James Morris is the maintainer for the security sub-system,
> > > so you'll want to send this through him. He will want you to
> > > have an ACK from Paul Moore, who is the SELinux maintainer.
> >
> > In the past I've pulled patches such as this (new LSM hook, with only
> > a SELinux implementation of the new hook) in via the selinux/next tree
> > after the other LSMs have ACK'd the new hook.  This helps limit merge
> > problems with other SELinux changes and allows us (the SELinux folks)
> > to include it in the ongoing testing that we do during the -rcX
> > releases.
> >
> > So Anna, if you or anyone else on the NFS side of the house want to
> > add your ACKs/REVIEWs/etc. please do so as I don't like merging
> > patches that cross subsystem boundaries without having all the
> > associated ACKs.  Casey, James, and other LSM folks please do the
> > same.
>
> Sure:
> Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>
> Are you also going to take patch 3/3 that uses the new hook, or should
> that go through the NFS tree? Patch 2/3 is a cleanup that can go
> through the NFS tree.

Generally when patches are posted as patchsets I would apply the whole
patchset assuming they patches were all good, however it does seem
like patch 2/3 is not strictly related to the other two?  That said,
as long as your ACK applies to all three patches in the patchset I
have no problem applying all of them to the selinux/next tree once
some of the other LSM maintainers provide their ACKs (while there may
only a SELinux implementation of the hook at the moment, we need to
make sure the other LSMs are okay with the basic hook concept).

Also, did the v4 posting only include patch 1/3?  I see v3 postings
for the other two patches, but the only v4 patch I see is 1/3 ... ?

-- 
paul moore
www.paul-moore.com
