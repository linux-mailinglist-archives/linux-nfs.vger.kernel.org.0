Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A0441A0C
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 03:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392179AbfFLBt3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 21:49:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:51926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728996AbfFLBt2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 Jun 2019 21:49:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F8E2ACAE;
        Wed, 12 Jun 2019 01:49:26 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 12 Jun 2019 11:49:17 +1000
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
In-Reply-To: <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com> <87muj3tuuk.fsf@notabene.neil.brown.name> <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com> <87lfy9vsgf.fsf@notabene.neil.brown.name> <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
Message-ID: <874l4vwp2a.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11 2019, Chuck Lever wrote:

> Hi Neil-
>
>
>> On Jun 10, 2019, at 9:09 PM, NeilBrown <neilb@suse.com> wrote:
>>=20
>> On Fri, May 31 2019, Chuck Lever wrote:
>>=20
>>>> On May 30, 2019, at 6:56 PM, NeilBrown <neilb@suse.com> wrote:
>>>>=20
>>>> On Thu, May 30 2019, Chuck Lever wrote:
>>>>=20
>>>>> Hi Neil-
>>>>>=20
>>>>> Thanks for chasing this a little further.
>>>>>=20
>>>>>=20
>>>>>> On May 29, 2019, at 8:41 PM, NeilBrown <neilb@suse.com> wrote:
>>>>>>=20
>>>>>> This patch set is based on the patches in the multipath_tcp branch of
>>>>>> git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
>>>>>>=20
>>>>>> I'd like to add my voice to those supporting this work and wanting to
>>>>>> see it land.
>>>>>> We have had customers/partners wanting this sort of functionality for
>>>>>> years.  In SLES releases prior to SLE15, we've provide a
>>>>>> "nosharetransport" mount option, so that several filesystem could be
>>>>>> mounted from the same server and each would get its own TCP
>>>>>> connection.
>>>>>=20
>>>>> Is it well understood why splitting up the TCP connections result
>>>>> in better performance?
>>>>>=20
>>>>>=20
>>>>>> In SLE15 we are using this 'nconnect' feature, which is much nicer.
>>>>>>=20
>>>>>> Partners have assured us that it improves total throughput,
>>>>>> particularly with bonded networks, but we haven't had any concrete
>>>>>> data until Olga Kornievskaia provided some concrete test data - than=
ks
>>>>>> Olga!
>>>>>>=20
>>>>>> My understanding, as I explain in one of the patches, is that parall=
el
>>>>>> hardware is normally utilized by distributing flows, rather than
>>>>>> packets.  This avoid out-of-order deliver of packets in a flow.
>>>>>> So multiple flows are needed to utilizes parallel hardware.
>>>>>=20
>>>>> Indeed.
>>>>>=20
>>>>> However I think one of the problems is what happens in simpler scenar=
ios.
>>>>> We had reports that using nconnect > 1 on virtual clients made things
>>>>> go slower. It's not always wise to establish multiple connections
>>>>> between the same two IP addresses. It depends on the hardware on each
>>>>> end, and the network conditions.
>>>>=20
>>>> This is a good argument for leaving the default at '1'.  When
>>>> documentation is added to nfs(5), we can make it clear that the optimal
>>>> number is dependant on hardware.
>>>=20
>>> Is there any visibility into the NIC hardware that can guide this setti=
ng?
>>>=20
>>=20
>> I doubt it, partly because there is more than just the NIC hardware at i=
ssue.
>> There is also the server-side hardware and possibly hardware in the midd=
le.
>
> So the best guidance is YMMV. :-)
>
>
>>>>> What about situations where the network capabilities between server a=
nd
>>>>> client change? Problem is that neither endpoint can detect that; TCP
>>>>> usually just deals with it.
>>>>=20
>>>> Being able to manually change (-o remount) the number of connections
>>>> might be useful...
>>>=20
>>> Ugh. I have problems with the administrative interface for this feature,
>>> and this is one of them.
>>>=20
>>> Another is what prevents your client from using a different nconnect=3D
>>> setting on concurrent mounts of the same server? It's another case of a
>>> per-mount setting being used to control a resource that is shared across
>>> mounts.
>>=20
>> I think that horse has well and truly bolted.
>> It would be nice to have a "server" abstraction visible to user-space
>> where we could adjust settings that make sense server-wide, and then a w=
ay
>> to mount individual filesystems from that "server" - but we don't.
>
> Even worse, there will be some resource sharing between containers that
> might be undesirable. The host should have ultimate control over those
> resources.
>
> But that is neither here nor there.
>
>
>> Probably the best we can do is to document (in nfs(5)) which options are
>> per-server and which are per-mount.
>
> Alternately, the behavior of this option could be documented this way:
>
> The default value is one. To resolve conflicts between nconnect settings =
on
> different mount points to the same server, the value set on the first mou=
nt
> applies until there are no more mounts of that server, unless nosharecache
> is specified. When following a referral to another server, the nconnect
> setting is inherited, but the effective value is determined by other moun=
ts
> of that server that are already in place.
>
> I hate to say it, but the way to make this work deterministically is to
> ask administrators to ensure that the setting is the same on all mounts
> of the same server. Again I'd rather this take care of itself, but it
> appears that is not going to be possible.
>
>
>>> Adding user tunables has never been known to increase the aggregate
>>> amount of happiness in the universe. I really hope we can come up with
>>> a better administrative interface... ideally, none would be best.
>>=20
>> I agree that none would be best.  It isn't clear to me that that is
>> possible.
>> At present, we really don't have enough experience with this
>> functionality to be able to say what the trade-offs are.
>> If we delay the functionality until we have the perfect interface,
>> we may never get that experience.
>>=20
>> We can document "nconnect=3D" as a hint, and possibly add that
>> "nconnect=3D1" is a firm guarantee that more will not be used.
>
> Agree that 1 should be the default. If we make this setting a
> hint, then perhaps it should be renamed; nconnect makes it sound
> like the client will always open N connections. How about "maxconn" ?
>
> Then, to better define the behavior:
>
> The range of valid maxconn values is 1 to 3? to 8? to NCPUS? to the
> count of the client=E2=80=99s NUMA nodes? I=E2=80=99d be in favor of a sm=
all number
> to start with. Solaris' experience with multiple connections is that
> there is very little benefit past 8.
>
> If maxconn is specified with a datagram transport, does the mount
> operation fail, or is the setting is ignored?

