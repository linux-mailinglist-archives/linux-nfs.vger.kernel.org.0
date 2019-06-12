Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B20F447BA
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2019 19:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfFMRBd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jun 2019 13:01:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:46876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729655AbfFLXiC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Jun 2019 19:38:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23DE9AD78;
        Wed, 12 Jun 2019 23:38:00 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 13 Jun 2019 09:37:52 +1000
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
In-Reply-To: <412B8D10-6CE6-4FF4-8479-C93D00F0F039@oracle.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com> <87muj3tuuk.fsf@notabene.neil.brown.name> <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com> <87lfy9vsgf.fsf@notabene.neil.brown.name> <3B887552-91FB-493A-8FDF-411562811B36@oracle.com> <874l4vwp2a.fsf@notabene.neil.brown.name> <412B8D10-6CE6-4FF4-8479-C93D00F0F039@oracle.com>
Message-ID: <87r27yv0hb.fsf@notabene.neil.brown.name>
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

On Wed, Jun 12 2019, Chuck Lever wrote:

> Hi Neil-
>
>
>> On Jun 11, 2019, at 9:49 PM, NeilBrown <neilb@suse.com> wrote:
>>=20
>> On Tue, Jun 11 2019, Chuck Lever wrote:
>>=20
>>> Hi Neil-
>>>=20
>>>=20
>>>> On Jun 10, 2019, at 9:09 PM, NeilBrown <neilb@suse.com> wrote:
>>>>=20
>>>> On Fri, May 31 2019, Chuck Lever wrote:
>>>>=20
>>>>>> On May 30, 2019, at 6:56 PM, NeilBrown <neilb@suse.com> wrote:
>>>>>>=20
>>>>>> On Thu, May 30 2019, Chuck Lever wrote:
>>>>>>=20
>>>>>>> Hi Neil-
>>>>>>>=20
>>>>>>> Thanks for chasing this a little further.
>>>>>>>=20
>>>>>>>=20
>>>>>>>> On May 29, 2019, at 8:41 PM, NeilBrown <neilb@suse.com> wrote:
>>>>>>>>=20
>>>>>>>> This patch set is based on the patches in the multipath_tcp branch=
 of
>>>>>>>> git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
>>>>>>>>=20
>>>>>>>> I'd like to add my voice to those supporting this work and wanting=
 to
>>>>>>>> see it land.
>>>>>>>> We have had customers/partners wanting this sort of functionality =
for
>>>>>>>> years.  In SLES releases prior to SLE15, we've provide a
>>>>>>>> "nosharetransport" mount option, so that several filesystem could =
be
>>>>>>>> mounted from the same server and each would get its own TCP
>>>>>>>> connection.
>>>>>>>=20
>>>>>>> Is it well understood why splitting up the TCP connections result
>>>>>>> in better performance?
>>>>>>>=20
>>>>>>>=20
>>>>>>>> In SLE15 we are using this 'nconnect' feature, which is much nicer.
>>>>>>>>=20
>>>>>>>> Partners have assured us that it improves total throughput,
>>>>>>>> particularly with bonded networks, but we haven't had any concrete
>>>>>>>> data until Olga Kornievskaia provided some concrete test data - th=
anks
>>>>>>>> Olga!
>>>>>>>>=20
>>>>>>>> My understanding, as I explain in one of the patches, is that para=
llel
>>>>>>>> hardware is normally utilized by distributing flows, rather than
>>>>>>>> packets.  This avoid out-of-order deliver of packets in a flow.
>>>>>>>> So multiple flows are needed to utilizes parallel hardware.
>>>>>>>=20
>>>>>>> Indeed.
>>>>>>>=20
>>>>>>> However I think one of the problems is what happens in simpler scen=
arios.
>>>>>>> We had reports that using nconnect > 1 on virtual clients made thin=
gs
>>>>>>> go slower. It's not always wise to establish multiple connections
>>>>>>> between the same two IP addresses. It depends on the hardware on ea=
ch
>>>>>>> end, and the network conditions.
>>>>>>=20
>>>>>> This is a good argument for leaving the default at '1'.  When
>>>>>> documentation is added to nfs(5), we can make it clear that the opti=
mal
>>>>>> number is dependant on hardware.
>>>>>=20
>>>>> Is there any visibility into the NIC hardware that can guide this set=
ting?
>>>>>=20
>>>>=20
>>>> I doubt it, partly because there is more than just the NIC hardware at=
 issue.
