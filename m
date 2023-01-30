Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E19681AE6
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Jan 2023 20:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjA3Tzr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Jan 2023 14:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjA3Tzq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Jan 2023 14:55:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2524ED3
        for <linux-nfs@vger.kernel.org>; Mon, 30 Jan 2023 11:55:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF72FB815E0
        for <linux-nfs@vger.kernel.org>; Mon, 30 Jan 2023 19:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DA0C433D2;
        Mon, 30 Jan 2023 19:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675108541;
        bh=AWteIIy2g/5a0dMekre1BTJyZBpg52Vyakr+clcqThk=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=EmvJ4/GPOM/Dqhyeko9+YUJTOIp7vMYEaN/hrlpssembKm+oGD4ckV9aPCoBK+JQr
         t9KVYAY7dWtZEfZR+Vom+AXgjC7sD6qWk5VqSGHK+5p6AWc7WhIMAdSLKa0OvEOKnN
         HNB9vwXDqgIKZhI4H9xWQ3SBdSM4p6k2VfXYsescYXvXlxfkUqJIKz75cX+mW8qHg3
         bvZdrrWK6t9jSGSILqh7qpJ8hEWKs8fIH2OTnDvXyjWIoaMkJ2NzuO3jS7UMEkSoCp
         FxCe1NTfxgSCT30K/je9FBlImG745lCyTLBG+pP/x3Jn39qvc+p/q5jH85s+mIcl5F
         Ki2OlgO0I7jjQ==
Message-ID: <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
Subject: Re: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
From:   Jeff Layton <jlayton@kernel.org>
To:     Andrew Klaassen <andrew.klaassen@boatrocker.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Mon, 30 Jan 2023 14:55:39 -0500
In-Reply-To: <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
         <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-01-30 at 19:33 +0000, Andrew Klaassen wrote:
