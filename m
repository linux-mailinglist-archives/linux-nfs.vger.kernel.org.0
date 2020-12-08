Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B112D2C1D
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Dec 2020 14:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgLHNjJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Dec 2020 08:39:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33448 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbgLHNjI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Dec 2020 08:39:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id k4so17652677edl.0
        for <linux-nfs@vger.kernel.org>; Tue, 08 Dec 2020 05:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tyPOgR6LAeVQTYBfoFUC/YN2JOK5Y9NpDSdcaSBJWo=;
        b=k1WzChEdy7UeD+/ivUsAO7jeNnR9mXB8hRymv9qo18VlF5IfHc+F8fQiYgDXu214Qe
         jlfBJGI8yxtZTIu4Tq2IT3R1qBpzS/MX97BQCnQiorDP0InTYVI/LGzhLeEt0C9zIsT1
         a2lKJTTGUnBOfqhpbLHQqRZvrSonpGzO3dRbmwA6CumbGxUMIuubBq/KuJ/eS+l4pq2r
         WHEtQGJXfOIiS+MDBECsLzWDGxhEARlH3eEVgd9SWbWRMZSZsE4OmosMs+ubMPerU6Jf
         kIvk5axCJINTLG3NcUKB39Jwf7iePpzrQTilv4WvXX+pu0bSaHEtAyb9Hjio54a9c4lA
         Ucfg==
X-Gm-Message-State: AOAM531Z9nRPkjb17JvEwP8KP2JoILb6JrYJ0PwqG2wmG3biNf7Y2Wfg
        ibC1qc6MvQe9seiY92mU8ygf4GM6uUEK3FENFtlSYgb6
X-Google-Smtp-Source: ABdhPJzu6t6iQCsr7wDYAAdrxYjy0cGcPqcerFo504X3qVZFxPKilTZNzNWEaVtD41bMhYMOhy3A9zNdMlQIAfkaa6M=
X-Received: by 2002:a50:c315:: with SMTP id a21mr24734139edb.50.1607434706581;
 Tue, 08 Dec 2020 05:38:26 -0800 (PST)
MIME-Version: 1.0
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
 <852166252.2305208.1607096860375.JavaMail.zimbra@desy.de> <CAN-5tyFJeLRyDUdtGkheGkmDE=i-FJprLFiav_mEPA35QeKLQA@mail.gmail.com>
 <1368097703.2347355.1607122227971.JavaMail.zimbra@desy.de>
 <1275679128.2737941.1607354764999.JavaMail.zimbra@desy.de>
 <1013351928.2746343.1607356477964.JavaMail.zimbra@desy.de> <1111815800.2958679.1607431154107.JavaMail.zimbra@desy.de>
In-Reply-To: <1111815800.2958679.1607431154107.JavaMail.zimbra@desy.de>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 8 Dec 2020 08:38:10 -0500
Message-ID: <CAFX2Jfk+Ep7zT4Rie5izF=TMuDz8uu7DOdTPszorHujigbtvfA@mail.gmail.com>
Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Tigran,

On Tue, Dec 8, 2020 at 7:39 AM Mkrtchyan, Tigran
<tigran.mkrtchyan@desy.de> wrote:
>
>
>
> Hi Anna et al.,
>
> I run some more test and found two issues:
>
> 1. our server returns on getdeviceinfo notification bitmap of size 2.
>    Though, only the first element has non zero values, some how this
>    makes client unhappy, probably due to definition on decode_getdeviceinfo_maxsz
>    that expects bitmap length to be 1.
>
> 2. The client uses READ_PLUS to DS despite the fact that flex file
>    layout stated that DS supports nfs v4.1
>
> Network File System, Ops(3): SEQUENCE, PUTFH, READ_PLUS
>     [Program Version: 4]
>     [V4 Procedure: COMPOUND (1)]
>     Tag: <EMPTY>
>     minorversion: 1
>     Operations (count: 3): SEQUENCE, PUTFH, READ_PLUS
>         Opcode: SEQUENCE (53)
>         Opcode: PUTFH (22)
>         Opcode: READ_PLUS (68)
>             StateID
>             offset: 0
>             count: 10016
>     [Main Opcode: READ_PLUS (68)]

Thanks for the update! You're right, READ_PLUS to the DS should not be
happening. I'll look into why it is.

Anna

