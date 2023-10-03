Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42A87B6DA1
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Oct 2023 17:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbjJCP6l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Oct 2023 11:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbjJCP6i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Oct 2023 11:58:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF9CAF
        for <linux-nfs@vger.kernel.org>; Tue,  3 Oct 2023 08:58:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92BBC43391;
        Tue,  3 Oct 2023 15:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696348712;
        bh=nj1p/m3gOzSCqysEI8XAL1eau1r0N60aIm9rSGb00K4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JlVRjK40yDkJFHPBCjUi1jEDCpuvsEU2lxxM+UyKIXqqPkaYr3FuiLHaSRC10t//A
         7DpMVn1d1HKAvkQtUnVB8x0NiLCqScZOs6WCwdEM9ZQh4jl0tqhHG3tD/5v30eKfc/
         XQrf9VbCoCdNrachVx95AmsjZ8kL8MQTDs2kVdayLhOYWOGJENses0BsriC4py3d8V
         k0Uw2cSMkOG3ZqE12aeE16XOHbq46jseYTgLAHVjCT37x1mXX1kWvJEXehxHvVwIl9
         BMpPMBNTvjyxh/X4GMGe31yFs0t6ugn1th0RGNMDuT/ZewyTbxmhwbiaNnFuyI4x1o
         7DWBjPLzwnScA==
Message-ID: <a70aea770dc59ac3ff1d4f7206dec34e8f201ed8.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: Don't retry using the same source port if
 connection failed
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 03 Oct 2023 11:58:30 -0400
In-Reply-To: <688C5594-9744-43D7-ACE3-69A7167E0AE5@oracle.com>
References: <20230927192712.317799-1-trondmy@kernel.org>
         <CAN-5tyF9rKdu0D-7nUFQtq1BWQABb+mdY3sLrDY1-sU_Q2p8fA@mail.gmail.com>
         <c32aec7b2a8b226a1617ff9755b7b5ce64ad3114.camel@hammerspace.com>
         <CAN-5tyE2_myhnzuf28gmm9ztJxb+g=fHS4wDVNE5D43BSandUA@mail.gmail.com>
         <d3c1b8980a2942d79b9a5fe61586ebe42e75b7e6.camel@hammerspace.com>
         <CAN-5tyF99D_HoGjjB2yuQpcQ_c39q7-xOawWuk4EUdaMZL=-jQ@mail.gmail.com>
         <77a198c49efa23976c1c787bb51366af705608c3.camel@kernel.org>
         <CAN-5tyE3VuSSqmQyUvi9mxhV0-PVfJUK50P9mdJ+x36YFP9wYQ@mail.gmail.com>
         <688C5594-9744-43D7-ACE3-69A7167E0AE5@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-10-03 at 15:32 +0000, Chuck Lever III wrote:
>=20
> > On Oct 3, 2023, at 11:28 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >=20
> > On Tue, Oct 3, 2023 at 11:12=E2=80=AFAM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >=20
> > > On Tue, 2023-10-03 at 10:44 -0400, Olga Kornievskaia wrote:
> > > > On Sat, Sep 30, 2023 at 7:06=E2=80=AFPM Trond Myklebust <trondmy@ha=
mmerspace.com> wrote:
> > > > >=20
> > > > > On Sat, 2023-09-30 at 18:36 -0400, Olga Kornievskaia wrote:
> > > > > > On Fri, Sep 29, 2023 at 10:57=E2=80=AFPM Trond Myklebust
> > > > > > <trondmy@hammerspace.com> wrote:
> > > > > > >=20
> > > > > > > On Thu, 2023-09-28 at 10:58 -0400, Olga Kornievskaia wrote:
> > > > > > > > On Wed, Sep 27, 2023 at 3:35=E2=80=AFPM <trondmy@kernel.org=
> wrote:
> > > > > > > > >=20
> > > > > > > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > > > > > >=20
> > > > > > > > > If the TCP connection attempt fails without ever establis=
hing a
> > > > > > > > > connection, then assume the problem may be the server is
> > > > > > > > > rejecting
> > > > > > > > > us
> > > > > > > > > due to port reuse.
> > > > > > > >=20
> > > > > > > > Doesn't this break 4.0 replay cache? Seems too general to a=
ssume
> > > > > > > > that
> > > > > > > > any unsuccessful SYN was due to a server reboot and it's ok=
 for