>>>> There is also the server-side hardware and possibly hardware in the mi=
ddle.
>>>=20
>>> So the best guidance is YMMV. :-)
>>>=20
>>>=20
>>>>>>> What about situations where the network capabilities between server=
 and
>>>>>>> client change? Problem is that neither endpoint can detect that; TCP
>>>>>>> usually just deals with it.
>>>>>>=20
>>>>>> Being able to manually change (-o remount) the number of connections
>>>>>> might be useful...
>>>>>=20
>>>>> Ugh. I have problems with the administrative interface for this featu=
re,
>>>>> and this is one of them.
>>>>>=20
>>>>> Another is what prevents your client from using a different nconnect=
=3D
>>>>> setting on concurrent mounts of the same server? It's another case of=
 a
>>>>> per-mount setting being used to control a resource that is shared acr=
oss
>>>>> mounts.
>>>>=20
>>>> I think that horse has well and truly bolted.
>>>> It would be nice to have a "server" abstraction visible to user-space
>>>> where we could adjust settings that make sense server-wide, and then a=
 way
>>>> to mount individual filesystems from that "server" - but we don't.
>>>=20
>>> Even worse, there will be some resource sharing between containers that
>>> might be undesirable. The host should have ultimate control over those
>>> resources.
>>>=20
>>> But that is neither here nor there.
>>>=20
>>>=20
>>>> Probably the best we can do is to document (in nfs(5)) which options a=
re
>>>> per-server and which are per-mount.
>>>=20
>>> Alternately, the behavior of this option could be documented this way:
>>>=20
>>> The default value is one. To resolve conflicts between nconnect setting=
s on
>>> different mount points to the same server, the value set on the first m=
ount
>>> applies until there are no more mounts of that server, unless noshareca=
che
>>> is specified. When following a referral to another server, the nconnect
>>> setting is inherited, but the effective value is determined by other mo=
unts
>>> of that server that are already in place.
>>>=20
>>> I hate to say it, but the way to make this work deterministically is to
>>> ask administrators to ensure that the setting is the same on all mounts
>>> of the same server. Again I'd rather this take care of itself, but it
>>> appears that is not going to be possible.
>>>=20
>>>=20
>>>>> Adding user tunables has never been known to increase the aggregate
>>>>> amount of happiness in the universe. I really hope we can come up with
>>>>> a better administrative interface... ideally, none would be best.
>>>>=20
>>>> I agree that none would be best.  It isn't clear to me that that is
>>>> possible.
>>>> At present, we really don't have enough experience with this
>>>> functionality to be able to say what the trade-offs are.
>>>> If we delay the functionality until we have the perfect interface,
>>>> we may never get that experience.
>>>>=20
>>>> We can document "nconnect=3D" as a hint, and possibly add that
>>>> "nconnect=3D1" is a firm guarantee that more will not be used.
>>>=20
>>> Agree that 1 should be the default. If we make this setting a
>>> hint, then perhaps it should be renamed; nconnect makes it sound
>>> like the client will always open N connections. How about "maxconn" ?
>>>=20
>>> Then, to better define the behavior:
>>>=20
>>> The range of valid maxconn values is 1 to 3? to 8? to NCPUS? to the
>>> count of the client=E2=80=99s NUMA nodes? I=E2=80=99d be in favor of a =
small number
>>> to start with. Solaris' experience with multiple connections is that
>>> there is very little benefit past 8.
>>>=20
>>> If maxconn is specified with a datagram transport, does the mount
>>> operation fail, or is the setting is ignored?
>>=20
>> With Trond's patches, the setting is ignored (as he said in a reply).
>> With my version, the setting is honoured.
>> Specifically, 'n' separate UDP sockets are created, each bound to a
>> different local port, each sending to the same server port.
>> If a bonding driver is using the source-port in the output hash
>> (xmit_policy=3Dlayer3+4 in the terminology of
>> linux/Documentation/net/bonding.txt),
>> then this would get better throughput over bonded network interfaces.
>
> One assumes the server end is careful to send a reply back
> to the same client UDP source port from whence came the
> matching request?
>
>
>>> If maxconn is a hint, when does the client open additional
>>> connections?
>>>=20
>>> IMO documentation should be clear that this setting is not for the
>>> purpose of multipathing/trunking (using multiple NICs on the client
>>> or server). The client has to do trunking detection/discovery in that
>>> case, and nconnect doesn't add that logic. This is strictly for
>>> enabling multiple connections between one client-server IP address
>>> pair.
>>>=20
>>> Do we need to state explicitly that all transport connections for a
>>> mount (or client-server pair) are the same connection type (i.e., all
>>> TCP or all RDMA, never a mix)?
>>>=20
>>>=20
>>>> Then further down the track, we might change the actual number of
>>>> connections automatically if a way can be found to do that without cos=
t.
>>>=20
>>> Fair enough.
>>>=20
>>>=20
>>>> Do you have any objections apart from the nconnect=3D mount option?
>>>=20
>>> Well I realize my last e-mail sounded a little negative, but I'm
>>> actually in favor of adding the ability to open multiple connections
>>> per client-server pair. I just want to be careful about making this
>>> a feature that has as few downsides as possible right from the start.
>>> I'll try to be more helpful in my responses.
>>>=20
>>> Remaining implementation issues that IMO need to be sorted:
>>>=20
>>> =E2=80=A2 We want to take care that the client can recover network reso=
urces
>>> that have gone idle. Can we reuse the auto-close logic to close extra
>>> connections?
>>=20
>> Were you aware that auto-close was ineffective with NFSv4 as the regular
>> RENEW (or SEQUENCE for v4.1) keeps a connection open?
>> My patches already force session management requests onto a single xprt.
>> It probably makes sense to do the same for RENEW and SEQUENCE.
>> Then when there is no fs activity, the other connections will close.
>> There is no mechanism to re-open only some of them though.  Any
>> non-trivial amount of traffic will cause all connection to re-open.
>
> This seems sensible.
>
>
>>> =E2=80=A2 How will the client schedule requests on multiple connections?
>>> Should we enable the use of different schedulers?
>>> =E2=80=A2 How will retransmits be handled?
>>> =E2=80=A2 How will the client recover from broken connections? Today's =
clients
>>> use disconnect to determine when to retransmit, thus there might be
>>> some unwanted interactions here that result in mount hangs.
>>> =E2=80=A2 Assume NFSv4.1 session ID rather than client ID trunking: is =
Linux
>>> client support in place for this already?
>>> =E2=80=A2 Are there any concerns about how the Linux server DRC will be=
have in
>>> multi-connection scenarios?
>>>=20
>>> None of these seem like a deal breaker. And possibly several of these
>>> are already decided, but just need to be published/documented.
>>=20
>> How about this:
>
> Thanks for writing this up.
>
>
>> NFS normally sends all requests to the server (and receives all replies)
>> over a single network connection, whether TCP, RDMA or (for NFSv3 and
>> earlier) UDP.  Often this is sufficient to utilize all available
>> network bandwidth, but not always.  When there is sufficient
>> parallelism in the server, the client, and the network connection, the
>> restriction to a single TCP stream can become a limitation.
>>=20
>> A simple scenario which portrays this limitation involves several
>> direct network connections between client and server where the multiple
>> interfaces on each end are bonded together.  If this bonding diverts
>> different flows to different interfaces, then a single TCP connection
>> will be limited to a single network interface, while multiple
>> connections could make use of all interfaces.  Various other scenarios
>> are possible including network controllers with multiple DMA/TSO
>> engines where a given flow can only be associated with a single engine
>> at a time, or Receive-side scaling which can direct different flows to
>> different receive queues and thence to different CPU cores.
>>=20
>> NFS has two distinct and complementary mechanisms to enable the use of
>> multiple connections to carry requests and replies.  We will refer to
>> these as trunking and nconnect, though the NFS RFCs use the term
>> "trunking" in a way that covers both.
>>=20
>> With trunking (also known as multipathing), the server-side IP address
>> of each connection is different.  RFC8587 (and other documents)
>> describe how a client can determine if two connections to different
>> addresses actually refer to the same server and so can be used for
>> trunking. The client can use explicit configuration, possibly using
>> the NFSv4 `fs_locations` attribute, to find the different addresses,
>> and can then establish multiple trunks.  With trunking, the different
>> connections could conceivably be over different protocols, both TCP and
>> RDMA for example.  Trunking makes use of explicit parallelism in the
>> network configuration.
>>=20
>> With nconnect, both the client and server side IP addresses are the
>> same on each connection, but the client side port number varies.
>
> Note that the client IP source port number is not relevant for RDMA
> connections. Multiple connections to the same service are de-
> multiplexed using other means.
>
> So then the goal of nconnect is specifically to enable multiple
> independent flows between the same two network endpoints.

