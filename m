Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142EB67E6CC
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jan 2023 14:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjA0NdS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Jan 2023 08:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjA0NdR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Jan 2023 08:33:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E81116AE2
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 05:33:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 678976173B
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 13:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8360DC433D2;
        Fri, 27 Jan 2023 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674826391;
        bh=nugXaOnk5OTeiXZEHM7EX6WlJdchpBuV6kJrQ1Dkeas=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=ia1KItRDU7juQp56cJLagl8tMeOZMFxGfhHTRR6dqp0KTDbxAobgEpma842yk/HUX
         ouR7Ld8p8l5e0LpDUtbz2X6h/trQwYqd+seMmxDbVbukossxoromHylZ9e50qw4PFq
         rNN1iBl4QXIYWq0bjNYRj8LU9dpR1apIDPce4Y5+oHZOwL5gqI/U/HJxlULbkStOL8
         YXvxiZOqBxDahn9f6RBn53VUBOz0v9okZ1vMlQQ9nC8KSkgpnJsM+z/65+FU57Yu6P
         kkXYMqYdm97+V+HwZFO58aLSuTYavc69vndUsaGVSKIPQrb7DlS7Z+Q/UM0JDthii4
         n9OFw5i2CKDtQ==
Message-ID: <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
Subject: Re: Trying to reduce NFSv4 timeouts to a few seconds on an
 established connection
From:   Jeff Layton <jlayton@kernel.org>
To:     Andrew Klaassen <andrew.klaassen@boatrocker.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Fri, 27 Jan 2023 08:33:10 -0500
In-Reply-To: <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
         <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-01-26 at 22:08 +0000, Andrew Klaassen wrote:
