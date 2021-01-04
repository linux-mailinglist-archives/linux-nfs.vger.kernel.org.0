Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BF72E99DF
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 17:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbhADQEL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 11:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbhADQEJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 11:04:09 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B38AC061574
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jan 2021 08:03:28 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id a12so65525579lfl.6
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jan 2021 08:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N/60JK33t4oUrdAxWdxnhjyWQgg49zVpewb8SKhK0TQ=;
        b=tSv/cNHwBpjBGxhD9rfEIsRaMv0RD2fvsgNfwBtgEhdoLQUKFdJoUjdQMGdERWCjbO
         Xl7RjSA3FjioomOxRehSg40ss6mKoUYlxogtX63yQtVDoZjOYq/lOYgqjvzE3FkrAoCj
         waPj1GW9Z5DRu/aLKCCnDp0sPfAZ6FU5M34/NPgp0Vtp2S1Nmxkb2HqxbBK2Cy6muQil
         GWuPHMPy6GVSIb9JItJYilkh4piVpbYp2CXKC+4hn0lOWBm8AKlaim642CT0RbDMke6H
         9rDqsn2Q5f8Z5THtBobgh8evAHwk9nwI5TuOTTH5MrvZltpOlwh3zWAsO16R06KcaHyD
         Z2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N/60JK33t4oUrdAxWdxnhjyWQgg49zVpewb8SKhK0TQ=;
        b=Q02zgTrbSDHQSeBdc61CQQ7OFfGyiftf4Ed+AZnrcFXk2Y94oOWzzk+V5T1DXVJtZQ
         My9A1EP4kc6h/1f6OGyDBiq37b+5W4fB4wrHBpQERbRiQRXl5Vz0YyHQk1aUxa03Rum0
         pgwwzTMwu36VOGjHLBlPs8l7dFZoaLjmI19EUyruLUwmObhVPozRrE173Zffp1CsyF4v
         j414/QEO61SG7tPB9EGAA21WFDs9uI6EiZMt2zmT4SaC8OJ3rAN/sRBWf9xdTONQZunT
         pL23EI3hfuVfye31l7bxEQC6/gy/s0w9R6OTbIl7BN6fGMpqsH941yap/2e9gdIT/WEN
         YrIA==
X-Gm-Message-State: AOAM5324b/kWGPx4wec8Zf962jMqt9cYjXA8LRfMSwDxWgjY15rQeiuX
        8D0BdvBqLGfRpKk+uLlDMIJouktqrQHfX/j8v5c=
X-Google-Smtp-Source: ABdhPJwQEIQ3up6OfaEQ/itrn+ZIrG+hGl0h6D4hKKkYqPNUzJ3PXM33I2sS1pJuhS9+Ia7laE+Lwq1fAYhwfseAmxo=
X-Received: by 2002:a05:651c:30f:: with SMTP id a15mr34197480ljp.503.1609776206870;
 Mon, 04 Jan 2021 08:03:26 -0800 (PST)
MIME-Version: 1.0
References: <CAL5u83HS=nurJ=r0tJU8ZqAXXkvu9-vWZpbVWoKALNh22WdKnw@mail.gmail.com>
 <87F51982-465A-46D4-BFB9-4B5E5A7EB82C@oracle.com> <CAL5u83FRJQ_ys32S1KWjx72kamNw_3a2eFEAwH=MNMhruU9X=g@mail.gmail.com>
 <6F313888-0355-4286-8692-E4685BCB2536@oracle.com> <CAL5u83Fxd2rGuYuaghcC4irUtscmXr5-p36Qqf4+FwtctZJFaQ@mail.gmail.com>
 <07383012-D499-498E-A194-716ABE1DE4C2@oracle.com>
In-Reply-To: <07383012-D499-498E-A194-716ABE1DE4C2@oracle.com>
From:   Hackintosh Five <hackintoshfive@gmail.com>
Date:   Mon, 4 Jan 2021 16:03:14 +0000
Message-ID: <CAL5u83FRV_-sae4cXLN3VqFe_=3wXm5g911LFjzohCp+c+55aQ@mail.gmail.com>
Subject: Re: Boot time improvement with systemd and nfs-utils
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I see. Does rpc-statd-notify HAVE to start before nfs-client? If not,
perhaps a one-off timer unit with no delay could be made so that the
startup of rpc-statd-notify doesn't block the boot process, while
still running after network-online?

On Mon, Jan 4, 2021 at 1:26 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> The problem is not in sm-notify itself, it's in the C library functions. =
The system's DNS resolver configuration is set during network startup. When=
 a process first attempts a DNS query, it retrieves the system DNS configur=
