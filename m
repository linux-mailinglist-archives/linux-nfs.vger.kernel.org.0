Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DC333C174
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Mar 2021 17:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhCOQQe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Mar 2021 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhCOQQK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Mar 2021 12:16:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C269CC06174A
        for <linux-nfs@vger.kernel.org>; Mon, 15 Mar 2021 09:16:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lr13so67273721ejb.8
        for <linux-nfs@vger.kernel.org>; Mon, 15 Mar 2021 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulnyOWV3k7p+kkHTBAJFOjtCBT9vuD1srNm0Q5hhXAI=;
        b=N2iGdudczdpkPsrDkM1mmtXSPjJkDgTe/DqW+CqExIcXzbqBtlIvjztFw+14ubnert
         E9k/Xwbp/N9mVngSq5/FOi18sQNwxq/DIOTcP6FW8esqto8efg8tGC9oNNWUJYwuZOLK
         28pKDQx4ca8UOtGz6bcjL+Eo+UmjwaPfa/IeeZd6lp3nceQhraxPhfce/UNXCkNwGTld
         S9HzGCH7hrJLVx/9hslrdnT7x4hMAh9To4W8jORbC89Errg10YbgV3CPyMBkvlOk1/+B
         O8bOHlDZiPe0lQJ0tnblufQyrUhlMwzWfiymI2UbJfnNeu4UUByv4TwZAtUqwPrWgbgr
         ZLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulnyOWV3k7p+kkHTBAJFOjtCBT9vuD1srNm0Q5hhXAI=;
        b=o8W4wslFSIeIrlB7iQETbqLy6QVoraLtiYrjYP9oBJnB+PopQYsA0VZJsNrEtkds0u
         hR55WNB2kBoTHH0iXczjs97QtV+QPVSGpJxzGFtRRnj73DZdq1D2nNbINeFbLDw4Li65
         t5jtk0dd9pmz6XKQ3E4XAMyozAd6UQHxSRt5Ey162jMchXJtp77/doSkE8g79nSGS6D4
         AfwFE5JNS4aBGUGMH6jtA7pYGY+BGCniblTZltp7kT8OO96zYnGJMHgT0G6AI42dxJik
         HAkW4RKNPovCY3jmfDKjlwiIQzbHuJOUk960U5F3fD7y+aJN6B+/yxezqWFdQGRuFax5
         FR+g==
X-Gm-Message-State: AOAM533p7Zr8doGZ9FIT559CW2aHpTDn9QYkG/U/HZ8Y00XDXeMVRHXj
        RUTmOXHuwR+cctgk+LME0jxTDU6Vb1G1Vzf21pEP
X-Google-Smtp-Source: ABdhPJwTF4hIv5pUp754NzExMaGQE6n1efQ6IkfwWybJHM92U5UvGrKKyUdUGxBCj1wjPGOQuBlC4LR4HjtyVeFs9ZY=
X-Received: by 2002:a17:906:a443:: with SMTP id cb3mr24222437ejb.542.1615824968416;
 Mon, 15 Mar 2021 09:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
 <20210227033755.24460-1-olga.kornievskaia@gmail.com> <CAFX2Jfk--KwkAss1gqTPnQt-bKvUUapNdHbuicu=m+jOtjrMyQ@mail.gmail.com>
 <f8f5323c-cdfd-92e8-b359-43caaf9d7490@schaufler-ca.com> <CAHC9VhR=+uwN8U17JhYWKcXSc9=ExCrG4O9-y+DPJg6xZ=WoYA@mail.gmail.com>
 <CAFX2JfnT49o-CkaAE3=c0KW9SDS1U+scP0RD++nmWwyKoBDWkA@mail.gmail.com>
 <CAHC9VhQNp-GQ6SMABNdN00RcDz30Os5SK217W-5swS8quakxPA@mail.gmail.com>
 <CAN-5tyG95bL8vbkG5B9OmAAXremJ-X5z09f+0ekLyigzibsZ5A@mail.gmail.com>
 <CAHC9VhTwqt0TDEWV97GaM8B5m4qmEwo+BYXYDeMs2D1LtZzUFg@mail.gmail.com> <CAN-5tyHdiuiOBX2bkZBGOTK-AMOccm27=qE-AZ_J9QQ00P91-Q@mail.gmail.com>
In-Reply-To: <CAN-5tyHdiuiOBX2bkZBGOTK-AMOccm27=qE-AZ_J9QQ00P91-Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Mar 2021 12:15:57 -0400
Message-ID: <CAHC9VhTZe0azgqt_OSk0cy-nM+upz9z2_i0j1wQQLD8UgbX9+Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] [security] Add new hook to compare new mount to an
 existing mount
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
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