> > From: Andrew Klaassen <andrew.klaassen@boatrocker.com>
> > Sent: Thursday, January 26, 2023 10:32 AM
> >=20
> > > From: Andrew Klaassen <andrew.klaassen@boatrocker.com>
> > > Sent: Monday, January 23, 2023 11:31 AM
> > >=20
> > > Hello,
> > >=20
> > > There's a specific NFSv4 mount on a specific machine which we'd
> > > like
> > > to timeout and return an error after a few seconds if the server
> > > goes away.
> > >=20
> > > I've confirmed the following on two different kernels, 4.18.0-
> > > 348.12.2.el8_5.x86_64 and 6.1.7-200.fc37.x86_64.
> > >=20
> > > I've been able to get both autofs and the mount command to
> > > cooperate,
> > > so that the mount attempt fails after an arbitrary number of
> > > seconds.
> > > This mount command, for example, will fail after 6 seconds, as
> > > expected based on the timeo=3D20,retrans=3D2,retry=3D0 options:
> > >=20
> > > $ time sudo mount -t nfs4 -o
> > > rw,relatime,sync,vers=3D4.2,rsize=3D131072,wsize=3D131072,namlen=3D25=
5,acr
> > > egmi
> > > n
> > >=20
> > =3D0,acregmax=3D0,acdirmin=3D0,acdirmax=3D0,soft,noac,proto=3Dtcp,timeo=
=3D20,ret
> > ra
> > > n s=3D2,retry=3D0,sec=3Dsys thor04:/mnt/thorfs04  /mnt/thor04
> > > mount.nfs4: Connection timed out
> > >=20
> > > real    0m6.084s
> > > user    0m0.007s
> > > sys     0m0.015s
> > >=20
> > > However, if the share is already mounted and the server goes away,
> > > the
> > > timeout is always 2 minutes plus the time I expect based on timeo
> > > and
> > > retrans.  In this case, 2 minutes and 6 seconds:
> > >=20
> > > $ time ls /mnt/thor04
> > > ls: cannot access '/mnt/thor04': Connection timed out
> > >=20
> > > real    2m6.025s
> > > user    0m0.003s
> > > sys     0m0.000s
> > >=20
> > > Watching the outgoing packets in the second case, the pattern is
> > > always the
> > > same:
> > > =A0- 0.2 seconds between the first two, then doubling each time
> > > until
> > > the two minute mark is exceeded (so the last NFS packet, which is
> > > always the 11th packet, is sent around 1:45 after the first).
> > > =A0- Then some generic packets that start exactly-ish on the two
> > > minute
> > > mark, 1 second between the first two, then doubling each time.=20
> > > (By
> > > this time the NFS command has given up.)
> > >=20
> > > 11:10:21.898305 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.],
> > > seq
> > > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834889483
> > > ecr
> > > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > > 0,2/53
> > > 11:10:22.105189 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.],
> > > seq
> > > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834889690
> > > ecr
> > > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > > 0,2/53
> > > 11:10:22.313290 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.],
> > > seq
> > > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834889898
> > > ecr
> > > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > > 0,2/53
> > > 11:10:22.721269 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.],
> > > seq
> > > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834890306
> > > ecr
> > > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > > 0,2/53
> > > 11:10:23.569192 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.],
> > > seq
> > > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834891154
> > > ecr
> > > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > > 0,2/53
> > > 11:10:25.233212 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.],
> > > seq
> > > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834892818
> > > ecr
> > > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > > 0,2/53
> > > 11:10:28.497282 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.],
> > > seq
> > > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834896082
> > > ecr
> > > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > > 0,2/53
> > > 11:10:35.025219 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.],
> > > seq
> > > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834902610
> > > ecr
> > > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > > 0,2/53
> > > 11:10:48.337201 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.],
> > > seq
> > > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834915922
> > > ecr
> > > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > > 0,2/53
> > > 11:11:14.449303 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.],
> > > seq
> > > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834942034
> > > ecr
> > > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > > 0,2/53
> > > 11:12:08.721251 IP 10.30.13.2.916 > 10.31.3.13.2049: Flags [P.],
> > > seq
> > > 14452:14652, ack 18561, win 501, options [nop,nop,TS val 834996306
> > > ecr
> > > 1589769203], length 200: NFS request xid 3614904256 196 getattr fh
> > > 0,2/53
> > > 11:12:22.545394 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S],
> > > seq
> > > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835010130
> > > ecr
> > > 0,nop,wscale 7], length 0
> > > 11:12:23.570199 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S],
> > > seq
> > > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835011155
> > > ecr
> > > 0,nop,wscale 7], length 0
> > > 11:12:25.617284 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S],
> > > seq
> > > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835013202
> > > ecr
> > > 0,nop,wscale 7], length 0
> > > 11:12:29.649219 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S],
> > > seq
> > > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835017234
> > > ecr
> > > 0,nop,wscale 7], length 0
> > > 11:12:37.905274 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S],
> > > seq
> > > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835025490
> > > ecr
> > > 0,nop,wscale 7], length 0
> > > 11:12:54.289212 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S],
> > > seq
> > > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835041874
> > > ecr
> > > 0,nop,wscale 7], length 0
> > > 11:13:26.545304 IP 10.30.13.2.942 > 10.31.3.13.2049: Flags [S],
> > > seq
> > > 1375256951, win 64240, options [mss 1460,sackOK,TS val 835074130
> > > ecr
> > > 0,nop,wscale 7], length 0
> > >=20
> > > I tried changing tcp_retries2 as suggested in another thread from
> > > this list:
> > >=20
> > > # echo 3 > /proc/sys/net/ipv4/tcp_retries2
> > >=20
> > > ...but it made no difference on either kernel.  The 2 minute
> > > timeout
> > > also doesn't seem to match with what I'd calculate from the
> > > initial
> > > value of tcp_retries2, which should give a much higher timeout.
> > >=20
> > > The only clue I've been able to find is in the retry=3Dn entry in
> > > the
> > > NFS
> > > manpage:
> > >=20
> > > " For TCP the default is 3 minutes, but system TCP connection
> > > timeouts
> > > will sometimes limit the timeout of each retransmission to around
> > > 2
> > minutes."
> > >=20
> > > What I'm not able to make sense of:
> > > =A0- The retry option says that it applies to mount operations, not
> > > read/write operations.  However, in this case I'm seeing the 2
> > > minute
> > > delay on read/write operations but *not* mount operations.
> > > =A0- A couple of hours of searching didn't lead me to any kernel
> > > settings that would result in a 2 minute timeout.
> > >=20
> > > Does anyone have any clues about a) what's happening and b) how to
> > > get
> > > our desired behaviour of being able to control both mount and
> > > read/write timeouts down to a few seconds?
> > >=20
> > > Thanks.
> >=20
> > I thought that changing TCP_RTO_MAX in include/net/tcp.h from 120 to
> > something smaller and recompiling the kernel would change the 2
> > minute
> > timeout, but it had no effect.  I'm going to keep poking through the
> > kernel
> > code to see if there's a knob I can turn to change the 2 minute
> > timeout, so
> > that I can at least understand where it's coming from.
> >=20
> > Any hints as to where I should be looking?
>=20
> I believe I've made some progress with this today:
>=20
> =A0- Calls to rpc_create() from fs/nfs/client.c are sending an
> rpc_timeout struct with their args.
> =A0- rpc_create() does *not* pass the timeout on to
> xprt_create_transport(), which then can't pass it on to
> xs_setup_tcp().
> =A0- xs_setup_tcp(), having no timeout passed to it, uses
> xs_tcp_default_timeout instead.
> =A0- changing xs_tcp_default_timeout changes the "ls" timeout behaviour
> I described above.
>=20
> In theory all of this means that the timeout simply needs to be passed
> through and used instead of xs_tcp_default_timeout.  I'm going to give
> this a try tomorrow.
>=20