> > > > > > > > the
> > > > > > > > client to change the port.
> > > > > > >=20
> > > > > > > This is where things get interesting. Yes, if we change the p=
ort
> > > > > > > number, then it will almost certainly break NFSv3 and NFSv4.0
> > > > > > > replay
> > > > > > > caching on the server.
> > > > > > >=20
> > > > > > > However the problem is that once we get stuck in the situatio=
n
> > > > > > > where we
> > > > > > > cannot connect, then each new connection attempt is just caus=
ing
> > > > > > > the
> > > > > > > server's TCP layer to push back and recall that the connectio=
n from
> > > > > > > this port was closed.
> > > > > > > IOW: the problem is that once we're in this situation, we can=
not
> > > > > > > easily
> > > > > > > exit without doing one of the following. Either we have to
> > > > > > >=20
> > > > > > >   1. Change the port number, so that the TCP layer allows us =
to
> > > > > > >      connect.
> > > > > > >   2. Or.. Wait for long enough that the TCP layer has forgott=
en
> > > > > > >      altogether about the previous connection.
> > > > > > >=20
> > > > > > > The problem is that option (2) is subject to livelock, and so=
 has a
> > > > > > > potential infinite time out. I've seen this livelock in actio=
n, and
> > > > > > > I'm
> > > > > > > not seeing a solution that has predictable results.
> > > > > > >=20
> > > > > > > So unless there is a solution for the problems in (2), I don'=
t see
> > > > > > > how
> > > > > > > we can avoid defaulting to option (1) at some point, in which=
 case
> > > > > > > the
> > > > > > > only question is "when do we switch ports?".
> > > > > >=20
> > > > > > I'm not sure how one can justify that regression that will come=
 out
> > > > > > of
> > > > > > #1 will be less of a problem then the problem in #2.
> > > > > >=20
> > > > > > I think I'm still not grasping why the NFS server would
> > > > > > (legitimately)
> > > > > > be closing a connection that is re-using the port. Can you pres=
ent a
> > > > > > sequence of events that would lead to this?
> > > > > >=20
> > > > >=20
> > > > > Yes. It is essentially the problem described in this blog:
> > > > > https://blog.davidvassallo.me/2010/07/13/time_wait-and-port-reuse=
/
> > > > >=20
> > > > > ...and as you can see, it is nothing to do with NFS. This is the =
TCP
> > > > > protocol working as expected.
> > > >=20
> > > > What I'm seeing are statements that RFC allows for/provides guidanc=
e
> > > > on how to transition out of TIME_WAIT state. I'm also hearing that =
the
> > > > reasons that the server can't allow for port reuse is due to broken
> > > > client implementation or use of (broken?) NAT implementation.
> > > >=20
> > > > I don't see how any of this justifies allowing a regression in the
> > > > linux client code. I'm clearly missing something. How are you possi=
bly
> > > > OK with breaking the reply cache?
> > > >=20
> > >=20
> > > Is it really breaking things though if you can't connect otherwise? B=
ear
> > > in mind that if you're dealing with NAT'ed setup, and you wait until =
the
> > > connection is completely forgotten, then the NAT'ing firewall is like=
ly
> > > to change your source port anyway.
> > >=20
> > > Chuck brought up an interesting question privately: should knfsd's
> > > v3/v4.0 DRC start ignoring the source port? We already check this
> > > otherwise:
> > >=20
> > > - IP addr
> > > - XID
> > > - hash of first 256 bytes of the payload
> >=20
> > Calculating a hash of every packet has a great performance impact.
>=20
> NFSD has done this for years. On modern CPUs, it's less of a
> performance hit than walking the DRC hash chain.
>=20
>=20

Yes, and calling it a hash is probably overstating it a bit...

It's doing a CRC over those bytes, which is fine for our purposes and
quite fast on modern hw.

