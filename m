Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF5E3399B6
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 23:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbhCLWfS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 17:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbhCLWfE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 17:35:04 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE012C061574;
        Fri, 12 Mar 2021 14:35:03 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id mm21so56228445ejb.12;
        Fri, 12 Mar 2021 14:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWpIBx1l9eSZdSwA4taVa5NCupfCLbCXfPtWL5IZLkU=;
        b=H/uOGulMLF9lC+6AmvRl8HfVRAJIZoI+nJpcEA6Qxcex/nog4hUkkIqY8jd/AuQH25
         RMSsG6xzDdSw/maF9GCVEc12UthelIpUj3WY0xI5X8u5JjizWidTmzWPQsSMXEJX8dZi
         gmuX7dk1Ks32wmkHLPBoPLIAk9IBuYZc4iNqmn7P/hiYu0+7v/ilkEBL9BNjcJaLB3eR
         VJ9UwR1gJ33ii05u8GaHuanai3WCUBkdz+d2IyZEjCu2tUEkSpti/cKkcgcKB5v05z2A
         oO+aeLSPK5FRyWVtj0v49RXOKn/buSv9+JpUN0HnnUHjv+P2hujYz31qhkggkUVj/6us
         E5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWpIBx1l9eSZdSwA4taVa5NCupfCLbCXfPtWL5IZLkU=;
        b=mI1cwLaU6LLsVI1H3slvJP+peSi1QbMij0PIAtC2oQgT3euANE/UFzSHSXf6Fl59Vi
         MY5m3PDgNe2bsVf5PWhVoLGYitflLcpMJ8AZ0MJaGnzPDfSgeIYTPiZippHRD7qukDy3
         0PATIutAxufh5AjZ/zqUSxycax108f5obkaV7bUI3eYCGg6rRvmn5wi3FJLdpMSPoJqT
         Vor9pk5012u/tvqR2e7mYoMS3cHU27Vj9C21yUZvQ9BjMHkqGSIfFFZzMp2u4cUT9OyC
         o//ApES4TSNW4pxyS8WuCwMQag9DJnNR3YOOQ49JrvjIDHydBKtBhKZnEdRCiBQ+ugyK
         /YmA==
X-Gm-Message-State: AOAM530Hja/MW5XKCJ72IG/xWpBlAEyDsxQZ6eTf7vYp4Wiysb2uHcVs
        ySdbQ2q2Wh3jgX61SxWQYzYLRlDZXNiKz3AdR73zb23D
X-Google-Smtp-Source: ABdhPJy17V0HTw4HcJfBA2lUUw2Z9yxw0+4VblM4Gn8m2qFT3INS8U0nmvAjhGpuxnJ14jdpOwwvOIfyq2dv2awnaJ4=
X-Received: by 2002:a17:906:18aa:: with SMTP id c10mr10993588ejf.248.1615588502425;
 Fri, 12 Mar 2021 14:35:02 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
 <20210227033755.24460-1-olga.kornievskaia@gmail.com> <CAFX2Jfk--KwkAss1gqTPnQt-bKvUUapNdHbuicu=m+jOtjrMyQ@mail.gmail.com>
 <f8f5323c-cdfd-92e8-b359-43caaf9d7490@schaufler-ca.com> <CAHC9VhR=+uwN8U17JhYWKcXSc9=ExCrG4O9-y+DPJg6xZ=WoYA@mail.gmail.com>
 <CAFX2JfnT49o-CkaAE3=c0KW9SDS1U+scP0RD++nmWwyKoBDWkA@mail.gmail.com> <CAHC9VhQNp-GQ6SMABNdN00RcDz30Os5SK217W-5swS8quakxPA@mail.gmail.com>
In-Reply-To: <CAHC9VhQNp-GQ6SMABNdN00RcDz30Os5SK217W-5swS8quakxPA@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 12 Mar 2021 17:34:51 -0500
Message-ID: <CAN-5tyG95bL8vbkG5B9OmAAXremJ-X5z09f+0ekLyigzibsZ5A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] [security] Add new hook to compare new mount to an
 existing mount
To:     Paul Moore <paul@paul-moore.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 12, 2021 at 4:55 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Mar 12, 2021 at 10:45 AM Anna Schumaker
> <anna.schumaker@netapp.com> wrote:
> > On Thu, Mar 4, 2021 at 8:34 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Tue, Mar 2, 2021 at 10:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > On 3/2/2021 10:20 AM, Anna Schumaker wrote:
> > > > > Hi Casey,
> > > > >
> > > > > On Fri, Feb 26, 2021 at 10:40 PM Olga Kornievskaia
> > > > > <olga.kornievskaia@gmail.com> wrote:
> > > > >> From: Olga Kornievskaia <kolga@netapp.com>
> > > > >>
> > > > >> Add a new hook that takes an existing super block and a new mount
> > > > >> with new options and determines if new options confict with an
> > > > >> existing mount or not.
> > > > >>
> > > > >> A filesystem can use this new hook to determine if it can share
> > > > >> the an existing superblock with a new superblock for the new mount.
> > > > >>
> > > > >> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > Do you have any other thoughts on this patch? I'm also wondering how
> > > > > you want to handle sending it upstream.
> > > >
> > > > James Morris is the maintainer for the security sub-system,
> > > > so you'll want to send this through him. He will want you to
> > > > have an ACK from Paul Moore, who is the SELinux maintainer.
> > >
> > > In the past I've pulled patches such as this (new LSM hook, with only
> > > a SELinux implementation of the new hook) in via the selinux/next tree
> > > after the other LSMs have ACK'd the new hook.  This helps limit merge
> > > problems with other SELinux changes and allows us (the SELinux folks)
> > > to include it in the ongoing testing that we do during the -rcX
> > > releases.
> > >
> > > So Anna, if you or anyone else on the NFS side of the house want to
> > > add your ACKs/REVIEWs/etc. please do so as I don't like merging
> > > patches that cross subsystem boundaries without having all the
> > > associated ACKs.  Casey, James, and other LSM folks please do the
> > > same.
> >
> > Sure:
> > Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > Are you also going to take patch 3/3 that uses the new hook, or should
> > that go through the NFS tree? Patch 2/3 is a cleanup that can go
> > through the NFS tree.
>
> Generally when patches are posted as patchsets I would apply the whole
> patchset assuming they patches were all good, however it does seem
> like patch 2/3 is not strictly related to the other two?  That said,
> as long as your ACK applies to all three patches in the patchset I
> have no problem applying all of them to the selinux/next tree once
> some of the other LSM maintainers provide their ACKs (while there may
> only a SELinux implementation of the hook at the moment, we need to
> make sure the other LSMs are okay with the basic hook concept).
>
> Also, did the v4 posting only include patch 1/3?  I see v3 postings
> for the other two patches, but the only v4 patch I see is 1/3 ... ?

I didn't not repost patches that didn't change.

>
> --
> paul moore
> www.paul-moore.com
