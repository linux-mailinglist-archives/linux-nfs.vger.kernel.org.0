Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAC2127519
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Dec 2019 06:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfLTFUI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Dec 2019 00:20:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:46356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfLTFUI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 20 Dec 2019 00:20:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A9F49AE19;
        Fri, 20 Dec 2019 05:20:05 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna.schumaker\@netapp.com" <anna.schumaker@netapp.com>
Date:   Fri, 20 Dec 2019 16:19:56 +1100
Cc:     "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/RFC] NFS: handle NFSv4.1 server that doesn't support NFS4_OPEN_CLAIM_DELEG_CUR_FH
In-Reply-To: <9f5f220e64245d7f1b0359149876b5dc056dcf12.camel@hammerspace.com>
References: <87y2v9fdz8.fsf@notabene.neil.brown.name> <3afd2d5c631d8e3429e025e204a7b1c95b3c1415.camel@hammerspace.com> <87v9qdf2gh.fsf@notabene.neil.brown.name> <d3299fefa94d6959d848b765ce60e2467ce1b253.camel@hammerspace.com> <87pngkg9ga.fsf@notabene.neil.brown.name> <9f5f220e64245d7f1b0359149876b5dc056dcf12.camel@hammerspace.com>
Message-ID: <87lfr7fu9v.fsf@notabene.neil.brown.name>
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

On Thu, Dec 19 2019, Trond Myklebust wrote:

> On Thu, 2019-12-19 at 16:39 +1100, NeilBrown wrote:
>> On Thu, Dec 19 2019, Trond Myklebust wrote:
>>=20
>> > On Thu, 2019-12-19 at 13:56 +1100, NeilBrown wrote:
>> > > On Wed, Dec 18 2019, Trond Myklebust wrote:
>> > >=20
>> > > > On Thu, 2019-12-19 at 09:47 +1100, NeilBrown wrote:
>> > > > > If an NFSv4.1 server doesn't support
>> > > > > NFS4_OPEN_CLAIM_DELEG_CUR_FH
>> > > > > (e.g. Linux 3.0), and a newer NFS client tries to use it to
>> > > > > claim
>> > > > > an open before returning a delegation, the server might
>> > > > > return
>> > > > > NFS4ERR_BADXDR.
>> > > > > That is what Linux 3.0 does, though the RFC doesn't seem to
>> > > > > be
>> > > > > explicit
>> > > > > on which flags must be supported, and what error can be
>> > > > > returned
>> > > > > for
>> > > > > unsupported flags.
>> > > >=20
>> > > > NFS4ERR_BADXDR is defined in RFC5661, section 15.1.1.1 as
>> > > > meaning
>> > > >=20
>> > > > "The arguments for this operation do not match those specified
>> > > > in
>> > > > the
>> > > > XDR definition."
>> > > >=20
>> > > > That's clearly not the case here, so I'd chalk this down to a
>> > > > fairly
>> > > > blatant server bug, at which point it makes no sense to fix it
>> > > > in
>> > > > the
>> > > > client.
>> > >=20
>> > > Ok, but the RFC seems to suggest it is OK to not support this
>> > > flag,
>> > > so
>> > > suppose I fixed the server to return NFS4ERR_NOTSUPP instead.
>> > > The client still wouldn't handle this response gracefully.
>> > >=20
>> >=20
>> > NFS4ERR_NOTSUPP is wrong too as the OPEN operation is clearly
>> > supported. The only error that might make sense is NFS4ERR_INVAL:
>> >=20
>> > "15.1.1.4.  NFS4ERR_INVAL (Error Code 22)
>> >=20
>> >    The arguments for this operation are not valid for some reason,
>> > even
>> >    though they do match those specified in the XDR definition for
>> > the
>> >    request."
>> >=20
>> > That said, why do we care about supporting NFSv4.1 on this server?
>> > It
>> > is clearly broken.
>>=20
>> I care about it because a customer has a support contract, but that
>> isn't your problem.
>>=20
>> I would think "we" care about it because we want to support the spec,
>> and the spec (RFC 5661 section 2.4) says:
>>=20
>>                                                         where the
>> server
>>    supports neither the CLAIM_DELEGATE_PREV nor CLAIM_DELEG_CUR_FH
>> claim
>>    types
>
> Given the context, I think that is actually a typo. It looks to me like
> it is talking about CLAIM_DELEGATE_PREV and CLAIM_DELEG_PREV_FH, since
> otherwise the talk about releasing delegation state when establishing a
> new lease makes no sense.

