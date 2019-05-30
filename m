Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1248F304DA
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 00:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfE3Wiv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 18:38:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:46790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfE3Wiv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 May 2019 18:38:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A196AF70;
        Thu, 30 May 2019 22:38:49 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Tom Talpey <tom@talpey.com>, Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 31 May 2019 08:38:38 +1000
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
In-Reply-To: <9b64b9d9-b7cf-c818-28e2-58b3a821d39d@talpey.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <1df23ebc-ffe5-1a57-c40a-d5e9a45c8498@talpey.com> <CAN-5tyHUah=fAsiSLb=n__q5HxRy3qeS83evf-vB59r4cpYgsw@mail.gmail.com> <9b64b9d9-b7cf-c818-28e2-58b3a821d39d@talpey.com>
Message-ID: <87pnnztvo1.fsf@notabene.neil.brown.name>
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

On Thu, May 30 2019, Tom Talpey wrote:

> On 5/30/2019 1:20 PM, Olga Kornievskaia wrote:
>> On Thu, May 30, 2019 at 1:05 PM Tom Talpey <tom@talpey.com> wrote:
>>>
>>> On 5/29/2019 8:41 PM, NeilBrown wrote:
>>>> I've also re-arrange the patches a bit, merged two, and remove the
>>>> restriction to TCP and NFSV4.x,x>=3D1.  Discussions seemed to suggest
>>>> these restrictions were not needed, I can see no need.
>>>
>>> I believe the need is for the correctness of retries. Because NFSv2,
>>> NFSv3 and NFSv4.0 have no exactly-once semantics of their own, server
>>> duplicate request caches are important (although often imperfect).
>>> These caches use client XID's, source ports and addresses, sometimes
>>> in addition to other methods, to detect retry. Existing clients are
>>> careful to reconnect with the same source port, to ensure this. And
>>> existing servers won't change.
>>=20
>> Retries are already bound to the same connection so there shouldn't be
>> an issue of a retransmission coming from a different source port.
>
> So, there's no path redundancy? If any connection is lost and can't
> be reestablished, the requests on that connection will time out?

Path redundancy happens lower down in the stack.  Presumably a bonding
driver will divert flows to a working path when one path fails.
NFS doesn't see paths at all.  It just sees TCP connections - each with
the same source and destination address.  How these are associated, from
time to time, with different hardware is completely transparent to NFS.

>
> I think a common configuration will be two NICs and two network paths,
> a so-called shotgun. Admins will be quite frustrated to discover it
> gives no additional robustness, and perhaps even less.
>
> Why not simply restrict this to the fully-correct, fully-functional
> NFSv4.1+ scenario, and not try to paper over the shortcomings?

Because I cannot see any shortcomings in using it for v3 or v4.0.

Also, there are situations where NFSv3 is a measurably better choice
than NFSv4.1.  Al least it seems to allow a quicker failover for HA.
But that is really a topic for another day.

NeilBrown

>
> Tom.
>
>>=20
>>> Multiple connections will result in multiple source ports, and possibly
>>> multiple source addresses, meaning retried client requests may be
>>> accepted as new, rather than having any chance of being recognized as
>>> retries.
>>>
>>> NFSv4.1+ don't have this issue, but removing the restrictions would
>>> seem to break the downlevel mounts.
>>>
>>> Tom.
>>>
>>=20
>>=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlzwW24ACgkQOeye3VZi
gbkEpBAAiBZdeevvM6gYFidvs+A+gUkalKl+22YWZYUe6cY1DVJ6d5MGxy4l1Zub
UvBNc3COxQHjn8VlFPTr6rq3n9uyQlCD/sJI+944HLARBABcBLwXJ4sPBnK7R9If
dfo7c1nJUlpaUv9p+mHIDRUKuncPDnjnKKMoTbMAiPjJ03lzA5BmIh5T4JlIFWVh
DdxowSCUeA9QHn1+eEeIimvteI53HvkZaSvWmZkawUWQTkSHGJgG5Te+P2NriL1w
oNkqt4Gb75UP3FrbdmuRnox5fczDIGNKQloEeU9HypuuW+sfKX3pQUcyASawZMua
1BWg6997prHGGi/YqU9zbUrLDoXFh9omgmiP3lOC0dTBeWOB4DnCtKmzRTqnpUfO
lO4fOJUIw3NB+CDKtJ8y9cqrNjRh4uHAtvH7rEgGMIOmKZRimByiGsogvZAiKAJk
+5KPP0wycTMtVCgeuhxHxy+zm1fYxPoAztrzqwqYYas/kBxIqtYfpmf3ljcnPnwm
fxX2E0Ii2NmfEQdE5IIJQzqUID5ddpXRIUq2cwucmf9zyMKPpckn4iduoE2YsUrG
cME7moQClyO3kfxAFi1RhnoqXRbKnn4mkVqG6GiwR9ESgpm++X4NVxPzldvAWRgr
p5Lon3as/CD0e/oso9GZroe1VO7wVDCt0vQJFc+5cs7ywvd2RYQ=
=WHxQ
-----END PGP SIGNATURE-----
--=-=-=--