That's a great root-cause analysis. The interlocking timeouts involved
with NFS and its sockets can be really difficult to unwind.

Is there a way to automate this testcase? That might be nice to have in
xfstests or the nfstest suite.

> Here's what I'm going to try first; I'm no C programmer, though, so
> any advice or corrections you might have would be appreciated.
>=20
> Thanks.
>=20
> Andrew
>=20
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 0b0b9f1eed46..1350c1f489f7 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -532,6 +532,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args
> *args)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.addrlen =3D args->addrsi=
ze,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.servername =3D args->ser=
vername,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.bc_xprt =3D args->bc_xpr=
t,
> +               .timeout =3D args->timeout,
> =A0=A0=A0=A0=A0=A0=A0=A0};
> =A0=A0=A0=A0=A0=A0=A0=A0char servername[48];
> =A0=A0=A0=A0=A0=A0=A0=A0struct rpc_clnt *clnt;
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index aaa5b2741b79..adc79d94b59e 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -3003,7 +3003,7 @@ static struct rpc_xprt *xs_setup_tcp(struct
> xprt_create *args)
> =A0=A0=A0=A0=A0=A0=A0=A0xprt->idle_timeout =3D XS_IDLE_DISC_TO;
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0xprt->ops =3D &xs_tcp_ops;
> -       xprt->timeout =3D &xs_tcp_default_timeout;
> +       xprt->timeout =3D args->timeout;
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0xprt->max_reconnect_timeout =3D xprt->timeout->to=
_maxval;
> =A0=A0=A0=A0=A0=A0=A0=A0xprt->connect_timeout =3D xprt->timeout->to_initv=
al *
>=20

Looks like you're probably on the right track. You're missing a few
things:

You'll need to add a "timeout" field to struct xprt_create in
include/linux/sunrpc/xprt.h, and there may be some other places that
either need to set the timeout in that structure, or do something with
that field when it's set.

Once you have something that fixes your reproducer, go ahead and post it
and we can help you work through whatever changes need to me made to
make it work.

Nice work!
--=20
Jeff Layton <jlayton@kernel.org>
