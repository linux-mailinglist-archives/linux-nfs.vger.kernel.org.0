Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D2630507
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 00:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfE3W42 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 18:56:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:48256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbfE3W42 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 May 2019 18:56:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8400FAD36;
        Thu, 30 May 2019 22:56:26 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 31 May 2019 08:56:19 +1000
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
In-Reply-To: <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
Message-ID: <87muj3tuuk.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, May 30 2019, Chuck Lever wrote:

> Hi Neil-
>
> Thanks for chasing this a little further.
>
>
>> On May 29, 2019, at 8:41 PM, NeilBrown <neilb@suse.com> wrote:
>>=20
>> This patch set is based on the patches in the multipath_tcp branch of
>> git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
>>=20
>> I'd like to add my voice to those supporting this work and wanting to
>> see it land.
>> We have had customers/partners wanting this sort of functionality for
>> years.  In SLES releases prior to SLE15, we've provide a
>> "nosharetransport" mount option, so that several filesystem could be
>> mounted from the same server and each would get its own TCP
>> connection.
>
> Is it well understood why splitting up the TCP connections result
> in better performance?
>
>
>> In SLE15 we are using this 'nconnect' feature, which is much nicer.
>>=20
>> Partners have assured us that it improves total throughput,
>> particularly with bonded networks, but we haven't had any concrete
>> data until Olga Kornievskaia provided some concrete test data - thanks
>> Olga!
>>=20
>> My understanding, as I explain in one of the patches, is that parallel
>> hardware is normally utilized by distributing flows, rather than
>> packets.  This avoid out-of-order deliver of packets in a flow.
>> So multiple flows are needed to utilizes parallel hardware.
>
> Indeed.
>
> However I think one of the problems is what happens in simpler scenarios.
> We had reports that using nconnect > 1 on virtual clients made things
> go slower. It's not always wise to establish multiple connections
> between the same two IP addresses. It depends on the hardware on each
> end, and the network conditions.

This is a good argument for leaving the default at '1'.  When
documentation is added to nfs(5), we can make it clear that the optimal
number is dependant on hardware.

>
> What about situations where the network capabilities between server and
> client change? Problem is that neither endpoint can detect that; TCP
> usually just deals with it.

Being able to manually change (-o remount) the number of connections
might be useful...

>
> Related Work:
>
> We now have protocol (more like conventions) for clients to discover
> when a server has additional endpoints so that it can establish
> connections to each of them.
>
> https://datatracker.ietf.org/doc/rfc8587/
>
> and
>
> https://datatracker.ietf.org/doc/draft-ietf-nfsv4-rfc5661-msns-update/
>
> Boiled down, the client uses fs_locations and trunking detection to
> figure out when two IP addresses are the same server instance.
>
> This facility can also be used to establish a connection over a
> different path if network connectivity is lost.
>
> There has also been some exploration of MP-TCP. The magic happens
> under the transport socket in the network layer, and the RPC client
> is not involved.

I would think that SCTP would be the best protocol for NFS to use as it
supports multi-streaming - several independent streams.  That would
require that hardware understands it of course.

Though I have examined MP-TCP closely, it looks like it is still fully
sequenced, so it would be tricky for two RPC messages to be assembled
into TCP frames completely independently - at least you would need
synchronization on the sequence number.

Thanks for your thoughts,
NeilBrown


>
>
>> Comments most welcome.  I'd love to see this, or something similar,
>> merged.
>>=20
>> Thanks,
>> NeilBrown
>>=20
>> ---
>>=20
>> NeilBrown (4):
>>      NFS: send state management on a single connection.
>>      SUNRPC: enhance rpc_clnt_show_stats() to report on all xprts.
>>      SUNRPC: add links for all client xprts to debugfs
>>=20
>> Trond Myklebust (5):
>>      SUNRPC: Add basic load balancing to the transport switch
>>      SUNRPC: Allow creation of RPC clients with multiple connections
>>      NFS: Add a mount option to specify number of TCP connections to use
>>      NFSv4: Allow multiple connections to NFSv4.x servers
>>      pNFS: Allow multiple connections to the DS
>>      NFS: Allow multiple connections to a NFSv2 or NFSv3 server
>>=20
>>=20
>> fs/nfs/client.c                      |    3 +
>> fs/nfs/internal.h                    |    2 +
>> fs/nfs/nfs3client.c                  |    1=20
>> fs/nfs/nfs4client.c                  |   13 ++++-
>> fs/nfs/nfs4proc.c                    |   22 +++++---
>> fs/nfs/super.c                       |   12 ++++
>> include/linux/nfs_fs_sb.h            |    1=20
>> include/linux/sunrpc/clnt.h          |    1=20
>> include/linux/sunrpc/sched.h         |    1=20
>> include/linux/sunrpc/xprt.h          |    1=20
>> include/linux/sunrpc/xprtmultipath.h |    2 +
>> net/sunrpc/clnt.c                    |   98 ++++++++++++++++++++++++++++=
++++--
>> net/sunrpc/debugfs.c                 |   46 ++++++++++------
>> net/sunrpc/sched.c                   |    3 +
>> net/sunrpc/stats.c                   |   15 +++--
>> net/sunrpc/sunrpc.h                  |    3 +
>> net/sunrpc/xprtmultipath.c           |   23 +++++++-
>> 17 files changed, 204 insertions(+), 43 deletions(-)
>>=20
>> --
>> Signature
>>=20
>
> --
> Chuck Lever

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlzwX5MACgkQOeye3VZi
gbkzVg//fdVd5kLhYulT2IlsTe/dDd5cL5zShs0k7YlJbYS5i6Z7dfJ9Z1USfT/8
fksCdMNBgN9BHx6nr6wsrcxX/j3aL/4tcrkzVaJy7UaResCHoc67ee+VCBzvXasQ
azHJ1B7Rt9/MHodoyDo0yROp2D2A2fWLd8GzxiT45upF7MaPtt+RzjG+Zq7u7MuV
26ksbUYSKnxGGi9WznQ/hlQ4Qa2xLPeiNBfqaR89P6FuOI9Q6rxxdxyexXbo3svJ
3TPr1/BCsokDl0lBUzQFLmT6DSLjF6THpRYNKLT+/vy37qsDCUGB8qVxyNJhzrAn
KLSJPINfQYxsFWRykZox9IDKx7TYR+UCrshA0aQcT8W7kwTqk/7LcOsu1soez5gs
tE6ODICO012vsLf3sZaP7mOO2vZ6TyxdDUuk9LdPO63vFJhPkbh3GKbkrhzun/3O
XsiBImQPRhMEGBSMqwmPnqvGuV+akapH6mXcn/hJeXfvFch/WOhLcWSZoNC7Exgk
YP1zyR8i+H5E3earx5mmJdh5vhz2x18xl/3+Nmo/7NL5AOgO6vNWEZcLqxNAvSN7
jNTsTy5goEKvJJE6f0YVpYIM7qqr9iW8E9PlA2Bd0UP4rR6rASWxZnUsh8/dGEfW
G+iTtw2qc8eGII585ndCA1JLMiTTChU+h1UIHKO89G5DYGZ4XkE=
=KRXW
-----END PGP SIGNATURE-----
--=-=-=--