With Trond's patches, the setting is ignored (as he said in a reply).
With my version, the setting is honoured.
Specifically, 'n' separate UDP sockets are created, each bound to a
different local port, each sending to the same server port.
If a bonding driver is using the source-port in the output hash
(xmit_policy=3Dlayer3+4 in the terminology of
linux/Documentation/net/bonding.txt),
then this would get better throughput over bonded network interfaces.

>
> If maxconn is a hint, when does the client open additional
> connections?
>
> IMO documentation should be clear that this setting is not for the
> purpose of multipathing/trunking (using multiple NICs on the client
> or server). The client has to do trunking detection/discovery in that
> case, and nconnect doesn't add that logic. This is strictly for
> enabling multiple connections between one client-server IP address
> pair.
>
> Do we need to state explicitly that all transport connections for a
> mount (or client-server pair) are the same connection type (i.e., all
> TCP or all RDMA, never a mix)?
>
>
>> Then further down the track, we might change the actual number of
>> connections automatically if a way can be found to do that without cost.
>
> Fair enough.
>
>
>> Do you have any objections apart from the nconnect=3D mount option?
>
> Well I realize my last e-mail sounded a little negative, but I'm
> actually in favor of adding the ability to open multiple connections
> per client-server pair. I just want to be careful about making this
> a feature that has as few downsides as possible right from the start.
> I'll try to be more helpful in my responses.
>
> Remaining implementation issues that IMO need to be sorted:
>
> =E2=80=A2 We want to take care that the client can recover network resour=
ces
> that have gone idle. Can we reuse the auto-close logic to close extra
> connections?

Were you aware that auto-close was ineffective with NFSv4 as the regular
RENEW (or SEQUENCE for v4.1) keeps a connection open?
My patches already force session management requests onto a single xprt.
It probably makes sense to do the same for RENEW and SEQUENCE.
Then when there is no fs activity, the other connections will close.
There is no mechanism to re-open only some of them though.  Any
non-trivial amount of traffic will cause all connection to re-open.

> =E2=80=A2 How will the client schedule requests on multiple connections?
> Should we enable the use of different schedulers?
> =E2=80=A2 How will retransmits be handled?
> =E2=80=A2 How will the client recover from broken connections? Today's cl=
ients
> use disconnect to determine when to retransmit, thus there might be
> some unwanted interactions here that result in mount hangs.
> =E2=80=A2 Assume NFSv4.1 session ID rather than client ID trunking: is Li=
nux
> client support in place for this already?
> =E2=80=A2 Are there any concerns about how the Linux server DRC will beha=
ve in
> multi-connection scenarios?
>
> None of these seem like a deal breaker. And possibly several of these
> are already decided, but just need to be published/documented.

