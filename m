Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD6306AE
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 04:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEaCbL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 22:31:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:40592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbfEaCbL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 May 2019 22:31:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E09CEAF46;
        Fri, 31 May 2019 02:31:09 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Tom Talpey <tom@talpey.com>, Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 31 May 2019 12:31:02 +1000
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
In-Reply-To: <f44dd718-6e4c-d068-f24a-9949cda5c2e8@talpey.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <1df23ebc-ffe5-1a57-c40a-d5e9a45c8498@talpey.com> <CAN-5tyHUah=fAsiSLb=n__q5HxRy3qeS83evf-vB59r4cpYgsw@mail.gmail.com> <9b64b9d9-b7cf-c818-28e2-58b3a821d39d@talpey.com> <87pnnztvo1.fsf@notabene.neil.brown.name> <f44dd718-6e4c-d068-f24a-9949cda5c2e8@talpey.com>
Message-ID: <87ef4fxsm1.fsf@notabene.neil.brown.name>
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

> On 5/30/2019 6:38 PM, NeilBrown wrote:
>> On Thu, May 30 2019, Tom Talpey wrote:
>>=20
>>> On 5/30/2019 1:20 PM, Olga Kornievskaia wrote:
>>>> On Thu, May 30, 2019 at 1:05 PM Tom Talpey <tom@talpey.com> wrote:
>>>>>
>>>>> On 5/29/2019 8:41 PM, NeilBrown wrote:
>>>>>> I've also re-arrange the patches a bit, merged two, and remove the
>>>>>> restriction to TCP and NFSV4.x,x>=3D1.  Discussions seemed to suggest
>>>>>> these restrictions were not needed, I can see no need.
>>>>>
>>>>> I believe the need is for the correctness of retries. Because NFSv2,
>>>>> NFSv3 and NFSv4.0 have no exactly-once semantics of their own, server
>>>>> duplicate request caches are important (although often imperfect).
>>>>> These caches use client XID's, source ports and addresses, sometimes
>>>>> in addition to other methods, to detect retry. Existing clients are
>>>>> careful to reconnect with the same source port, to ensure this. And
>>>>> existing servers won't change.
>>>>
>>>> Retries are already bound to the same connection so there shouldn't be
>>>> an issue of a retransmission coming from a different source port.
>>>
>>> So, there's no path redundancy? If any connection is lost and can't
>>> be reestablished, the requests on that connection will time out?
>>=20
>> Path redundancy happens lower down in the stack.  Presumably a bonding
>> driver will divert flows to a working path when one path fails.
>> NFS doesn't see paths at all.  It just sees TCP connections - each with
>> the same source and destination address.  How these are associated, from
>> time to time, with different hardware is completely transparent to NFS.
>
> But, you don't propose to constrain this to bonded connections. So
> NFS will create connections on whatever collection of NICs which are
> locally, and if these aren't bonded, well, the issues become visible.

If a client had multiple network interfaces with different addresses,
and several of them had routes to the selected server IP, then this
might result in the multiple connections to the server having different
local addresses (as well as different local ports) - I don't know the
network layer well enough to be sure if this is possible, but it seems
credible.

If one of these interfaces then went down, and there was no automatic
routing reconfiguration in place to restore connectivity through a
different interface, then the TCP connection would timeout and break.
The xprt would then try to reconnect using the same source port and
destination address - it doesn't provide an explicit source address, but
lets the network layer provide one.
This would presumably result in a connection with a different source
address.  So requests would continue to flow on the xprt, but they might
miss the DRC as the source address would be different.

If you have a configuration like this (multi-homed client with
multiple interfaces that can reach the server with equal weight), then
you already have a possible problem of missing the DRC if one interface
goes down a new connection is established from another one.  nconnect
doesn't change that.

So I still don't see any problem.

If I've misunderstood you, please provide a detailed description of the
sort of configuration where you think a problem might arise.

>
> BTW, RDMA NICs are never bonded.

I've come across the concept of "Multi-Rail", but I cannot say that I
fully understand it yet.  I suspect you would need more than nconnect to
make proper use of multi-rail RDMA

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlzwkeYACgkQOeye3VZi
gblhzQ//R0DUo+syjAS9hjA2pteJs4obvnXxueQpu//4OU+Lk1SxV/Lu991AiR98
I2di7qNWNLAFJgKuRcgF7b4VjikJ8VQwPeP/2tfOKuIlQUvLrJTT2YNupQXV/poj
9r0rjaXnOtNOnrwZ0nBf5nu6/yk2I6IcoU3W3Xpe04cxPQiRtBqfadWQ8oyWiVQ0
85QqgyrGMsuwUGKMyRuuYtf7UCeTmI3Ym0+V3bF1KrWxY1EjjygT5aiuBLANVDDH
SoJkMDpU54J9c7ji/fWTxgVnbQsOnYPczkNcOOoDb/alWi65R6b6nl72z/YFqc9f
pjPdQdNKqXlzbEn9Hkpzbw5oMYUw5U1DoqaksXm+CTBL5epwFNvEZsP7GelD97DT
dq4y5PEw/f+byaHl5sS8N32UFoDxIzXNwKSdJhXF2Cy1CyUeN6pmFRxoXowQ7wtW
xSPFV5JVxon4G1YLo476dzEhd6OLxb3FC/202+i8pw8M7LKYxu6b3J+KQc+m8YGz
yuOWexVJ0TNoj+j2tUkI0YntWi7VHbKMp955e+tq3RV5rDbXzuIAdg4GjRPyfYGa
DcwGZ0n/mI4FZOPWM+y7HBiWSbO4c9kH9B18bprOvAw5VI9cXPtV7gkXIZj6ZZ7G
VqK9OznymcG8bcaMI1O1L17NLf5YyIO4pH+WJNGt8fN5ClI6oWM=
=qFEY
-----END PGP SIGNATURE-----
--=-=-=--