Yes, focusing on "independent flows" is likely to be best.  Multiple
ports must be just an example.

>
> Note that a server is also responsible for detecting when two
> unique IP addresses are the same client for purposes of open/lock
> state recovery. It's possible that the same client IP address can
> host multiple NFS client instances each at different source ports.
>
> NFSv4 has protocol to do this (SETCLIENTID and EXCHANGE_ID), but
> NFSv2/3 do not. This is one reason why Tom has been counseling
> caution about multichannel NFSv2/3. Perhaps that is only an issue
> for NLM, which is already a separate connection...
>

I don't think there are any interesting issues here.  NLM and STATMON
remain separate for NFSv3 and don't change their behaviour at all.
NFSv3 has no concept of clients, only of permissions associated with
each individual request.  The server cannot differentiate between
requests from different (privileged) ports on the same client.

It is really the client that has responsibility for identifying itself.
The server only needs to reliably track whatever the client claims.

>
>> This enables NFS to benefit from transparent parallelism in the network
>> stack, such as interface bonding and receive-side scaling as described
>> earlier.
>>=20
>> When multiple connections are available, NFS will send
>> session-management requests on a single connection (the first
>> connection opened)
>
> Maybe you meant "lease management" requests?

Probably I do .... though maybe I can be forgiven for mistakenly
thinking that CREATE_SESSION and DESTROY_SESSION could be described as
"session management" :-)

