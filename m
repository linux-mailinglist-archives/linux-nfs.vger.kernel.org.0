Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D727F080F
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 18:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjKSRRy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 12:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjKSRRx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 12:17:53 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A9BD5
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 09:17:50 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso5145726a12.1
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 09:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700414268; x=1701019068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FR/NuLgw0LjMLCkOwG88T/KrqveNwXOYtA5h4jE7sp0=;
        b=nUX5pQTj7rWTn32TC4CyibwJ9S4mhZuGlkdT8ZLMY7XXeJvQTWnl/qI2Z9koHFGijB
         yirgSt9/K03hEIkdINfa8k4uj0TT41LB/Mdrb9mZWSNZ/CbMI7xQf4Lu9AoY1RPdva0X
         nPznIaambc2s5Aq/7RFcVyOgIgYKCb5MAbe362RdePI5id7kZZjS7liYDXA8RqfFbkhp
         16WlO2nHxq6LngZiHQQP6hcYCLq/j6dphd7OHhRVI9KV6kQgkApBdd7VTa1+UH+zWI4u
         +djxz7/yINHqIBPM3nsf/pvKgz1ZUh1ovEpLJwN9B1dnf2wC0E3rpe3AkWQms7hWQQQJ
         mUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700414268; x=1701019068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FR/NuLgw0LjMLCkOwG88T/KrqveNwXOYtA5h4jE7sp0=;
        b=tUgGPaA3Dj4dQg1suzlkhqnSqtEFF5PdwGj/0B7U7i2ZqPdQxIO7OAwj+sKuVoA2oQ
         85rfDGELLKSqiM5mTk9RV+/5cIbGRYM5UbyGteZk3j2OJMlGWV95gBW7sAaEo7xCFv1k
         +Gm3t5wbRoJyeM9X80Ie2++MtHkPn7A9fLbuQtyTFtinXklsTrRKjei+2mq4euJ0o2ko
         2dC6hYY6G9cR73UhJeI85d11hBObfAr03tY9S6pAHK5C9AOJJTsORV/Nypd7UMTjXLP7
         gGukU7wvHMuxida7iXCRhaibHTyLAacwKhelFmEJs7BAgGs4hSkZLKV4H0/gbSFnUDUv
         Y18w==
X-Gm-Message-State: AOJu0YzrBulb43dminji/zCSl/rASyAtV3jPqCeYx0PBx7/3M6gyqQd4
        CfMguCCWfrimvtgCz0Ibw+RJUF8VdaMYZ7B4kfU=
X-Google-Smtp-Source: AGHT+IEJeBlpMMJR4PmlLX+Iuf+xJmX2BccmA6yAUSV20/KNP4mUyuOvdSibC9kZXhIxf5R2OdIoNNsfK1AGWgcbobk=
X-Received: by 2002:a05:6402:2056:b0:543:5c2f:e0e6 with SMTP id
 bc22-20020a056402205600b005435c2fe0e6mr3149282edb.17.1700414268537; Sun, 19
 Nov 2023 09:17:48 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
 <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com> <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
 <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com> <CANH4o6O=ihW7ENc-BTBXR4d4JL0QJjZa5YdYaKAdoHdq9vwGcA@mail.gmail.com>
 <5DA015E1-50C6-4F56-B4E7-62A4BE90DBA4@oracle.com> <CALXu0UcLV-KZ4GNY8UgWCwiUOO_HsH=KLWOKuWJ2uEDP+a9sqw@mail.gmail.com>
 <d864c378-3b4d-41f2-bb21-d3403db55cbc@redhat.com>
