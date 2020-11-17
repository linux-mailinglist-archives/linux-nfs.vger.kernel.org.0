Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD7C2B67E8
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Nov 2020 15:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgKQOvC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Nov 2020 09:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgKQOvC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Nov 2020 09:51:02 -0500
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [IPv6:2001:638:700:1038::1:9c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6C5C0613CF
        for <linux-nfs@vger.kernel.org>; Tue, 17 Nov 2020 06:51:01 -0800 (PST)
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [131.169.56.166])
        by smtp-o-3.desy.de (Postfix) with ESMTP id 03EC760667
        for <linux-nfs@vger.kernel.org>; Tue, 17 Nov 2020 15:50:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 03EC760667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1605624658; bh=QHO9KeomPCu25FPrDIg+v8rKEmwSS0IavjDLZ2LKosc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kpYuWGE2VmUZDLwmBhwre4KtOflrXlfSEgztDsZ86G2Z+982aqVqeIOTIhJ3K64+e
         sDAxThi8E0xgu9f9MgJaGbvNryAWohZgNjdCjc8uet9VVKjWuFSln0o+OcB3Cusqkv
         1nUPQmONHHQcueFz2W+BusunxWRB6LMeqpX7OMHU=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [131.169.56.131])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id ED5E4A0586;
        Tue, 17 Nov 2020 15:50:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id C2E661001A7;
        Tue, 17 Nov 2020 15:50:57 +0100 (CET)
Date:   Tue, 17 Nov 2020 15:50:57 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     trondmy <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Message-ID: <1959492891.1289318.1605624657755.JavaMail.zimbra@desy.de>
In-Reply-To: <291795931.1083930.1605560150768.JavaMail.zimbra@desy.de>
References: <20201110231906.863446-1-trondmy@kernel.org> <3a3696f03eef74ac4723fdc0d1297076a34aa8ae.camel@hammerspace.com> <1375056959.614278.1605271687151.JavaMail.zimbra@desy.de> <994125760.684644.1605303041944.JavaMail.zimbra@desy.de> <d73c15ca631ad52f036bb8708ab15b89af432952.camel@hammerspace.com> <1371149886.691555.1605311212511.JavaMail.zimbra@desy.de> <fc82f441b9393720102f1a7e151517ef881f99df.camel@hammerspace.com> <291795931.1083930.1605560150768.JavaMail.zimbra@desy.de>
Subject: Re: [PATCH v3 00/11] Add RDMA support to the pNFS file+flexfiles
 data channels
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF82 (Linux)/8.8.15_GA_3953)
Thread-Topic: Add RDMA support to the pNFS file+flexfiles data channels
Thread-Index: AQHWt7lTY9xR7iW33kG2X9IO1/hKs6nCBtsAFTVACHJOhL5PDfzm1vaA/xWRAGqA63bEgH5VnYYpbZFtEok=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Here is the result:


$ git bisect bad=20
c567552612ece787b178e3b147b5854ad422a836 is the first bad commit
commit c567552612ece787b178e3b147b5854ad422a836
Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
Date:   Wed May 28 13:41:22 2014 -0400

    NFS: Add READ_PLUS data segment support
   =20
    This patch adds client support for decoding a single NFS4_CONTENT_DATA
    segment returned by the server. This is the simplest implementation
    possible, since it does not account for any hole segments in the reply.
   =20
    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

 fs/nfs/nfs42xdr.c         | 141 ++++++++++++++++++++++++++++++++++++++++++=
++++
 fs/nfs/nfs4client.c       |   2 +
 fs/nfs/nfs4proc.c         |  43 +++++++++++++-
 fs/nfs/nfs4xdr.c          |   1 +
 include/linux/nfs4.h      |   2 +-
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |   2 +-
 7 files changed, 187 insertions(+), 5 deletions(-)


Regards,
   Tigran.



----- Original Message -----
> From: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> To: "trondmy" <trondmy@hammerspace.com>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Monday, 16 November, 2020 21:55:50
> Subject: Re: [PATCH v3 00/11] Add RDMA support to the pNFS file+flexfiles=
 data channels