ation as it is at that moment, and keeps that configuration until the proce=
ss exits. If sm-notify starts before the system's DNS resolver is configure=
d, then it simply doesn't work because it can't perform DNS queries correct=
ly.
>
>
> On Jan 4, 2021, at 8:13 AM, Hackintosh Five <hackintoshfive@gmail.com> wr=
ote:
>
> Yep, sm-notify is Wanted by nfs-utils.target, and hence clients. But I ca=
n't see anywhere in the source of lm-notify where being offline would make =
a difference (beyond triggering a retry). If such a function does exist and=
 I missed it, perhaps it could be moved to the end of the program (so the h=
ostname is calculated only when the network is available, or whatever)
>
> On Mon, 4 Jan 2021, 12:54 Chuck Lever, <chuck.lever@oracle.com> wrote:
>>
>> Hi-
>>
>> > On Jan 4, 2021, at 7:51 AM, Hackintosh Five <hackintoshfive@gmail.com>=
 wrote:
>> >
>> > Hi, thanks for the fast reply
>> >
>> > I have never even used nfs and I'm not a systemd expert, so I'm not at
>> > all sure this interpretation is correct, but here goes. I only removed
>> > the dependency from rpc.statd.notify, not rpc.statd.
>>
>> Same problem exists for sm-notify.
>>
>>
>> > I didn't remove
>> > the `After=3Dnfs-server` line, and for nfs-server to be up,
>> > network-online must be up first (there's an After requirement in the
>> > nfs-server unit). So if the nfs-server is enabled, the
>> > rpc-statd-notify will order itself after the server is up, which
>> > depends on the network.
>>
>> IIRC sm-notify runs on clients too. That's why the dependency is
>> on the network and not on nfs-server.
>>
>>
>> > That means that, if there is a server, the
>> > server must be up before it sends notifications, so it will have the
>> > right hostname. This only improves boot speed on nfs clients, where
>> > nfs-client.target pulls in rpc-statd-notify.service.
>> >
>> >
>> > On Mon, Jan 4, 2021 at 12:27 PM Chuck Lever <chuck.lever@oracle.com> w=
rote:
>> >>
>> >> Hello, thanks for your report.
>> >>
>> >> The dependency you are removing addresses a bug -- if the network is =
not configured when rpc.statd is started, the rpc.statd process continues t=
o use incorrect local address information even after the network is up.
>> >>
>> >>
>> >>> On Jan 4, 2021, at 6:32 AM, Hackintosh Five <hackintoshfive@gmail.co=
m> wrote:
>> >>>
>> >>> rpc-statd-notify is causing a 10 second hang on my system during boo=
t
>> >>> due to an unwanted dependency on network-online.target. This
>> >>> dependency isn't needed anyway, because rpc-statd-notify (sm-notify)
>> >>> will wait for the network to come online if it isn't already (up to =
15
>> >>> minutes, so no risk of timeout that would be avoided by systemd)
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> From c90bd7e701c2558606907f08bf27ae9be3f8e0bf Mon Sep 17 00:00:00 20=
01
>> >>> From: Hackintosh 5 <git@hack5.dev>
>> >>> Date: Sat, 2 Jan 2021 14:28:30 +0000
>> >>> Subject: [PATCH] systemd: network-online.target is not needed for
>> >>> rpc-statd-notify.service
>> >>>
>> >>> Commit 09e5c6c2 changed the After line for rpc-statd-notify to chang=
e
>> >>> network.target to network-online.target, which is incorrect, because
>> >>> sm-notify has a default timeout of 15 minutes, which is longer than
>> >>> the timeout for network-online.target. In other words, the dependenc=
y
>> >>> on network-online.target is useless and delays system boot by ~10
>> >>> seconds.
>> >>> ---
>> >>> systemd/rpc-statd-notify.service | 4 ++--
>> >>> 1 file changed, 2 insertions(+), 2 deletions(-)
>> >>>
>> >>> diff --git a/systemd/rpc-statd-notify.service
>> >>> b/systemd/rpc-statd-notify.service
>> >>> index aad4c0d2..8a40e862 100644
>> >>> --- a/systemd/rpc-statd-notify.service
>> >>> +++ b/systemd/rpc-statd-notify.service
>> >>> @@ -1,8 +1,8 @@
>> >>> [Unit]
>> >>> Description=3DNotify NFS peers of a restart
>> >>> DefaultDependencies=3Dno
>> >>> -Wants=3Dnetwork-online.target
>> >>> -After=3Dlocal-fs.target network-online.target nss-lookup.target
>> >>> +Wants=3Dnetwork.target
>> >>> +After=3Dlocal-fs.target network.target nss-lookup.target
>> >>>
>> >>> # if we run an nfs server, it needs to be running before we
>> >>> # tell clients that it has restarted.
>> >>> --
>> >>> 2.29.2
>> >>
>> >> --
>> >> Chuck Lever
>> >>
>> >>
>> >>
>>
>> --
>> Chuck Lever
>>
>>
>>
>
> --
> Chuck Lever
>
>
>
