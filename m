Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FDC33BFBE
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Mar 2021 16:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhCOPbL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Mar 2021 11:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhCOPbE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Mar 2021 11:31:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675C6C06174A;
        Mon, 15 Mar 2021 08:31:04 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id c10so66866539ejx.9;
        Mon, 15 Mar 2021 08:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64X34bhEu2CD4Cj0a1kh10CwAhIg45vGeoEortJGqEI=;
        b=pdeyMiPqUWXw0wj4NTdwpSsQuWE/eNpD+xq9PLRjaShfJOr4j8o4/Sw1ZI6JLIAnBw
         caaaprG7KzEZYaTbQN+fN2Z2PelKUzf69fTjg69SGKIjB5VZeKQGzI4tcJmJUAbQSgr2
         GsJHyrgO7dg7JKarzOHQUULOHth1hpdNBBqQAl2K+YXveqowqFiwUiXuCsm0EvFZayYj
         kH1mMHLvYn0SnLvNCdiqfUD1cEIWJBc2gPv03bvhCH08ljRfBLKFab9IvZwswre2BynU
         SQf8ypBxMhi9BDXlJ8rl0nJwjdek0SLUKc1D7a3PTarHw4e7tdofImRiTxHzMUcA55Zo
         ODEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64X34bhEu2CD4Cj0a1kh10CwAhIg45vGeoEortJGqEI=;
        b=iAIq0Rs+eQ6Z7OQUmj9qZW113snzvRf0yYdfH6YQuaB29sSSkUTmzF762I6q86GG/1
         uoJPF7OYEOAfGBlT7Wt+HtnBqV4Ku6oVr7dHeDo7tn4e02NrflG6svHb8+0yEbLJ9paX
         sYRvhV3ojCEeuohtQSRTk13Lcpq0PRsoqC+1eY//zdkRkDYWNbxSU1C27vSbVM3NhGB2
         JRa3eSbdujZ0jZsipkbFerzJhaaYV9VQXAKFsflaOJ/7LeNLzAYDdWF5JkERSzvdBfwF
         9/mU/z8C7swzz+PalgiyUdb192RKukOEf366n/gjvI4z6spxnnGe7/YYZnSSsk1TsmPU
         Z2gQ==
X-Gm-Message-State: AOAM530mphQFcZp7e4CEB41dib6149ZUoTxzSTK/MvjgcAwQ+4i8aAEW
        Ciu8rIS0JZs2ZQMox4XrblzgulVftnl2jMz00PA=
X-Google-Smtp-Source: ABdhPJxcge7lnTHMouIBxSQoPnrryLugp62QtIQuXmZVtKNqbqTHBdXvJvWz9OvlmUnTTs6CFORClbYDvG5PTEeIEd8=
X-Received: by 2002:a17:906:b20b:: with SMTP id p11mr24674890ejz.0.1615822263078;
 Mon, 15 Mar 2021 08:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGuV-gs0KzVbKSj42ZMx553zy9wOfVb1SoHoE-WCoN1_w@mail.gmail.com>
 <20210227033755.24460-1-olga.kornievskaia@gmail.com> <CAFX2Jfk--KwkAss1gqTPnQt-bKvUUapNdHbuicu=m+jOtjrMyQ@mail.gmail.com>
 <f8f5323c-cdfd-92e8-b359-43caaf9d7490@schaufler-ca.com> <CAHC9VhR=+uwN8U17JhYWKcXSc9=ExCrG4O9-y+DPJg6xZ=WoYA@mail.gmail.com>
 <CAFX2JfnT49o-CkaAE3=c0KW9SDS1U+scP0RD++nmWwyKoBDWkA@mail.gmail.com>
 <CAHC9VhQNp-GQ6SMABNdN00RcDz30Os5SK217W-5swS8quakxPA@mail.gmail.com>
 <CAN-5tyG95bL8vbkG5B9OmAAXremJ-X5z09f+0ekLyigzibsZ5A@mail.gmail.com> <CAHC9VhTwqt0TDEWV97GaM8B5m4qmEwo+BYXYDeMs2D1LtZzUFg@mail.gmail.com>