>
> EXCHANGE_ID, RECLAIM_COMPLETE, CREATE_SESSION, DESTROY_SESSION
> and DESTROY_CLIENTID will of course go over the main connection.
> However, each connection will need to use BIND_CONN_TO_SESSION
> to join an existing session. That's how the server knows
> the additional connections are from a client instance it has
> already recognized.
>
> For NFSv4.0, SETCLIENTID, SETCLIENTID_CONFIRM, and RENEW
> would go over the main connection (and those have nothing to do
> with sessions).

Well.... they have nothing to do with NFSv4.1 Sessions.
But it is useful to have a name for the collection of RPCs related to a
particular negotiated clientid, and "session" (small 's') seems as good
a name as any....

>
>
>> while general filesystem access requests will be
>> distrubuted over all available connections.  When load is light (as
>> measured by the number of outstanding requests on each connection)
>> requests will be distributed in a round-robin fashion.  When the number
>> of outstanding requests on any connection exceeds 2, and also exceeds
>> the average across all connection, that connection will be skipping in
>> the round-robin.  As flows are likely to be distributed over hardware
>> in a non-fair manner (such as a hash on the port number), it is likely
>> that each hardware resource might serve a different number of flows.
>> Bypassing flows with above-average backlog goes some way to restoring
>> fairness to the distribution of requests across hardware resources.
>>=20
>> In the (hopefully rare) case that a retransmit is needed for an
>> (apparently) lost packet,  the same connection - or at least the same
>> source port number - will be used for all retransmits.  This ensures
>> that any Duplicate Reply Cache on the server has the best possible
>> chance of recognizing the retransmission for what it is.  When a given
>> connection breaks and needs to be re-established, pending requests on
>> that connection will be resent.  Pending requests on other connections
>> will not be affected.
>
> I'm having trouble with several points regarding retransmission.
>
> 1. Retransmission is also used to recover when a server or its
> backend storage drops a request. An NFSv3 server is permitted by
> spec to drop requests without notifying clients. That's a nit with
> your write-up, but...

Only if you think that when a server drops a request, it isn't "lost".

>
> 2. An NFSv4 server MUST NOT drop requests; if it ever does it is
> required to close the connection to force the client to retransmit.
> In fact, current clients depend on connection loss to know when
> to retransmit. Both Linux and Solaris no longer use retransmit
> timeouts to trigger retransmit; they will only retransmit after
> connection loss.
>
> 2a. IMO the spec is written such that a client is allowed to send
> a retransmission on another connection that already exists. But
> maybe that is not what we want to implement.

It certainly isn't what we *do* implement.
For v3 and v4.0, I think it is best to use the same xprt - which may or
may not be the same connection, but does have the same port numbers.
For v4.1 it might make sense to use another xprt if that is easy to impleme=
nt.

>
> 3. RPC/RDMA clients always drop the connection before retransmitting
> because they have to reset the connection's credit accounting.
>
> 4. RPC/RDMA cannot depend on IP source port, because the RPC part
> of the stack has no visibility into the choice of source port that
> is chosen. Thus the server's DRC cannot use the source port. I
> think server DRC's need to be prepared to deal with multiple client
> connections.

OK, that could be an issue.
Linux uses an independent xid sequence for each xprt, so two separate
xprts can easily use the same xid for different requests.
If RDMA cannot see the source port, it might depend more on the xid and
so risk getting confused.