>
>
> I should re-run some tests with Trond's tree as I was checking the
> DS errors in during the test I run last weeks.
>
> Regards,
>    Tigran.
>
> ----- Original Message -----
> > From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> > To: "Anna Schumaker" <Anna.Schumaker@netapp.com>
> > Cc: "schumaker anna" <schumaker.anna@gmail.com>, "linux-nfs" <linux-nfs@vger.kernel.org>, "Olga Kornievskaia"
> > <aglo@umich.edu>
> > Sent: Monday, 7 December, 2020 16:54:37
> > Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
>
> > Sorry, completely confused. It the same commit as before
> > c567552612ece787b178e3b147b5854ad422a836
> >
> > Tigran.
> >
> >
> > ----- Original Message -----
> >> From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> >> To: "Anna Schumaker" <Anna.Schumaker@netapp.com>
> >> Cc: "schumaker anna" <schumaker.anna@gmail.com>, "linux-nfs"
> >> <linux-nfs@vger.kernel.org>, "Olga Kornievskaia"
> >> <aglo@umich.edu>
> >> Sent: Monday, 7 December, 2020 16:26:05
> >> Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
> >
> >> Hi Anna
> >>
> >> I re-run bisect on your tree with tag nfs-for-5.10-1 as bad and 5.9.0 as good.
> >>
> >> The bisect point to commit a14a63594cc2e5bdcbb1543d29df945da71e380f, which makes
> >> more sense.
> >>
> >> [centos@os-46-nfs-devel linux-nfs]$ git bisect good
> >> c567552612ece787b178e3b147b5854ad422a836 is the first bad commit
> >> commit c567552612ece787b178e3b147b5854ad422a836
> >> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >> Date:   Wed May 28 13:41:22 2014 -0400
> >>
> >>    NFS: Add READ_PLUS data segment support
> >>
> >>    This patch adds client support for decoding a single NFS4_CONTENT_DATA
> >>    segment returned by the server. This is the simplest implementation
> >>    possible, since it does not account for any hole segments in the reply.
> >>
> >>    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >>
> >> fs/nfs/nfs42xdr.c         | 141 ++++++++++++++++++++++++++++++++++++++++++++++
> >> fs/nfs/nfs4client.c       |   2 +
> >> fs/nfs/nfs4proc.c         |  43 +++++++++++++-
> >> fs/nfs/nfs4xdr.c          |   1 +
> >> include/linux/nfs4.h      |   2 +-
> >> include/linux/nfs_fs_sb.h |   1 +
> >> include/linux/nfs_xdr.h   |   2 +-
> >> 7 files changed, 187 insertions(+), 5 deletions(-)
> >>
> >>
> >> Best regards,
> >>   Tigran
> >>
> >> ----- Original Message -----
> >>> From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> >>> To: "Olga Kornievskaia" <aglo@umich.edu>
> >>> Cc: "schumaker anna" <schumaker.anna@gmail.com>, "linux-nfs"
> >>> <linux-nfs@vger.kernel.org>, "Anna Schumaker"
> >>> <Anna.Schumaker@netapp.com>
> >>> Sent: Friday, 4 December, 2020 23:50:27
> >>> Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
> >>
> >>> I agree with Olga, especially that disabling doesn't fixes my issue.
> >>> Unfortunately I have no idea how kernel's vm works, but I am
> >>> ready to test as many times as needed.
> >>>
> >>> Thanks,
> >>>   Tigran.
> >>>
> >>> ----- Original Message -----
> >>>> From: "Olga Kornievskaia" <aglo@umich.edu>
> >>>> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> >>>> Cc: "schumaker anna" <schumaker.anna@gmail.com>, "linux-nfs"
> >>>> <linux-nfs@vger.kernel.org>, "Anna Schumaker"
> >>>> <Anna.Schumaker@netapp.com>
> >>>> Sent: Friday, 4 December, 2020 21:00:32
> >>>> Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
> >>>
> >>>> I object to putting the disable patch in, I think we need to fix the problem.
> >>>>
> >>>> The current problem is generic/263 is failing because the end of the
> >>>> buffer is corrupted since we lost the bytes when hole was expanded. I
> >>>> don't know what the solution is: (1) hole expanding handling needs to
> >>>> be fixed to not lose data or (2) we shouldnt be reporting that we read
> >>>> the bytes we lost.
> >>>>
> >>>> On Fri, Dec 4, 2020 at 10:49 AM Mkrtchyan, Tigran
> >>>> <tigran.mkrtchyan@desy.de> wrote:
> >>>>>
> >>>>> Hi Anna,
> >>>>>
> >>>>> I see problems with gedeviceinfo and bisected it to
> >>>>> c567552612ece787b178e3b147b5854ad422a836.
> >>>>> The commit itself doesn't look that can break it, but might
> >>>>> be can help you find the problem.
> >>>>>
> >>>>> What I see, that after xdr_read_pages call the xdr stream points
> >>>>> to a some random point (or wrong page)
> >>>>>
> >>>>> Regards,
> >>>>>    Tigran.
> >>>>>
> >>>>>
> >>>>> ----- Original Message -----
> >>>>> > From: "schumaker anna" <schumaker.anna@gmail.com>
> >>>>> > To: "linux-nfs" <linux-nfs@vger.kernel.org>
> >>>>> > Cc: "Anna Schumaker" <Anna.Schumaker@Netapp.com>
> >>>>> > Sent: Thursday, 3 December, 2020 21:18:38
> >>>>> > Subject: [PATCH 0/3] NFS: Disable READ_PLUS by default
> >>>>>
> >>>>> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >>>>> >
> >>>>> > I've been scratching my head about what's going on with xfstests generic/091
> >>>>> > and generic/263, but I'm not sure what else to look at at this point.
> >>>>> > This patchset disables READ_PLUS by default by marking it as a
> >>>>> > developer-only kconfig option.
> >>>>> >
> >>>>> > I also included a couple of patches fixing some other issues that were
> >>>>> > noticed while inspecting the code. These patches don't help the tests
> >>>>> > pass, but they do fail later on after applying so it does feel like
> >>>>> > progress.
> >>>>> >
> >>>>> > I'm hopeful the remaning issues can be worked out in the future.
> >>>>> >
> >>>>> > Thanks,
> >>>>> > Anna
> >>>>> >
> >>>>> >
> >>>>> > Anna Schumaker (3):
> >>>>> >  NFS: Disable READ_PLUS by default
> >>>>> >  NFS: Allocate a scratch page for READ_PLUS
> >>>>> >  SUNRPC: Keep buf->len in sync with xdr->nwords when expanding holes
> >>>>> >
> >>>>> > fs/nfs/Kconfig          |  9 +++++++++
> >>>>> > fs/nfs/nfs42xdr.c       |  2 ++
> >>>>> > fs/nfs/nfs4proc.c       |  2 +-
> >>>>> > fs/nfs/read.c           | 13 +++++++++++--
> >>>>> > include/linux/nfs_xdr.h |  1 +
> >>>>> > net/sunrpc/xdr.c        |  3 ++-
> >>>>> > 6 files changed, 26 insertions(+), 4 deletions(-)
> >>>>> >
> >>>>> > --
> > > > > > > 2.29.2