In-Reply-To: <CAHC9VhTwqt0TDEWV97GaM8B5m4qmEwo+BYXYDeMs2D1LtZzUFg@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 15 Mar 2021 11:30:51 -0400
Message-ID: <CAN-5tyHdiuiOBX2bkZBGOTK-AMOccm27=qE-AZ_J9QQ00P91-Q@mail.gmail.com>
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

On Sun, Mar 14, 2021 at 9:44 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Mar 12, 2021 at 5:35 PM Olga Kornievskaia
> <olga.kornievskaia@gmail.com> wrote:
> > On Fri, Mar 12, 2021 at 4:55 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Fri, Mar 12, 2021 at 10:45 AM Anna Schumaker
> > > <anna.schumaker@netapp.com> wrote:
> > > > On Thu, Mar 4, 2021 at 8:34 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Tue, Mar 2, 2021 at 10:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > > > On 3/2/2021 10:20 AM, Anna Schumaker wrote:
> > > > > > > Hi Casey,
> > > > > > >
> > > > > > > On Fri, Feb 26, 2021 at 10:40 PM Olga Kornievskaia
> > > > > > > <olga.kornievskaia@gmail.com> wrote:
> > > > > > >> From: Olga Kornievskaia <kolga@netapp.com>
> > > > > > >>
> > > > > > >> Add a new hook that takes an existing super block and a new mount
> > > > > > >> with new options and determines if new options confict with an
> > > > > > >> existing mount or not.
> > > > > > >>
> > > > > > >> A filesystem can use this new hook to determine if it can share
> > > > > > >> the an existing superblock with a new superblock for the new mount.
> > > > > > >>
> > > > > > >> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > > > > Do you have any other thoughts on this patch? I'm also wondering how
> > > > > > > you want to handle sending it upstream.
> > > > > >
> > > > > > James Morris is the maintainer for the security sub-system,
> > > > > > so you'll want to send this through him. He will want you to
> > > > > > have an ACK from Paul Moore, who is the SELinux maintainer.
> > > > >
> > > > > In the past I've pulled patches such as this (new LSM hook, with only
> > > > > a SELinux implementation of the new hook) in via the selinux/next tree
> > > > > after the other LSMs have ACK'd the new hook.  This helps limit merge
> > > > > problems with other SELinux changes and allows us (the SELinux folks)
> > > > > to include it in the ongoing testing that we do during the -rcX
> > > > > releases.
> > > > >
> > > > > So Anna, if you or anyone else on the NFS side of the house want to
> > > > > add your ACKs/REVIEWs/etc. please do so as I don't like merging
> > > > > patches that cross subsystem boundaries without having all the
> > > > > associated ACKs.  Casey, James, and other LSM folks please do the
> > > > > same.
> > > >
> > > > Sure:
> > > > Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > >
> > > > Are you also going to take patch 3/3 that uses the new hook, or should
> > > > that go through the NFS tree? Patch 2/3 is a cleanup that can go
> > > > through the NFS tree.
> > >
> > > Generally when patches are posted as patchsets I would apply the whole
> > > patchset assuming they patches were all good, however it does seem
> > > like patch 2/3 is not strictly related to the other two?  That said,
> > > as long as your ACK applies to all three patches in the patchset I
> > > have no problem applying all of them to the selinux/next tree once
> > > some of the other LSM maintainers provide their ACKs (while there may
> > > only a SELinux implementation of the hook at the moment, we need to
> > > make sure the other LSMs are okay with the basic hook concept).
> > >
> > > Also, did the v4 posting only include patch 1/3?  I see v3 postings
> > > for the other two patches, but the only v4 patch I see is 1/3 ... ?
> >
> > I didn't not repost patches that didn't change.
>
> Okay, so I'm guessing that means path 2/3 and 3/3 didn't change?
>
> While I suppose there are cases where people do not do this, it has
> been my experience that if someone posts a patchset and some portion
> of the patchset changes, due to feedback or other factors, the entire
> patchset is reposted under the new version number.  If nothing else
> this helps ensure people are always looking at the latest draft of a
> particular patch instead of having to dig through the list to
> determine which patch is the most recent.

Correct, patches 2&3 didn't change and selinux patch generated several
iterations. Would you like me to repost a series? I'm not sure what
I'm supposed to do at this point.

>
> --
> paul moore
> www.paul-moore.com
