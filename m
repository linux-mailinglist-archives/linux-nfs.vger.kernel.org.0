Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF6C3B873E
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 18:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhF3Qva (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 12:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhF3Qva (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Jun 2021 12:51:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE5EC061756
        for <linux-nfs@vger.kernel.org>; Wed, 30 Jun 2021 09:49:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b2so5326556ejg.8
        for <linux-nfs@vger.kernel.org>; Wed, 30 Jun 2021 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhK/jsGZ1fjRwv8qTs4wIHtLw2Ow2ERgmLWCB6L9Kag=;
        b=krBttlLpfTb7pFODKWCd5APMnI9k8g0vi0vwdlvZg3xOVbMIqimh7n/hThWVxVCZ+7
         qo03hAH9+s3A49axLWH88eBGddUUa80VF9Qda9dtt1cxRu/8bDA99turbvfNf6KmJAgZ
         vo5WtwyJxgsVTsZWZJuDV86GzhYc6UxBxB/440+6aOzE3pIymGg6HOJOYf0LJ48mE8j6
         0d6tFt7OrB2pUZigYgUxhSG20TDr5wORK47VNPd405ZiVGOke8qCd11tHaX7Ewa7KygW
         D1SJ847OQbnJkS+vo4L5PGni1Bm5FOcBLvF8NPNidRKQWvrBp02fpsRN8kl8qQxH3Z2U
         3dmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhK/jsGZ1fjRwv8qTs4wIHtLw2Ow2ERgmLWCB6L9Kag=;
        b=ZIpkkTngmfL2s4+fQ+GrsA3De/OZ4VR+I+zyxijae/iPKdNRYfPNpwc0wvdGEktC4I
         TfqD2gsAblV0EY0B9g4nSSXIqyt81Ehi3RisTbapLVyzkRl7B+39CLGtoZVTmVPgQouB
         je2OKnPA6H26rxSSLIHhCuvoSQ3M1dwc2ukhFz1tbX9NWixLjyPfXTpecjVuMxAGx8b1
         EYQKOhKBYDy2eIA+etjvdhJwBZ4AgPquYtCjqi80i7hpjfH2jTJiMMsetn/zDc09HU6F
         jJ9vgyftnB6nNfVW4xBAdlzK46uhxPFFNgq6dq5bvK+MeW3XKsADLu1vaBVcoE/ZBJze
         UQQw==
X-Gm-Message-State: AOAM533xB/HwVdf8PHCgjFQgeR/bfBLp7xSD8FViT83hBtXj5MZfPXhH
        qUboi9DMo81M77TWFjwnBx2XOZ9kfmrxqtLexWY=
X-Google-Smtp-Source: ABdhPJxweYMa0lGsj9wUHMNlsnQknYgitLRimB3BeTamvwpa5QlO1T02sKW7f126nUsbMfmqjRj5D+BRtjxnWkDoGz8=
X-Received: by 2002:a17:906:4899:: with SMTP id v25mr37228397ejq.451.1625071739382;
 Wed, 30 Jun 2021 09:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyEuB5C9u+xZ5L47fSQ9cwZnsbhJuBs+gybU2A-jzAkfog@mail.gmail.com>
 <81154dc28d528402bf5e090a81e6892c7abc431c.camel@hammerspace.com>
 <B0CA736F-E3E8-4446-9A6E-3ADCDD7F8736@oracle.com> <CAN-5tyE5Y3+ZPrfAR8=UVdNnWxyzO6a_NTeTsMFH_TyyMqK-bQ@mail.gmail.com>
 <607F15BF-89B4-4123-8223-A3893229D219@oracle.com> <20210630152258.GC20229@fieldses.org>
In-Reply-To: <20210630152258.GC20229@fieldses.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 30 Jun 2021 12:48:47 -0400
Message-ID: <CAN-5tyFD2SU1xVkiNh-Sp8s-_2QOu3O5ixOa_TDEXBNF=i2OVw@mail.gmail.com>
Subject: Re: client's caching of server-side capabilities
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 30, 2021 at 11:23 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, Jun 29, 2021 at 01:51:43PM +0000, Chuck Lever III wrote:
> >
> >
> > > On Jun 29, 2021, at 9:48 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> > >
> > > On Tue, Jun 29, 2021 at 8:58 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
> > >>
> > >>
> > >>
> > >>> On Jun 28, 2021, at 6:06 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> > >>>
> > >>> On Mon, 2021-06-28 at 16:23 -0400, Olga Kornievskaia wrote:
> > >>>> Hi folks,
> > >>>>
> > >>>> I have a general question of why the client doesn't throw away the
> > >>>> cached server's capabilities on server reboot. Say a client mounted a
> > >>>> server when the server didn't support security_labels, then the
> > >>>> server
> > >>>> was rebooted and support was enabled. Client re-establishes its
> > >>>> clientid/session, recovers state, but assumes all the old
> > >>>> capabilities
> > >>>> apply. A remount is required to clear old/find new capabilities. The
> > >>>> opposite is true that a capability could be removed (but I'm assuming
> > >>>> that's a less practical example).
> > >>>>
> > >>>> I'm curious what are the problems of clearing server capabilities and
> > >>>> rediscovering them on reboot? Is it because a local filesystem could
> > >>>> never have its attributes changed and thus a network file system
> > >>>> can't
> > >>>> either?
> > >>>>
> > >>>> Thank you.
> > >>>
> > >>> In my opinion, the client should aim for the absolute minimum overhead
> > >>> on a server reboot. The goal should be to recover state and get I/O
> > >>> started again as quickly as possible.
> > >>
> > >> I 100% agree with the above. However...
> > >>
> > >>
> > >>> Detection of new features, etc
> > >>> can wait until the client needs to restart.
> > >>
> > >> A server reboot can be part of a failover to a different server. I
> > >> think capability discovery needs to happen as part of server reboot
> > >> recovery, it can't be optimized away.
> > >
> > > Can you clarify what you mean by a "failover to a different server"?
> >
> > IP-based failover means that a server can crash, and its partner can
> > detect that and take over the IP address and exports of the failed
> > server. The replacement server doesn't have to have exactly the same
> > set of capabilities.
>
> So it could also lose capabilities?

Well, wouldn't the client lose capabilities even now? Operations
relying on those capabilities wouldn't work (ie., say security label
wouldn't be returned or an operation would error with ENOTSUPP). And I
think when it comes to operations, that's fine as the capability would
then be adjusted (removed).

To make it clear again, I'm not suggesting to do it at server reboot
as it was pointed out to cause performance problems.

> I'm a little nervous about server features being changed out from under
> the client while the client has the server mounted.
>
> But, I don't know, looking quickly through the list of NFS_CAP_*
> definitions in nfs_fs_sb.h, I'm not coming up with a case where we
> couldn't handle it, maybe it's OK.
>
> --b.
