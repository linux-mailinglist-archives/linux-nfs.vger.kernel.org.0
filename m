Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2497E93DB
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 02:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjKMBBq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Nov 2023 20:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjKMBBp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Nov 2023 20:01:45 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2391519A3
        for <linux-nfs@vger.kernel.org>; Sun, 12 Nov 2023 17:01:42 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507975d34e8so5592697e87.1
        for <linux-nfs@vger.kernel.org>; Sun, 12 Nov 2023 17:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699837300; x=1700442100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQa521AbyPQZjCwt7xe2eXOI9aM+ZU2+cs0JIT/Viac=;
        b=FKB1Yi0q/Wh6uUfcSSRauD40TyV2a7yyxqtuzrGkj2K1pXTyQKkKvCD+28QLpHqYa/
         maYsui1a7A7ZAe30OPAG3w2PfhLNMr6meDzsilfBSzdbW/OhZehnWxrdosfBCUXLcalP
         A0xQAy4f5KaQEo/Z5lnz1nBdaRwW0c4RZM8RnyM1OlusjhsrusIkTMlghffanvZb8XGA
         rFj+y/F1yDC0fOElOfW425ov+kF3w2mDA2fut1loklK+iNzCIba810SQPwn69fszayIq
         JnLcmcjemRb6rI9IzqHdmDHlWYes4z/hmMqK5OseWU4Hc/eISxZj2QCj+8vfAJaXfXrf
         ZQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699837300; x=1700442100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQa521AbyPQZjCwt7xe2eXOI9aM+ZU2+cs0JIT/Viac=;
        b=U8Hi+ORdZIzwDQmjoHcsaaRjXKaNC2z3WmmQykhDjUO6ej+satmfiIxNMq/MIKDY2K
         Cb/Wxg+wrkOWHNDS812nz+3c3dKtre7IglXHbeXL1KSkPbRz++tCYljiGtDj5DC9Nm4c
         jcBLPl+EJg2RrywmbhRlWBZKB0JHDNzc+FkqS1AQfy2D+/KzVX975UDuDm/s6ML7MO4D
         ji8aPz+sDX4kjhZkr/GSKyfYPLomMxMFz9HuAzpoUz3FdylErhntRghKLOW1wrg7oG8R
         i/UsgMmwnVRg5W4jGvRn54LQh0cPpARq2WUOWd0DBt63dC7JWeezfkq19ApYIF726zdX
         XysA==
X-Gm-Message-State: AOJu0YwA753ZZG0cEOppju3mjcJl4i4zcuxfLUHV053JILTEP43wFdx1
        iKcSVJbxAoYJ4hKRSf4yYOvZbnzKBJOQh17odAeqf6wN
X-Google-Smtp-Source: AGHT+IHvdaIOwlepfXNbQNWgs9WTCgaXQFjbKi1eDLxUfXr6h0lzzk8e0lBCinxGweqGa1hV8D+6/CkdVrUrKv1usKY=
X-Received: by 2002:a19:ac03:0:b0:508:1a25:a190 with SMTP id
 g3-20020a19ac03000000b005081a25a190mr3290421lfc.23.1699837299667; Sun, 12 Nov
 2023 17:01:39 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
 <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com> <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
 <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com> <CANH4o6O=ihW7ENc-BTBXR4d4JL0QJjZa5YdYaKAdoHdq9vwGcA@mail.gmail.com>
 <5DA015E1-50C6-4F56-B4E7-62A4BE90DBA4@oracle.com>
In-Reply-To: <5DA015E1-50C6-4F56-B4E7-62A4BE90DBA4@oracle.com>
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Mon, 13 Nov 2023 02:01:03 +0100
Message-ID: <CALXu0UcLV-KZ4GNY8UgWCwiUOO_HsH=KLWOKuWJ2uEDP+a9sqw@mail.gmail.com>
Subject: Change "hostname" to "hostport" in text-based mountd downcall Re: BUG
 in exports(5), no example for refer= Re: Examples for refer= in /etc/exports?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Martin Wege <martin.l.wege@gmail.com>,
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

