Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9403C0C8
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 03:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbfFKBJN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jun 2019 21:09:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:58950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388845AbfFKBJN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 Jun 2019 21:09:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 565E7ADF7;
        Tue, 11 Jun 2019 01:09:11 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Date:   Tue, 11 Jun 2019 11:09:04 +1000
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
In-Reply-To: <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com> <87muj3tuuk.fsf@notabene.neil.brown.name> <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
Message-ID: <87lfy9vsgf.fsf@notabene.neil.brown.name>
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

On Fri, May 31 2019, Chuck Lever wrote:

>> On May 30, 2019, at 6:56 PM, NeilBrown <neilb@suse.com> wrote:
>>=20
>> On Thu, May 30 2019, Chuck Lever wrote:
>>=20
>>> Hi Neil-
>>>=20
>>> Thanks for chasing this a little further.
>>>=20
>>>=20
>>>> On May 29, 2019, at 8:41 PM, NeilBrown <neilb@suse.com> wrote:
>>>>=20
>>>> This patch set is based on the patches in the multipath_tcp branch of
>>>> git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
>>>>=20
>>>> I'd like to add my voice to those supporting this work and wanting to
>>>> see it land.
>>>> We have had customers/partners wanting this sort of functionality for
>>>> years.  In SLES releases prior to SLE15, we've provide a
>>>> "nosharetransport" mount option, so that several filesystem could be
>>>> mounted from the same server and each would get its own TCP
>>>> connection.
>>>=20
>>> Is it well understood why splitting up the TCP connections result
>>> in better performance?
>>>=20
>>>=20
>>>> In SLE15 we are using this 'nconnect' feature, which is much nicer.
>>>>=20
>>>> Partners have assured us that it improves total throughput,
>>>> particularly with bonded networks, but we haven't had any concrete
>>>> data until Olga Kornievskaia provided some concrete test data - thanks
>>>> Olga!
>>>>=20
>>>> My understanding, as I explain in one of the patches, is that parallel
>>>> hardware is normally utilized by distributing flows, rather than
>>>> packets.  This avoid out-of-order deliver of packets in a flow.
>>>> So multiple flows are needed to utilizes parallel hardware.
>>>=20
>>> Indeed.
>>>=20
>>> However I think one of the problems is what happens in simpler scenario=
s.
>>> We had reports that using nconnect > 1 on virtual clients made things
>>> go slower. It's not always wise to establish multiple connections
>>> between the same two IP addresses. It depends on the hardware on each
>>> end, and the network conditions.
>>=20
>> This is a good argument for leaving the default at '1'.  When
>> documentation is added to nfs(5), we can make it clear that the optimal
>> number is dependant on hardware.
>
> Is there any visibility into the NIC hardware that can guide this setting?
>

I doubt it, partly because there is more than just the NIC hardware at
issue.
There is also the server-side hardware and possibly hardware in the
middle.


>
>>> What about situations where the network capabilities between server and
>>> client change? Problem is that neither endpoint can detect that; TCP
>>> usually just deals with it.
>>=20
>> Being able to manually change (-o remount) the number of connections
>> might be useful...
>
> Ugh. I have problems with the administrative interface for this feature,
> and this is one of them.
>
> Another is what prevents your client from using a different nconnect=3D
> setting on concurrent mounts of the same server? It's another case of a
> per-mount setting being used to control a resource that is shared across
> mounts.

I think that horse has well and truly bolted.
It would be nice to have a "server" abstraction visible to user-space
where we could adjust settings that make sense server-wide, and then a way
to mount individual filesystems from that "server" - but we don't.

Probably the best we can do is to document (in nfs(5)) which options are
per-server and which are per-mount.

>
> Adding user tunables has never been known to increase the aggregate
> amount of happiness in the universe. I really hope we can come up with
> a better administrative interface... ideally, none would be best.

I agree that none would be best.  It isn't clear to me that that is
possible.
At present, we really don't have enough experience with this
functionality to be able to say what the trade-offs are.
If we delay the functionality until we have the perfect interface,
we may never get that experience.

We can document "nconnect=3D" as a hint, and possibly add that
"nconnect=3D1" is a firm guarantee that more will not be used.
Then further down the track, we might change the actual number of
connections automatically if a way can be found to do that without cost.

Do you have any objections apart from the nconnect=3D mount option?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlz+/zAACgkQOeye3VZi
gblp1A/+J4rOOdFelHHlQ8pgaPpSagQHha0jWX39cpscHi4MpEyM3uLL43mg7IRQ
2F6K/4aELuvJ2FVT8SsdPyVtgg09kLV8X+JGGRQqKo2gBmTtIxPRHSxNthYWMiWB
ww32kfXU1Dhyp8YNH33CiCEW7eg+/a1JFLIx5RaluCwGaN8/qC97tGX/rHFvkcrH
fNf2J8QCVNSfw4eCatXo0kPM+6zqrJHhMTDbp3hvqmtr2u5O3qu8Rmh3ZasDVtbB
NB1aSpmkEZ8H6PKSRLCNibX8O+tSGIEjO/RMeAl/TNtyZGTNiUWzQc/ymwdrfi9k
AKXWgoApNfrrhSSChdLSBXSbjfEGdLMuNv2cpnp7DIEdZIym0kebQqB2h8FQ6/mP
3ck6pKvRjGCRVfZpsKKAsU8ysrdNUqmeMZC8arhyk95EM+2ZN5UvbCv9b0l4P7Gt
AIHiOZZTDeF4DbXtF/YWXEs2mDs9XqEPSvPOiUdmeX5zs64UHQb3G0xSNThaxTxZ
cY5asCimharEq/Cf0c8tUIiNOLR+eBT4Bw1VQAVjuYsZPf/79GnhAOngjQKux0ip
ENqu3VSzVaOmlixB18ToBBLBV/+FMX9ZxYGCRHwOyvwvyA+0UxZPWASz0tbHM5Sb
i3S8znOf4ph2AzoJAks7XgzPKktKgsPcMVYnKGPn/d57dZ/yOow=
=Btrm
-----END PGP SIGNATURE-----
--=-=-=--