> Hi Trond,
>=20
> I am afraid, that the fix didn't work. I bisecting it....
>=20
>=20
> Tigran.
>=20
>=20
> ----- Original Message -----
>> From: "trondmy" <trondmy@hammerspace.com>
>> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
>> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
>> Sent: Saturday, 14 November, 2020 15:29:01
>> Subject: Re: [PATCH v3 00/11] Add RDMA support to the pNFS file+flexfile=
s data
>> channels
>=20
>> On Sat, 2020-11-14 at 00:46 +0100, Mkrtchyan, Tigran wrote:
>>>=20
>>>=20
>>> ----- Original Message -----
>>> > From: "trondmy" <trondmy@hammerspace.com>
>>> > To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
>>> > Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
>>> > Sent: Friday, 13 November, 2020 23:45:00
>>> > Subject: Re: [PATCH v3 00/11] Add RDMA support to the pNFS
>>> > file+flexfiles data channels
>>>=20
>>> > On Fri, 2020-11-13 at 22:30 +0100, Mkrtchyan, Tigran wrote:
>>> > >=20
>>> > > After more testing, it looks like that client doesn't like
>>> > > notification bitmap:
>>> > >=20
>>> > >=20
>>> > > [31576.789492] --> _nfs4_proc_getdeviceinfo
>>> > > [31576.789503] --> nfs41_call_sync_prepare data->seq_server
>>> > > 000000001d17c43e
>>> > > [31576.789507] --> nfs4_alloc_slot used_slots=3D0000
>>> > > highest_used=3D4294967295 max_slots=3D16
>>> > > [31576.789510] <-- nfs4_alloc_slot used_slots=3D0001 highest_used=
=3D0
>>> > > slotid=3D0
>>> > > [31576.789527] encode_sequence:
>>> > > sessionid=3D2910695007:150995712:0:16777216 seqid=3D92462 slotid=3D=
0
>>> > > max_slotid=3D0 cache_this=3D0
>>> > > [31576.789991] decode_getdeviceinfo: unsupported notification
>>> >=20
>>> > According to this, you appear to be returning a deviceinfo bitmap
>>> > with
>>> > at least one non-zero entry that is not in the first 32-bit word.
>>> > We
>>> > only ask for notifications for NOTIFY_DEVICEID4_CHANGE and
>>> > NOTIFY_DEVICEID4_DELETE, so we only expect bitmap[0] to have non-
>>> > zero
>>> > entries.
>>>=20
>>>=20
>>> according to packet capture only bitmap[0] has non zero bits set.
>>> This is the reply of compound starting from nfs staus code, tag
>>> length and so on.
>>>=20
>>>=20
>>> 0000=C2=A0=C2=A0 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 35
>>> 0010=C2=A0=C2=A0 00 00 00 00 5f ae 7d ad 00 03 00 09 00 00 00 00
>>> 0020=C2=A0=C2=A0 00 00 00 01 00 00 00 4c 00 00 00 00 00 00 00 0f
>>> 0030=C2=A0=C2=A0 00 00 00 0f 00 00 00 00 00 00 00 2f 00 00 00 00
>>> 0040=C2=A0=C2=A0 00 00 00 04 00 00 00 40 00 00 00 01 00 00 00 03
>>> 0050=C2=A0=C2=A0 74 63 70 00 00 00 00 16 31 33 31 2e 31 36 39 2e
>>> 0060=C2=A0=C2=A0 31 39 31 2e 31 34 33 2e 31 32 35 2e 34 39 00 00
>>> 0070=C2=A0=C2=A0 00 00 00 01 00 00 00 04 00 00 00 01 00 10 00 00
>>> 0080=C2=A0=C2=A0 00 10 00 00 00 00 00 01 00 00 00 02 00 00 00 06
>>> 0090=C2=A0=C2=A0 00 00 00 00
>>>=20
>>>=20
>>> the last 12 bytes : bitmap size, bitmap[0], bitmap[1]
>>>=20
>>>=20
>>> This part of code in the didn't change since 2010, and I
>>> have no issues to use 5.8 kernel. I am pretty sure, that
>>> tests with 5.9 did pass as expected. I will try to bisec it.
>>=20
>> I don't think I've introduced this bug. I did not touch anything in the
>> getdeviceinfo proc or XDR code.
>> Does the following patch help?
>>=20
>> 8<-------------------------------------------------------
>> From e92b2d4e39e91d379ec1147115820ab5dfe4c89a Mon Sep 17 00:00:00 2001
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>> Date: Fri, 13 Nov 2020 21:42:16 -0500
>> Subject: [PATCH] NFSv4: Fix the alignment of page data in the getdevicei=
nfo
>> reply
>>=20
>> We can fit the device_addr4 opaque data padding in the pages.
>>=20
>> Fixes: cf500bac8fd4 ("SUNRPC: Introduce rpc_prepare_reply_pages()")
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>> fs/nfs/nfs4xdr.c | 14 ++++++++++----
>> 1 file changed, 10 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
>> index c6dbfcae7517..c8714381d511 100644
>> --- a/fs/nfs/nfs4xdr.c
>> +++ b/fs/nfs/nfs4xdr.c
>> @@ -3009,15 +3009,19 @@ static void nfs4_xdr_enc_getdeviceinfo(struct rp=
c_rqst
>> *req,
>> =09struct compound_hdr hdr =3D {
>> =09=09.minorversion =3D nfs4_xdr_minorversion(&args->seq_args),
>> =09};
>> +=09uint32_t replen;
>>=20
>> =09encode_compound_hdr(xdr, req, &hdr);
>> =09encode_sequence(xdr, &args->seq_args, &hdr);
>> +
>> +=09replen =3D hdr.replen + op_decode_hdr_maxsz;
>> +
>> =09encode_getdeviceinfo(xdr, args, &hdr);
>>=20
>> -=09/* set up reply kvec. Subtract notification bitmap max size (2)
>> -=09 * so that notification bitmap is put in xdr_buf tail */
>> +=09/* set up reply kvec. device_addr4 opaque data is read into the
>> +=09 * pages */
>> =09rpc_prepare_reply_pages(req, args->pdev->pages, args->pdev->pgbase,
>> -=09=09=09=09args->pdev->pglen, hdr.replen - 2);
>> +=09=09=09=09args->pdev->pglen, replen + 2);
>> =09encode_nops(&hdr);
>> }
>>=20
>> @@ -5848,7 +5852,9 @@ static int decode_getdeviceinfo(struct xdr_stream =
*xdr,
>> =09 * and places the remaining xdr data in xdr_buf->tail
>> =09 */
>> =09pdev->mincount =3D be32_to_cpup(p);
>> -=09if (xdr_read_pages(xdr, pdev->mincount) !=3D pdev->mincount)
>> +=09/* Calculate padding */
>> +=09len =3D xdr_align_size(pdev->mincount);
>> +=09if (xdr_read_pages(xdr, len) !=3D len)
>> =09=09return -EIO;
>>=20
>> =09/* Parse notification bitmap, verifying that it is zero. */
>> --
>> 2.28.0
>>=20
>>=20
>>=20
>> --
>> Trond Myklebust
>> Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