> > From: Jeff Layton <jlayton@kernel.org>
> > Sent: Friday, January 27, 2023 8:33 AM
> >=20
> > On Thu, 2023-01-26 at 22:08 +0000, Andrew Klaassen wrote:
> > > > From: Andrew Klaassen <andrew.klaassen@boatrocker.com>
> > > > Sent: Thursday, January 26, 2023 10:32 AM
> > > >=20
> > > > > From: Andrew Klaassen <andrew.klaassen@boatrocker.com>
> > > > > Sent: Monday, January 23, 2023 11:31 AM
> > > > >=20
> > > > > Hello,
> > > > >=20
> > > > > There's a specific NFSv4 mount on a specific machine which
> > > > > we'd
> > > > > like to timeout and return an error after a few seconds if the
> > > > > server goes away.
> > > > >=20
> > > > > I've confirmed the following on two different kernels, 4.18.0-
> > > > > 348.12.2.el8_5.x86_64 and 6.1.7-200.fc37.x86_64.
> > > > >=20
> > > > > I've been able to get both autofs and the mount command to
> > > > > cooperate, so that the mount attempt fails after an arbitrary
> > > > > number of seconds.
> > > > > This mount command, for example, will fail after 6 seconds, as
> > > > > expected based on the timeo=3D20,retrans=3D2,retry=3D0 options:
> > > > >=20
> > > > > $ time sudo mount -t nfs4 -o
> > > > > rw,relatime,sync,vers=3D4.2,rsize=3D131072,wsize=3D131072,namlen=
=3D255
> > > > > ,acr
> > > > > egmi
> > > > > n
> > > > >=20
> > > > =3D0,acregmax=3D0,acdirmin=3D0,acdirmax=3D0,soft,noac,proto=3Dtcp,t=
imeo=3D20
> > > > ,ret
> > > > ra
> > > > > n s=3D2,retry=3D0,sec=3Dsys thor04:/mnt/thorfs04  /mnt/thor04
> > > > > mount.nfs4: Connection timed out
> > > > >=20
> > > > > real    0m6.084s
> > > > > user    0m0.007s
> > > > > sys     0m0.015s
> > > > >=20
> > > > > However, if the share is already mounted and the server goes
> > > > > away,
> > > > > the timeout is always 2 minutes plus the time I expect based
> > > > > on
> > > > > timeo and retrans.  In this case, 2 minutes and 6 seconds:
> > > > >=20
> > > > > $ time ls /mnt/thor04
> > > > > ls: cannot access '/mnt/thor04': Connection timed out
> > > > >=20
> > > > > real    2m6.025s
> > > > > user    0m0.003s
> > > > > sys     0m0.000s
> > > > >=20
> > > > > Watching the outgoing packets in the second case, the pattern
> > > > > is
> > > > > always the
> > > > > same:
> > > > > =C2=A0- 0.2 seconds between the first two, then doubling each tim=
e
> > > > > until the two minute mark is exceeded (so the last NFS packet,
> > > > > which is always the 11th packet, is sent around 1:45 after the
> > > > > first).
> > > > > =C2=A0- Then some generic packets that start exactly-ish on the t=
wo
> > > > > minute mark, 1 second between the first two, then doubling
> > > > > each
> > > > > time.
> > > > > (By
> > > > > this time the NFS command has given up.)
> > > > >=20
> > > > > 11:10:21.898305 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags
> > > > > [P.],
> > > > > seq 14452:14652, ack 18561, win 501, options [nop,nop,TS val
> > > > > 834889483 ecr 1589769203], length 200: NFS request xid
> > > > > 3614904256
> > > > > 196 getattr fh
> > > > > 0,2/53
> > > > > 11:10:22.105189 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags
> > > > > [P.],
> > > > > seq 14452:14652, ack 18561, win 501, options [nop,nop,TS val
> > > > > 834889690 ecr 1589769203], length 200: NFS request xid
> > > > > 3614904256
> > > > > 196 getattr fh
> > > > > 0,2/53
> > > > > 11:10:22.313290 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags
> > > > > [P.],
> > > > > seq 14452:14652, ack 18561, win 501, options [nop,nop,TS val
> > > > > 834889898 ecr 1589769203], length 200: NFS request xid
> > > > > 3614904256
> > > > > 196 getattr fh
> > > > > 0,2/53
> > > > > 11:10:22.721269 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags
> > > > > [P.],
> > > > > seq 14452:14652, ack 18561, win 501, options [nop,nop,TS val
> > > > > 834890306 ecr 1589769203], length 200: NFS request xid
> > > > > 3614904256
> > > > > 196 getattr fh
> > > > > 0,2/53
> > > > > 11:10:23.569192 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags
> > > > > [P.],
> > > > > seq 14452:14652, ack 18561, win 501, options [nop,nop,TS val
> > > > > 834891154 ecr 1589769203], length 200: NFS request xid
> > > > > 3614904256
> > > > > 196 getattr fh
> > > > > 0,2/53
> > > > > 11:10:25.233212 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags
> > > > > [P.],
> > > > > seq 14452:14652, ack 18561, win 501, options [nop,nop,TS val
> > > > > 834892818 ecr 1589769203], length 200: NFS request xid
> > > > > 3614904256
> > > > > 196 getattr fh
> > > > > 0,2/53
> > > > > 11:10:28.497282 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags
> > > > > [P.],
> > > > > seq 14452:14652, ack 18561, win 501, options [nop,nop,TS val
> > > > > 834896082 ecr 1589769203], length 200: NFS request xid
> > > > > 3614904256
> > > > > 196 getattr fh
> > > > > 0,2/53
> > > > > 11:10:35.025219 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags
> > > > > [P.],
> > > > > seq 14452:14652, ack 18561, win 501, options [nop,nop,TS val
> > > > > 834902610 ecr 1589769203], length 200: NFS request xid
> > > > > 3614904256
> > > > > 196 getattr fh
> > > > > 0,2/53
> > > > > 11:10:48.337201 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags
> > > > > [P.],
> > > > > seq 14452:14652, ack 18561, win 501, options [nop,nop,TS val
> > > > > 834915922 ecr 1589769203], length 200: NFS request xid
> > > > > 3614904256
> > > > > 196 getattr fh
> > > > > 0,2/53
> > > > > 11:11:14.449303 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags
> > > > > [P.],
> > > > > seq 14452:14652, ack 18561, win 501, options [nop,nop,TS val
> > > > > 834942034 ecr 1589769203], length 200: NFS request xid
> > > > > 3614904256
> > > > > 196 getattr fh
> > > > > 0,2/53
> > > > > 11:12:08.721251 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags
> > > > > [P.],
> > > > > seq 14452:14652, ack 18561, win 501, options [nop,nop,TS val
> > > > > 834996306 ecr 1589769203], length 200: NFS request xid
> > > > > 3614904256
> > > > > 196 getattr fh
> > > > > 0,2/53
> > > > > 11:12:22.545394 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags
> > > > > [S],
> > > > > seq 1375256951, win 64240, options [mss 1460,sackOK,TS val
> > > > > 835010130 ecr 0,nop,wscale 7], length 0
> > > > > 11:12:23.570199 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags
> > > > > [S],
> > > > > seq 1375256951, win 64240, options [mss 1460,sackOK,TS val
> > > > > 835011155 ecr 0,nop,wscale 7], length 0
> > > > > 11:12:25.617284 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags
> > > > > [S],
> > > > > seq 1375256951, win 64240, options [mss 1460,sackOK,TS val
> > > > > 835013202 ecr 0,nop,wscale 7], length 0
> > > > > 11:12:29.649219 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags
> > > > > [S],
> > > > > seq 1375256951, win 64240, options [mss 1460,sackOK,TS val
> > > > > 835017234 ecr 0,nop,wscale 7], length 0
> > > > > 11:12:37.905274 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags
> > > > > [S],
> > > > > seq 1375256951, win 64240, options [mss 1460,sackOK,TS val
> > > > > 835025490 ecr 0,nop,wscale 7], length 0
> > > > > 11:12:54.289212 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags
> > > > > [S],
> > > > > seq 1375256951, win 64240, options [mss 1460,sackOK,TS val
> > > > > 835041874 ecr 0,nop,wscale 7], length 0
> > > > > 11:13:26.545304 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags
> > > > > [S],
> > > > > seq 1375256951, win 64240, options [mss 1460,sackOK,TS val
> > > > > 835074130 ecr 0,nop,wscale 7], length 0
> > > > >=20
> > > > > I tried changing tcp_retries2 as suggested in another thread
> > > > > from
> > > > > this list:
> > > > >=20
> > > > > # echo 3 > /proc/sys/net/ipv4/tcp_retries2
> > > > >=20
> > > > > ...but it made no difference on either kernel.  The 2 minute
> > > > > timeout also doesn't seem to match with what I'd calculate
> > > > > from
> > > > > the initial value of tcp_retries2, which should give a much
> > > > > higher
> > > > > timeout.
> > > > >=20
> > > > > The only clue I've been able to find is in the retry=3Dn entry
> > > > > in
> > > > > the NFS
> > > > > manpage:
> > > > >=20
> > > > > " For TCP the default is 3 minutes, but system TCP connection
> > > > > timeouts will sometimes limit the timeout of each
> > > > > retransmission
> > > > > to around
> > > > > 2
> > > > minutes."
> > > > >=20
> > > > > What I'm not able to make sense of:
> > > > > =C2=A0- The retry option says that it applies to mount operations=
,
> > > > > not
> > > > > read/write operations.  However, in this case I'm seeing the 2
> > > > > minute delay on read/write operations but *not* mount
> > > > > operations.
> > > > > =C2=A0- A couple of hours of searching didn't lead me to any kern=
el
> > > > > settings that would result in a 2 minute timeout.
> > > > >=20
> > > > > Does anyone have any clues about a) what's happening and b)
> > > > > how to
> > > > > get our desired behaviour of being able to control both mount
> > > > > and
> > > > > read/write timeouts down to a few seconds?
> > > > >=20
> > > > > Thanks.
> > > >=20
> > > > I thought that changing TCP_RTO_MAX in include/net/tcp.h from
> > > > 120 to
> > > > something smaller and recompiling the kernel would change the 2
> > > > minute timeout, but it had no effect.  I'm going to keep poking
> > > > through the kernel code to see if there's a knob I can turn to
> > > > change the 2 minute timeout, so that I can at least understand
> > > > where
> > > > it's coming from.
> > > >=20
> > > > Any hints as to where I should be looking?
> > >=20
> > > I believe I've made some progress with this today:
> > >=20
> > > =C2=A0- Calls to rpc_create() from fs/nfs/client.c are sending an
> > > rpc_timeout struct with their args.
> > > =C2=A0- rpc_create() does *not* pass the timeout on to
> > > xprt_create_transport(), which then can't pass it on to
> > > xs_setup_tcp().
> > > =C2=A0- xs_setup_tcp(), having no timeout passed to it, uses
> > > xs_tcp_default_timeout instead.
> > > =C2=A0- changing xs_tcp_default_timeout changes the "ls" timeout
> > > behaviour
> > > I described above.
> > >=20
> > > In theory all of this means that the timeout simply needs to be
> > > passed
> > > through and used instead of xs_tcp_default_timeout.  I'm going to
> > > give
> > > this a try tomorrow.
> > >=20
> >=20
> > That's a great root-cause analysis. The interlocking timeouts
> > involved with
> > NFS and its sockets can be really difficult to unwind.
> >=20
> > Is there a way to automate this testcase? That might be nice to have
> > in
> > xfstests or the nfstest suite.
> >=20
> > > Here's what I'm going to try first; I'm no C programmer, though,
> > > so
> > > any advice or corrections you might have would be appreciated.
> > >=20
> > > Thanks.
> > >=20
> > > Andrew
> > >=20
> > > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c index
> > > 0b0b9f1eed46..1350c1f489f7 100644
> > > --- a/net/sunrpc/clnt.c
> > > +++ b/net/sunrpc/clnt.c
> > > @@ -532,6 +532,7 @@ struct rpc_clnt *rpc_create(struct
> > > rpc_create_args
> > > *args)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.addrlen =3D args->addrsize,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.servername =3D args->servername,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.bc_xprt =3D args->bc_xprt,
> > > +               .timeout =3D args->timeout,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char servername[48];
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct rpc_clnt *clnt=
;
> > > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c index
> > > aaa5b2741b79..adc79d94b59e 100644
> > > --- a/net/sunrpc/xprtsock.c
> > > +++ b/net/sunrpc/xprtsock.c
> > > @@ -3003,7 +3003,7 @@ static struct rpc_xprt *xs_setup_tcp(struct
> > > xprt_create *args)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xprt->idle_timeout =
=3D XS_IDLE_DISC_TO;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xprt->ops =3D &xs_tcp=
_ops;
> > > -       xprt->timeout =3D &xs_tcp_default_timeout;
> > > +       xprt->timeout =3D args->timeout;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xprt->max_reconnect_t=
imeout =3D xprt->timeout->to_maxval;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xprt->connect_timeout=
 =3D xprt->timeout->to_initval *