In-Reply-To: <d864c378-3b4d-41f2-bb21-d3403db55cbc@redhat.com>
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Sun, 19 Nov 2023 18:17:11 +0100
Message-ID: <CALXu0UcUUmVSih6LfCTHWKZA_Czfv5f=MM_cQE_HsGXtuq2y1Q@mail.gmail.com>
Subject: Re: Change "hostname" to "hostport" in text-based mountd downcall Re:
 BUG in exports(5), no example for refer= Re: Examples for refer= in /etc/exports?
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Martin Wege <martin.l.wege@gmail.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Roland Mainz <roland.mainz@nrubsig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 13 Nov 2023 at 16:48, Steve Dickson <steved@redhat.com> wrote:
>
> Hello Ced,
>
> On 11/12/23 8:01 PM, Cedric Blancher wrote:
> > On Fri, 10 Nov 2023 at 20:17, Chuck Lever III <chuck.lever@oracle.com> =
wrote:
> >>
> >>
> >>
> >>> On Nov 10, 2023, at 3:30 AM, Martin Wege <martin.l.wege@gmail.com> wr=
ote:
> >>>
> >>> On Fri, Nov 10, 2023 at 3:20=E2=80=AFAM Chuck Lever III <chuck.lever@=
oracle.com> wrote:
> >>>>
> >>>>> On Nov 9, 2023, at 7:47 PM, Cedric Blancher <cedric.blancher@gmail.=
com> wrote:
> >>>>>
> >>>>> On Fri, 10 Nov 2023 at 01:37, Chuck Lever III <chuck.lever@oracle.c=
om> wrote:
> >>>>>>
> >>>>>>> On Nov 9, 2023, at 7:05 PM, Cedric Blancher <cedric.blancher@gmai=
l.com> wrote:
> >>>>>>>
> >>>>>>> On Thu, 2 Nov 2023 at 10:51, Cedric Blancher <cedric.blancher@gma=
il.com> wrote:
> >>>>>>>>
> >>>>>>>> Good morning!
> >>>>>>>>
> >>>>>>>> Does anyone have examples of how to use the refer=3D option in /=
etc/exports?
> >>>>>>>
> >>>>>>> Short answer:
> >>>>>>> To redirect an NFS mount from local machine /ref/baguette to
> >>>>>>> /export/home/baguette on host 134.49.22.111 add this to Linux
> >>>>>>> /etc/exports:
> >>>>>>>
> >>>>>>> /ref *(no_root_squash,refer=3D/export/home@134.49.22.111)
> >>>>>>>
> >>>>>>> This is basically an exports(5) manpage bug, which does not provi=
de
> >>>>>>> ANY examples.
> >>>>>>
> >>>>>> That's because setting up a referral this way is deprecated.
> >>>>>
> >>>>> Why did you do that?
> >>>>
> >>>> The nfsref command on Linux matches the same command on Solaris.
> >>>>
> >>>> nfsref was added years ago to manage junctions, as part of FedFS.
> >>>> The "refer=3D" export option can't do that...
> >>>
> >>> Where in the kernel is the code for the refer=3D option? I'd like to =
get
> >>> some of my students to contribute support for custom NFS ports.
> >>
> >> IIRC supporting ports is one thing we can't do right now because
> >> the mountd downcall interface is text-based, and its parser can
> >> barely handle "refer=3D", let alone specifying a port.
> >
> > I had a chat this weekend with Roland Mainz (who works on the NFSv4
> > driver for Windows these days):
> > ...
> > That is the old mistake to think that "hostname" and "port" are
> > separate entities. We had this kind of debate at SUN/MPK17 several
> > times. Host and TCP port are the "location of the server", and they
> > are inseparable.
> > ...
> > The RFCs even help out with that one, for example RFC1738 (URL RFC)
> > defines a "hostport" in Page 18.
> > And that's what I actually did for ms-nfs41-client: NIH&Institute
> > Pasteur needed custom TCP server ports, and I implemented this by
> > changing the communication of nfs41_driver.sys (kernel) to userland
> > NFSv4 client daemon (nfsd_debug.exe) from "hostname" to "hostport",
> > and added the port number in the UNC, so Windows always uses (and
> > remembers!) the port number together with the hostname.
> > Or easier: I changed "hostname" to "hostport" to embed the port number
> > in the up-/downcalls for mount requests - and that is what the Linux
> > people can use too.
> > ...
> >
> >> Our plan is to replace the mountd downcall with a netlink protocol
> >> that Lorenzo is working on, and then it would be very straightforward
> >> to add a port to each target location. But getting to a mature
> >> netlink implementation will take a while.
> >
> > Yeah, instead of waiting for NetLink you could implement Roland's
> > suggestion, and change "hostname" to "hostport" in your test-based
> > mount protocol, and technically everywhere else, like /proc/mounts and
> > the /sbin/mount output.
> > So instead of:
> > mount -t nfs -o port=3D4444 10.10.0.10:/backups /var/backups
> > you could use
> > mount -t nfs 10.10.0.10@4444:/backups /var/backups
> >
> > The same applies to refer=3D - just change from "hostname" to
> > "hostport", and the text-based mountd downcall can stay the same (e.g.
> > so "foobarhost" changes to "foobarhost@444" in the mountd download.)
> My suggestion is you and Roland attend the next Bakeathon, this
> spring, which will have remote access for testing and
> talk about this on one of @2pm talks.

Where is the bakeathon hosted? San Francisco?

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