> > But
> > perhaps if we require v3 traffic to do that then we can get v3 and
> > v4.1 performance on the same level and folks would finally switch to
> > v4.1.
> >=20
> > I also forgot to write that while we don't care about port (not being
> > reused) for 4.1. If we switch the port on every connection
> > establishment we will same way run into port exhaustion. Use of
> > nconnect is becoming common so something like a server reboot on a
> > client machine with about only 10 mounts using nconnect=3D16 and averag=
e
> > of 7 SYNs (as per example here) before the server starts again, the
> > client would use 1K source ports?
> >=20
> > > That seems like enough discriminators that we could stop comparing th=
e
> > > source port without breaking things.
> > >=20
> > > > > > But can't we at least arm ourselves in not unnecessarily breaki=
ng the
> > > > > > reply cache by at least imposing some timeout/number of retries
> > > > > > before
> > > > > > resetting? If the client was retrying to unsuccessfully re-esta=
blish
> > > > > > connection for a (fixed) while, then 4.0 client's lease would e=
xpire
> > > > > > and switching the port after the lease expires makes no differe=
nce.
> > > > > > There isn't a solution in v3 unfortunately. But a time-based ap=
proach
> > > > > > would at least separate these 'peculiar' servers vs normal serv=
ers.
> > > > > > And if this is a 4.1 client, we can reset the port without a ti=
meout.
> > > > > >=20
> > > > >=20
> > > > > This is not a 'peculiar server' vs 'normal server' problem. The r=
euse
> > > > > of ports in this way violates the TCP protocol, and has been a pr=
oblem
> > > >=20
> > > > I disagree here. Even the RFC quoted by the blogger says that reuse=
 of
> > > > port is allowed.
> > > >=20
> > > > > for NFS/TCP since the beginning. However, it was never a problem =
for
> > > > > the older connectionless UDP protocol, which is where the practic=
e of
> > > > > tying the replay cache to the source port began in the first plac=
e.
> > > > >=20
> > > > > NFSv4.1 does not have this problem because it deliberately does n=
ot
> > > > > reuse TCP ports, and the reason is precisely to avoid the TIME_WA=
IT
> > > > > state problems.
> > > > >=20
> > > > > NFSv3 tries to avoid it by doing an incremental back off, but we
> > > > > recently saw that does not suffice to avoid live lock, after a sy=
stem
> > > > > got stuck for several hours in this state.
> > > > >=20
> > > > > > Am I correct that every unsuccessful SYN causes a new source po=
int to
> > > > > > be taken? If so, then a server reboot where multiple SYNs are s=
ent
> > > > > > prior to connection re-establishment (times number of mounts) m=
ight
> > > > > > cause source port exhaustion?
> > > > > >=20
> > > > >=20
> > > > > No. Not every unsuccessful SYN: It is every unsuccessful sequence=
 of
