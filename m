Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D977E30608
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 03:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfEaBBt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 21:01:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:59486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726131AbfEaBBt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 May 2019 21:01:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 821A4ACE5;
        Fri, 31 May 2019 01:01:47 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Rick Macklem <rmacklem@uoguelph.ca>,
        Olga Kornievskaia <aglo@umich.edu>, Tom Talpey <tom@talpey.com>
Date:   Fri, 31 May 2019 11:01:37 +1000
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
In-Reply-To: <QB1PR01MB2643963C3A7EDE1D92C57221DD180@QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <1df23ebc-ffe5-1a57-c40a-d5e9a45c8498@talpey.com> <CAN-5tyHUah=fAsiSLb=n__q5HxRy3qeS83evf-vB59r4cpYgsw@mail.gmail.com> <QB1PR01MB2643963C3A7EDE1D92C57221DD180@QB1PR01MB2643.CANPRD01.PROD.OUTLOOK.COM>
Message-ID: <87h89bxwr2.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, May 30 2019, Rick Macklem wrote:

> Olga Kornievskaia wrote:
>>On Thu, May 30, 2019 at 1:05 PM Tom Talpey <tom@talpey.com> wrote:
>>>
>>> On 5/29/2019 8:41 PM, NeilBrown wrote:
>>> > I've also re-arrange the patches a bit, merged two, and remove the
>>> > restriction to TCP and NFSV4.x,x>=1.  Discussions seemed to suggest
>>> > these restrictions were not needed, I can see no need.
>>>
>>> I believe the need is for the correctness of retries. Because NFSv2,
>>> NFSv3 and NFSv4.0 have no exactly-once semantics of their own, server
>>> duplicate request caches are important (although often imperfect).
>>> These caches use client XID's, source ports and addresses, sometimes
>>> in addition to other methods, to detect retry. Existing clients are
>>> careful to reconnect with the same source port, to ensure this. And
>>> existing servers won't change.
>>
>>Retries are already bound to the same connection so there shouldn't be
>>an issue of a retransmission coming from a different source port.
> I don't think the above is correct for NFSv4.0 (it may very well be true for NFSv3).

It is correct for the Linux implementation of NFS, though the term
"xprt" is more accurate than "connection".

A "task" is bound it a specific "xprt" which, in the case of tcp, has a
fixed source port.  If the TCP connection breaks, a new one is created
with the same addresses and ports, and this new connection serves the
same xprt.

> Here's what RFC7530 Sec. 3.1.1 says:
> 3.1.1.  Client Retransmission Behavior
>
>    When processing an NFSv4 request received over a reliable transport
>    such as TCP, the NFSv4 server MUST NOT silently drop the request,
>    except if the established transport connection has been broken.
>    Given such a contract between NFSv4 clients and servers, clients MUST
>    NOT retry a request unless one or both of the following are true:
>
>    o  The transport connection has been broken
>
>    o  The procedure being retried is the NULL procedure
>
> If the transport connection is broken, the retry needs to be done on a new TCP
> connection, does it not? (I'm assuming you are referring to a retry of an RPC here.)
> (My interpretation of "broken" is "can't be fixed, so the client must use a different
>  TCP connection.)

Yes, a new connection.  But the Linux client makes sure to use the same
source port.

>
> Also, NFSv4.0 cannot use Sun RPC over UDP, whereas some DRCs only
> work for UDP traffic. (The FreeBSD server does have DRC support for TCP, but
> the algorithm is very different than what is used for UDP, due to the long delay
> before a retried RPC request is received. This can result in significant server
> overheads, so some sites choose to disable the DRC for TCP traffic or tune it
> in such a way as it becomes almost useless.)
> The FreeBSD DRC code for NFS over TCP expects the retry to be from a different
> port# (due to a new connection re: the above) for NFSv4.0. For NFSv3, my best
> recollection is that it doesn't care what the source port# is. (It basically uses a
> hash on the RPC request excluding TCP/IP header to recognize possible
> duplicates.)

Interesting .... hopefully the hash is sufficiently strong.
I think it is best to assume same source port, but there is no formal
standard.

Thanks,
NeilBrown


>
> I don't know what other NFS servers choose to do w.r.t. the DRC for NFS over TCP,
> however for some reason I thought that the Linux knfsd only used a DRC for UDP?
> (Someone please clarify this.)
>
> rick
>
>> Multiple connections will result in multiple source ports, and possibly
>> multiple source addresses, meaning retried client requests may be
>> accepted as new, rather than having any chance of being recognized as
>> retries.
>>
>> NFSv4.1+ don't have this issue, but removing the restrictions would
>> seem to break the downlevel mounts.
>>
>> Tom.
>>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlzwfPIACgkQOeye3VZi
gbnbwA/7B6R4We9etJpmwBJmeWZ5EopKTrHoAZPEEzytefyH5ZoYDYR9JkGVzZIv
xQcDxjEcyAv+8mKiPmPpk+eaSB5ZaRAtq4Ozm0fbijBrctB0hSEAbMhPrPrdZs4j
xDK+bMUaqtQ/mBJy0u1upkBJ9YSU8chDnMj8Kk6xRWR9SvNTsKFMifbMU/CVveO/
xODIj5FEc7sI4qqt3tXE+AGe4VSxoyshjvsfAp/8JFQz/Y4bsALotHK68xWKkDxO
Zr2lfqAQ1C6lwoJ57R8ShJezprRGFP/qwl8KehN5an1RVAmPUMD/qsQl+9zlzESY
0okwURNH7ib2Eg3sOdFnr4/5tKAxXULKimFdeaJlXDslGa/e2iXojWU+twttnnQH
ZpunLDTF/gFH8kS4v1dw93BefNFksf+9n1BS9rKO4dUNjyNmN7W/1Oo+ogbUcHSY
1jcXO9ZEDDgL5d7LIzLBjn4imp/MW7F0P72slLphWnl9bGkaHocd0BPfiyl8uihm
zdR0qgvfdj1B8m1uvqSqTIN3SRNUoWtb0MCqHHCpFNiNvULa4R5mu0LrUD5arP5k
Dikt3C21J8Gk8Zqt09voBZXBWyO3EhXZRpm0MNCCTgbgxRxAll9AEeuWdS6jRjng
KAd8z3I2c93+tKDLkd4/GJGnya3WJmLPXwKSWK5QTFgvVd4tY94=
=ZXep
-----END PGP SIGNATURE-----
--=-=-=--