> > >=20
> >=20
> > Looks like you're probably on the right track. You're missing a few
> > things:
> >=20
> > You'll need to add a "timeout" field to struct xprt_create in
> > include/linux/sunrpc/xprt.h, and there may be some other places that
> > either
> > need to set the timeout in that structure, or do something with that
> > field
> > when it's set.
> >=20
> > Once you have something that fixes your reproducer, go ahead and
> > post it
> > and we can help you work through whatever changes need to me made to
> > make it work.
> >=20
> > Nice work!
>=20
> Thanks for the tip, that was helpful.
>=20
> Currently I'm fighting with kernel recompilation.  I decided to make
> it quicker by slimming down the config, but apparently I've achieved
> something which Google claims no one else has achieved:
>=20
> Errors on kernel make modules_install:
>=20
> =C2=A0=C2=A0DEPMOD  /lib/modules/6.2.0-rc5-sunrpctimeo+
> depmod: WARNING: /lib/modules/6.2.0-rc5-
> sunrpctimeo+/kernel/fs/nfs/nfsv4.ko needs unknown symbol
> nfs4_disable_idmapping
> depmod: WARNING: /lib/modules/6.2.0-rc5-
> sunrpctimeo+/kernel/fs/nfs/nfsv4.ko needs unknown symbol
> nfs4_label_alloc
> depmod: WARNING: /lib/modules/6.2.0-rc5-
> sunrpctimeo+/kernel/fs/nfs/nfsv4.ko needs unknown symbol
> send_implementation_id
> depmod: WARNING: /lib/modules/6.2.0-rc5-
> sunrpctimeo+/kernel/fs/nfs/nfsv4.ko needs unknown symbol
> nfs_atomic_open
> depmod: WARNING: /lib/modules/6.2.0-rc5-
> sunrpctimeo+/kernel/fs/nfs/nfsv4.ko needs unknown symbol
> nfs_clear_verifier_delegated
> depmod: WARNING: /lib/modules/6.2.0-rc5-
> sunrpctimeo+/kernel/fs/nfs/nfsv4.ko needs unknown symbol
> nfs4_client_id_uniquifier
> depmod: WARNING: /lib/modules/6.2.0-rc5-
> sunrpctimeo+/kernel/fs/nfs/nfsv4.ko needs unknown symbol
> nfs4_dentry_operations
> depmod: WARNING: /lib/modules/6.2.0-rc5-
> sunrpctimeo+/kernel/fs/nfs/nfsv4.ko needs unknown symbol
> nfs_fscache_open_file
> depmod: WARNING: /lib/modules/6.2.0-rc5-
> sunrpctimeo+/kernel/fs/nfs/nfsv4.ko needs unknown symbol nfs4_fs_type
> depmod: WARNING: /lib/modules/6.2.0-rc5-
> sunrpctimeo+/kernel/fs/nfs/nfsv4.ko needs unknown symbol
> recover_lost_locks
> depmod: WARNING: /lib/modules/6.2.0-rc5-
> sunrpctimeo+/kernel/fs/nfs/nfsv4.ko needs unknown symbol
> nfs_callback_nr_threads
> depmod: WARNING: /lib/modules/6.2.0-rc5-
> sunrpctimeo+/kernel/fs/nfs/nfsv4.ko needs unknown symbol
> max_session_cb_slots
> depmod: WARNING: /lib/modules/6.2.0-rc5-
> sunrpctimeo+/kernel/fs/nfs/nfsv4.ko needs unknown symbol
> max_session_slots
> depmod: WARNING: /lib/modules/6.2.0-rc5-
> sunrpctimeo+/kernel/fs/nfs/nfsv4.ko needs unknown symbol
> nfs_idmap_cache_timeout
> depmod: WARNING: /lib/modules/6.2.0-rc5-
> sunrpctimeo+/kernel/fs/nfs/nfsv4.ko needs unknown symbol
> nfs_callback_set_tcpport
>=20
> Errors on module load:
>=20
> [   94.008271] nfsv4: Unknown symbol nfs4_disable_idmapping (err -2)
> [   94.008321] nfsv4: Unknown symbol nfs4_label_alloc (err -2)
> [   94.008434] nfsv4: Unknown symbol send_implementation_id (err -2)
> [   94.008446] nfsv4: Unknown symbol nfs_atomic_open (err -2)
> [   94.008468] nfsv4: Unknown symbol nfs_clear_verifier_delegated (err
> -2)
> [   94.008475] nfsv4: Unknown symbol nfs4_client_id_uniquifier (err -
> 2)
> [   94.008501] nfsv4: Unknown symbol nfs4_dentry_operations (err -2)
> [   94.008521] nfsv4: Unknown symbol nfs_fscache_open_file (err -2)
> [   94.008566] nfsv4: Unknown symbol nfs4_fs_type (err -2)
> [   94.008595] nfsv4: Unknown symbol recover_lost_locks (err -2)
> [   94.008639] nfsv4: Unknown symbol nfs_callback_nr_threads (err -2)
> [   94.008654] nfsv4: Unknown symbol max_session_cb_slots (err -2)
> [   94.008678] nfsv4: Unknown symbol max_session_slots (err -2)
> [   94.008694] nfsv4: Unknown symbol nfs_idmap_cache_timeout (err -2)
> [   94.008709] nfsv4: Unknown symbol nfs_callback_set_tcpport (err -2)
>=20
> I suspect I've turned something off in the config that I shouldn't
> have, but I'm not sure what.  I see that one of the symbols
> (nfs_clear_verifier_delegated) is in include/linux/nfs_fs.h, and the
> others are defined in fs/nfs/nfs4_fs.h, fs/nfs/super.c, fs/nfs/dir.c,
> fs/nfs/inode.c, fs/nfs/fscache.c, and fs/nfs/fs_context.c.  I'm
> changing config options and recompiling to try to figure out what I'm
> missing, but at a couple of hours per compile and only a couple of
> days a week to work on this it's slow going.  Any hints as to what I
> might be doing wrong would be appreciated.  =F0=9F=98=8A
>=20

Looks like the ABI got broken when you turned off some options.

Generally, if you just want to build a single module, then you want the
.config to be _exactly_ the one that you used to build the kernel you're
going to plug it into. Then to build the modules under fs/nfs you can
do:

    make modules_prepare
    make M=3Dfs/nfs

...and then drop the resulting .ko objects into the right place in
/lib/modules.

That said, it may be simpler to just build and work with a whole kernel
for testing purposes. Working with an individual kmod can be a bit
tricky unless you know what you're doing.

Once you do the first, subsequent builds should be reasonably fast.
--=20
Jeff Layton <jlayton@kernel.org>