There was a patch floating around which reserved a few bits of the xid
for an xprt index to ensure all xids were unique, but Trond didn't like
sub-dividing the xid space (which is fair enough).
So maybe it isn't safe to use nconnect with RDMA and protocol versions
earlier than 4.1.

>
> 5. The DRC (and thus considerations about the client IP source port)
> does not come into play for NFSv4.1 sessions.
>
>
>> Trunking (as described here) is not currently supported by the Linux
>> NFS client except in pNFS configurations (I think - is that right?).
>> nconnect is supported and currently requires a mount option.
>>=20
>> If the "nonconnect" mount option is given, the nconnect is completely
>> disabled to the target server.  If "nconnect=3DN" is given (for some N
>> from 1 to 256) then that many connections will initially be created and
>> used.  Over time, the number of connections may be increased or
>> decreased depending on available resources and recent demand.  This may
>> also happen if neither "nonconnect" or "nconnect=3D" is given.  However
>> no design or implementation yet exists for this possibility.
>
> See my e-mail from earlier today on mount option behavior.
>
> I prefer "nconnect=3D1" to "nonconnect"....
>
>
>> Where multiple filesystem are mounted from the same server, the
>> "nconnect" option given for the first mount will apply to all mounts
>> from that server.  If the option is given on subsequent mounts from the
>> server, it will be silently ignored.
>>=20
>>=20
>> What doesn't that cover?
>> Have written it, I wonder if I should change the terminology do
>> distinguish between "multipath trunking" where the server IP address
>> varies, and "connection trunking" where the server IP address is fixed.
>
> I agree that the write-up needs to be especially careful about
> terminology.
>
> "multi-path trunking" is probably not appropriate, but "connection
> trunking" might be close. I used "multi-flow" above, fwiw.

Why not "multi-path trunking" when the server IP varies?
I like "multi-flow trunking" when the server IP doesn't change!

Maybe the mount option should be flows=3DN ??

Thanks a lot,
NeilBrown


>
>
>> Suppose we do add multi-path (non-pNFS) trunking support.   Would it
>> make sense to have multiple connections over each path?
>
> IMO, yes.
>
>> Would each path benefit from the same number of connections?
>
> Probably not, the client will need to have some mechanism for
> deciding how many connections to open for each trunk, or it
> will have to use a fixed number (like nconnect).
>
>
>> How do we manage that?
>
> Presumably via the same mechanism that the client would use
> to determine how many connections to open for a single pair
> of endpoints.
>
> Actually I suspect that for pNFS file and flexfile layouts,
> the client will want to use multi-flow when communicating
> with DS's. So this future may be here pretty quickly.
>
>
> --
> Chuck Lever

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl0BjNAACgkQOeye3VZi
gbmNkg//fqVPWoPRlBvKeDgNhuksuHO2d1q267fWDct6giHFVLWr0liVDw1VH+C0
c2nDPRHldIeAkzhQ28vi+lkdnjYhPn8Eklyl81XHGVQLAE/1Mm03a7wJy4dIkLih
3jZwATocLvAzCpqFFcoefoVsRia+FSybp7u3sBFWJNZY0motLqzQx4Ek8rtmU4St
bbR24x8kq52AoALS2Rv7+hQMcbtVw6J+PcIM75EOArKkp4JK4aOEpJ1XDDlV0VRF
fDLrGkfRisGOO0oeCuPtd3d8RqconWXf7WueczJ+NdcoOWHZaBfoiegsnJy6/ZK6
aO4WXKlwGuBwy7uKPhh4fleEY7I92hiPRUFido4uZ8cfUmnddohVCLFubCmdE1n8
7QE6X6clFnieJX3b6IDRd14AchFI3/v+v1JfhTbWX6FZdbFh0ULWZikCqCOUDKdU
m8dXqnrXICfg+OeqondiRIbBc2JW7ABfOBzj562ITymkI37cPDSay/3yNOHbMNh8
vVSnsxewyx4MKCsg4kY8mZpeLjT5aetkPYsLD34j5vw5IkN3D5VgM6pmnbWKvji7
nlsMHCYmhnK88FkbEkSNLQSUmYJAIwZYyveSJQpoFMSQ3yeQSFG7SKdU4CMTRiN4
F+grp9jgTdavWAR863btWg7mRUhx8Gkcohh+AQxgsFHmkQom2GY=
=FdZF
-----END PGP SIGNATURE-----
--=-=-=--