> > > >=20
> > > > I disagree. Here's a snippet of the network trace with the proposed
> > > > patch. The port is changed on EVERY unsuccessful SYN.
> > > >=20
> > > >   76 2023-10-03 10:17:04.285731 192.168.1.134 =E2=86=92 192.168.1.1=
06 NFS 238
> > > > V3 WRITE Call, FH: 0x10bedd7c Offset: 0 Len: 4 FILE_SYNC
> > > >   77 2023-10-03 10:17:04.328371 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 66
> > > > 2049 =E2=86=92 909 [ACK] Seq=3D1113 Ack=3D1501 Win=3D31872 Len=3D0 =
TSval=3D3542359002
> > > > TSecr=3D3081600630
> > > >  256 2023-10-03 10:18:04.341041 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 66
> > > > [TCP Keep-Alive] 909 =E2=86=92 2049 [ACK] Seq=3D1500 Ack=3D1113 Win=
=3D32000 Len=3D0
> > > > TSval=3D3081660681 TSecr=3D3542359002
> > > >  259 2023-10-03 10:18:04.341500 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 909 [RST] Seq=3D1113 Win=3D0 Len=3D0
> > > >  260 2023-10-03 10:18:04.341860 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > [TCP Port numbers reused] 909 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32=
120 Len=3D0
> > > > MSS=3D1460 SACK_PERM TSval=3D3081660681 TSecr=3D0 WS=3D128
> > > >  261 2023-10-03 10:18:04.342031 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 909 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  266 2023-10-03 10:18:07.380801 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 954 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081663720 TSecr=3D0 WS=3D128
> > > >  267 2023-10-03 10:18:07.380971 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 954 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  275 2023-10-03 10:18:10.423352 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 856 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081666760 TSecr=3D0 WS=3D128
> > > >  276 2023-10-03 10:18:10.423621 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 856 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  286 2023-10-03 10:18:13.466277 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 957 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081669801 TSecr=3D0 WS=3D128
> > > >  287 2023-10-03 10:18:13.466812 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 957 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  289 2023-10-03 10:18:16.509229 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 695 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081672841 TSecr=3D0 WS=3D128
> > > >  290 2023-10-03 10:18:16.509845 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 695 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  294 2023-10-03 10:18:19.551062 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 940 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081675881 TSecr=3D0 WS=3D128
> > > >  295 2023-10-03 10:18:19.551434 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 940 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  300 2023-10-03 10:18:22.590380 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 810 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081678921 TSecr=3D0
> > > > WS=3D128
> > > >  301 2023-10-03 10:18:22.590726 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 810 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  308 2023-10-03 10:18:25.628256 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 877 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081681961 TSecr=3D0 WS=3D128
> > > >  309 2023-10-03 10:18:25.628724 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 877 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  312 2023-10-03 10:18:28.665682 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 934 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081685001 TSecr=3D0 WS=3D128
> > > >  313 2023-10-03 10:18:28.666374 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 934 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  320 2023-10-03 10:18:31.702236 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 803 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081688040 TSecr=3D0 WS=3D128
> > > >  321 2023-10-03 10:18:31.702490 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 74
> > > > 2049 =E2=86=92 803 [SYN, ACK] Seq=3D0 Ack=3D1 Win=3D31856 Len=3D0 M=
SS=3D1460 SACK_PERM
> > > > TSval=3D1993141756 TSecr=3D3081688040 WS=3D128
> > > >  322 2023-10-03 10:18:31.702729 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 66
> > > > 803 =E2=86=92 2049 [ACK] Seq=3D1 Ack=3D1 Win=3D32128 Len=3D0 TSval=
=3D3081688040
> > > > TSecr=3D1993141756
> > > >  323 2023-10-03 10:18:31.702737 192.168.1.134 =E2=86=92 192.168.1.1=
06 NFS 238
> > > > V3 WRITE Call, FH: 0x10bedd7c Offset: 0 Len: 4 FILE_SYNC
> > > >  324 2023-10-03 10:18:31.702893 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 66
> > > > 2049 =E2=86=92 803 [ACK] Seq=3D1 Ack=3D173 Win=3D31872 Len=3D0 TSva=
l=3D1993141756
> > > > TSecr=3D3081688040
> > > >  749 2023-10-03 10:19:01.880214 192.168.1.106 =E2=86=92 192.168.1.1=
34 NFS 206
> > > > V3 WRITE Reply (Call In 323) Len: 4 FILE_SYNC
> > > >=20
> > > > This is the same without the patch. Port is successfully reused.
> > > > Replay cache OK here not above.
> > > >=20
> > > >   76 2023-10-03 10:17:04.285731 192.168.1.134 =E2=86=92 192.168.1.1=
06 NFS 238
> > > > V3 WRITE Call, FH: 0x10bedd7c Offset: 0 Len: 4 FILE_SYNC
> > > >   77 2023-10-03 10:17:04.328371 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 66
> > > > 2049 =E2=86=92 909 [ACK] Seq=3D1113 Ack=3D1501 Win=3D31872 Len=3D0 =
TSval=3D3542359002
> > > > TSecr=3D3081600630
> > > >  256 2023-10-03 10:18:04.341041 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 66
> > > > [TCP Keep-Alive] 909 =E2=86=92 2049 [ACK] Seq=3D1500 Ack=3D1113 Win=
=3D32000 Len=3D0
> > > > TSval=3D3081660681 TSecr=3D3542359002
> > > >  259 2023-10-03 10:18:04.341500 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 909 [RST] Seq=3D1113 Win=3D0 Len=3D0
> > > >  260 2023-10-03 10:18:04.341860 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > [TCP Port numbers reused] 909 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32=
120 Len=3D0
> > > > MSS=3D1460 SACK_PERM TSval=3D3081660681 TSecr=3D0 WS=3D128
> > > >  261 2023-10-03 10:18:04.342031 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 909 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  266 2023-10-03 10:18:07.380801 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 954 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081663720 TSecr=3D0 WS=3D128
> > > >  267 2023-10-03 10:18:07.380971 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 954 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  275 2023-10-03 10:18:10.423352 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 856 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081666760 TSecr=3D0 WS=3D128
> > > >  276 2023-10-03 10:18:10.423621 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 856 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  286 2023-10-03 10:18:13.466277 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 957 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081669801 TSecr=3D0 WS=3D128
> > > >  287 2023-10-03 10:18:13.466812 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 957 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  289 2023-10-03 10:18:16.509229 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 695 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081672841 TSecr=3D0 WS=3D128
> > > >  290 2023-10-03 10:18:16.509845 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 695 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  294 2023-10-03 10:18:19.551062 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 940 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081675881 TSecr=3D0 WS=3D128
> > > >  295 2023-10-03 10:18:19.551434 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 940 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  300 2023-10-03 10:18:22.590380 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 810 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081678921 TSecr=3D0 WS=3D128
> > > >  301 2023-10-03 10:18:22.590726 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 810 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  308 2023-10-03 10:18:25.628256 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 877 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081681961 TSecr=3D0 WS=3D128
> > > >  309 2023-10-03 10:18:25.628724 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 877 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  312 2023-10-03 10:18:28.665682 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 934 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081685001 TSecr=3D0 WS=3D128
> > > >  313 2023-10-03 10:18:28.666374 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 54
> > > > 2049 =E2=86=92 934 [RST, ACK] Seq=3D1 Ack=3D1 Win=3D0 Len=3D0
> > > >  320 2023-10-03 10:18:31.702236 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 74
> > > > 803 =E2=86=92 2049 [SYN] Seq=3D0 Win=3D32120 Len=3D0 MSS=3D1460 SAC=
K_PERM
> > > > TSval=3D3081688040 TSecr=3D0 WS=3D128
> > > >  321 2023-10-03 10:18:31.702490 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 74
> > > > 2049 =E2=86=92 803 [SYN, ACK] Seq=3D0 Ack=3D1 Win=3D31856 Len=3D0 M=
SS=3D1460 SACK_PERM
> > > > TSval=3D1993141756 TSecr=3D3081688040 WS=3D128
> > > >  322 2023-10-03 10:18:31.702729 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 66
> > > > 803 =E2=86=92 2049 [ACK] Seq=3D1 Ack=3D1 Win=3D32128 Len=3D0 TSval=
=3D3081688040
> > > > TSecr=3D1993141756
> > > >  323 2023-10-03 10:18:31.702737 192.168.1.134 =E2=86=92 192.168.1.1=
06 NFS 238
> > > > V3 WRITE Call, FH: 0x10bedd7c Offset: 0 Len: 4 FILE_SYNC
> > > >  324 2023-10-03 10:18:31.702893 192.168.1.106 =E2=86=92 192.168.1.1=
34 TCP 66
> > > > 2049 =E2=86=92 803 [ACK] Seq=3D1 Ack=3D173 Win=3D31872 Len=3D0 TSva=
l=3D1993141756
> > > > TSecr=3D3081688040
> > > >  749 2023-10-03 10:19:01.880214 192.168.1.106 =E2=86=92 192.168.1.1=
34 NFS 206
> > > > V3 WRITE Reply (Call In 323) Len: 4 FILE_SYNC
> > > >  750 2023-10-03 10:19:01.880616 192.168.1.134 =E2=86=92 192.168.1.1=
06 TCP 66
> > > > 803 =E2=86=92 2049 [ACK] Seq=3D173 Ack=3D141 Win=3D32000 Len=3D0 TS=
val=3D3081718241
> > > > TSecr=3D1993171927
> > > >=20
> > > >=20
> > > > > SYNs. If the server is not replying to our SYN packets, then the =
TCP
> > > > > layer will back off and retransmit. So there is already a backoff=
-retry
> > > > > happening at that level.
> > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Trond Myklebust
> > > > > > > > > <trond.myklebust@hammerspace.com>
> > > > > > > > > ---
> > > > > > > > > net/sunrpc/xprtsock.c | 10 +++++++++-
> > > > > > > > > 1 file changed, 9 insertions(+), 1 deletion(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.=
c
> > > > > > > > > index 71848ab90d13..1a96777f0ed5 100644
> > > > > > > > > --- a/net/sunrpc/xprtsock.c
> > > > > > > > > +++ b/net/sunrpc/xprtsock.c
> > > > > > > > > @@ -62,6 +62,7 @@
> > > > > > > > > #include "sunrpc.h"
> > > > > > > > >=20
> > > > > > > > > static void xs_close(struct rpc_xprt *xprt);
> > > > > > > > > +static void xs_reset_srcport(struct sock_xprt *transport=
);
> > > > > > > > > static void xs_set_srcport(struct sock_xprt *transport, s=
truct
> > > > > > > > > socket *sock);
> > > > > > > > > static void xs_tcp_set_socket_timeouts(struct rpc_xprt *x=
prt,
> > > > > > > > >                struct socket *sock);
> > > > > > > > > @@ -1565,8 +1566,10 @@ static void xs_tcp_state_change(st=
ruct
> > > > > > > > > sock
> > > > > > > > > *sk)
> > > > > > > > >                break;
> > > > > > > > >        case TCP_CLOSE:
> > > > > > > > >                if (test_and_clear_bit(XPRT_SOCK_CONNECTIN=
G,
> > > > > > > > > -                                       &transport-
> > > > > > > > > > sock_state))
> > > > > > > > > +                                      &transport->sock_s=
tate))
> > > > > > > > > {
> > > > > > > > > +                       xs_reset_srcport(transport);
> > > > > > > > >                        xprt_clear_connecting(xprt);
> > > > > > > > > +               }
> > > > > > > > >                clear_bit(XPRT_CLOSING, &xprt->state);
> > > > > > > > >                /* Trigger the socket release */
> > > > > > > > >                xs_run_error_worker(transport,
> > > > > > > > > XPRT_SOCK_WAKE_DISCONNECT);
> > > > > > > > > @@ -1722,6 +1725,11 @@ static void xs_set_port(struct rpc=
_xprt
> > > > > > > > > *xprt, unsigned short port)
> > > > > > > > >        xs_update_peer_port(xprt);
> > > > > > > > > }
> > > > > > > > >=20
> > > > > > > > > +static void xs_reset_srcport(struct sock_xprt *transport=
)
> > > > > > > > > +{
> > > > > > > > > +       transport->srcport =3D 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > static void xs_set_srcport(struct sock_xprt *transport, s=
truct
> > > > > > > > > socket *sock)
> > > > > > > > > {
> > > > > > > > >        if (transport->srcport =3D=3D 0 && transport-
> > > > > > > > > > xprt.reuseport)
> > > > > > > > > --
> > > > > > > > > 2.41.0
> > > > > > > > >=20
> > > > > > >=20
> > > > > > > --
> > > > > > > Trond Myklebust Linux NFS client maintainer, Hammerspace
> > > > > > > trond.myklebust@hammerspace.com
> > > > >=20
> > > > > --
> > > > > Trond Myklebust
> > > > > Linux NFS client maintainer, Hammerspace
> > > > > trond.myklebust@hammerspace.com
> > > > >=20
> > > > >=20
> > >=20
> > > --
> > > Jeff Layton <jlayton@kernel.org>
>=20
>=20
> --
> Chuck Lever
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
