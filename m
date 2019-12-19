Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D92125AD8
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Dec 2019 06:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfLSFj5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Dec 2019 00:39:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:49064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfLSFj5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Dec 2019 00:39:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EBC43AB9D;
        Thu, 19 Dec 2019 05:39:54 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna.schumaker\@netapp.com" <anna.schumaker@netapp.com>
Date:   Thu, 19 Dec 2019 16:39:49 +1100
Cc:     "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/RFC] NFS: handle NFSv4.1 server that doesn't support NFS4_OPEN_CLAIM_DELEG_CUR_FH
In-Reply-To: <d3299fefa94d6959d848b765ce60e2467ce1b253.camel@hammerspace.com>
References: <87y2v9fdz8.fsf@notabene.neil.brown.name> <3afd2d5c631d8e3429e025e204a7b1c95b3c1415.camel@hammerspace.com> <87v9qdf2gh.fsf@notabene.neil.brown.name> <d3299fefa94d6959d848b765ce60e2467ce1b253.camel@hammerspace.com>
Message-ID: <87pngkg9ga.fsf@notabene.neil.brown.name>
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

> On Thu, 2019-12-19 at 13:56 +1100, NeilBrown wrote:
>> On Wed, Dec 18 2019, Trond Myklebust wrote:
>>=20
>> > On Thu, 2019-12-19 at 09:47 +1100, NeilBrown wrote:
>> > > If an NFSv4.1 server doesn't support NFS4_OPEN_CLAIM_DELEG_CUR_FH
>> > > (e.g. Linux 3.0), and a newer NFS client tries to use it to claim
>> > > an open before returning a delegation, the server might return
>> > > NFS4ERR_BADXDR.
>> > > That is what Linux 3.0 does, though the RFC doesn't seem to be
>> > > explicit
>> > > on which flags must be supported, and what error can be returned
>> > > for
>> > > unsupported flags.
>> >=20
>> > NFS4ERR_BADXDR is defined in RFC5661, section 15.1.1.1 as meaning
>> >=20
>> > "The arguments for this operation do not match those specified in
>> > the
>> > XDR definition."
>> >=20
>> > That's clearly not the case here, so I'd chalk this down to a
>> > fairly
>> > blatant server bug, at which point it makes no sense to fix it in
>> > the
>> > client.
>>=20
>> Ok, but the RFC seems to suggest it is OK to not support this flag,
>> so
>> suppose I fixed the server to return NFS4ERR_NOTSUPP instead.
>> The client still wouldn't handle this response gracefully.
>>=20
>
> NFS4ERR_NOTSUPP is wrong too as the OPEN operation is clearly
> supported. The only error that might make sense is NFS4ERR_INVAL:
>
> "15.1.1.4.  NFS4ERR_INVAL (Error Code 22)
>
>    The arguments for this operation are not valid for some reason, even
>    though they do match those specified in the XDR definition for the
>    request."
>
> That said, why do we care about supporting NFSv4.1 on this server? It
> is clearly broken.

I care about it because a customer has a support contract, but that
isn't your problem.

I would think "we" care about it because we want to support the spec,
and the spec (RFC 5661 section 2.4) says:

                                                        where the server
   supports neither the CLAIM_DELEGATE_PREV nor CLAIM_DELEG_CUR_FH claim
   types

Also you have code in the client to handle the possibility that an
NFSv4.1 or later server might not handle some features of OPEN.
Three separate features are grouped under "NFS_CAP_ATOMIC_OPEN_V1":
If this isn't set, we fall back:

        case NFS4_OPEN_CLAIM_FH:
                return NFS4_OPEN_CLAIM_NULL;
        case NFS4_OPEN_CLAIM_DELEG_CUR_FH:
                return NFS4_OPEN_CLAIM_DELEGATE_CUR;
        case NFS4_OPEN_CLAIM_DELEG_PREV_FH:
                return NFS4_OPEN_CLAIM_DELEGATE_PREV;

However nfs4_map_atomic_open_claim() is not called when
NFS4_OPEN_CLAIM_DELEG_CUR_FH is tried, and fails.  This appears
to be an omission in the code.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl37DSUACgkQOeye3VZi
gbkouBAAxGlRG8YHUkSbT91zvE1IND66d1zCJGOQyoWoA+z6lqMtjpJaFEojuH8b
trIXPFHPMwCVAKsi+KvQge01Mw27BE+1jVz9JN/0OA6Gtpj3HKu1Fzg35p+KFnTc
5WV03jvBGmOYFElavFPEN/52uuxIgaDU2+d6tImJhJqs+o1Ui3EYPj9rTwCzsXxS
YqgGuGtQ2dBkV60zo7+rf1qnsBOVUmS0RpZKqeM/vuRWyaZayPfPeEf10Cj/5rxi
AWlydc1JGIjEJegZGJAvtNepm1eRR6HjbUQPgGp0prhADwpu2mYpZM33PfLPS5gg
LJ86387qDh8IOekEo31d5xcGpvTObqxWOdxBadh0U/9Jljv2WtlrfA3aWz+qNGYN
PTPtGllV4Luv04fl06oq6sa5ve+DIl6QNTFIpTSuGZj6J6n1fgaSNSKFtz+tQ9m0
jRh2xZz9EpTOZAb6Hz809JYf31yOn3qVIdbWz4fvvpQPU4lirXwwGS0W8K6NIHrC
reUjCsKvx2Rp9/F0CBxut7eEEi8CSMB0YKPFgP2JzlT19IyZ8kRwP8T92XJJ7trU
YBbzbY8Qu5wcws/SMRqXYGasVTWsHbxpaPUVT72900F198XOPiDH7uYOqRhqRFp1
CsQEencdxZg4Tql10dlYx4FT+do/in0LRfxbJdxaP7fHfXNsgQc=
=nnkI
-----END PGP SIGNATURE-----
--=-=-=--