On Fri, 10 Nov 2023 at 20:17, Chuck Lever III <chuck.lever@oracle.com> wrot=
e:
>
>
>
> > On Nov 10, 2023, at 3:30 AM, Martin Wege <martin.l.wege@gmail.com> wrot=
e:
> >
> > On Fri, Nov 10, 2023 at 3:20=E2=80=AFAM Chuck Lever III <chuck.lever@or=
acle.com> wrote:
> >>
> >>> On Nov 9, 2023, at 7:47 PM, Cedric Blancher <cedric.blancher@gmail.co=
m> wrote:
> >>>
> >>> On Fri, 10 Nov 2023 at 01:37, Chuck Lever III <chuck.lever@oracle.com=
> wrote:
> >>>>
> >>>>> On Nov 9, 2023, at 7:05 PM, Cedric Blancher <cedric.blancher@gmail.=
com> wrote:
> >>>>>
> >>>>> On Thu, 2 Nov 2023 at 10:51, Cedric Blancher <cedric.blancher@gmail=
.com> wrote:
> >>>>>>
> >>>>>> Good morning!
> >>>>>>
> >>>>>> Does anyone have examples of how to use the refer=3D option in /et=
c/exports?
> >>>>>
> >>>>> Short answer:
> >>>>> To redirect an NFS mount from local machine /ref/baguette to
> >>>>> /export/home/baguette on host 134.49.22.111 add this to Linux
> >>>>> /etc/exports:
> >>>>>
> >>>>> /ref *(no_root_squash,refer=3D/export/home@134.49.22.111)
> >>>>>
> >>>>> This is basically an exports(5) manpage bug, which does not provide
> >>>>> ANY examples.
> >>>>
> >>>> That's because setting up a referral this way is deprecated.
> >>>
> >>> Why did you do that?
> >>
> >> The nfsref command on Linux matches the same command on Solaris.
> >>
> >> nfsref was added years ago to manage junctions, as part of FedFS.
> >> The "refer=3D" export option can't do that...
> >
> > Where in the kernel is the code for the refer=3D option? I'd like to ge=
t
> > some of my students to contribute support for custom NFS ports.
>
> IIRC supporting ports is one thing we can't do right now because
> the mountd downcall interface is text-based, and its parser can
> barely handle "refer=3D", let alone specifying a port.

I had a chat this weekend with Roland Mainz (who works on the NFSv4
driver for Windows these days):
...
That is the old mistake to think that "hostname" and "port" are
separate entities. We had this kind of debate at SUN/MPK17 several
times. Host and TCP port are the "location of the server", and they
are inseparable.
...
The RFCs even help out with that one, for example RFC1738 (URL RFC)
defines a "hostport" in Page 18.
And that's what I actually did for ms-nfs41-client: NIH&Institute
Pasteur needed custom TCP server ports, and I implemented this by
changing the communication of nfs41_driver.sys (kernel) to userland
NFSv4 client daemon (nfsd_debug.exe) from "hostname" to "hostport",
and added the port number in the UNC, so Windows always uses (and
remembers!) the port number together with the hostname.
Or easier: I changed "hostname" to "hostport" to embed the port number
in the up-/downcalls for mount requests - and that is what the Linux
people can use too.
...

> Our plan is to replace the mountd downcall with a netlink protocol
> that Lorenzo is working on, and then it would be very straightforward
> to add a port to each target location. But getting to a mature
> netlink implementation will take a while.

Yeah, instead of waiting for NetLink you could implement Roland's
suggestion, and change "hostname" to "hostport" in your test-based
mount protocol, and technically everywhere else, like /proc/mounts and
the /sbin/mount output.
So instead of:
mount -t nfs -o port=3D4444 10.10.0.10:/backups /var/backups
you could use
mount -t nfs 10.10.0.10@4444:/backups /var/backups

The same applies to refer=3D - just change from "hostname" to
"hostport", and the text-based mountd downcall can stay the same (e.g.
so "foobarhost" changes to "foobarhost@444" in the mountd download.)

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
