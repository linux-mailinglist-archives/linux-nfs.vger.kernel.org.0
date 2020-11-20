Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EE52BAC3D
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 15:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgKTOw6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 09:52:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45188 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgKTOw5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 09:52:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AKEnlCM126275;
        Fri, 20 Nov 2020 14:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=8SNr2GEyQ9vA9shgg9vwYh0EHHki3IKUdGFkE3S+HZs=;
 b=UpapML4Wd42XJC0COgZcZrSG/1y7YgG8Ukc2mi9qRsiKIECrgTrIO3e+XLlURXjJGuAC
 6sRBUTaaVsJ7KSS8OgWEXm+5PNCEt8K2t07mjd7/W+MGEGhy/UfHIZp+lK3s4mZ2onfc
 MjkRYSop+ryms4fZXDdlRL/YUkwKy8CIVnvWsCfHQ1/xOlN0Ho3sUTS/iAnNEqTGgeJv
 S2u+JsNCeT5cd7WGLbSwKy4DBFZ/L7pOYPq4QiRyinIuhq9i/PbKKFuT24+1R6zxnDZQ
 l/gz2TXqJX3n4eaK5BYFr6IyQTQnUxSbklYCoCU26GBnP4UETEz44n7u58KON5ucgw8W Vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34t7vnjxq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Nov 2020 14:52:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AKEnkhh013933;
        Fri, 20 Nov 2020 14:52:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34uspxr1nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Nov 2020 14:52:53 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AKEqn2t011032;
        Fri, 20 Nov 2020 14:52:52 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Nov 2020 06:52:49 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 3/3] NFS: Avoid copy of xdr padding in read()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <40f07903bf0cb1b80c6fa99f3465c4b1d771b027.camel@hammerspace.com>
Date:   Fri, 20 Nov 2020 09:52:47 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A3A6033-F7AC-4518-9D84-B420D05CFA4E@oracle.com>
References: <20201118221939.20715-1-trondmy@kernel.org>
 <20201118221939.20715-2-trondmy@kernel.org>
 <20201118221939.20715-3-trondmy@kernel.org>
 <42FFB4EC-5E31-4002-92FC-7CA329479D78@oracle.com>
 <57b085d32f624986412770d10cc4daa8211ee0f4.camel@hammerspace.com>
 <D322F599-E680-4715-AD9A-CC6017AFF8E0@oracle.com>
 <6f13978155f7f6fd6cc885f9efdb13c0e890faf3.camel@hammerspace.com>
 <F2A105B4-6395-45ED-ABFF-DD6A0EBE1D79@oracle.com>
 <40f07903bf0cb1b80c6fa99f3465c4b1d771b027.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011200102
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 19, 2020, at 7:58 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Thu, 2020-11-19 at 17:58 -0500, Chuck Lever wrote:
>>=20
>>=20
>>> On Nov 19, 2020, at 9:34 AM, Trond Myklebust <
>>> trondmy@hammerspace.com> wrote:
>>>=20
>>> On Thu, 2020-11-19 at 09:31 -0500, Chuck Lever wrote:
>>>>=20
>>>>=20
>>>>> On Nov 19, 2020, at 9:30 AM, Trond Myklebust <
>>>>> trondmy@hammerspace.com> wrote:
>>>>>=20
>>>>> On Thu, 2020-11-19 at 09:17 -0500, Chuck Lever wrote:
>>>>>>=20
>>>>>>=20
>>>>>>> On Nov 18, 2020, at 5:19 PM, trondmy@kernel.org wrote:
>>>>>>>=20
>>>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>>>=20
>>>>>>> When doing a read() into a page, we also don't care if the
>>>>>>> nul
>>>>>>> padding
>>>>>>> stays in that last page when the data length is not 32-bit
>>>>>>> aligned.
>>>>>>=20
>>>>>> What if the READ payload lands in the middle of a file? The
>>>>>> pad on the end will overwrite file content just past where
>>>>>> the READ payload lands.
>>>>>=20
>>>>> If the size > buf->page_len, then it gets truncated in
>>>>> xdr_align_pages() afaik.
>>>>=20
>>>> I will need to check how RPC/RDMA behaves. It might build a
>>>> chunk that includes the pad in this case, which would break
>>>> things.
>>>=20
>>> That would be a bug in the existing code too, then. It shouldn't be
>>> writing beyond the buffer size we set in the NFS layer.
>>=20
>> Testing now with xfstests, which should include fsx with direct
>> I/O of odd sizes. So far I haven't seen any unexpected behavior.
>>=20
>> But I'm not sure what copy you're trying to avoid. This one in
>> xdr_align_pages() ?
>>=20
>> 1189         else if (nwords < xdr->nwords) {
>> 1190                 /* Truncate page data and move it into the tail
>> */
>> 1191                 offset =3D buf->page_len - len;
>> 1192                 copied =3D xdr_shrink_pagelen(buf, offset);
>> 1193                 trace_rpc_xdr_alignment(xdr, offset, copied);
>> 1194                 xdr->nwords =3D XDR_QUADLEN(buf->len - cur);
>> 1195         }
>>=20
>> We set up the receive buffer already to avoid this copy. It should
>> rarely, if ever, happen. That's the point of
>> rpc_prepare_reply_pages().
>=20
>=20
> ...and the point of padding here is to avoid unaligned access to
> memory. That is completely broken by this whole mechanism, which =
causes
> us to place the real data in the tail in an unaligned buffer that
> follows this padding.