On Mon, Mar 15, 2021 at 11:31 AM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
> On Sun, Mar 14, 2021 at 9:44 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Mar 12, 2021 at 5:35 PM Olga Kornievskaia
> > <olga.kornievskaia@gmail.com> wrote:
> > > On Fri, Mar 12, 2021 at 4:55 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > On Fri, Mar 12, 2021 at 10:45 AM Anna Schumaker
> > > > <anna.schumaker@netapp.com> wrote:
> > > > > On Thu, Mar 4, 2021 at 8:34 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > On Tue, Mar 2, 2021 at 10:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > > > > On 3/2/2021 10:20 AM, Anna Schumaker wrote:
> > > > > > > > Hi Casey,
> > > > > > > >
> > > > > > > > On Fri, Feb 26, 2021 at 10:40 PM Olga Kornievskaia
> > > > > > > > <olga.kornievskaia@gmail.com> wrote:
> > > > > > > >> From: Olga Kornievskaia <kolga@netapp.com>
> > > > > > > >>
> > > > > > > >> Add a new hook that takes an existing super block and a new mount
> > > > > > > >> with new options and determines if new options confict with an
> > > > > > > >> existing mount or not.
> > > > > > > >>
> > > > > > > >> A filesystem can use this new hook to determine if it can share
> > > > > > > >> the an existing superblock with a new superblock for the new mount.
> > > > > > > >>
> > > > > > > >> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > > > > Do you have any other thoughts on this patch? I'm also wondering how
> > > > > > > > you want to handle sending it upstream.
> > > > > > >
> > > > > > > James Morris is the maintainer for the security sub-system,
> > > > > > > so you'll want to send this through him. He will want you to
> > > > > > > have an ACK from Paul Moore, who is the SELinux maintainer.
> > > > > >
> > > > > > In the past I've pulled patches such as this (new LSM hook, with only
> > > > > > a SELinux implementation of the new hook) in via the selinux/next tree
> > > > > > after the other LSMs have ACK'd the new hook.  This helps limit merge
> > > > > > problems with other SELinux changes and allows us (the SELinux folks)
> > > > > > to include it in the ongoing testing that we do during the -rcX
> > > > > > releases.
> > > > > >
> > > > > > So Anna, if you or anyone else on the NFS side of the house want to
> > > > > > add your ACKs/REVIEWs/etc. please do so as I don't like merging
> > > > > > patches that cross subsystem boundaries without having all the
> > > > > > associated ACKs.  Casey, James, and other LSM folks please do the
> > > > > > same.
> > > > >
> > > > > Sure:
> > > > > Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > > >
> > > > > Are you also going to take patch 3/3 that uses the new hook, or should
> > > > > that go through the NFS tree? Patch 2/3 is a cleanup that can go
> > > > > through the NFS tree.
> > > >
> > > > Generally when patches are posted as patchsets I would apply the whole
> > > > patchset assuming they patches were all good, however it does seem
> > > > like patch 2/3 is not strictly related to the other two?  That said,
> > > > as long as your ACK applies to all three patches in the patchset I
> > > > have no problem applying all of them to the selinux/next tree once
> > > > some of the other LSM maintainers provide their ACKs (while there may
> > > > only a SELinux implementation of the hook at the moment, we need to
> > > > make sure the other LSMs are okay with the basic hook concept).
> > > >
> > > > Also, did the v4 posting only include patch 1/3?  I see v3 postings
> > > > for the other two patches, but the only v4 patch I see is 1/3 ... ?
> > >
> > > I didn't not repost patches that didn't change.
> >
> > Okay, so I'm guessing that means path 2/3 and 3/3 didn't change?
> >
> > While I suppose there are cases where people do not do this, it has
> > been my experience that if someone posts a patchset and some portion
> > of the patchset changes, due to feedback or other factors, the entire
> > patchset is reposted under the new version number.  If nothing else
> > this helps ensure people are always looking at the latest draft of a
> > particular patch instead of having to dig through the list to
> > determine which patch is the most recent.
>
> Correct, patches 2&3 didn't change and selinux patch generated several
> iterations. Would you like me to repost a series? I'm not sure what
> I'm supposed to do at this point.

As long as we are clear that the latest draft of patch 1/3 is to be
taken from the v4 patch{set} and patches 2/3 and 3/3 are to be taken
from v3 of the patchset I don't think you need to do anything further.
The important bit is for the other LSM folks to ACK the new hook; if I
don't see anything from them, either positive or negative, I'll merge
it towards the end of this week or early next.

-- 
paul moore
www.paul-moore.com