How about this:

 NFS normally sends all requests to the server (and receives all replies)
 over a single network connection, whether TCP, RDMA or (for NFSv3 and
 earlier) UDP.  Often this is sufficient to utilize all available
 network bandwidth, but not always.  When there is sufficient
 parallelism in the server, the client, and the network connection, the
 restriction to a single TCP stream can become a limitation.

 A simple scenario which portrays this limitation involves several
 direct network connections between client and server where the multiple
 interfaces on each end are bonded together.  If this bonding diverts
 different flows to different interfaces, then a single TCP connection
 will be limited to a single network interface, while multiple
 connections could make use of all interfaces.  Various other scenarios
 are possible including network controllers with multiple DMA/TSO
 engines where a given flow can only be associated with a single engine
 at a time, or Receive-side scaling which can direct different flows to
 different receive queues and thence to different CPU cores.

 NFS has two distinct and complementary mechanisms to enable the use of
 multiple connections to carry requests and replies.  We will refer to
 these as trunking and nconnect, though the NFS RFCs use the term
 "trunking" in a way that covers both.

 With trunking (also known as multipathing), the server-side IP address
 of each connection is different.  RFC8587 (and other documents)
 describe how a client can determine if two connections to different
 addresses actually refer to the same server and so can be used for
 trucking.  The client can use explicit configuration, possibly using
 the NFSv4 `fs_locations` attribute, to find the different addresses,
 and can then establish multiple trunks.  With trunking, the different
 connections could conceivably be over different protocols, both TCP and
 RDMA for example.  Trunking makes use of explicit parallelism in the
 network configuration.

 With nconnect, both the client and server side IP addresses are the
 same on each connection, but the client side port number varies.  This
 enables NFS to benefit from transparent parallelism in the network
 stack, such as interface bonding and receive-side scaling as described
 earlier.

 When multiple connections are available, NFS will send
 session-management requests on a single connection (the first
 connection opened) while general filesystem access requests will be
 distrubuted over all available connections.  When load is light (as
 measured by the number of outstanding requests on each connection)
 requests will be distributed in a round-robin fashion.  When the number
 of outstanding requests on any connection exceeds 2, and also exceeds
 the average across all connection, that connection will be skipping in
 the round-robin.  As flows are likely to be distributed over hardware
 in a non-fair manner (such as a hash on the port number), it is likely
 that each hardware resource might serve a different number of flows.
 Bypassing flows with above-average backlog goes some way to restoring
 fairness to the distribution of requests across hardware resources.

 In the (hopefully rare) case that a retransmit is needed for an
 (apparently) lost packet,  the same connection - or at least the same
 source port number - will be used for all retransmits.  This ensures
 that any Duplicate Reply Cache on the server has the best possible
 chance of recognizing the retransmission for what it is.  When a given
 connection breaks and needs to be re-established, pending requests on
 that connection will be resent.  Pending requests on other connections
 will not be affected.

 Trunking (as described here) is not currently supported by the Linux
 NFS client except in pNFS configurations (I think - is that right?).
 nconnect is supported and currently requires a mount option.

 If the "nonconnect" mount option is given, the nconnect is completely
 disabled to the target server.  If "nconnect=3DN" is given (for some N
 from 1 to 256) then that many connections will initially be created and
 used.  Over time, the number of connections may be increased or
 decreased depending on available resources and recent demand.  This may
 also happen if neither "nonconnect" or "nconnect=3D" is given.  However
 no design or implementation yet exists for this possibility.

 Where multiple filesystem are mounted from the same server, the
 "nconnect" option given for the first mount will apply to all mounts
 from that server.  If the option is given on subsequent mounts from the
 server, it will be silently ignored.


What doesn't that cover?
Have written it, I wonder if I should change the terminology do
distinguish between "multipath trunking" where the server IP address
varies, and "connection trunking" where the server IP address is fixed.

Suppose we do add multi-path (non-pNFS) trunking support.   Would it
make sense to have multiple connections over each path?  Would each path
benefit from the same number of connections?  How do we manage that?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl0AWh0ACgkQOeye3VZi
gbmMmg/+OPdCwRBRPVQjWe50Fdff/3LfjI61RPzb37fpsBADyBH/tUDVxDGqbyHI
ZwwooBjcu/1BnNqXpa05fnd/5zm0qY5PgoG2ipNKnRVM2BqrzzbTp4eMvhhUspFH
wDq9ONzPxjbHUcjVIoaUYMViepaNsmK0pS3EYVs7L0cdUDXVF8nLwfEfEMET/JlZ
0/52R69+fjX4ZNAJvbXJA/saQL4+CH+spuuIWHrxXpElIkWdX6ep5S3inkbwAGU5
4MFwdp1oTAaoHrLmPtcSIN6ee1HiJ47SCV8fCXUBg0ruB8HA0l9kHmyGIKbJX/rl
BHmOCrzKe4uqSi8LgE74oH+PvUz/LncOq2FkgiBj7mkrFeWjVlVAl13pL/ktes9l
JiYZY29BM1Bva4XR9IRQUfezv2LMV9IXS/YG7Buqt9zEXbusdKwVrYysE84IclDX
/sXXmpIToIHMjvcLzC4AmST2engvzJ0RWtkhnjZD0w9G8zvSY1ce73Klb0jgaSlp
9WxDI5W+ovVHyMXGVS3tyQ4OMis0Sfg86JbhDI9jC9t9GQqwxNTQYOPG3eDZnR56
MaDC0uza6rIOnj1MBxKRSKB9s37X4u0hTvH4eii8r3L8eVUWg+U7t7SRON2Xz8oW
GehsQv5b1tTO8VVDqvvY7/C4ff5ERlk7aiUb/WrgJ+czJId8I04=
=UWMb
-----END PGP SIGNATURE-----
--=-=-=--