Hmmm.. Yes, that's believable.

>
>
>> Also you have code in the client to handle the possibility that an
>> NFSv4.1 or later server might not handle some features of OPEN.
>> Three separate features are grouped under "NFS_CAP_ATOMIC_OPEN_V1":
>> If this isn't set, we fall back:
>>=20
>>         case NFS4_OPEN_CLAIM_FH:
>>                 return NFS4_OPEN_CLAIM_NULL;
>>         case NFS4_OPEN_CLAIM_DELEG_CUR_FH:
>>                 return NFS4_OPEN_CLAIM_DELEGATE_CUR;
>>         case NFS4_OPEN_CLAIM_DELEG_PREV_FH:
>>                 return NFS4_OPEN_CLAIM_DELEGATE_PREV;
>>=20
>
> Right. That's a convenience for downgrading NFSv4.1 service to what is
> supported by NFSv4.0.
>
>> However nfs4_map_atomic_open_claim() is not called when
>> NFS4_OPEN_CLAIM_DELEG_CUR_FH is tried, and fails.  This appears
>> to be an omission in the code.
>>=20
>
> It is deliberate. There really isn't anything that describes what is
> and isn't mandatory to implement in NFSv4.1, but if we have to make
> everything optional, then we're going to have to add a lot of mostly
> unnecessary complexity to the client.
> At what point do we then stop? Do we support a NFSv4.1 server that
> implements no NFSv4.1 features? Why not just let the client downgrade
> to NFSv4.0 in that case?

I was a bit surprised that nfs4_map_atomic_open_claim() exists at all,
but given that it did, I assumed it would be used more uniformly.

So this all implies that Linux NFS server claimed to support NFSv4.1
before it actually did - which seems odd.  This is just a bug (which are
expected), but a clear ommission.

Oh well, it probably won't be too hard to backport the
NFS4_OPEN_CLAIM_DELEG_CUR_FH support if it turns out to be really
needed.

Thanks a lot for your time,
NeilBrown


>
>
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl38Wf0ACgkQOeye3VZi
gbmVeA//SnWdP75+5RR7F5pRSaMB5ZVEMGh15g3vpq2UWPCqPtCHiZmQ/I7aZ/1h
DPbj3+UG/b3PfGC6UedYoVjhtllGyMpb7KKgEv+PO/BKFGY5jy7EZ5ILsd01yPYA
5HkKaWoTMAAg976w88cha7jxHpFpOWR8av9jv5sgYCHb8Z7COE+CbTsHJ+JHyOks
ahvWDeVTR5dB5muT+HeGcS51BPdj38fX/UfbsvQgzcXpOgn7O5lK6g4F0erJvPlc
eoRfUSUo384Z2kgXr08ZX7kU33PGbxJAhQoJbmukBWj9Zm4S3L5c8Frh3w8XQq20
+7N52iUtvdEHQKZ3ROod9bLqCCVDcsqBnzOjPPRORZOtESlqe159Wa6qxsHBNegZ
8VvGMps/iCpb2vvm2QgJ9SkXR8tDy7SJd+nCWRpPxGGzugDxJ5S5e7ylDlj8mDC1
ovvEalEYyqamtxi7hXFnKQ9PHgSXMppB2bNAEvP3I7KobfEBWn+SlPiGHCnbUC0L
NME8GVagNLk102K7A27v1tms/Vk5pzB/+xfe/09Fudwwkgo0D28jIHUsbi0sFeYz
RTDDLDQ0CMrVnIR2WHTbIXWncC1qSqMFJszebJUHKmIVbT4OU1sRolxroJnZO763
RWvQl9vaUMVScoES6IfiUurFV55//655x+Qy9lPRv78V+B+dGKI=
=+XAi
-----END PGP SIGNATURE-----
--=-=-=--