I've never seen run-time complaints about unaligned accesses of
the tail data. Do you have a reproducer? (And obviously this
applies only to NFSv4 COMPOUND results, right?)


> Furthermore, rpc_prepare_reply_pages() only ever places the padding in
> the tail _if_ our buffer size is already not 32-bit aligned. =
Otherwise,
> we're engaging in this pointless exercise of making the tail buffer
> data unaligned after the fact.

Architecturally, I agree that it would be best if the tail buffer
presented the XDR data items aligned on 4 bytes.

But I do not agree that a pad goes in the pages. Some transports do
not send an XDR pad for unaligned data payloads. Transports have to
have a way of avoiding that pad. If it no longer goes in the tail,
then how will they do that?

We could perhaps have a new flag, XDRBUF_IMPLICIT_PAD, that means
the transport has to add a pad to xdr->pages on send, or did not add
a pad on receive.


>>>>>>> Signed-off-by: Trond Myklebust
>>>>>>> <trond.myklebust@hammerspace.com>
>>>>>>> ---
>>>>>>> fs/nfs/nfs2xdr.c | 2 +-
>>>>>>> fs/nfs/nfs3xdr.c | 2 +-
>>>>>>> fs/nfs/nfs4xdr.c | 2 +-
>>>>>>> 3 files changed, 3 insertions(+), 3 deletions(-)
>>>>>>>=20
>>>>>>> diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
>>>>>>> index db9c265ad9e1..468bfbfe44d7 100644
>>>>>>> --- a/fs/nfs/nfs2xdr.c
>>>>>>> +++ b/fs/nfs/nfs2xdr.c
>>>>>>> @@ -102,7 +102,7 @@ static int decode_nfsdata(struct
>>>>>>> xdr_stream
>>>>>>> *xdr, struct nfs_pgio_res *result)
>>>>>>>         if (unlikely(!p))
>>>>>>>                 return -EIO;
>>>>>>>         count =3D be32_to_cpup(p);
>>>>>>> -       recvd =3D xdr_read_pages(xdr, count);
>>>>>>> +       recvd =3D xdr_read_pages(xdr, xdr_align_size(count));
>>>>>>>         if (unlikely(count > recvd))
>>>>>>>                 goto out_cheating;
>>>>>>> out:
>>>>>>> diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
>>>>>>> index d3e1726d538b..8ef7c961d3e2 100644
>>>>>>> --- a/fs/nfs/nfs3xdr.c
>>>>>>> +++ b/fs/nfs/nfs3xdr.c
>>>>>>> @@ -1611,7 +1611,7 @@ static int decode_read3resok(struct
>>>>>>> xdr_stream *xdr,
>>>>>>>         ocount =3D be32_to_cpup(p++);
>>>>>>>         if (unlikely(ocount !=3D count))
>>>>>>>                 goto out_mismatch;
>>>>>>> -       recvd =3D xdr_read_pages(xdr, count);
>>>>>>> +       recvd =3D xdr_read_pages(xdr, xdr_align_size(count));
>>>>>>>         if (unlikely(count > recvd))
>>>>>>>                 goto out_cheating;
>>>>>>> out:
>>>>>>> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
>>>>>>> index 755b556e85c3..5baa767106dc 100644
>>>>>>> --- a/fs/nfs/nfs4xdr.c
>>>>>>> +++ b/fs/nfs/nfs4xdr.c
>>>>>>> @@ -5202,7 +5202,7 @@ static int decode_read(struct
>>>>>>> xdr_stream
>>>>>>> *xdr, struct rpc_rqst *req,
>>>>>>>                 return -EIO;
>>>>>>>         eof =3D be32_to_cpup(p++);
>>>>>>>         count =3D be32_to_cpup(p);
>>>>>>> -       recvd =3D xdr_read_pages(xdr, count);
>>>>>>> +       recvd =3D xdr_read_pages(xdr, xdr_align_size(count));
>>>>>>>         if (count > recvd) {
>>>>>>>                 dprintk("NFS: server cheating in read
>>>>>>> reply: "
>>>>>>>                                 "count %u > recvd %u\n",
>>>>>>> count,
>>>>>>> recvd);
>>>>>>> --=20
>>>>>>> 2.28.0
>>>=20
>>> --=20
>>> Trond Myklebust
>>> Linux NFS client maintainer, Hammerspace
>>> trond.myklebust@hammerspace.com
>>>=20
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



